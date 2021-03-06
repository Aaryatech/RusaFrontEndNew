package com.ats.rusafrontend.controller;

import java.net.InetAddress;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.TimeZone;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.commen.EmailUtility;
import com.ats.rusafrontend.commen.FormValidation;
import com.ats.rusafrontend.commen.Info;
import com.ats.rusafrontend.commen.InitializeSession;
import com.ats.rusafrontend.commen.SessionKeyGen;
import com.ats.rusafrontend.commen.VpsImageUpload;
import com.ats.rusafrontend.commen.XssEscapeUtils;
import com.ats.rusafrontend.model.*;
import com.ats.rusafrontend.reCaptcha.VerifyRecaptcha;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

@Controller
@Scope("session")
public class ImageController {

	/*---Dependency:------
		<dependency>
	<groupId>org.glassfish</groupId>
	<artifactId>javax.json</artifactId>
	<version>1.0.2</version>
	</dependency>*/

	ContactUs contactUs = new ContactUs();
	int flag = 0;

	@RequestMapping(value = "/NewsDetails/{newsblogsId}", method = RequestMethod.GET)
	public ModelAndView getImageLink(@PathVariable String newsblogsId, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();

		ModelAndView model = new ModelAndView("content/news-detail");

		try {
			newsblogsId = XssEscapeUtils.jsoupParse(newsblogsId);
			session.setAttribute("mapping", "NewsDetails-" + newsblogsId);

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				if (session.getAttribute("menuList") == null) {
					InitializeSession.intializeSission(request);
				}
				int langId = (Integer) session.getAttribute("langId");

				int newsId = Integer.parseInt(EmailUtility.DecodeKey(String.valueOf(newsblogsId)));

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("newsblogsId", newsId);
				map1.add("langId", langId);
				NewsDetails image = Constant.getRestTemplate().postForObject(Constant.url + "/getNewsListByNewsId",
						map1, NewsDetails.class);
				// List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
				// System.out.println("list_new: " + image.toString());
				model.addObject("image", image);
				session.setAttribute("getGallryImageURL", Constant.getGallryImageURL);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	/*
	 * @RequestMapping(value = "/NewsDetails/{langId}/{pageId}/{newsblogsId}",
	 * method = RequestMethod.GET) public ModelAndView getImageLink(@PathVariable
	 * int langId, @PathVariable int pageId, @PathVariable int newsblogsId,
	 * HttpServletRequest request, HttpServletResponse response) {
	 * 
	 * ModelAndView model = new ModelAndView("content/news-detail"); try {
	 * 
	 * Maintainance maintainance =
	 * Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
	 * Maintainance.class);
	 * 
	 * if (maintainance.getMaintenanceStatus() == 1) {
	 * 
	 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
	 * maintainance); } else {
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("langId", langId); TopMenuList sectionTree =
	 * Constant.getRestTemplate().postForObject(Constant.url + "/getTopMenuList",
	 * map, TopMenuList.class); model.addObject("menuList", sectionTree);
	 * 
	 * MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String,
	 * Object>(); map1.add("langId", langId); map1.add("pageId", pageId);
	 * map1.add("newsblogsId", newsblogsId); NewsDetails image =
	 * Constant.getRestTemplate().postForObject(Constant.url + "/getNewsBlogById",
	 * map1, NewsDetails.class); // List<ImageLink> imagList = new
	 * ArrayList<ImageLink>(Arrays.asList(image)); System.out.println("list_new: " +
	 * image.toString()); model.addObject("image", image);
	 * model.addObject("getGallryImageURL", Constant.getGallryImageURL);
	 * 
	 * }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return model; }
	 */

	@RequestMapping(value = "/ContactUs", method = RequestMethod.GET)
	public ModelAndView ContactUs(HttpServletRequest request, HttpServletResponse response) {

		// System.out.println("langI d ***"+langId);
		ModelAndView model = null;

		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "ContactUs");

			int langId = 1;

			try {
				langId = (Integer) session.getAttribute("langId");
			} catch (Exception e) {
				// e.printStackTrace();
				session.setAttribute("langId", langId);
			}

			if (langId == 2) {
				model = new ModelAndView("content/contactUsMarathi");
			} else {
				model = new ModelAndView("content/contactUs");
			}

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

	@RequestMapping(value = "/teamDetails", method = RequestMethod.GET)
	public ModelAndView teamDetails(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/teamDetails");
		try {
			int langId = 1;

			HttpSession session = request.getSession();

			try {
				langId = (Integer) session.getAttribute("langId");
			} catch (Exception e) {
				// e.printStackTrace();
				session.setAttribute("langId", langId);
			}

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				/*
				 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
				 * Object>(); map.add("langId", langId);
				 * 
				 * TopMenuList sectionTree =
				 * Constant.getRestTemplate().postForObject(Constant.url + "/getTopMenuList",
				 * map, TopMenuList.class);
				 * 
				 * // HttpSession session = request.getSession();
				 * session.setAttribute("menuList", sectionTree);
				 */
				session.setAttribute("mapping", "teamDetails");

				TestImonial[] getTeamList = Constant.getRestTemplate().getForObject(Constant.url + "/getTeamDetail",
						TestImonial[].class);
				List<TestImonial> teamList = new ArrayList<TestImonial>(Arrays.asList(getTeamList));
				model.addObject("teamList", teamList);
				model.addObject("gallryImageURL", Constant.getGallryImageURL);

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("slugName", "teamDetails");
				PageMetaData pageMetaData = Constant.getRestTemplate().postForObject(Constant.url + "/getPageMetaData",
						map1, PageMetaData.class);
				model.addObject("pageMetaData", pageMetaData);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/insertContactUs", method = RequestMethod.POST)
	public String insertContactUs(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String a = new String();
		try {

			String token = request.getParameter("token");
			String key = (String) session.getAttribute("generatedKey");

			if (token.trim().equals(key.trim())) {
				a = "redirect:/ContactUs";

				final long serialVersionUID = -6506682026701304964L;

				String name = XssEscapeUtils.jsoupParse(request.getParameter("name")).trim().replaceAll("[ ]{2,}", " ");
				String email = XssEscapeUtils.jsoupParse(request.getParameter("email")).trim().replaceAll("[ ]{2,}",
						" ");
				String message = XssEscapeUtils.jsoupParse(request.getParameter("message")).trim().replaceAll("[ ]{2,}",
						" ");
				String mobileNo = XssEscapeUtils.jsoupParse(request.getParameter("mobileNo")).trim()
						.replaceAll("[ ]{2,}", " ");
				String formType = XssEscapeUtils.jsoupParse(request.getParameter("formType")).trim()
						.replaceAll("[ ]{2,}", " ");

				String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
				String captcha = session.getAttribute("captcha_security").toString();
				boolean error;

				String verifyCaptcha = request.getParameter("captcha");
				if (captcha.equals(verifyCaptcha)) {
					error = false;
				} else {
					error = true;
				}

				if (FormValidation.Validaton(email, "email") == true
						|| FormValidation.Validaton(mobileNo, "mobile") == true
						|| FormValidation.Validaton(name, "") == true || FormValidation.Validaton(message, "") == true
						|| error == true) {

					error = true;

				}

				// boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);
				// boolean verify = true;

				Date date = new Date(); // your date
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);

				if (error == false) {
					InetAddress addr = InetAddress.getByName(request.getRemoteAddr());
					String hostName = addr.getHostName();
					String userAgent = request.getHeader("User-Agent");
					contactUs.setIpAddress(hostName);
					contactUs.setUserAgent(userAgent);
					contactUs.setAddDate(sf.format(date));
					contactUs.setContactName(name);
					contactUs.setEmailId(email);
					contactUs.setMessage(message);
					contactUs.setMobileNo(mobileNo);
					contactUs.setDelStatus(1);
					contactUs.setStatus(1);
					contactUs.setStatusByAdmin(0);
					contactUs.setExVar1(formType);
					System.out.println("Verify");
					// contactUs.setRemark(null);

					ContactUs res = Constant.getRestTemplate().postForObject(Constant.url + "/saveContactUs", contactUs,
							ContactUs.class);

					if (res == null) {
						session.setAttribute("errorMsg", "Your Message Failed To Sent ! ");
					} else {
						session.setAttribute("success", "Your Message Successfully Sent ! ");
					}

				} else {

					flag = 1;
					session.setAttribute("errorMsg", "Your Message Failed To Sent ! ");
				}
				Random randChars = new Random();
				String sImageCode = (Long.toString(Math.abs(randChars.nextLong()), 36)).substring(0, 6);
				session.setAttribute("captcha_security", sImageCode);
			} else {

				a = "redirect:/accessDenied";
			}
			SessionKeyGen.changeSessionKey(request);

		} catch (Exception e) {
			SessionKeyGen.changeSessionKey(request);
			session.setAttribute("errorMsg", "Your Message Failed To Sent ! ");
			e.printStackTrace();
		}

		return a;
	}

	@RequestMapping(value = "/verifyCaptcha", method = RequestMethod.GET)
	public @ResponseBody Info verifyCaptcha(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();
		try {
			String verifyCaptcha = request.getParameter("captcha");

			HttpSession session = request.getSession();
			String captcha = session.getAttribute("captcha_security").toString();
			// System.out.println(verifyCaptcha + " " + captcha);
			if (captcha.equals(verifyCaptcha)) {
				info.setError(false);
			} else {
				info.setError(true);
			}

		} catch (Exception e) {
			e.printStackTrace();
			info.setError(true);
		}

		return info;

	}

	@RequestMapping(value = "/screenReader", method = RequestMethod.GET)
	public ModelAndView screenReader(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView model = new ModelAndView("screenReader");
		try {
			session.setAttribute("mapping", "screenReader");

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", "screenReader");
				PageMetaData pageMetaData = Constant.getRestTemplate().postForObject(Constant.url + "/getPageMetaData",
						map, PageMetaData.class);
				model.addObject("pageMetaData", pageMetaData);
				model.addObject("siteKey", Constant.siteKey);
				model.addObject("flag", flag);
				flag = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/newsList", method = RequestMethod.GET)
	public ModelAndView newsList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/news-list");
		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "newsList");
			int langId = 1;
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId);
				NewsDetails[] getPagesModule = Constant.getRestTemplate()
						.postForObject(Constant.url + "/getLastFourNewsByLangId", map1, NewsDetails[].class);
				List<NewsDetails> newsBlogsList = new ArrayList<NewsDetails>(Arrays.asList(getPagesModule));

				model.addObject("newsBlogsList", newsBlogsList);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);
				model.addObject("siteKey", Constant.siteKey);
				model.addObject("flag", flag);
				flag = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/eventfrontList", method = RequestMethod.GET)
	public ModelAndView eventfrontList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/eventList");
		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "eventfrontList");
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
				/*
				 * for (int i = 0; i < event.size(); i++) {
				 * event.get(i).setEventDateFrom(DateConvertor.convertToDMY(event.get(i).
				 * getEventDateFrom()));
				 * 
				 * }
				 */
				// model.addObject("event", event);
				model.addObject("event", event);
				model.addObject("siteKey", Constant.siteKey);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);

				model.addObject("flag", flag);
				flag = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	/*
	 * @RequestMapping(value = "/upcomingEventsList", method = RequestMethod.GET)
	 * public ModelAndView upcomingEventsList(HttpServletRequest request,
	 * HttpServletResponse response) { HttpSession session = request.getSession();
	 * ModelAndView model = new ModelAndView("content/upcoming-front"); try {
	 * 
	 * // session.setAttribute("mapping", "upcomingEvents"); Maintainance
	 * maintainance = Constant.getRestTemplate().getForObject(Constant.url +
	 * "/checkIsMaintenance", Maintainance.class);
	 * 
	 * if (maintainance.getMaintenanceStatus() == 1) {
	 * 
	 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
	 * maintainance); } else {
	 * 
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("slugName", "upcomingEvents"); PageMetaData pageMetaData =
	 * Constant.getRestTemplate().postForObject(Constant.url + "/getPageMetaData",
	 * map, PageMetaData.class);
	 * 
	 * MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String,
	 * Object>();
	 * 
	 * map1.add("langId", 1); List<NewsDetails> upcoming =
	 * Constant.getRestTemplate().postForObject(Constant.url +
	 * "/getAllUpcomingEvents", map1, List.class); // List<ImageLink> imagList = new
	 * ArrayList<ImageLink>(Arrays.asList(image)); System.out.println("list_new: " +
	 * upcoming.toString()); model.addObject("upcoming", upcoming);
	 * model.addObject("typeId", 2); // model.addObject("value", 0);
	 * 
	 * // model.addObject("pageMetaData", pageMetaData);
	 * session.setAttribute("getGallryImageURL", Constant.getGallryImageURL);
	 * 
	 * }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return model; }
	 * 
	 * @RequestMapping(value = "/previousEventsList", method = RequestMethod.GET)
	 * public ModelAndView previousEventsList(HttpServletRequest request,
	 * HttpServletResponse response) { HttpSession session = request.getSession();
	 * ModelAndView model = new ModelAndView("content/previousfront"); try {
	 * 
	 * // session.setAttribute("mapping", "upcomingEvents"); Maintainance
	 * maintainance = Constant.getRestTemplate().getForObject(Constant.url +
	 * "/checkIsMaintenance", Maintainance.class);
	 * 
	 * if (maintainance.getMaintenanceStatus() == 1) {
	 * 
	 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
	 * maintainance); } else {
	 * 
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("slugName", "upcomingEvents"); PageMetaData pageMetaData =
	 * Constant.getRestTemplate().postForObject(Constant.url + "/getPageMetaData",
	 * map, PageMetaData.class);
	 * 
	 * MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String,
	 * Object>();
	 * 
	 * map1.add("langId", 1); NewsDetails[] previousList =
	 * Constant.getRestTemplate().postForObject(Constant.url +
	 * "/getAllPreviousEvents", map1, NewsDetails[].class); List<NewsDetails>
	 * previous = new ArrayList<NewsDetails>(Arrays.asList(previousList));
	 * System.out.println("list_new: " + previous.toString());
	 * model.addObject("previous", previous); model.addObject("typeId", 1); //
	 * model.addObject("pageMetaData", pageMetaData);
	 * session.setAttribute("getGallryImageURL", Constant.getGallryImageURL);
	 * 
	 * }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return model; }
	 */

	@RequestMapping(value = "/eventDetailfront/{newsblogsId}", method = RequestMethod.GET)
	public ModelAndView eventDetailfront(@PathVariable String newsblogsId, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("event-detail-front");
		try {
			newsblogsId = XssEscapeUtils.jsoupParse(newsblogsId);
			HttpSession session = request.getSession();
			session.setAttribute("mapping", "eventDetailfront/" + newsblogsId);

			int newsId = Integer.parseInt(EmailUtility.DecodeKey(String.valueOf(newsblogsId)));

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				if (session.getAttribute("menuList") == null) {
					InitializeSession.intializeSission(request);
				}
				int langId = (Integer) session.getAttribute("langId");
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId);

				map1.add("newsblogsId", newsId);
				NewsDetails eventList = Constant.getRestTemplate().postForObject(Constant.url + "/getEventListByNewsId",
						map1, NewsDetails.class);

				// List<NewsDetails> event = new
				// ArrayList<NewsDetails>(Arrays.asList(eventList));

				model.addObject("event", eventList);
				model.addObject("dateEvent", eventList.getEventDateFrom());

				model.addObject("siteKey", Constant.siteKey);
				// model.addObject("typeId", typeId);

				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);

				model.addObject("flag", flag);
				flag = 0;

				String[] ids = null;
				try {

					ids = eventList.getExVar2().split(",");
				} catch (Exception e) {

				}
				session.setAttribute("allowedType", ids);
				SimpleDateFormat sf = new SimpleDateFormat("dd-MM-yyyy");

				Date today = new Date();
				Date eventDate = sf.parse(eventList.getEventDateFrom());

				System.out.println(today + " " + eventDate);
				if (eventDate.compareTo(today) >= 0) {

					model.addObject("isapply", 1);
				} else {
					model.addObject("isapply", 0);
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	/*
	 * @RequestMapping(value = "/eventDetail/{langId}/{pageId}/{newsblogsId}",
	 * method =RequestMethod.GET) public ModelAndView eventDetail(@PathVariable int
	 * langId, @PathVariable int pageId, @PathVariable int newsblogsId,
	 * HttpServletRequest request, HttpServletResponse response) {
	 * 
	 * 
	 * ModelAndView model = new ModelAndView("event-detail"); try {
	 * 
	 * HttpSession session = request.getSession();
	 * session.setAttribute("mapping","eventList");
	 * 
	 * Maintainance maintainance =
	 * Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
	 * Maintainance.class); if (maintainance.getMaintenanceStatus() == 1) {
	 * 
	 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
	 * maintainance); } else { MultiValueMap<String, Object> map = new
	 * LinkedMultiValueMap<String, Object>(); map.add("slugName", "eventList");
	 * PageMetaData pageMetaData =
	 * Constant.getRestTemplate().postForObject(Constant.url + "/getPageMetaData",
	 * map, PageMetaData.class);
	 * 
	 * 
	 * MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String,
	 * Object>(); map1.add("langId", langId); map1.add("pageId", pageId);
	 * map1.add("newsblogsId", newsblogsId); NewsDetails eventList =
	 * Constant.getRestTemplate().postForObject(Constant.url +
	 * "/getEventListByNewsId",map1, NewsDetails.class);
	 * 
	 * // List<NewsDetails> event = new
	 * ArrayList<NewsDetails>(Arrays.asList(eventList)); String dateEvent=
	 * DateConvertor.convertToYMD(eventList.getEventDateFrom());
	 * model.addObject("event", eventList); model.addObject("dateEvent", dateEvent);
	 * model.addObject("pageMetaData",pageMetaData); model.addObject("siteKey",
	 * Constant.siteKey); session.setAttribute("gallryImageURL",
	 * Constant.getGallryImageURL);
	 * 
	 * model.addObject("flag", flag); flag=0;
	 * 
	 * }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return model; }
	 */

	@RequestMapping(value = "/eventJson", method = RequestMethod.GET)
	public @ResponseBody String eventJson(HttpServletRequest request, HttpServletResponse response) {

		String jsonString = new String();
		try {

			System.out.println("akshay kasar");

			CalenderList m = Constant.getRestTemplate().getForObject(Constant.url + "/getEventListforCalender",
					CalenderList.class);

			for (int i = 0; i < m.getResult().size(); i++) {
				m.getResult().get(i).setUrl(Constant.siteFrontEndUrl + "eventDetailfront/"
						+ EmailUtility.Encrypt(String.valueOf(m.getResult().get(i).getId())));
			}

			ObjectMapper mapper = new ObjectMapper();
			jsonString = mapper.writeValueAsString(m);
			System.out.println(jsonString);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return jsonString;
	}

	List<MultipartFile> pdfList = new ArrayList<>();
	String imageName = new String();

	@RequestMapping(value = "/submtFrontEventAppliedForm", method = RequestMethod.POST)
	public String submtFrontEventAppliedForm(@RequestParam("pagePdf") List<MultipartFile> pagePdf,
			HttpServletRequest request, HttpServletResponse response) {

		pdfList = pagePdf;

		// ModelAndView model = new ModelAndView("masters/addEmployee");
		Info info = new Info();
		String pdfName = new String();
		String ss = new String();
		HttpSession session = request.getSession();
		int newsblogsId = Integer.parseInt(request.getParameter("newsblogsId"));
		ModelAndView mav = new ModelAndView("event-detail-front");
		mav.addObject("newsblogsId", newsblogsId);
		System.out.println("newsblogsId :" + newsblogsId);
		Registration userDetail = null;

		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");

		VpsImageUpload upload = new VpsImageUpload();

		try {
			userDetail = (Registration) session.getAttribute("userInfo");
			System.out.println("userDetail: " + userDetail);
		} catch (Exception e) {

			e.printStackTrace();
		}
		try {

			String token = request.getParameter("token");
			String key = (String) session.getAttribute("generatedKey");

			if (token.trim().equals(key.trim())) {

				if (userDetail != null) {

					pdfName = dateTimeInGMT.format(date) + "_" + pagePdf.get(0).getOriginalFilename();

					MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

					map1.add("newsblogsId", newsblogsId);
					map1.add("userId", userDetail.getRegId());
					info = Constant.getRestTemplate().postForObject(Constant.url + "/getAppliedEvents", map1,
							Info.class);

					if (info.isError() == true) {

						int langId = (Integer) session.getAttribute("langId");
						MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
						map.add("langId", langId);
						map.add("newsblogsId", newsblogsId);
						NewsDetails eventList = Constant.getRestTemplate()
								.postForObject(Constant.url + "/getEventListByNewsId", map, NewsDetails.class);
						int userType = (Integer) session.getAttribute("userType");
						String[] ids = eventList.getExVar2().split(",");

						int allowd = 0;

						for (int i = 0; i < ids.length; i++) {

							if (userType == Integer.parseInt(ids[i])) {
								allowd = 1;
								break;
							}
						}

						if (allowd == 1) {

							EventRegistration eventReg = new EventRegistration();

							Calendar cal = Calendar.getInstance();
							cal.setTime(date);
							eventReg.setDelStatus(1);
							eventReg.setIsActive(1);
							eventReg.setNewsblogsId(newsblogsId);
							eventReg.setRegDate(sf.format(date));
							eventReg.setUserId(userDetail.getRegId());
							eventReg.setDoc1(pdfName);

							info = upload.saveUploadedFiles(pagePdf.get(0), Constant.cmsPdf, Constant.files, pdfName);

							if (info.isError() == false) {
								EventRegistration res = Constant.getRestTemplate().postForObject(
										Constant.url + "/saveEventRegister", eventReg, EventRegistration.class);

								session.setAttribute("success", "Successfully Registed Event !");
							}
						} else {

							session.setAttribute("errorMsg", "You can't apply for this event !");
						}
						// upload.saveUploadedFiles(pagePdf.get(0), Constant.cmsPdf, Constant.pdf,
						// pdfName);

					} else {

						session.setAttribute("errorMsg", "Already Register ");
					}
					ss = "redirect:/eventDetailfront/" + EmailUtility.Encrypt(String.valueOf(newsblogsId));
				} else {

					String imageName = dateTimeInGMT.format(date) + "_" + pagePdf.get(0).getOriginalFilename();
					session.setAttribute("eventFileName", imageName);
					System.out.println(" imageName " + imageName);
					info = upload.saveUploadedFiles(pagePdf.get(0), Constant.cmsPdf, Constant.files, imageName);
					if (info.isError() == false) {
						System.out.println("User Id: " + userDetail);
						session.setAttribute("errorMsg", "Please login for apply event !");
						session.setAttribute("fileFromApplyEvent", EmailUtility.Encrypt(String.valueOf(1)));
						session.setAttribute("eventFromApplyEven", EmailUtility.Encrypt(String.valueOf(newsblogsId)));
						ss = "redirect:/login";
					} else {
						session.setAttribute("errorMsg", "File Upload Error");
						ss = "redirect:/eventDetailfront/" + EmailUtility.Encrypt(String.valueOf(newsblogsId));
					}

				}
			} else {
				ss = "redirect:/eventDetailfront/" + EmailUtility.Encrypt(String.valueOf(newsblogsId));
				session.setAttribute("errorMsg", "something wrong");
			}
		} catch (Exception e) {

			e.printStackTrace();
		}

		return ss;
	}

	@RequestMapping(value = "/applyEventFrontWithFile/{newsblogsId}", method = RequestMethod.GET)
	public String applyEventFrontWithFile(@PathVariable int newsblogsId, HttpServletRequest request,
			HttpServletResponse response) {

		Info info = new Info();

		String ss = new String();
		HttpSession session = request.getSession();

		ModelAndView mav = new ModelAndView("event-detail-front");
		mav.addObject("newsblogsId", newsblogsId);
		System.out.println("newsblogsId :" + newsblogsId);
		Registration userDetail = null;

		try {
			userDetail = (Registration) session.getAttribute("userInfo");

		} catch (Exception e) {

			e.printStackTrace();
		}
		try {
			if (userDetail != null) {

				int langId = (Integer) session.getAttribute("langId");
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId);
				map1.add("newsblogsId", newsblogsId);
				NewsDetails eventList = Constant.getRestTemplate().postForObject(Constant.url + "/getEventListByNewsId",
						map1, NewsDetails.class);
				int userType = (Integer) session.getAttribute("userType");
				String[] ids = eventList.getExVar2().split(",");

				int allowd = 0;

				for (int i = 0; i < ids.length; i++) {

					if (userType == Integer.parseInt(ids[i])) {
						allowd = 1;
						break;
					}
				}

				if (allowd == 1) {

					Date date = new Date();
					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

					map1 = new LinkedMultiValueMap<String, Object>();

					map1.add("newsblogsId", newsblogsId);
					map1.add("userId", userDetail.getRegId());
					info = Constant.getRestTemplate().postForObject(Constant.url + "/getAppliedEvents", map1,
							Info.class);

					if (info.isError() == true) {
						EventRegistration eventReg = new EventRegistration();

						Calendar cal = Calendar.getInstance();
						cal.setTime(date);
						eventReg.setDelStatus(1);
						eventReg.setIsActive(1);
						eventReg.setNewsblogsId(newsblogsId);
						eventReg.setRegDate(sf.format(date));
						eventReg.setUserId(userDetail.getRegId());
						try {
							String imageName = (String) session.getAttribute("eventFileName");
							System.out.println(" imageName " + imageName);
							eventReg.setDoc1(imageName);
						} catch (Exception e) {
							eventReg.setDoc1(imageName);
						}

						EventRegistration res = Constant.getRestTemplate()
								.postForObject(Constant.url + "/saveEventRegister", eventReg, EventRegistration.class);

						session.setAttribute("success", "Successfully Registed Event !");

					} else {
						session.setAttribute("errorMsg", "Event Already Registered !");
					}

				} else {

					session.setAttribute("errorMsg", "You can't apply for this event !");
				}

				ss = "redirect:/eventDetailfront/" + EmailUtility.Encrypt(String.valueOf(newsblogsId));
				imageName = new String();
			} else {

				session.setAttribute("errorMsg", "Please login for apply event !");
				ss = "redirect:/login";
				session.setAttribute("fileFromApplyEvent", EmailUtility.Encrypt(String.valueOf(1)));
				session.setAttribute("eventFromApplyEven", EmailUtility.Encrypt(String.valueOf(newsblogsId)));

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

		return ss;
	}

	@RequestMapping(value = "/testimonialsImageList", method = RequestMethod.GET)
	public ModelAndView testimonialsImageList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("testimonialList");

		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "testimonialsImageList");
			int langId = 1;
			int valueType = 1;

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("valueType", valueType);

				TestImonial[] testImonialList = Constant.getRestTemplate()
						.postForObject(Constant.url + "/getAllTestImonialsList", map1, TestImonial[].class);
				List<TestImonial> testImonial = new ArrayList<TestImonial>(Arrays.asList(testImonialList));
				System.out.println("testImonial :" + testImonial.toString());
				model.addObject("testImonial", testImonial);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);
				model.addObject("siteKey", Constant.siteKey);
				model.addObject("flag", flag);
				model.addObject("valueType", valueType);
				flag = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/testimonialsVideoList", method = RequestMethod.GET)
	public ModelAndView testimonialsVideoList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("testimonialList");

		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "testimonialsVideoList");
			int langId = 1;
			int valueType = 2;
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("valueType", valueType);

				TestImonial[] testImonialList = Constant.getRestTemplate()
						.postForObject(Constant.url + "/getAllTestImonialsList", map1, TestImonial[].class);
				List<TestImonial> testImonial = new ArrayList<TestImonial>(Arrays.asList(testImonialList));
				System.out.println("testImonial :" + testImonial.toString());
				model.addObject("testImonial", testImonial);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);
				model.addObject("siteKey", Constant.siteKey);
				model.addObject("flag", flag);
				model.addObject("valueType", valueType);
				flag = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/testimonialsDetail", method = RequestMethod.GET)
	public ModelAndView testimonialsDetail(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("testimonialsDetail");

		try {

			HttpSession session = request.getSession();

			session.setAttribute("mapping", "testimonialsDetail");
			// int testimonialId =
			// Integer.parseInt(EmailUtility.DecodeKey(request.getParameter("testimonialId")));
			int testimonialId = Integer.parseInt(request.getParameter("testimonialId"));

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				if (session.getAttribute("menuList") == null) {
					InitializeSession.intializeSission(request);
				}

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("id", testimonialId);

				TestImonial testImonial = Constant.getRestTemplate().postForObject(Constant.url + "/getTestImonialById",
						map, TestImonial.class);

				model.addObject("testImonial", testImonial);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
}
