package com.ats.rusafrontend.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
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
import com.ats.rusafrontend.commen.Info;
import com.ats.rusafrontend.commen.VpsImageUpload;
import com.ats.rusafrontend.model.EventRegistration;
import com.ats.rusafrontend.model.Maintainance;
import com.ats.rusafrontend.model.NewsDetails;
import com.ats.rusafrontend.model.OtpResponse;
import com.ats.rusafrontend.model.PageMetaData;
import com.ats.rusafrontend.model.Registration;

@Controller
@Scope("session")
public class loginController {
	RestTemplate rest = new RestTemplate();
	Registration editReg = new Registration();
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
	public ModelAndView myProfile(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = new ModelAndView("edit-profile");
		try {
			int userDetail = (int) session.getAttribute("UserDetail");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("regId", userDetail);
			editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
			String dobDate = DateConvertor.convertToDMY(editReg.getDob());
			model.addObject("editReg", editReg);
			model.addObject("dobDate", dobDate);
			model.addObject("isEdit", 1);
			// model.addObject("url", Constant.bannerImageURL);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/editProfile", method = RequestMethod.GET)
	public ModelAndView editProfile(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = new ModelAndView("edit-my-profile");
		try {
			int userDetail = (int) session.getAttribute("UserDetail");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("regId", userDetail);
			editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
			String dobDate = DateConvertor.convertToDMY(editReg.getDob());
			model.addObject("editReg", editReg);
			model.addObject("dobDate", dobDate);
			model.addObject("isEdit", 1);
			// model.addObject("url", Constant.bannerImageURL);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/editUserRegistration", method = RequestMethod.POST)
	public String editUserRegistration(HttpServletRequest request, HttpServletResponse response) {

		String redirect = null;
		String uuid = editReg.getUserUuid();
		try {
			Date date = new Date(); // your date
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			int type = Integer.parseInt(request.getParameter("userType"));
			System.out.println("Type: " + uuid);
			if (type == 1) {
				String email = request.getParameter("email");
				String altEmail1 = request.getParameter("altEmail");
				String name = request.getParameter("name");
				String collegeName = request.getParameter("collegeName");
				String university = request.getParameter("university");
				String dept = request.getParameter("dept");
				String dob = request.getParameter("dob");
				String mobile = request.getParameter("mobile");
				String authour = request.getParameter("authour");

				editReg.setAlternateEmail(altEmail1);
				editReg.setName(name);
				editReg.setCollegeName(collegeName);
				editReg.setUnversityName(university);
				editReg.setDepartmentName(dept);
				editReg.setUserType(1);
				editReg.setAuthorizedPerson(authour);
				editReg.setDob(DateConvertor.convertToYMD(dob));

				if (editReg.getEmails().equals(email)) {
					editReg.setEmails(email);
				} else {
					System.out.println("Email new");
					editReg.setExVar1(email);
				}
				if (editReg.getMobileNumber().equals(mobile)) {
					editReg.setMobileNumber(mobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveRegistration", editReg,
							Registration.class);
					redirect = "redirect:/editProfile";
				} else {
					System.out.println("1. mobile number");
					editReg.setExVar2(mobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveReg", editReg, Registration.class);
					redirect = "redirect:/ editVerifyOtp /" + uuid + "";
				}

			}
			if (type == 2) {
				String collegeEmail = request.getParameter("collegeEmail");
				String altEmail2 = request.getParameter("altEmail");
				String institute = request.getParameter("institute");
				String aisheName1 = request.getParameter("aisheName");
				String univ = request.getParameter("univ");
				String collegeDept = request.getParameter("collegeDept");
				String collegeMobile = request.getParameter("collegeMobile");
				String designation = request.getParameter("designationCollege");
				String cAuthour = request.getParameter("collegeAuthour");

				editReg.setAlternateEmail(altEmail2);
				editReg.setName(institute);
				editReg.setAuthorizedPerson(cAuthour);
				editReg.setAisheCode(aisheName1);
				editReg.setUnversityName(univ);
				editReg.setDepartmentName(collegeDept);
				editReg.setDesignationName(designation);
				editReg.setUserType(2);

				if (editReg.getEmails().equals(collegeEmail)) {
					editReg.setEmails(collegeEmail);
				} else {
					System.out.println("Email new");
					editReg.setExVar1(collegeEmail);
				}

				if (editReg.getMobileNumber().equals(collegeMobile)) {
					editReg.setMobileNumber(collegeMobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveRegistration", editReg,
							Registration.class);
					redirect = "redirect:/editProfile";
				} else {
					System.out.println("Email new");
					editReg.setExVar2(collegeMobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveReg", editReg, Registration.class);
					redirect = "redirect:/ editVerifyOtp /" + uuid + "";
				}

			}
			if (type == 3) {
				String uniEmail = request.getParameter("uniEmail");
				String altEmail3 = request.getParameter("altEmail");
				String uniName = request.getParameter("uniName");
				String aisheName2 = request.getParameter("aisheName");
				String uniDept = request.getParameter("uniDept");
				String uniMobile = request.getParameter("uniMobile");
				String uniDes = request.getParameter("uniDes");
				String uniAuthour = request.getParameter("uniAuthour");

				editReg.setExVar2(uniMobile);
				editReg.setExVar1(uniEmail);
				editReg.setAlternateEmail(altEmail3);
				editReg.setAisheCode(aisheName2);
				editReg.setName(uniName);
				editReg.setAuthorizedPerson(uniAuthour);
				editReg.setDepartmentName(uniDept);
				editReg.setDesignationName(uniDes);
				editReg.setUserType(3);

				if (editReg.getEmails().equals(uniEmail)) {
					editReg.setEmails(uniEmail);
				} else {
					System.out.println("Email new");
					editReg.setExVar1(uniEmail);
				}

				if (editReg.getMobileNumber().equals(uniMobile)) {
					editReg.setMobileNumber(uniMobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveRegistration", editReg,
							Registration.class);
					redirect = "redirect:/editProfile";
				} else {
					System.out.println("Email new");
					editReg.setExVar2(uniMobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveReg", editReg, Registration.class);
					redirect = "redirect:/ editVerifyOtp /" + uuid + "";
				}

			}
			System.out.println("Data: " + editReg.toString());

		} catch (Exception e1) {
			e1.printStackTrace();
		}

		return redirect;
	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public String changePassword(HttpServletRequest request, HttpServletResponse response) {

		String newPass = request.getParameter("newPass");
		System.out.println("newPass : " + newPass);
		ModelAndView mav = new ModelAndView("change-pass");
		HttpSession session = request.getSession();

		Info info = new Info();
		try {
			int userDetail = (int) session.getAttribute("UserDetail");
			if (newPass.equalsIgnoreCase("") || newPass == null) {
				mav = new ModelAndView("change-pass");
				mav.addObject("msg", "Invalid password");
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail);
				map.add("password", newPass);

				info = rest.postForObject(Constant.url + "/changePassword", map, Info.class);
				mav = new ModelAndView("change-pass");
				System.out.println(info.toString());

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("regId", userDetail);
				Registration editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map1,
						Registration.class);
				String dobDate = DateConvertor.convertToDMY(editReg.getDob());
				mav.addObject("editReg", editReg);
				mav.addObject("dobDate", dobDate);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/changePass";
	}

	@RequestMapping(value = "/editVerifyOtp/{uuid}", method = RequestMethod.GET)
	public ModelAndView editVerifyOtp(@PathVariable("uuid") String uuid, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("editRegOtp");
		try {
			/*
			 * HttpSession session = request.getSession(); session.setAttribute("suuid",
			 * suuid);
			 */
			model.addObject("uuid", uuid);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/verifyEditOtpProcess", method = RequestMethod.POST)
	public ModelAndView verifyEditOtpProcess(HttpServletRequest request, HttpServletResponse res) throws IOException {

		String userOtp = request.getParameter("userOtp");
		String uuid = request.getParameter("uuid");
		HttpSession session = request.getSession();
		// int type = Integer.parseInt(request.getParameter("type"));
		// int userDetail = (int) session.getAttribute("UserDetail");
		System.out.println("UUID :" + uuid + ", UserOTP :" + userOtp);

		ModelAndView mav = new ModelAndView("editRegOtp");
		mav.addObject("uuid", uuid);
		RestTemplate rest = new RestTemplate();
		res.setContentType("text/html");

		try {

			if (userOtp.equalsIgnoreCase("") || userOtp == null) {
				mav = new ModelAndView("editRegOtp");
				mav.addObject("uuid", uuid);
				mav.addObject("msg", "Invalid Otp");
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("userOtp", userOtp);
				map.add("uuid", uuid);

				OtpResponse verifyOtp = rest.postForObject(Constant.url + "/verifyOtpResponse", map, OtpResponse.class);

				if (verifyOtp.isError() == false) {
					mav = new ModelAndView("edit-my-profile");

					// mav.addObject("userDetail",userDetail);
				} else {
					mav = new ModelAndView("editRegOtp");
					mav.addObject("uuid", uuid);

					System.out.println("Invalid login credentials");
					mav.addObject("msg", "Invalid login");
				}
			}
		} catch (Exception e) {
			System.out.println("HomeController Login API Excep:  " + e.getMessage());
			e.printStackTrace();
			mav.addObject("msg", "Invalid login");
		}

		return mav;
	}

	@RequestMapping(value = "/resendEditOtpProcess", method = RequestMethod.POST)
	public ModelAndView resendEditOtpProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("editRegOtp");
		try {

			String uuid = request.getParameter("uuid");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("uuid", uuid);

			OtpResponse verifyOtp = rest.postForObject(Constant.url + "/verifyEditResendOtp", map, OtpResponse.class);

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
				editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);

				upload.saveUploadedImge(file.get(0), Constant.getUserProfileURL, imageName, Constant.values, 0, 0, 0, 0,
						0);
				editReg.setImageName(imageName);
				System.out.println("Data :" + editReg.toString());
				Registration res = rest.postForObject(Constant.url + "/saveRegistration", editReg, Registration.class);

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
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", "eventList");
				PageMetaData pageMetaData = rest.postForObject(Constant.url + "/getPageMetaData", map,
						PageMetaData.class);
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId);
				NewsDetails[] eventList = rest.postForObject(Constant.url + "/getAllEventsL", map1,
						NewsDetails[].class);
				List<NewsDetails> event = new ArrayList<NewsDetails>(Arrays.asList(eventList));
				for (int i = 0; i < event.size(); i++) {
					event.get(i).setEventDateFrom(DateConvertor.convertToDMY(event.get(i).getEventDateFrom()));

				}
				// model.addObject("event", event);

				MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
				map2.add("regId", userDetail);
				editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map2, Registration.class);
				String dobDate = DateConvertor.convertToDMY(editReg.getDob());
				model.addObject("editReg", editReg);
				model.addObject("dobDate", dobDate);
				model.addObject("event", event);
				model.addObject("pageMetaData", pageMetaData);
				model.addObject("siteKey", Constant.siteKey);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/eventDetail/{newsblogsId}/{typeId}", method = RequestMethod.GET)
	public ModelAndView eventDetail(@PathVariable int newsblogsId, @PathVariable int typeId, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("event-detail");
		HttpSession session = request.getSession();
		try {
			int userDetail = (int) session.getAttribute("UserDetail");

			session.setAttribute("mapping", "eventList");
			int langId = 1;
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", "eventList");
				PageMetaData pageMetaData = rest.postForObject(Constant.url + "/getPageMetaData", map,
						PageMetaData.class);

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId);

				map1.add("newsblogsId", newsblogsId);
				NewsDetails eventList = rest.postForObject(Constant.url + "/getEventListByNewsId", map1,
						NewsDetails.class);

				// List<NewsDetails> event = new
				// ArrayList<NewsDetails>(Arrays.asList(eventList));
				MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
				map2.add("regId", userDetail);
				editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map2, Registration.class);

				model.addObject("editReg", editReg);

				String dateEvent = DateConvertor.convertToDMY(eventList.getEventDateFrom());
				model.addObject("event", eventList);
				model.addObject("dateEvent", dateEvent);
				model.addObject("pageMetaData", pageMetaData);
				model.addObject("siteKey", Constant.siteKey);
				model.addObject("typeId", typeId);

				System.out.println("typeId :" + typeId);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/applyEvent/{newsblogsId}", method = RequestMethod.GET)
	public String applyEvent(@PathVariable int newsblogsId, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		// Registration userDetail=null;
		int userDetail = 0;
		Info info=null;
	//	String redirect=null;
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
				info  = rest.postForObject(Constant.url + "/getAppliedEvents", map1,
						Info.class);
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

					EventRegistration res = rest.postForObject(Constant.url + "/saveEventRegister", eventReg,
							EventRegistration.class);

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

		return "redirect:/eventDetail"+"/" +newsblogsId +"/2";
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
			info  = rest.postForObject(Constant.url + "/getAppliedEvents", map1,
					Info.class);

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

				EventRegistration res = rest.postForObject(Constant.url + "/saveEventRegister", eventReg,
						EventRegistration.class);

				System.out.println("res Id: " + res.toString());
								
				session.setAttribute("success", "Successfully Registed Event !");
				upload.saveUploadedFiles(pagePdf.get(0), Constant.uploadDocURL, pdfName);
			}
			else
			{
				try {

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					map.add("regId", userDetail);
					map.add("newsblogsId", newsblogsId);
					map.add("pdfName", pdfName);

					info = rest.postForObject(Constant.url + "/uploadEventDocument", map, Info.class);

					System.out.println(info.toString());
					if (info.isError() == false) {
						
						session.setAttribute("success", "Successfully Registed Event !");
						
					}			
					
					
					upload.saveUploadedFiles(pagePdf.get(0), Constant.uploadDocURL, pdfName);
				
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			
				session.setAttribute("errorMsg", "Event Already Registered !");

			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/eventDetail"+"/" +newsblogsId +"/2";
	}
	@RequestMapping(value = "/firstChangePass", method = RequestMethod.GET)
	public ModelAndView firstChangePass(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("changePass");
		try {

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	@RequestMapping(value = "/firstChangePassword", method = RequestMethod.POST)
	public ModelAndView FirstChangePassword(HttpServletRequest request, HttpServletResponse response) {

		String newPass = request.getParameter("newPass");
		System.out.println("newPass : " + newPass);
		ModelAndView mav = new ModelAndView("changePass");
		HttpSession session = request.getSession();

		Info info = new Info();
		try {
			int userDetail = (int) session.getAttribute("UserDetail");
			if (newPass.equalsIgnoreCase(" ") || newPass == null) {
				
				mav = new ModelAndView("changePass");				
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail);
				map.add("password", newPass);

				info = rest.postForObject(Constant.url + "/changePassword", map, Info.class);
				if(info.isError() == false)
				{
					mav = new ModelAndView("login");
					System.out.println(info.toString());
					//session.setAttribute("success", "Successfully Updated Password !");					
				}
						
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
}
