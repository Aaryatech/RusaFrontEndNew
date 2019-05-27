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
import org.springframework.ui.Model;
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
import com.ats.rusafrontend.model.EventRecord;
import com.ats.rusafrontend.model.EventRegistration;
import com.ats.rusafrontend.model.Maintainance;
import com.ats.rusafrontend.model.NewsDetails;
import com.ats.rusafrontend.model.OtpResponse;
import com.ats.rusafrontend.model.PageMetaData;
import com.ats.rusafrontend.model.Registration;


@Controller
@Scope("session")
public class UserController {

	RestTemplate rest = new RestTemplate();
	int flag = 0;
	/*
	 * <dependency> <groupId>com.fasterxml.uuid</groupId>
	 * <artifactId>java-uuid-generator</artifactId> <version>3.1.4</version>
	 * </dependency>
	 */

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("login");
		try {
			HttpSession session = request.getSession();
			session.setAttribute("mapping", "login");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
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

	@RequestMapping(value = "/loginResponse", method = RequestMethod.POST)
	public String loginResponse(HttpServletRequest request, HttpServletResponse response,Model model) {

		HttpSession session = request.getSession();

		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		 String mav = new String();
		 
		try {
			session.setAttribute("mapping", "upcomingEvents");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav ="maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {
			
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("userName", userName);
				map.add("password", password);

				Registration verify = rest.postForObject(Constant.url + "/loginFrontEnd", map, Registration.class);
				if (verify.isError() == false) {
					
					System.out.println("verify.getExInt1() " + verify.getExInt1());
					if(verify.getExInt1()==0)
					{
						mav = "changePass" ;
						session.setAttribute("UserDetail", verify.getRegId());
						
						session.setAttribute("userInfo", verify);
						
					}
					else
					{
					mav = "redirect:/upcomingEvents" ;
					//System.out.println("Login :" + verify.getRegId());
					session.setAttribute("UserDetail", verify.getRegId());
					
					session.setAttribute("userInfo", verify);
					session.setAttribute("userType", (Integer) verify.getUserType());
					
					MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

					map1.add("langId", 1);
					List<NewsDetails> upcoming = rest.postForObject(Constant.url + "/getAllUpcomingEvents", map1,
							List.class);
					// List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
					//System.out.println("list_new: " + upcoming.toString());
					MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
					map2.add("regId",  verify.getRegId()); 
					Registration editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map2, Registration.class);
					model.addAttribute("editReg", editReg);
					model.addAttribute("upcoming", upcoming);
					// model.addObject("pageMetaData", pageMetaData);
					model.addAttribute("typeId", 2);
					session.setAttribute("successMsg", "Login Successful !");			
					session.setAttribute("profileUrl", Constant.getUserProfileURL);
					}
				} else {
					mav = "login" ;
					//System.out.println("Invalid login credentials");				
					session.setAttribute("errorMsg", true);
					session.setAttribute("errorMsg", "Invalid login credentials !");
				}
			}
			
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(HttpServletRequest request, HttpServletResponse response,Model model) {

		String mav = new String() ;
		HttpSession session = request.getSession();

		try {			
			session.setAttribute("mapping", "dashboard");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance" ;
				model.addAttribute("maintainance", maintainance);
			} else {
				mav = "content/upcoming-dashboard" ;
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
			int userDetail = (int) session.getAttribute("UserDetail");
			System.out.println("userDetail : "+userDetail);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("regId", userDetail); 
			Registration editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
			
			MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

			map1.add("langId", 1);
			List<NewsDetails> upcoming = rest.postForObject(Constant.url + "/getAllUpcomingEvents", map1,List.class);
			model.addAttribute("editReg", editReg);
			System.out.println("list_new: " + upcoming.toString());
			model.addAttribute("upcoming", upcoming);
			model.addAttribute("typeId", 2);
			 
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav = "login";
		}

		return mav;
	}

	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public ModelAndView registration(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("registration");
		try {
			HttpSession session = request.getSession();
			session.setAttribute("mapping", "registration");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
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
			//	String dob = request.getParameter("dob");
				String mobile = request.getParameter("mobile");
				String designation = request.getParameter("authour");

				registration.setEmails(email);
				registration.setAlternateEmail(altEmail1);
				registration.setName(name);
				registration.setCollegeName(collegeName);
				registration.setUnversityName(university);
				registration.setDepartmentName(dept);
				registration.setUserType(1);
				registration.setMobileNumber(mobile);
				registration.setDesignationName(designation);
				
			}
			if (type == 2) {
				String collegeEmail = request.getParameter("collegeEmail");
				String altEmail2 = request.getParameter("altEmail");
				String institute = request.getParameter("institute");
				String aisheName1 = request.getParameter("aisheName");
				String univ = request.getParameter("univ");
				String collegeDept = request.getParameter("dept");
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
  
			  
			Registration res = rest.postForObject(Constant.url + "/saveReg", registration, Registration.class);

		} catch (Exception e1) {
			System.out.println("ex " +e1.getMessage());
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
			 * HttpSession session = request.getSession(); session.setAttribute("mapping",
			 * "verifyOtp");
			 * 
			 * Maintainance maintainance = rest.getForObject(Constant.url +
			 * "/checkIsMaintenance", Maintainance.class); if
			 * (maintainance.getMaintenanceStatus() == 1) {
			 * 
			 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
			 * maintainance); } else { MultiValueMap<String, Object> map = new
			 * LinkedMultiValueMap<String, Object>(); map.add("slugName", "login");
			 * PageMetaData pageMetaData = rest.postForObject(Constant.url +
			 * "/getPageMetaData", map, PageMetaData.class); model.addObject("pageMetaData",
			 * pageMetaData); model.addObject("siteKey", Constant.siteKey);
			 * model.addObject("flag", flag); flag = 0; }
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

			if (userOtp.equalsIgnoreCase(" ") || userOtp == null) {
				mav = new ModelAndView("otp");
				mav.addObject("uuid", uuid);
				//mav.addObject("msg", "Invalid Otp");
				session.setAttribute("errorMsg", "Invalid OTP !");
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("userOtp", userOtp);
				map.add("uuid", uuid);

				OtpResponse verifyOtp = rest.postForObject(Constant.url + "/verifyOtpResponse", map, OtpResponse.class);

				if (verifyOtp.isError() == false) {
					mav = new ModelAndView("registration");
					session.setAttribute("success", "Registration Successful !");
				} else {
					mav = new ModelAndView("otp");
					mav.addObject("uuid", uuid);
					session.setAttribute("errorMsg", "Invalid OTP !");
					
				}
			}
		} catch (Exception e) {
			System.out.println("HomeController Login API Excep:  " + e.getMessage());
			e.printStackTrace();
			mav.addObject("msg", "Invalid login");
			session.setAttribute("errorMsg", "Invalid OTP !");
		}

		return mav;
	}

	@RequestMapping(value = "/resendOtpProcess", method = RequestMethod.POST)
	public ModelAndView resendOtpProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("otp");
		HttpSession session = request.getSession();
		try {
			session.setAttribute("mapping", "resendOtpProcess");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = new ModelAndView("maintainance");
				mav.addObject("maintainance", maintainance);
			} else {
			
				mav.addObject("siteKey", Constant.siteKey);
				mav.addObject("flag", flag);
				flag = 0;
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
			}
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

	@RequestMapping(value = "/applyEventFront/{newsblogsId}", method = RequestMethod.GET)
	public String applyEventFront(@PathVariable int newsblogsId, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		// Registration userDetail=null;
		int userDetail = 0;
		Info info=null;
		String ss = new String();
		
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
				info = rest.postForObject(Constant.url + "/getAppliedEvents", map1,
						Info.class);
				if (info.isError()== true) {
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

				

					if (res != null) {

						session.setAttribute("success", "Successfully Registed Event !");
					}
				} else {
					session.setAttribute("errorMsg", "Event Already Registered !");
				//	session.setAttribute("msg", "Event Already Registered");
				}

				ss = "redirect:/eventDetailfront/" + newsblogsId;
				
			} else {
				session.setAttribute("errorMsg", "Please Login !"); 
				ss = "redirect:/login";
			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ss;
	}

	@RequestMapping(value = "/upcomingEvents", method = RequestMethod.GET)
	public String upcomingEvents(HttpServletRequest request, HttpServletResponse response,Model model) {
		HttpSession session = request.getSession();
		
		
		//ModelAndView model = new ModelAndView("content/upcoming-dashboard");
		String ret = new String();
		
		try {
			session.setAttribute("mapping", "upcomingEvents");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				//model = new ModelAndView("maintainance");
				model.addAttribute("maintainance", maintainance);
				ret = "maintainance";
			} else {
				
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
			int userDetail = (int) session.getAttribute("UserDetail");
							
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("langId", 1);
				NewsDetails[] upcoming = rest.postForObject(Constant.url + "/getAllUpcomingEvents", map1,
						NewsDetails[].class);
				 List<NewsDetails> upcomingList = new ArrayList<NewsDetails>(Arrays.asList(upcoming));
				 
				 for(int i = 0 ; i <upcomingList.size() ; i++) {
					 upcomingList.get(i).setExVar1(EmailUtility.Encrypt(String.valueOf(upcomingList.get(i).getNewsblogsId())));
				 }
				 
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail); 
				Registration editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
				model.addAttribute("editReg", editReg);
				//System.out.println("list_new: " + upcoming.toString());
				model.addAttribute("upcoming", upcomingList);
				model.addAttribute("typeId", EmailUtility.Encrypt(String.valueOf(2)));
			//	model.addObject("value", 0);
				
				// model.addObject("pageMetaData", pageMetaData);
				 
				
				ret = "content/upcoming-dashboard";
			}

		} catch (Exception e) {
			e.printStackTrace();
			ret = "login";
			 
		}

		return ret;
	}

	@RequestMapping(value = "/previousEvents", method = RequestMethod.GET)
	public String previousEvents(HttpServletRequest request, HttpServletResponse response,Model model) {
		HttpSession session = request.getSession();
		String mav = new String();
		
		try {
			session.setAttribute("mapping", "previousEvents");
			int userDetail = (int) session.getAttribute("UserDetail"); 
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance" ;
				model.addAttribute("maintainance", maintainance);
			} else {
				
				mav =  "content/previous-dashboard" ;
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("langId", 1);
				map1.add("userId", userDetail);
				EventRecord[] previousList = rest.postForObject(Constant.url + "/allPreviousEventWithApllied", map1,
						EventRecord[].class);
				List<EventRecord> previous = new ArrayList<EventRecord>(Arrays.asList(previousList));
				
				 for(int i = 0 ; i <previous.size() ; i++) {
					 previous.get(i).setExVar1(EmailUtility.Encrypt(String.valueOf(previous.get(i).getNewsblogsId()))); 
				 }
				
				// List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail); 
				Registration editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
				model.addAttribute("editReg", editReg);
				//System.out.println("list_new: " + previous.toString());
				model.addAttribute("previous", previous);
				model.addAttribute("typeId", EmailUtility.Encrypt(String.valueOf(1)));
				model.addAttribute("documentUrl", Constant.getCmsPdf);
				// model.addObject("pageMetaData", pageMetaData);
				 

			}

		} catch (Exception e) {
			e.printStackTrace();
			mav = "login";
		}

		return mav;
	}

	

	@RequestMapping(value = "/changePass", method = RequestMethod.GET)
	public String changePass(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();
		
		HttpSession session = request.getSession();
		try {
			session.setAttribute("mapping", "changePass");
			
			
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance" ;
				model.addAttribute("maintainance", maintainance);
			} else {
				mav = "change-pass" ;
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
			int userDetail = (int) session.getAttribute("UserDetail");
			System.out.println("userDetail : "+userDetail);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("regId", userDetail); 
			Registration editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
			model.addAttribute("editReg", editReg);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav = "login";
		}

		return mav;
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

			info = rest.postForObject(Constant.url + "/checkPasswordByUserId", map, Info.class);
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
		//int userDetail = (int) session.getAttribute("UserDetail");
		session.removeAttribute("userDetail");
		session.removeAttribute("userInfo");
		session.invalidate();
		return "redirect:/";
	}
	@RequestMapping(value = "/forgetPass", method = RequestMethod.GET)
	public ModelAndView forgetPass(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("forget-pass");
		HttpSession session = request.getSession();
		try {
			session.setAttribute("mapping", "forgetPass");
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

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
	
	@RequestMapping(value = "/forgetPassword", method = RequestMethod.POST)
	public String forgetPassword(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String userName = request.getParameter("userName");
		String mobileNumber = request.getParameter("phone");
	
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("email", userName);
			map.add("mobileNumber", mobileNumber);

			Registration verify = rest.postForObject(Constant.url + "/forgetPassword", map, Registration.class);
			if (verify.isError() == false) {	
				session.setAttribute("success", "Please Check mail !");
			//	System.out.println("Login :" + verify.getRegId());
				//session.setAttribute("UserDetail", verify.getRegId());
				
			} else {
				session.setAttribute("errorMsg", "Invalid credentials !");
				System.out.println("Invalid credentials");
				
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		return "redirect:/login";
	}
	
	@RequestMapping(value = "/fillFeeback", method = RequestMethod.GET)
	public String fillFeedback(HttpServletRequest request, HttpServletResponse response,Model model) {
 
		String mav = new String();
		
		try {
			HttpSession session = request.getSession();
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			session.setAttribute("mapping", "fillFeeback");
			
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance" ;
				model.addAttribute("maintainance", maintainance);
			}else {
				int userDetail = (int) session.getAttribute("UserDetail");
				String id =  request.getParameter("eventId") ;
				
				int eventId = Integer.parseInt(EmailUtility.DecodeKey(String.valueOf(id)));
				mav =  "eventfeedback" ;
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail); 
				Registration editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
				model.addAttribute("editReg", editReg);
				model.addAttribute("eventId", eventId);
			}
			
			 
		} catch (Exception e1) {
			e1.printStackTrace();
			mav = "login";
		}

		return mav;
	}
	
	@RequestMapping(value = "/submitFeedbackForm", method = RequestMethod.POST)
	public String submitFeedbackForm(HttpServletRequest request, HttpServletResponse response) {
  
	
		HttpSession session = request.getSession();
		
		try {
			
			
			int userDetail = (int) session.getAttribute("UserDetail");
			int eventId = Integer.parseInt(request.getParameter("eventId"));
			int value = Integer.parseInt(request.getParameter("formType"));
			String msg =  request.getParameter("message") ;
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("userId", userDetail);
			map.add("eventId", eventId);
			map.add("value", value);
			map.add("messge", msg); 
			Info update = rest.postForObject(Constant.url + "/updateEventFeedback", map, Info.class);
			
			if(update.isError()==true) {
				session.setAttribute("errorMsg", "Failed to submit feedback ");
			}else {
				session.setAttribute("success", "Feebback submited Successfully !");
			}
			
			
		} catch (Exception e1) {
			session.setAttribute("errorMsg", "Failed to submit feedback ");
			e1.printStackTrace();
		}

		return "redirect:/upcomingEvents";
	}
	@RequestMapping(value = "/checkUniqueField", method = RequestMethod.GET)
    public @ResponseBody Info checkUniqueField(HttpServletRequest request, HttpServletResponse response) {

        Info info = new Info();

        try {

            MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

            String inputValue = request.getParameter("inputValue");
            int valueType = Integer.parseInt(request.getParameter("valueType"));
            int primaryKey = Integer.parseInt(request.getParameter("primaryKey"));
         System.out.println("values are   "+inputValue+valueType+primaryKey);
          
            map.add("inputValue", inputValue);
            map.add("valueType", valueType);
            map.add("primaryKey", primaryKey);
            
            
            
            

            info = rest.postForObject(Constant.url + "checkUniqueField", map, Info.class);
            System.err.println("Info Response  " + info.toString());

        } catch (Exception e) {
            System.err.println("Exce in checkUniqueField  " + e.getMessage());
            e.printStackTrace();
        }

        return info;

    }

}
