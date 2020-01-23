package com.ats.rusafrontend.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.commen.EmailUtility;
import com.ats.rusafrontend.commen.FormValidation;
import com.ats.rusafrontend.commen.Info;
import com.ats.rusafrontend.commen.InitializeSession;
import com.ats.rusafrontend.commen.VpsImageUpload;
import com.ats.rusafrontend.commen.XssEscapeUtils;
import com.ats.rusafrontend.model.EventRegistration;
import com.ats.rusafrontend.model.Maintainance;
import com.ats.rusafrontend.model.NewsDetails;
import com.ats.rusafrontend.model.OtpResponse;
import com.ats.rusafrontend.model.PageMetaData;
import com.ats.rusafrontend.model.PreviousRegRecord;
import com.ats.rusafrontend.model.Registration;
import com.ats.rusafrontend.model.RegistrationUserDetail;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@Scope("session")
public class loginController {

	RegistrationUserDetail editReg = new RegistrationUserDetail();
	int flag = 0;
	/*
	 * @RequestMapping(value = "/editProfile", method = RequestMethod.GET) public
	 * ModelAndView editProfile(HttpServletRequest request, HttpServletResponse
	 * response) {
	 * 
	 * ModelAndView model = new ModelAndView("edit-profile"); try {
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return model; }
	 */

	@RequestMapping(value = "/myProfile", method = RequestMethod.GET)
	public String myProfile(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();
		String mav = new String();
		try {

			session.setAttribute("mapping", "myProfile");

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {
				mav = "edit-profile";
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
				int userDetail = (int) session.getAttribute("UserDetail");
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("regId", userDetail);
				editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserDetailbyRegId", map1,
						RegistrationUserDetail.class);

				model.addAttribute("editReg", editReg);

				try {
					String dobDate = DateConvertor.convertToDMY(editReg.getDob());
					model.addAttribute("dobDate", dobDate);
				} catch (Exception e) {

				}
				model.addAttribute("isEdit", 1);
				// model.addObject("url", Constant.bannerImageURL);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav = "login";
		}

		return mav;
	}

	@RequestMapping(value = "/editProfile", method = RequestMethod.GET)
	public String editProfile(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();
		String mav = new String();

		try {
			session.setAttribute("mapping", "editProfile");
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {

				mav = "edit-my-profile";
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
				int userDetail = (int) session.getAttribute("UserDetail");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail);
				editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserDetailbyRegId", map,
						RegistrationUserDetail.class);

				model.addAttribute("editReg", editReg);
				try {
					String dobDate = DateConvertor.convertToDMY(editReg.getDob());
					model.addAttribute("dobDate", dobDate);
				} catch (Exception e) {

				}
				model.addAttribute("isEdit", 1);
				// model.addObject("url", Constant.bannerImageURL);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav = "login";
		}

		return mav;
	}

	PreviousRegRecord prevrecrod = new PreviousRegRecord();
	RegistrationUserDetail jsonRecord = new RegistrationUserDetail();

	@RequestMapping(value = "/editUserRegistration", method = RequestMethod.POST)
	public String editUserRegistration(HttpServletRequest request, HttpServletResponse response) {

		String redirect = null;
		String uuid = editReg.getUserUuid();
		try {
			HttpSession session = request.getSession();
			boolean valError = false;
			Date date = new Date(); // your date
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			int type = Integer.parseInt(request.getParameter("userType"));

			SimpleDateFormat dttime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("regId", editReg.getRegId());
			prevrecrod = Constant.getRestTemplate().postForObject(Constant.url + "/getPrevRecordByRegId", map,
					PreviousRegRecord.class);

			jsonRecord = new RegistrationUserDetail();

			if (prevrecrod.isError() == false) {

				ObjectMapper mapper = new ObjectMapper();
				jsonRecord = mapper.readValue(prevrecrod.getRecord(), RegistrationUserDetail.class);

			}

			if (type != 1) {

				String cAuthour = XssEscapeUtils.jsoupParse(request.getParameter("cAuthour"));

			}

			String altEmail2 = XssEscapeUtils.jsoupParse(request.getParameter("altEmail")).trim().replaceAll("[ ]{2,}",
					" ");
			String collegeDept = XssEscapeUtils.jsoupParse(request.getParameter("depatment")).trim()
					.replaceAll("[ ]{2,}", " ");
			String collegeMobile = XssEscapeUtils.jsoupParse(request.getParameter("mobile")).trim()
					.replaceAll("[ ]{2,}", " ");
			String designation = XssEscapeUtils.jsoupParse(request.getParameter("inddesognation")).trim()
					.replaceAll("[ ]{2,}", " ");

			if (prevrecrod.isError() == false) {

				if (type != 1) {

					String cAuthour = XssEscapeUtils.jsoupParse(request.getParameter("cAuthour")).trim()
							.replaceAll("[ ]{2,}", " ");
					String phoneNo = XssEscapeUtils.jsoupParse(request.getParameter("phoneNo")).trim()
							.replaceAll("[ ]{2,}", " ");
					// System.out.println(phoneNo);

					if (FormValidation.Validaton(cAuthour, "") == true
							|| FormValidation.Validaton(phoneNo, "") == true) {
						valError = true;
					}

					if (!editReg.getAuthorizedPerson().equals(cAuthour)) {

						jsonRecord.setAuthorizedPerson(editReg.getAuthorizedPerson());
						prevrecrod.setLastUpdate(dttime.format(date));
						editReg.setAuthorizedPerson(cAuthour);
					}

					try {
						if (!editReg.getExVar2().equals(phoneNo)) {

							jsonRecord.setExVar2(editReg.getExVar2());
							prevrecrod.setLastUpdate(dttime.format(date));
							editReg.setExVar2(phoneNo);
						}
					} catch (Exception e) {
						jsonRecord.setExVar2(editReg.getExVar2());
						prevrecrod.setLastUpdate(dttime.format(date));
						editReg.setExVar2(phoneNo);
					}
				}

				if (FormValidation.Validaton(collegeDept, "") == true
						|| FormValidation.Validaton(designation, "") == true
						|| FormValidation.Validaton(collegeMobile, "mobile") == true || valError == true) {
					valError = true;
				}

				if (!editReg.getAlternateEmail().equals(altEmail2)) {

					jsonRecord.setAlternateEmail(editReg.getAlternateEmail());
					prevrecrod.setLastUpdate(dttime.format(date));
				}

				if (!editReg.getDepartmentName().equals(collegeDept)) {

					jsonRecord.setDepartmentName(editReg.getDepartmentName());
					prevrecrod.setLastUpdate(dttime.format(date));
				}
				if (!editReg.getDesignationName().equals(designation)) {

					jsonRecord.setDesignationName(editReg.getDesignationName());
					prevrecrod.setLastUpdate(dttime.format(date));
				}

			}

			editReg.setAlternateEmail(altEmail2);
			editReg.setDesignationName(designation);
			editReg.setDepartmentName(collegeDept);
			editReg.setEditDate(sf.format(date));

			if (prevrecrod.isError() == true) {

				jsonRecord = editReg;
				prevrecrod.setLastUpdate(dttime.format(date));
				prevrecrod.setRegId(editReg.getRegId());
			}

			if (valError == false) {
				if (editReg.getMobileNumber().equals(collegeMobile)) {

					Registration res = Constant.getRestTemplate().postForObject(Constant.url + "/saveRegistration",
							editReg, Registration.class);

					ObjectMapper mapper = new ObjectMapper();
					prevrecrod.setRecord(mapper.writeValueAsString(jsonRecord));

					PreviousRegRecord update = Constant.getRestTemplate()
							.postForObject(Constant.url + "/savePreviousRecord", prevrecrod, PreviousRegRecord.class);

					redirect = "redirect:/editProfile";
				} else {

					editReg.setExVar2(collegeMobile);
					redirect = "redirect:/ editVerifyOtp /" + uuid + "/1";
				}
				session.setAttribute("success", "Successfully Updated Information !");
			} else {
				redirect = "redirect:/editProfile";
				session.setAttribute("errorMsg", "Failed To Update Information");
			}

			// System.out.println("Data: " + editReg.toString());

		} catch (Exception e1) {
			e1.printStackTrace();
			HttpSession session = request.getSession();
			session.setAttribute("errorMsg", "Failed To Update Information");
		}

		return redirect;
	}

	Info resWithOtp = new Info();

	@RequestMapping(value = "/editVerifyOtp/{uuid}/{resend}", method = RequestMethod.GET)
	public ModelAndView editVerifyOtp(@PathVariable("uuid") String uuid, @PathVariable("resend") int resend,
			HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("editRegOtp");
		try {

			HttpSession session = request.getSession();
			model.addObject("editReg", editReg);

			if (uuid.equals(editReg.getUserUuid())) {

				if (resend == 1) {

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("uuid", uuid);
					map.add("mobileNo", editReg.getExVar2());
					resWithOtp = Constant.getRestTemplate().postForObject(Constant.url + "/sendOtp", map, Info.class);
					if (resWithOtp.isError() == false) {

						session.setAttribute("success", "Opt Send Successfully");
					} else {
						session.setAttribute("errorMsg", "Failed to Send OTP");
					}
				} else {

					session.setAttribute("errorMsg", "OTP Not Matched");
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/verifyEditOtpProcess", method = RequestMethod.POST)
	public String verifyEditOtpProcess(HttpServletRequest request, HttpServletResponse res) throws IOException {

		String ret = new String();
		HttpSession session = request.getSession();

		try {
			String userOtp = request.getParameter("userOtp");
			SimpleDateFormat dttime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date date = new Date();

			if (userOtp.equalsIgnoreCase("") || userOtp == null) {
				ret = "redirect:/editVerifyOtp/" + editReg.getUserUuid() + "/0";
				session.setAttribute("errorMsg", "OTP Not Matched");
			} else {

				if (userOtp.equals(resWithOtp.getMsg())) {

					jsonRecord.setMobileNumber(editReg.getMobileNumber());
					editReg.setMobileNumber(editReg.getExVar2());

					Registration a = Constant.getRestTemplate().postForObject(Constant.url + "/saveRegistration",
							editReg, Registration.class);

					ObjectMapper mapper = new ObjectMapper();
					prevrecrod.setRecord(mapper.writeValueAsString(jsonRecord));
					prevrecrod.setLastUpdate(dttime.format(date));
					PreviousRegRecord update = Constant.getRestTemplate()
							.postForObject(Constant.url + "/savePreviousRecord", prevrecrod, PreviousRegRecord.class);

					ret = "redirect:/editProfile";
					session.setAttribute("success", "Successfully Updated Information !");

				} else {
					ret = "redirect:/editVerifyOtp/" + editReg.getUserUuid() + "/0";
					session.setAttribute("errorMsg", "OTP Not Matched");
				}

			}
		} catch (Exception e) {

		}

		return ret;
	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public String changePassword(HttpServletRequest request, HttpServletResponse response) {

		String newPass = request.getParameter("newPass");
		String confirmPass = request.getParameter("confirmPass");
		String oldPass = request.getParameter("pass");
		// System.out.println("newPass : " + newPass);
		ModelAndView mav = new ModelAndView("change-pass");
		HttpSession session = request.getSession();

		Info info = new Info();
		try {
			session.setAttribute("mapping", "changePassword");
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				mav = new ModelAndView("maintainance");
				mav.addObject("maintainance", maintainance);
			} else {

				mav.addObject("siteKey", Constant.siteKey);
				mav.addObject("flag", flag);
				flag = 0;
				int userDetail = (int) session.getAttribute("UserDetail");

				if (newPass.equalsIgnoreCase(" ") || newPass == null) {
					mav = new ModelAndView("change-pass");
					session.setAttribute("errorMsg", "Invalid Password !");

				} else {

					MessageDigest md = MessageDigest.getInstance("MD5");
					byte[] messageDigest = md.digest(oldPass.getBytes());
					BigInteger number = new BigInteger(1, messageDigest);
					String oldHashText = number.toString(16);

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					map.add("userId", userDetail);
					map.add("pass", oldHashText);

					info = Constant.getRestTemplate().postForObject(Constant.url + "/checkPasswordByUserId", map,
							Info.class);

					messageDigest = md.digest(newPass.getBytes());
					number = new BigInteger(1, messageDigest);
					String hashtext = number.toString(16);

					Pattern p = Pattern.compile("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$");
					Matcher m = p.matcher(newPass);

					if (info.isError() == false && m.matches() && newPass.equals(confirmPass)) {

						map = new LinkedMultiValueMap<String, Object>();
						map.add("regId", userDetail);
						map.add("password", hashtext);

						info = Constant.getRestTemplate().postForObject(Constant.url + "/changePassword", map,
								Info.class);
						mav = new ModelAndView("change-pass");
						System.out.println(info.toString());

						session.setAttribute("success", "Successfully Updated Password !");

						MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
						map1.add("regId", userDetail);
						Registration editReg = Constant.getRestTemplate()
								.postForObject(Constant.url + "/getRegUserbyRegId", map1, Registration.class);
						mav.addObject("editReg", editReg);
					} else {
						session.setAttribute("errorMsg", "Invalid Password");
					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/changePass";
	}

	@RequestMapping(value = "/resendEditOtpProcess", method = RequestMethod.POST)
	public ModelAndView resendEditOtpProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("editRegOtp");
		try {

			String uuid = request.getParameter("uuid");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("uuid", uuid);

			OtpResponse verifyOtp = Constant.getRestTemplate().postForObject(Constant.url + "/verifyEditResendOtp", map,
					OtpResponse.class);

			if (verifyOtp.isError() == false) {
				mav = new ModelAndView("editRegOtp");
				mav.addObject("uuid", uuid);
				System.out.println(" update ragistration table new :");
			} else {
				mav = new ModelAndView("edit-my-profile");
			}

			mav.addObject("uuid", uuid);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/uploadProfilePhoto", method = RequestMethod.POST)
	public String uploadProfilePhoto(@RequestParam("file") List<MultipartFile> file, HttpServletRequest request,
			HttpServletResponse response) {

		// ModelAndView mav=new ModelAndView("edit-my-profile");
		HttpSession session = request.getSession();
		try {
			System.out.println("Profile Photo");

			Date date = new Date();
			SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
			String imageName = new String();
			imageName = dateTimeInGMT.format(date) + "_" + file.get(0).getOriginalFilename();
			VpsImageUpload upload = new VpsImageUpload();

			int userDetail = (int) session.getAttribute("UserDetail");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("regId", userDetail);
			try {
				// upload.saveUploadedImge(file.get(0),
				// Constant.otherDocURL,imageName,Constant.values,0,0,0,0,0);
				editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserDetailbyRegId", map,
						RegistrationUserDetail.class);

				upload.saveUploadedImge(file.get(0), Constant.userProfileURL, imageName, Constant.values, 0, 0, 0, 0,
						0);
				editReg.setImageName(imageName);
				System.out.println("Data :" + editReg.toString());
				Registration res = Constant.getRestTemplate().postForObject(Constant.url + "/saveRegistration", editReg,
						Registration.class);
				session.setAttribute("info", res);

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			session.setAttribute("gallryImageURL", Constant.getUserProfileURL);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/editProfile";
	}

	@RequestMapping(value = "/eventList", method = RequestMethod.GET)
	public ModelAndView eventList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/event-List");
		HttpSession session = request.getSession();
		try {

			int userDetail = (int) session.getAttribute("UserDetail");
			session.setAttribute("mapping", "eventList");
			int langId = 1;
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId);
				NewsDetails[] eventList = Constant.getRestTemplate().postForObject(Constant.url + "/getAllEventsL",
						map1, NewsDetails[].class);
				List<NewsDetails> event = new ArrayList<NewsDetails>(Arrays.asList(eventList));
				for (int i = 0; i < event.size(); i++) {
					event.get(i).setEventDateFrom(DateConvertor.convertToDMY(event.get(i).getEventDateFrom()));

				}
				// model.addObject("event", event);

				MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
				map2.add("regId", userDetail);
				editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserDetailbyRegId", map2,
						RegistrationUserDetail.class);
				// String dobDate = DateConvertor.convertToDMY(editReg.getDob());
				model.addObject("editReg", editReg);
				// model.addObject("dobDate", dobDate);
				model.addObject("event", event);

				model.addObject("siteKey", Constant.siteKey);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/eventDetail", method = RequestMethod.GET)
	public String eventDetail(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		HttpSession session = request.getSession();
		try {
			session.setAttribute("mapping", "eventDetail");
			int userDetail = (int) session.getAttribute("UserDetail");
			String id = request.getParameter("newsblogsId");
			String type = request.getParameter("typeId");

			int newsblogsId = Integer.parseInt(EmailUtility.DecodeKey(String.valueOf(id)));
			int typeId = Integer.parseInt(EmailUtility.DecodeKey(String.valueOf(type)));

			int langId = 1;
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {

				mav = "event-detail";
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId);

				map1.add("newsblogsId", newsblogsId);
				NewsDetails eventList = Constant.getRestTemplate().postForObject(Constant.url + "/getEventListByNewsId",
						map1, NewsDetails.class);

				// List<NewsDetails> event = new
				// ArrayList<NewsDetails>(Arrays.asList(eventList));
				MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
				map2.add("regId", userDetail);
				editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserDetailbyRegId", map2,
						RegistrationUserDetail.class);

				model.addAttribute("editReg", editReg);

				String dateEvent = DateConvertor.convertToDMY(eventList.getEventDateFrom());
				model.addAttribute("event", eventList);
				model.addAttribute("dateEvent", dateEvent);

				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("typeId", typeId);

				System.out.println("typeId :" + typeId);

				String[] Ids = eventList.getExVar2().split(",");
				model.addAttribute("ids", Ids);
			}

		} catch (Exception e) {
			e.printStackTrace();
			mav = "login";
		}

		return mav;
	}

	@RequestMapping(value = "/applyEvent/{newsblogsId}", method = RequestMethod.GET)
	public String applyEvent(@PathVariable int newsblogsId, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		// Registration userDetail=null;
		int userDetail = 0;
		Info info = null;
		// String redirect=null;
		ModelAndView mav = null;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			// userDetail =(Registration) session.getAttribute("UserDetail");

			userDetail = (int) session.getAttribute("UserDetail");

			// System.out.println("userDetail "+userDetail.getRegId());

			System.out.println("User Id: " + userDetail);

			MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

			map1.add("newsblogsId", newsblogsId);
			map1.add("userId", userDetail);
			info = Constant.getRestTemplate().postForObject(Constant.url + "/getAppliedEvents", map1, Info.class);
			if (info.isError() == true) {
				EventRegistration eventReg = new EventRegistration();

				Date date = new Date(); // your date
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				eventReg.setDelStatus(1);
				// eventReg.setEventRegId();
				eventReg.setIsActive(1);
				eventReg.setNewsblogsId(newsblogsId);
				eventReg.setRegDate(sf.format(date));
				eventReg.setUserId(userDetail);

				EventRegistration res = Constant.getRestTemplate().postForObject(Constant.url + "/saveEventRegister",
						eventReg, EventRegistration.class);

				System.out.println("res Id: " + res.toString());

				if (res != null) {
					session.setAttribute("success", "Successfully Registed Event !");
				}
			} else {
				System.out.println("User Id: " + userDetail);

				session.setAttribute("errorMsg", "Event Already Registered !");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/eventDetail" + "?newsblogsId=" + EmailUtility.Encrypt(String.valueOf(newsblogsId))
				+ "&typeId=" + EmailUtility.Encrypt(String.valueOf(2));
	}

	@RequestMapping(value = "/submtEventAppliedForm", method = RequestMethod.POST)
	public String submtEventAppliedForm(@RequestParam("pagePdf") List<MultipartFile> pagePdf,
			HttpServletRequest request, HttpServletResponse response) {

		// ModelAndView model = new ModelAndView("masters/addEmployee");
		Info info = new Info();
		String pdfName = new String();

		HttpSession session = request.getSession();
		int newsblogsId = Integer.parseInt(request.getParameter("newsblogsId"));
		System.out.println("newsblogsId :" + newsblogsId);
		int userDetail = 0;

		try {
			userDetail = (int) session.getAttribute("UserDetail");
			System.out.println("userDetail: " + userDetail);

			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");

			VpsImageUpload upload = new VpsImageUpload();
			pdfName = dateTimeInGMT.format(date) + "_" + pagePdf.get(0).getOriginalFilename();

			MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

			map1.add("newsblogsId", newsblogsId);
			map1.add("userId", userDetail);
			info = Constant.getRestTemplate().postForObject(Constant.url + "/getAppliedEvents", map1, Info.class);

			if (info.isError() == true) {
				EventRegistration eventReg = new EventRegistration();

				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				eventReg.setDelStatus(1);
				eventReg.setIsActive(1);
				eventReg.setNewsblogsId(newsblogsId);
				eventReg.setRegDate(sf.format(date));
				eventReg.setUserId(userDetail);
				eventReg.setDoc1(pdfName);

				info = upload.saveUploadedFiles(pagePdf.get(0), Constant.cmsPdf, Constant.pdf, pdfName);
				if (info.isError() == false) {
					EventRegistration res = Constant.getRestTemplate()
							.postForObject(Constant.url + "/saveEventRegister", eventReg, EventRegistration.class);
					session.setAttribute("success", "Successfully Registed Event !");
				}

			} else {
				try {
					/*
					 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
					 * Object>(); map.add("regId", userDetail); map.add("newsblogsId", newsblogsId);
					 * map.add("pdfName", pdfName);
					 * 
					 * info = Constant.getRestTemplate().postForObject(Constant.url +
					 * "/uploadEventDocument", map, Info.class);
					 * 
					 * System.out.println(info.toString());
					 * 
					 * upload.saveUploadedFiles(pagePdf.get(0), Constant.uploadDocURL, pdfName);
					 */

				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}

				session.setAttribute("errorMsg", "Event Already Registered !");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/eventDetail" + "?newsblogsId=" + EmailUtility.Encrypt(String.valueOf(newsblogsId))
				+ "&typeId=" + EmailUtility.Encrypt(String.valueOf(2));
	}

	@RequestMapping(value = "/firstChangePass", method = RequestMethod.GET)
	public ModelAndView firstChangePass(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("changePass");
		HttpSession session = request.getSession();
		try {

			session.setAttribute("mapping", "firstChangePass");

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				model.addObject("siteKey", Constant.siteKey);
				model.addObject("flag", flag);
				flag = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/firstChangePassword", method = RequestMethod.POST)
	public String FirstChangePassword(HttpServletRequest request, HttpServletResponse response, Model model) {

		String newPass = request.getParameter("newPass");
		String confirmPass = request.getParameter("confirmPass");

		// System.out.println("newPass : " + newPass);
		String mav = new String();
		HttpSession session = request.getSession();

		Info info = new Info();
		try {
			session.setAttribute("mapping", "firstChangePassword");

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {

				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
				int userDetail = (int) session.getAttribute("UserDetail");
				if (newPass.equalsIgnoreCase(" ") || newPass == null) {

					mav = "changePass";
					session.setAttribute("errorMsg", "Invalid Password !");
				} else {

					Pattern p = Pattern.compile("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$");
					Matcher m = p.matcher(newPass);

					if (m.matches() && newPass.equals(confirmPass)) {
						
						MessageDigest md = MessageDigest.getInstance("MD5");
						byte[] messageDigest = md.digest(newPass.getBytes());
						BigInteger number = new BigInteger(1, messageDigest);
						String pass = number.toString(16);

						MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
						map1.add("regId", userDetail);
						map1.add("password", pass);

						info = Constant.getRestTemplate().postForObject(Constant.url + "/changePassword", map1,
								Info.class);
						if (info.isError() == false) {

							session.removeAttribute("userDetail");
							session.removeAttribute("userInfo");
							session.invalidate();

							session = request.getSession();
							if (session.getAttribute("menuList") == null) {
								InitializeSession.intializeSission(request);
							}

							mav = "redirect:/login";
							System.out.println(info.toString());
							session.setAttribute("success", "Successfully Updated Password !");
						}
					} else {
						session.setAttribute("errorMsg", "Invalid Password !");
					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
}
