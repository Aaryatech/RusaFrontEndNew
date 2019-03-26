package com.ats.rusafrontend.controller;

import java.io.IOException;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.commen.EmailUtility;
import com.ats.rusafrontend.commen.Info;
import com.ats.rusafrontend.model.ContactUs;
import com.ats.rusafrontend.model.EventRegistration;
import com.ats.rusafrontend.model.Maintainance;
import com.ats.rusafrontend.model.NewsDetails;
import com.ats.rusafrontend.model.OtpResponse;
import com.ats.rusafrontend.model.PageMetaData;
import com.ats.rusafrontend.model.Registration;
import com.ats.rusafrontend.reCaptcha.VerifyRecaptcha;

@Controller
@Scope("session")
public class UserController {

	RestTemplate rest = new RestTemplate();

	/*
	 * <dependency> <groupId>com.fasterxml.uuid</groupId>
	 * <artifactId>java-uuid-generator</artifactId> <version>3.1.4</version>
	 * </dependency>
	 */

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("login");
		try {

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/loginResponse", method = RequestMethod.POST)
	public ModelAndView loginResponse(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		ModelAndView mav = new ModelAndView("login");
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("userName", userName);
			map.add("password", password);

			Registration verify = rest.postForObject(Constant.url + "/loginFrontEnd", map, Registration.class);
			if (verify.isError() == false) {
				mav = new ModelAndView("content/dashboard");
				System.out.println("Login :" + verify.getRegId());
				session.setAttribute("UserDetail", verify.getRegId());
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("langId", 1);
				List<NewsDetails> upcoming = rest.postForObject(Constant.url + "/getAllUpcomingEvents", map1,
						List.class);
				// List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
				System.out.println("list_new: " + upcoming.toString());
				mav.addObject("upcoming", upcoming);
				// model.addObject("pageMetaData", pageMetaData);
				session.setAttribute("getGallryImageURL", Constant.getGallryImageURL);
			} else {
				mav = new ModelAndView("login");
				System.out.println("Invalid login credentials");
				mav.addObject("msg", "Invalid login");
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public ModelAndView dashboard(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/upcoming-dashboard");

		HttpSession session = request.getSession();

		try {
			Registration UserDetail = (Registration) session.getAttribute("UserDetail");
			System.err.println("User Id: " + UserDetail.getRegId());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public ModelAndView registration(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("registration");
		try {

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/insertUserRegistration", method = RequestMethod.POST)
	public String insertUserRegistration(HttpServletRequest request, HttpServletResponse response) {

		String uuid = null;
		try {
			Registration registration = new Registration();

			int type = Integer.parseInt(request.getParameter("userType"));
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

				registration.setEmails(email);
				registration.setAlternateEmail(altEmail1);
				registration.setName(name);
				registration.setCollegeName(collegeName);
				registration.setUnversityName(university);
				registration.setDepartmentName(dept);
				registration.setUserType(1);
				registration.setMobileNumber(mobile);
				registration.setAuthorizedPerson(authour);
				registration.setDob(DateConvertor.convertToYMD(dob));

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

				registration.setMobileNumber(collegeMobile);
				registration.setEmails(collegeEmail);
				registration.setAlternateEmail(altEmail2);
				registration.setName(institute);
				registration.setAuthorizedPerson(cAuthour);
				registration.setAisheCode(aisheName1);
				registration.setUnversityName(univ);
				registration.setDepartmentName(collegeDept);
				registration.setDesignationName(designation);
				registration.setUserType(2);

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

				registration.setMobileNumber(uniMobile);
				registration.setEmails(uniEmail);
				registration.setAlternateEmail(altEmail3);
				registration.setAisheCode(aisheName2);
				registration.setName(uniName);
				registration.setAuthorizedPerson(uniAuthour);
				registration.setDepartmentName(uniDept);
				registration.setDesignationName(uniDes);
				registration.setUserType(3);

			}

			Date date = new Date(); // your date
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);

			uuid = UUID.randomUUID().toString();

			registration.setAddDate(sf.format(date));
			registration.setUserPassword("0");
			registration.setUserUuid(uuid);
			registration.setIsActive(0);
			registration.setDelStatus(1);
			registration.setRegisterVia("web");

			// contactUs.setRemark(null);

			Registration res = rest.postForObject(Constant.url + "/saveReg", registration, Registration.class);

		} catch (Exception e1) {
			e1.printStackTrace();
		}

		return "redirect:/ verifyOtp /" + uuid;
	}

	@RequestMapping(value = "/verifyOtp/{uuid}", method = RequestMethod.GET)
	public ModelAndView verifyOtp(@PathVariable("uuid") String uuid, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("otp");
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

	@RequestMapping(value = "/verifyOtpProcess", method = RequestMethod.POST)
	public ModelAndView verifyOtpProcess(HttpServletRequest request, HttpServletResponse res) throws IOException {

		String userOtp = request.getParameter("userOtp");
		String uuid = request.getParameter("uuid");

		System.out.println("UUID :" + uuid + ", UserOTP :" + userOtp);

		ModelAndView mav = new ModelAndView("otp");
		mav.addObject("uuid", uuid);
		RestTemplate rest = new RestTemplate();
		res.setContentType("text/html");
		HttpSession session = request.getSession();
		try {

			if (userOtp.equalsIgnoreCase("") || userOtp == null) {
				mav = new ModelAndView("otp");
				mav.addObject("uuid", uuid);
				mav.addObject("msg", "Invalid Otp");
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("userOtp", userOtp);
				map.add("uuid", uuid);

				OtpResponse verifyOtp = rest.postForObject(Constant.url + "/verifyOtpResponse", map, OtpResponse.class);

				if (verifyOtp.isError() == false) {
					mav = new ModelAndView("registration");
				} else {
					mav = new ModelAndView("otp");
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

	@RequestMapping(value = "/resendOtpProcess", method = RequestMethod.POST)
	public ModelAndView resendOtpProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("otp");
		try {

			String uuid = request.getParameter("uuid");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("uuid", uuid);

			OtpResponse verifyOtp = rest.postForObject(Constant.url + "/verifyResendOtpResponse", map,
					OtpResponse.class);

			if (verifyOtp.isError() == false) {
				mav = new ModelAndView("otp");
				mav.addObject("uuid", uuid);
				System.out.println(" update ragistration table new :");
			} else {
				mav = new ModelAndView("registration");
			}

			mav.addObject("uuid", uuid);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/getCurrentMonthEvents", method = RequestMethod.POST)
	public ModelAndView getCurrentMonthEvents(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("");
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dd = new SimpleDateFormat("dd-MM-yyyy");

			Calendar cal = Calendar.getInstance();

			Calendar cal1 = Calendar.getInstance();
			cal.set(cal1.get(Calendar.YEAR), cal1.get(Calendar.MONTH), 1);

			String firstDate = sdf.format(cal.getTimeInMillis());
			String firstDate1 = dd.format(cal.getTimeInMillis());
			cal.set(cal.DAY_OF_MONTH, cal.getActualMaximum(cal.DAY_OF_MONTH));
			String endDate = sdf.format(cal.getTimeInMillis());
			String endDate1 = dd.format(cal.getTimeInMillis());
			String uuid = request.getParameter("uuid");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("firstDate", firstDate);
			map.add("endDate", endDate);
			// map.add("firstDate", firstDate);

			NewsDetails monthDate = rest.postForObject(Constant.url + "/getCurrentMonthEvents", map, NewsDetails.class);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/applyEvent/{newsblogsId}", method = RequestMethod.GET)
	public ModelAndView applyEvent(@PathVariable int newsblogsId, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		// Registration userDetail=null;
		int userDetail = 0;
		ModelAndView mav = null;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			// userDetail =(Registration) session.getAttribute("UserDetail");
			try {
				userDetail = (int) session.getAttribute("UserDetail");

			} catch (Exception e) {
				userDetail = 0;
				e.printStackTrace();
			}

			// System.out.println("userDetail "+userDetail.getRegId());
			if (userDetail > 0) {

				System.out.println("User Id: " + userDetail);

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("newsblogsId", newsblogsId);
				map1.add("userId", userDetail);
				List<EventRegistration> appliedevent = rest.postForObject(Constant.url + "/getAppliedEvents", map1,
						List.class);
				if (appliedevent == null) {
					EventRegistration eventReg = new EventRegistration();

					Date date = new Date(); // your date
					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
					Calendar cal = Calendar.getInstance();
					cal.setTime(date);
					eventReg.setDelStatus(1);
					// eventReg.setEventRegId();
					eventReg.setIsActive(0);
					eventReg.setNewsblogsId(newsblogsId);
					eventReg.setRegDate(sf.format(date));
					eventReg.setUserId(userDetail);

					EventRegistration res = rest.postForObject(Constant.url + "/saveEventRegister", eventReg,
							EventRegistration.class);

					System.out.println("res Id: " + res.toString());

					if (res != null) {

						mav = new ModelAndView("content/eventList");
						mav.addObject("msg", "Successfully Registed Event");
					}
				} else {
					System.out.println("User Id: " + userDetail);
					mav = new ModelAndView("content/eventList");
					mav.addObject("msg", "Event Already Registered");
				}

			} else {
				System.out.println("User Id: " + userDetail);
				mav = new ModelAndView("login");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/upcomingEvents", method = RequestMethod.GET)
	public ModelAndView upcomingEvents(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView model = new ModelAndView("content/upcoming-dashboard");
		try {

			// session.setAttribute("mapping", "upcomingEvents");
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				/*
				 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
				 * Object>(); map.add("slugName", "upcomingEvents"); PageMetaData pageMetaData =
				 * rest.postForObject(Constant.url + "/getPageMetaData", map,
				 * PageMetaData.class);
				 */
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("langId", 1);
				List<NewsDetails> upcoming = rest.postForObject(Constant.url + "/getAllUpcomingEvents", map1,
						List.class);
				// List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
				System.out.println("list_new: " + upcoming.toString());
				model.addObject("upcoming", upcoming);
				// model.addObject("pageMetaData", pageMetaData);
				session.setAttribute("getGallryImageURL", Constant.getGallryImageURL);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/previousEvents", method = RequestMethod.GET)
	public ModelAndView previousEvents(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView model = new ModelAndView("content/previous-dashboard");
		try {

			// session.setAttribute("mapping", "upcomingEvents");
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				/*
				 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
				 * Object>(); map.add("slugName", "upcomingEvents"); PageMetaData pageMetaData =
				 * rest.postForObject(Constant.url + "/getPageMetaData", map,
				 * PageMetaData.class);
				 */
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("langId", 1);
				NewsDetails[] previousList = rest.postForObject(Constant.url + "/getAllPreviousEvents", map1,
						NewsDetails[].class);
				List<NewsDetails> previous = new ArrayList<NewsDetails>(Arrays.asList(previousList));
				System.out.println("list_new: " + previous.toString());
				model.addObject("previous", previous);
				// model.addObject("pageMetaData", pageMetaData);
				session.setAttribute("getGallryImageURL", Constant.getGallryImageURL);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public Info changePassword(HttpServletRequest request, HttpServletResponse response) {

		String newPass = request.getParameter("newPass");
		System.out.println( "newPass : " + newPass );
		ModelAndView mav= new ModelAndView("change-pass");
		HttpSession session = request.getSession();
		
		Info info = new Info();
		try {
			int userDetail = (int) session.getAttribute("UserDetail");
			if (newPass.equalsIgnoreCase("") || newPass == null) {
				mav = new ModelAndView("change-pass");
				mav.addObject("msg", "Invalid password");
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId",userDetail);
				map.add("password", newPass);

				info = rest.postForObject(Constant.url + "/changePassword", map, Info.class);
				mav = new ModelAndView("change-pass");
				System.out.println(info.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return info;
	}

	@RequestMapping(value = "/changePass", method = RequestMethod.GET)
	public ModelAndView changePass(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("change-pass");
		HttpSession session = request.getSession();
		try {
			
			//int userDetail = (int) session.getAttribute("UserDetail");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/getPasswordCheck", method = RequestMethod.GET)
	public @ResponseBody Info getPasswordCheck(HttpServletRequest request, HttpServletResponse response) {
		Info info = new Info();
		Registration verify = null;
		HttpSession session = request.getSession();
		String pass = request.getParameter("pass");

	//	int userDetail = 0;
		ModelAndView mav = null;
		int userDetail = (int) session.getAttribute("UserDetail");
		mav = new ModelAndView("change-pass");
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("userId", userDetail);
			map.add("pass", pass);

			info = rest.postForObject(Constant.url + "/getLastPassword", map, Info.class);
			/*
			 * if (verify.isError() == false) { mav = new ModelAndView("changePass");
			 * 
			 * } else { mav = new ModelAndView("changePass");
			 * System.out.println("Invalid Password "); mav.addObject("msg",
			 * "Invalid Password"); }
			 */
			System.out.println(info.toString());
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		return info;
	}
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("User Logout");

		session.invalidate();
		return "redirect:/";
	}
}
