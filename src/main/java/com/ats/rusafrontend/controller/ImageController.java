package com.ats.rusafrontend.controller;

import java.net.InetAddress;
import java.nio.file.Files;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.commen.Info;
import com.ats.rusafrontend.commen.VpsImageUpload;
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

	RestTemplate rest = new RestTemplate();
	ContactUs contactUs = new ContactUs();
	int flag = 0;

	@RequestMapping(value = "/NewsDetails/{langId}/{newsblogsId}", method = RequestMethod.GET)
	public ModelAndView getImageLink(@PathVariable int langId, @PathVariable int newsblogsId,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView model = new ModelAndView("content/news-detail");
		try {

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("newsblogsId", newsblogsId);
				map1.add("langId", langId);
				NewsDetails image = rest.postForObject(Constant.url + "/getNewsListByNewsId", map1, NewsDetails.class);
				// List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
				System.out.println("list_new: " + image.toString());
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
	 * Maintainance maintainance = rest.getForObject(Constant.url +
	 * "/checkIsMaintenance", Maintainance.class);
	 * 
	 * if (maintainance.getMaintenanceStatus() == 1) {
	 * 
	 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
	 * maintainance); } else {
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("langId", langId); TopMenuList sectionTree =
	 * rest.postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);
	 * model.addObject("menuList", sectionTree);
	 * 
	 * MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String,
	 * Object>(); map1.add("langId", langId); map1.add("pageId", pageId);
	 * map1.add("newsblogsId", newsblogsId); NewsDetails image =
	 * rest.postForObject(Constant.url + "/getNewsBlogById", map1,
	 * NewsDetails.class); // List<ImageLink> imagList = new
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

		ModelAndView model = new ModelAndView("content/contactUs");
		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "ContactUs");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", "ContactUs");
				PageMetaData pageMetaData = rest.postForObject(Constant.url + "/getPageMetaData", map,
						PageMetaData.class);
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

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				/*
				 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
				 * Object>(); map.add("langId", langId);
				 * 
				 * TopMenuList sectionTree = rest.postForObject(Constant.url +
				 * "/getTopMenuList", map, TopMenuList.class);
				 * 
				 * // HttpSession session = request.getSession();
				 * session.setAttribute("menuList", sectionTree);
				 */
				session.setAttribute("mapping", "teamDetails");

				TestImonial[] getTeamList = rest.getForObject(Constant.url + "/getTeamDetail", TestImonial[].class);
				List<TestImonial> teamList = new ArrayList<TestImonial>(Arrays.asList(getTeamList));
				model.addObject("teamList", teamList);
				model.addObject("gallryImageURL", Constant.getGallryImageURL);

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("slugName", "teamDetails");
				PageMetaData pageMetaData = rest.postForObject(Constant.url + "/getPageMetaData", map1,
						PageMetaData.class);
				model.addObject("pageMetaData", pageMetaData);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/insertContactUs", method = RequestMethod.POST)
	public String insertContactUs(HttpServletRequest request, HttpServletResponse response) {

		try {
			final long serialVersionUID = -6506682026701304964L;

			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String message = request.getParameter("message");
			String mobileNo = request.getParameter("mobileNo");
			String formType = request.getParameter("formType");

			String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
			boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);

			Date date = new Date(); // your date
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);

			if (verify) {
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

				ContactUs res = rest.postForObject(Constant.url + "/saveContactUs", contactUs, ContactUs.class);

			} else {

				flag = 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/ContactUs";
	}

	@RequestMapping(value = "/screenReader", method = RequestMethod.GET)
	public ModelAndView screenReader(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("screenReader");
		try {

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
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", "newsList");
				PageMetaData pageMetaData = rest.postForObject(Constant.url + "/getPageMetaData", map,
						PageMetaData.class);
				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("langId", langId);
				NewsDetails[] getPagesModule = rest.postForObject(Constant.url + "/getLastFourNewsByLangId", map1,
						NewsDetails[].class);
				List<NewsDetails> newsBlogsList = new ArrayList<NewsDetails>(Arrays.asList(getPagesModule));

				model.addObject("newsBlogsList", newsBlogsList);
				model.addObject("pageMetaData", pageMetaData);
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
				model.addObject("event", event);
				model.addObject("pageMetaData", pageMetaData);
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
	 * maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance",
	 * Maintainance.class);
	 * 
	 * if (maintainance.getMaintenanceStatus() == 1) {
	 * 
	 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
	 * maintainance); } else {
	 * 
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("slugName", "upcomingEvents"); PageMetaData pageMetaData =
	 * rest.postForObject(Constant.url + "/getPageMetaData", map,
	 * PageMetaData.class);
	 * 
	 * MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String,
	 * Object>();
	 * 
	 * map1.add("langId", 1); List<NewsDetails> upcoming =
	 * rest.postForObject(Constant.url + "/getAllUpcomingEvents", map1, List.class);
	 * // List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
	 * System.out.println("list_new: " + upcoming.toString());
	 * model.addObject("upcoming", upcoming); model.addObject("typeId", 2); //
	 * model.addObject("value", 0);
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
	 * maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance",
	 * Maintainance.class);
	 * 
	 * if (maintainance.getMaintenanceStatus() == 1) {
	 * 
	 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
	 * maintainance); } else {
	 * 
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("slugName", "upcomingEvents"); PageMetaData pageMetaData =
	 * rest.postForObject(Constant.url + "/getPageMetaData", map,
	 * PageMetaData.class);
	 * 
	 * MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String,
	 * Object>();
	 * 
	 * map1.add("langId", 1); NewsDetails[] previousList =
	 * rest.postForObject(Constant.url + "/getAllPreviousEvents", map1,
	 * NewsDetails[].class); List<NewsDetails> previous = new
	 * ArrayList<NewsDetails>(Arrays.asList(previousList));
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

	@RequestMapping(value = "/eventDetailfront/{newsblogsId}/{typeId}", method = RequestMethod.GET)
	public ModelAndView eventDetailfront(@PathVariable int newsblogsId, @PathVariable int typeId,
			HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("event-detail-front");
		try {

			HttpSession session = request.getSession();
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
				String dateEvent = DateConvertor.convertToDMY(eventList.getEventDateFrom());
				model.addObject("event", eventList);
				model.addObject("dateEvent", dateEvent);
				model.addObject("pageMetaData", pageMetaData);
				model.addObject("siteKey", Constant.siteKey);
				model.addObject("typeId", typeId);

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
	 * Maintainance maintainance = rest.getForObject(Constant.url +
	 * "/checkIsMaintenance", Maintainance.class); if
	 * (maintainance.getMaintenanceStatus() == 1) {
	 * 
	 * model = new ModelAndView("maintainance"); model.addObject("maintainance",
	 * maintainance); } else { MultiValueMap<String, Object> map = new
	 * LinkedMultiValueMap<String, Object>(); map.add("slugName", "eventList");
	 * PageMetaData pageMetaData = rest.postForObject(Constant.url +
	 * "/getPageMetaData", map, PageMetaData.class);
	 * 
	 * 
	 * MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String,
	 * Object>(); map1.add("langId", langId); map1.add("pageId", pageId);
	 * map1.add("newsblogsId", newsblogsId); NewsDetails eventList =
	 * rest.postForObject(Constant.url + "/getEventListByNewsId",map1,
	 * NewsDetails.class);
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

			CalenderList m = rest.getForObject(Constant.url + "/getEventListforCalender", CalenderList.class);

			for (int i = 0; i < m.getResult().size(); i++) {
				m.getResult().get(i).setUrl(Constant.siteFrontEndUrl + "eventDetail/" + m.getResult().get(i).getId());
			}

			ObjectMapper mapper = new ObjectMapper();
			jsonString = mapper.writeValueAsString(m);
			System.out.println(jsonString);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return jsonString;
	}

	@RequestMapping(value = "/submtEventAppliedForm", method = RequestMethod.POST)
	public String submtEventAppliedForm(@RequestParam("pagePdf") List<MultipartFile> pagePdf,
			HttpServletRequest request, HttpServletResponse response) {

		// ModelAndView model = new ModelAndView("masters/addEmployee");
		Info info = new Info();
		String pdfName = new String();
		String ss = new String();
		HttpSession session = request.getSession();
		int newsblogsId = Integer.parseInt(request.getParameter("newsblogsId"));
		ModelAndView mav = new ModelAndView("event-detail");
		mav.addObject("newsblogsId", newsblogsId);
		System.out.println("newsblogsId :" + newsblogsId);
		int userDetail = 0;

		try {
			userDetail = (int) session.getAttribute("UserDetail");
			System.out.println("userDetail: " + userDetail);
		} catch (Exception e) {
			userDetail = 0;
			e.printStackTrace();
		}

		if (userDetail > 0) {

			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");

			VpsImageUpload upload = new VpsImageUpload();
			pdfName = dateTimeInGMT.format(date) + "_" + pagePdf.get(0).getOriginalFilename();

			MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();

			map1.add("newsblogsId", newsblogsId);
			map1.add("userId", userDetail);
			List<EventRegistration> appliedevent = rest.postForObject(Constant.url + "/getAppliedEvents", map1,
					List.class);

			if (appliedevent == null) {
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
				// ss="redirect:/eventDetail/"+newsblogsId;

			} else {
				if (pagePdf.get(0).getOriginalFilename() == null || pagePdf.get(0).getOriginalFilename() == "") {
					try {

					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				} else {

					// pdfName =
					// dateTimeInGMT.format(date)+"_"+pagePdf.get(0).getOriginalFilename();

					try {

						MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
						map.add("regId", userDetail);
						map.add("newsblogsId", newsblogsId);
						map.add("pdfName", pdfName);

						info = rest.postForObject(Constant.url + "/uploadEventDocument", map, Info.class);

						System.out.println(info.toString());
						if (info.isError() == true) {
							EventRegistration eventReg = new EventRegistration();

							Calendar cal = Calendar.getInstance();
							cal.setTime(date);
							eventReg.setDelStatus(1);
							eventReg.setIsActive(1);
							// eventReg.setEventRegId();
							// eventReg.setIsActive(1);
							eventReg.setNewsblogsId(newsblogsId);
							eventReg.setRegDate(sf.format(date));
							eventReg.setUserId(userDetail);
							eventReg.setDoc1(pdfName);
							EventRegistration res = rest.postForObject(Constant.url + "/saveEventRegister", eventReg,
									EventRegistration.class);

							System.out.println("res Id: " + res.toString());

						}

						upload.saveUploadedFiles(pagePdf.get(0), Constant.uploadDocURL, pdfName);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
			}
			ss = "redirect:/eventDetail/" + newsblogsId;
		} else {
			System.out.println("User Id: " + userDetail);
			ss = "redirect:/login";
		}

		return ss;
	}

	@RequestMapping(value = "/eventDetail/{newsblogsId}/{typeId}", method = RequestMethod.GET)
	public ModelAndView eventDetail(@PathVariable int newsblogsId, @PathVariable int typeId, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("event-detail");
		try {

			HttpSession session = request.getSession();
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
				String dateEvent = DateConvertor.convertToDMY(eventList.getEventDateFrom());
				model.addObject("event", eventList);
				model.addObject("dateEvent", dateEvent);
				model.addObject("pageMetaData", pageMetaData);
				model.addObject("siteKey", Constant.siteKey);
				model.addObject("typeId", typeId);

				System.out.println("typeId :" + typeId);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);
				model.addObject("flag", flag);
				flag = 0;

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
}
