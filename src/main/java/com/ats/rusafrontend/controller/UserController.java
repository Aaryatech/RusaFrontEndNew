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

import javax.servlet.http.Cookie;
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
import com.ats.rusafrontend.commen.InitializeSession;
import com.ats.rusafrontend.model.EventRecord;
import com.ats.rusafrontend.model.EventRegistration;
import com.ats.rusafrontend.model.InstituteInfo;
import com.ats.rusafrontend.model.Maintainance;
import com.ats.rusafrontend.model.NewsDetails;
import com.ats.rusafrontend.model.OtpResponse;
import com.ats.rusafrontend.model.PageMetaData;
import com.ats.rusafrontend.model.Registration;
import com.ats.rusafrontend.model.University;

@Controller
@Scope("session")
public class UserController {

 
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

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				String eventId = request.getParameter("event");
				String file = request.getParameter("file");
				
				model.addObject("eventId", eventId);
				model.addObject("siteKey", Constant.siteKey);
				model.addObject("flag", flag);
				model.addObject("file", file);
				flag = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/loginResponse", method = RequestMethod.POST)
	public String loginResponse(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();

		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		String mav = new String();

		try {
			

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {

				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("userName", userName);
				map.add("password", password);

				Registration verify = Constant.getRestTemplate().postForObject(Constant.url + "/loginFrontEnd", map, Registration.class);

				if (verify.isError() == false) {

					String eventId = request.getParameter("eventId");
					int langId = (Integer) session.getAttribute("langId");
					
					System.out.println("print: "+session.getId());
					session.removeAttribute("userDetail");
					session.removeAttribute("userInfo");
					session.invalidate();
					
					session = request.getSession();
					
					System.out.println("print2: "+request.getSession().getId());
					
					if (!eventId.equals("0")) {
						
						session.setAttribute("UserDetail", verify.getRegId()); 
						session.setAttribute("userInfo", verify);
						session.setAttribute("userType", (Integer) verify.getUserType());
						
						
						int file = Integer.parseInt(EmailUtility.DecodeKey(request.getParameter("file")));
						
						if(file==1) {
							mav="redirect:/applyEventFrontWithFile/"+EmailUtility.DecodeKey(String.valueOf(eventId));
						}else {
							mav="redirect:/applyEventFront/"+EmailUtility.DecodeKey(String.valueOf(eventId));
						}
						 
					} else {

						session.setAttribute("mapping", "upcomingEvents");
						
						
						if (session.getAttribute("menuList") == null) {
							InitializeSession.intializeSissionByLangId(request,langId);
						}
						
						if (verify.getExInt1() == 0) {
							mav = "changePass";
							session.setAttribute("UserDetail", verify.getRegId());

							session.setAttribute("userInfo", verify);

						} else {
							
							
							 
							session.setAttribute("UserDetail", verify.getRegId());

							session.setAttribute("userInfo", verify);
							session.setAttribute("userType", (Integer) verify.getUserType());

							MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

							map1.add("langId", langId);
							NewsDetails[] newsDetails = Constant.getRestTemplate().postForObject(Constant.url + "/getAllUpcomingEvents", map1,
									NewsDetails[].class);
							List<NewsDetails> upcoming = new ArrayList<NewsDetails>(Arrays.asList(newsDetails));

							MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
							map2.add("regId", verify.getRegId());
							Registration editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserbyRegId", map2,
									Registration.class);
							model.addAttribute("editReg", editReg);
							model.addAttribute("upcoming", upcoming);
							model.addAttribute("typeId", 2);
							session.setAttribute("info",editReg);
							session.setAttribute("successMsg", "Login Successful !");
							session.setAttribute("profileUrl", Constant.getUserProfileURL);
							mav = "redirect:/upcomingEvents";
						}
					}

				} else {
					
					
					String eventId = request.getParameter("eventId");
 
					if (!eventId.equals("0")) {
						
						String file = request.getParameter("file") ;
						mav = "redirect:/login?file="+file+"&event=" + eventId;
						
					}else {
						mav = "redirect:/login";
					}
					 
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
	public String dashboard(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();
		HttpSession session = request.getSession();

		try {
			session.setAttribute("mapping", "dashboard");

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {
				mav = "content/upcoming-dashboard";
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
				int userDetail = (int) session.getAttribute("UserDetail");
				System.out.println("userDetail : " + userDetail);
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail);
				Registration editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("langId", 1);
				List<NewsDetails> upcoming = Constant.getRestTemplate().postForObject(Constant.url + "/getAllUpcomingEvents", map1,
						List.class);
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

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				model.addObject("siteKey", Constant.siteKey);
				model.addObject("flag", flag);
				flag = 0;
				
				University[] university = Constant.getRestTemplate().getForObject(Constant.url + "/getUniversityList", University[].class);
				List<University> universityList = new ArrayList<>(Arrays.asList(university)); 
				model.addObject("universityList", universityList);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	
	@RequestMapping(value = "/getInstitute", method = RequestMethod.POST)
	public @ResponseBody List<InstituteInfo> getInstituteList(HttpServletRequest request,
			HttpServletResponse response) {

		 
		List<InstituteInfo> instituteInfolist = new ArrayList<>();
		try {
			
			int uniId = Integer.parseInt(request.getParameter("uniId"));
			 
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("uniId", uniId); 
			InstituteInfo[] instituteInfo = Constant.getRestTemplate().postForObject(Constant.url + "/getInstituteListByUniversityId",map,
					InstituteInfo[].class);
			
			instituteInfolist = new ArrayList<>(Arrays.asList(instituteInfo));
			 
		}catch(Exception e) {
			e.printStackTrace();
			 
		}
		
		return instituteInfolist;
 

	}
	
	@RequestMapping(value = "/getAshecodeByInstiid", method = RequestMethod.GET)
	public @ResponseBody InstituteInfo getAshecode(HttpServletRequest request,
			HttpServletResponse response) {

		 
		InstituteInfo instituteInfo  = new InstituteInfo();
		try {
			
			int instiId = Integer.parseInt(request.getParameter("instiId"));
			 
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("instiId", instiId); 
			 instituteInfo = Constant.getRestTemplate().postForObject(Constant.url + "/getInstituteInfoById",map,
					InstituteInfo .class);
			 
			 
		}catch(Exception e) {
			e.printStackTrace();
			 
		}
		
		return instituteInfo;
 

	}
	
	@RequestMapping(value = "/getInstituteInformation", method = RequestMethod.GET)
	public @ResponseBody InstituteInfo getInstituteInformation(HttpServletRequest request,
			HttpServletResponse response) {

		 
		InstituteInfo instituteInfo  = new InstituteInfo();
		try {
			
			String instiaisheCode =  request.getParameter("instiaisheCode") ;
			 
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("asheCode", instiaisheCode); 
			 instituteInfo = Constant.getRestTemplate().postForObject(Constant.url + "/getInstituteInfoByAsheCode",map,
					InstituteInfo .class);
			 
			if(instituteInfo==null) {
				instituteInfo  = new InstituteInfo();
			}
			 
			 
		}catch(Exception e) {
			e.printStackTrace();
			instituteInfo  = new InstituteInfo();
		}
		
		return instituteInfo;
 

	}

	@RequestMapping(value = "/insertUserRegistration", method = RequestMethod.POST)
	public String insertUserRegistration(HttpServletRequest request, HttpServletResponse response) {

		String uuid = null;
		HttpSession session = request.getSession();
		boolean error = false;
		
		try {
			Registration registration = new Registration(); 
			int type = Integer.parseInt(request.getParameter("type"));
			

			if (type == 1) {
				
				String university = request.getParameter("university") ;
				String collegeName = request.getParameter("collegeName") ;
				String indAshecode = request.getParameter("indAshecode");
				String name = request.getParameter("name");
				String inddesognation = request.getParameter("inddesognation");
				String depatment = request.getParameter("depatment");
				String mobile = request.getParameter("mobile");
				String email = request.getParameter("email");
				String altEmail1 = request.getParameter("altEmail");
				 
				registration.setEmails(email);
				registration.setAlternateEmail(altEmail1);
				registration.setName(name);
				registration.setCollegeName(collegeName);
				registration.setUnversityName(university);
				registration.setDepartmentName(depatment);
				registration.setUserType(1);
				registration.setMobileNumber(mobile);
				registration.setDesignationName(inddesognation);
				registration.setAisheCode(indAshecode);
				  
			}
			if (type == 2) {
				
				String instiaisheCode = request.getParameter("instiaisheCode");
				String univ = request.getParameter("univ");
				String institute = request.getParameter("institute");
				String designation = request.getParameter("instidesignation");
				String cAuthour = request.getParameter("cAuthour");
				String collegeDept = request.getParameter("instiDept");
				String collegeMobile = request.getParameter("instiMobile"); 
				String instiEmail = request.getParameter("instiEmail");
				String instialtEmail = request.getParameter("instialtEmail");
				 
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("asheCode", instiaisheCode); 
				InstituteInfo instituteInfo = Constant.getRestTemplate().postForObject(Constant.url + "/getInstituteInfoByAsheCode",map,
						InstituteInfo .class);
				  
				if(instituteInfo!=null && instituteInfo.getYesNo()!=1) {
					registration.setMobileNumber(collegeMobile);
					registration.setEmails(instiEmail);
					registration.setAlternateEmail(instialtEmail);
					registration.setName(instituteInfo.getInsName());
					registration.setAuthorizedPerson(cAuthour);
					registration.setAisheCode(instiaisheCode);
					registration.setUnversityName(String.valueOf(instituteInfo.getAffUniversity()));
					registration.setCollegeName(String.valueOf(instituteInfo.getMhInstId()));
					registration.setDepartmentName(collegeDept);
					registration.setDesignationName(designation);
					registration.setUserType(2); 
				}else {
					error=true;
				}
			}
			if (type == 3) {
				
				String uniName = request.getParameter("uniName");
				String uniaisheName = request.getParameter("uniaisheName");
				String uniinstitute = request.getParameter("uniinstitute"); 
				String uniAuthour = request.getParameter("uniAuthour");
				String uniDes = request.getParameter("uniDes");
				String uniDept = request.getParameter("uniDept");
				String uniMobile = request.getParameter("uniMobile"); 
				String uniEmail = request.getParameter("uniEmail"); 
				String unialtEmail = request.getParameter("unialtEmail");
				 
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("asheCode", uniaisheName); 
				InstituteInfo instituteInfo = Constant.getRestTemplate().postForObject(Constant.url + "/getInstituteInfoByAsheCode",map,
						InstituteInfo .class);
				if(instituteInfo!=null && instituteInfo.getYesNo()!=1 ) {
					
					registration.setMobileNumber(uniMobile);
					registration.setEmails(uniEmail);
					registration.setAlternateEmail(unialtEmail);
					registration.setAisheCode(uniaisheName);
					registration.setName(instituteInfo.getInsName());
					registration.setUnversityName(String.valueOf(instituteInfo.getAffUniversity()));
					registration.setCollegeName(String.valueOf(instituteInfo.getMhInstId()));
					registration.setAuthorizedPerson(uniAuthour);
					registration.setDepartmentName(uniDept);
					registration.setDesignationName(uniDes);
					registration.setUserType(3);
					 
				}else {
					error=true;
				}
				

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

			if(error==false) {
				Registration res = Constant.getRestTemplate().postForObject(Constant.url + "/saveReg", registration, Registration.class);
				return "redirect:/verifyOtp/"+uuid;
			}else {
				session.setAttribute("errorMsg", "Failed To Register");
				return "redirect:/registration"; 
			}
			

		} catch (Exception e1) {
			System.out.println("ex " + e1.getMessage());
			e1.printStackTrace();
			error=true;
			session.setAttribute("errorMsg", "Failed To Register");
			return "redirect:/registration"; 
		}
		 
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
			 * Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url +
			 * "/checkIsMaintenance", Maintainance.class); if
			 * (maintainance.getMaintenanceStatus() == 1) {
			 * 
			 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
			 * maintainance); } else { MultiValueMap<String, Object> map = new
			 * LinkedMultiValueMap<String, Object>(); map.add("slugName", "login");
			 * PageMetaData pageMetaData = Constant.getRestTemplate().postForObject(Constant.url +
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
	public String verifyOtpProcess(HttpServletRequest request, HttpServletResponse res) throws IOException {

		String userOtp = request.getParameter("userOtp");
		String uuid = request.getParameter("uuid");
		System.out.println("UUID :" + uuid + ", UserOTP :" + userOtp);

		ModelAndView mav = new ModelAndView("otp");
		mav.addObject("uuid", uuid);
		 
		res.setContentType("text/html");
		HttpSession session = request.getSession();
		try {

			if (userOtp.equalsIgnoreCase(" ") || userOtp == null) {
				mav = new ModelAndView("otp");
				mav.addObject("uuid", uuid);
				// mav.addObject("msg", "Invalid Otp");
				session.setAttribute("errorMsg", "Invalid OTP !");
				return "redirect:/verifyOtp/"+uuid; 
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("userOtp", userOtp);
				map.add("uuid", uuid);

				OtpResponse verifyOtp = Constant.getRestTemplate().postForObject(Constant.url + "/verifyOtpResponse", map, OtpResponse.class);

				if (verifyOtp.isError() == false) {
					mav = new ModelAndView("registration");
					session.setAttribute("success", "Registration Successful !");
					return "redirect:/registration";
				} else {
					mav = new ModelAndView("otp");
					mav.addObject("uuid", uuid);
					session.setAttribute("errorMsg", "Invalid OTP !");
					return "redirect:/verifyOtp/"+uuid; 
				}
			}
		} catch (Exception e) {
			System.out.println("HomeController Login API Excep:  " + e.getMessage());
			e.printStackTrace();
			mav.addObject("msg", "Invalid login");
			session.setAttribute("errorMsg", "Invalid OTP !");
			return "redirect:/registration";
		}

		
	}

	@RequestMapping(value = "/resendOtpProcess", method = RequestMethod.POST)
	public ModelAndView resendOtpProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("otp");
		HttpSession session = request.getSession();
		try {
			session.setAttribute("mapping", "resendOtpProcess");

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
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

				OtpResponse verifyOtp = Constant.getRestTemplate().postForObject(Constant.url + "/verifyResendOtpResponse", map,
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

			NewsDetails monthDate = Constant.getRestTemplate().postForObject(Constant.url + "/getCurrentMonthEvents", map, NewsDetails.class);

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
		Info info = null;
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

				int langId = (Integer) session.getAttribute("langId");
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId); 
				map1.add("newsblogsId", newsblogsId);
				NewsDetails eventList = Constant.getRestTemplate().postForObject(Constant.url + "/getEventListByNewsId", map1,
						NewsDetails.class); 
				int userType = (Integer) session.getAttribute("userType"); 
				String[] ids = eventList.getExVar2().split(",");

				int allowd=0;
				
				for (int i = 0; i < ids.length; i++) {

					if (userType == Integer.parseInt(ids[i])) {
						allowd=1;
						break;
					}
				}

				if(allowd==1) {
					
					map1 = new LinkedMultiValueMap<String, Object>();

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

						EventRegistration res = Constant.getRestTemplate().postForObject(Constant.url + "/saveEventRegister", eventReg,
								EventRegistration.class);

						if (res != null) {

							session.setAttribute("success", "Successfully Registed Event !");
						}
					} else {
						session.setAttribute("errorMsg", "Event Already Registered !"); 
					}
				}else {
					session.setAttribute("errorMsg", "You can't apply for this event !"); 
				}
				 
				ss = "redirect:/eventDetailfront/" + EmailUtility.Encrypt(String.valueOf(newsblogsId));

			} else {
				session.setAttribute("errorMsg", "Please login for apply event !");
				ss = "redirect:/login?file="+EmailUtility.Encrypt(String.valueOf(0))+"&event=" + EmailUtility.Encrypt(String.valueOf(newsblogsId));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ss;
	}

	@RequestMapping(value = "/upcomingEvents", method = RequestMethod.GET)
	public String upcomingEvents(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		// ModelAndView model = new ModelAndView("content/upcoming-dashboard");
		String ret = new String();

		try {
			session.setAttribute("mapping", "upcomingEvents");

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				// model = new ModelAndView("maintainance");
				model.addAttribute("maintainance", maintainance);
				ret = "maintainance";
			} else {
				int langId = (Integer) session.getAttribute("langId");
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
				int userDetail = (int) session.getAttribute("UserDetail");

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

				map1.add("langId", langId);
				NewsDetails[] upcoming = Constant.getRestTemplate().postForObject(Constant.url + "/getAllUpcomingEvents", map1,
						NewsDetails[].class);
				List<NewsDetails> upcomingList = new ArrayList<NewsDetails>(Arrays.asList(upcoming));

				for (int i = 0; i < upcomingList.size(); i++) {
					upcomingList.get(i)
							.setExVar1(EmailUtility.Encrypt(String.valueOf(upcomingList.get(i).getNewsblogsId())));
				}

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail);
				Registration editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
				model.addAttribute("editReg", editReg);
				// System.out.println("list_new: " + upcoming.toString());
				model.addAttribute("upcoming", upcomingList);
				model.addAttribute("typeId", EmailUtility.Encrypt(String.valueOf(2)));
				// model.addObject("value", 0);

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
	public String previousEvents(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();
		String mav = new String();

		try {
			session.setAttribute("mapping", "previousEvents");
			int userDetail = (int) session.getAttribute("UserDetail");
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {

				mav = "content/previous-dashboard";
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				int langId = (Integer) session.getAttribute("langId");
				
				map1.add("langId", langId);
				map1.add("userId", userDetail);
				EventRecord[] previousList = Constant.getRestTemplate().postForObject(Constant.url + "/allPreviousEventWithApllied", map1,
						EventRecord[].class);
				List<EventRecord> previous = new ArrayList<EventRecord>(Arrays.asList(previousList));

				for (int i = 0; i < previous.size(); i++) {
					previous.get(i).setExVar1(EmailUtility.Encrypt(String.valueOf(previous.get(i).getNewsblogsId())));
				}

				// List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail);
				Registration editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
				model.addAttribute("editReg", editReg);
				// System.out.println("list_new: " + previous.toString());
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

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {
				mav = "change-pass";
				model.addAttribute("siteKey", Constant.siteKey);
				model.addAttribute("flag", flag);
				flag = 0;
				int userDetail = (int) session.getAttribute("UserDetail");
				System.out.println("userDetail : " + userDetail);
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail);
				Registration editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
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

		// int userDetail = 0;
		ModelAndView mav = null;
		int userDetail = (int) session.getAttribute("UserDetail");
		mav = new ModelAndView("change-pass");
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("userId", userDetail);
			map.add("pass", pass);

			info = Constant.getRestTemplate().postForObject(Constant.url + "/checkPasswordByUserId", map, Info.class);
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
	public String logout(HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("User Logout");
		// int userDetail = (int) session.getAttribute("UserDetail");
		Cookie[] cookies = request.getCookies();
	    if (cookies != null)
	        for (Cookie cookie : cookies) {
	            cookie.setValue("");
	            cookie.setPath("/");
	            cookie.setMaxAge(0);
	            response.addCookie(cookie);
	        }
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
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

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

			Registration verify = Constant.getRestTemplate().postForObject(Constant.url + "/forgetPassword", map, Registration.class);
			if (verify.isError() == false) {
				session.setAttribute("success", "Please Check mail !");
				// System.out.println("Login :" + verify.getRegId());
				// session.setAttribute("UserDetail", verify.getRegId());

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
	public String fillFeedback(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {
			HttpSession session = request.getSession();
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			session.setAttribute("mapping", "fillFeeback");

			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {
				int userDetail = (int) session.getAttribute("UserDetail");
				String id = request.getParameter("eventId");

				int eventId = Integer.parseInt(EmailUtility.DecodeKey(String.valueOf(id)));
				mav = "eventfeedback";
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("regId", userDetail);
				Registration editReg = Constant.getRestTemplate().postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
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
			String msg = request.getParameter("message");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("userId", userDetail);
			map.add("eventId", eventId);
			map.add("value", value);
			map.add("messge", msg);
			Info update = Constant.getRestTemplate().postForObject(Constant.url + "/updateEventFeedback", map, Info.class);

			if (update.isError() == true) {
				session.setAttribute("errorMsg", "Failed to submit feedback ");
			} else {
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
			System.out.println("values are   " + inputValue + valueType + primaryKey);

			map.add("inputValue", inputValue);
			map.add("valueType", valueType);
			map.add("primaryKey", primaryKey);

			info = Constant.getRestTemplate().postForObject(Constant.url + "checkUniqueField", map, Info.class);
			System.err.println("Info Response  " + info.toString());

		} catch (Exception e) {
			System.err.println("Exce in checkUniqueField  " + e.getMessage());
			e.printStackTrace();
		}

		return info;

	}

}
