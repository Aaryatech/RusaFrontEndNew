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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

 import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
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
	int flag=0;
	  
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

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("langId", langId);
				TopMenuList sectionTree = rest.postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);
				model.addObject("menuList", sectionTree);

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
				flag=0;
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
			}else {
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("langId", langId);

				TopMenuList sectionTree = rest.postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);

				// HttpSession session = request.getSession();
				session.setAttribute("menuList", sectionTree);
				session.setAttribute("mapping", "teamDetails");

				TestImonial[] getTeamList = rest.getForObject(Constant.url + "/getTeamDetail", TestImonial[].class);
				List<TestImonial> teamList = new ArrayList<TestImonial>(Arrays.asList(getTeamList));
				model.addObject("teamList", teamList);
				model.addObject("gallryImageURL", Constant.getGallryImageURL);

				MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
				map1.add("slugName", "teamDetails");
				PageMetaData pageMetaData = rest.postForObject(Constant.url + "/getPageMetaData", map1, PageMetaData.class);
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

			String gRecaptchaResponse = request
					.getParameter("g-recaptcha-response");
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
				flag=0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	   
	@RequestMapping(value = "/eventList", method = RequestMethod.GET)
	public ModelAndView eventList(HttpServletRequest request, HttpServletResponse response) {

		
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
				NewsDetails[] eventList = rest.postForObject(Constant.url + "/getAllEventsL",map1,
						NewsDetails[].class);
				List<NewsDetails> event = new ArrayList<NewsDetails>(Arrays.asList(eventList));
				for(int i=0; i<event.size();i++)
				{
					event.get(i).setEventDateFrom(DateConvertor.convertToDMY(event.get(i).getEventDateFrom()));					
					
				}
				//model.addObject("event", event);
				model.addObject("event", eventList);
				model.addObject("pageMetaData", pageMetaData);				
				model.addObject("siteKey", Constant.siteKey);
				session.setAttribute("gallryImageURL", Constant.getGallryImageURL);

				model.addObject("flag", flag);
				flag=0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	
	  @RequestMapping(value = "/eventDetail/{newsblogsId}", method =RequestMethod.GET) 
	  public ModelAndView eventDetail(@PathVariable int newsblogsId, HttpServletRequest request, HttpServletResponse response) {
	  
	  
	  ModelAndView model = new ModelAndView("event-detail");
	  try {
	  
	  HttpSession session = request.getSession(); 
	  session.setAttribute("mapping","eventList"); 
	  int langId=1;
	  Maintainance maintainance =
	  rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
	  if (maintainance.getMaintenanceStatus() == 1) {
	  
	  model = new ModelAndView("maintainance"); model.addObject("maintainance",
	  maintainance); } else { MultiValueMap<String, Object> map = new
	  LinkedMultiValueMap<String, Object>(); map.add("slugName", "eventList");
	  PageMetaData pageMetaData = rest.postForObject(Constant.url +
	  "/getPageMetaData", map, PageMetaData.class);
	    
	  
	  MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
	  map1.add("langId", langId);
	
	  map1.add("newsblogsId", newsblogsId);
	  NewsDetails eventList = rest.postForObject(Constant.url + "/getEventListByNewsId",map1, NewsDetails.class); 
	  
	//  List<NewsDetails> event = new ArrayList<NewsDetails>(Arrays.asList(eventList));
      String dateEvent=  DateConvertor.convertToYMD(eventList.getEventDateFrom());
	  model.addObject("event", eventList);
	  model.addObject("dateEvent", dateEvent);
	  model.addObject("pageMetaData",pageMetaData); 
	  model.addObject("siteKey", Constant.siteKey);
	  session.setAttribute("gallryImageURL", Constant.getGallryImageURL);

	  model.addObject("flag", flag); 
	  flag=0; 
	  
	  }
	  
	  } catch (Exception e) { e.printStackTrace(); }
	  
	  return model; }
	  
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

		// ModelAndView model = new ModelAndView("moduleForms/showFoldersFiles");
		String jsonString = new String();
		try {
			 
		 System.out.println("akshay kasar");

		 CalenderList m = new CalenderList();
		 List<Result> result = new ArrayList<>();
		 m.setSuccess(1);
		 
		 Result r = new Result();
		 r.setId("1");
		 r.setTitle("aksshay");
		 r.set_class("event-info");
		 r.setUrl("http://www.example.com/");
		 r.setStart("1362938400000");
		 r.setEnd("1362938400000");
		 result.add(r);
		 m.setResult(result);
		 
		 
		 ObjectMapper mapper = new ObjectMapper();
			jsonString = mapper.writeValueAsString(m);
		 
		} catch (Exception e) {
			e.printStackTrace();
		}

		/*return "{\r\n" + 
				"	\"success\": 1,\r\n" + 
				"	\"result\": [\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"293\",\r\n" + 
				"			\"title\": \"This is warning class event with very long title to check how it fits to evet in day view\",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"event-warning\",\r\n" + 
				"			\"start\": \"1362938400000\",\r\n" + 
				"			\"end\":   \"1363197686300\"\r\n" + 
				"		},\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"256\",\r\n" + 
				"			\"title\": \"Event that ends on timeline\",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"event-warning\",\r\n" + 
				"			\"start\": \"1363155300000\",\r\n" + 
				"			\"end\":   \"1363227600000\"\r\n" + 
				"		},\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"276\",\r\n" + 
				"			\"title\": \"Short day event\",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"event-success\",\r\n" + 
				"			\"start\": \"1363245600000\",\r\n" + 
				"			\"end\":   \"1363252200000\"\r\n" + 
				"		},\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"294\",\r\n" + 
				"			\"title\": \"This is information class \",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"event-info\",\r\n" + 
				"			\"start\": \"1363111200000\",\r\n" + 
				"			\"end\":   \"1363284086400\"\r\n" + 
				"		},\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"297\",\r\n" + 
				"			\"title\": \"This is success event\",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"event-success\",\r\n" + 
				"			\"start\": \"1363234500000\",\r\n" + 
				"			\"end\":   \"1363284062400\"\r\n" + 
				"		},\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"54\",\r\n" + 
				"			\"title\": \"This is simple event\",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"\",\r\n" + 
				"			\"start\": \"1363712400000\",\r\n" + 
				"			\"end\":   \"1363716086400\"\r\n" + 
				"		},\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"532\",\r\n" + 
				"			\"title\": \"This is inverse event\",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"event-inverse\",\r\n" + 
				"			\"start\": \"1364407200000\",\r\n" + 
				"			\"end\":   \"1364493686400\"\r\n" + 
				"		},\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"548\",\r\n" + 
				"			\"title\": \"This is special event\",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"event-special\",\r\n" + 
				"			\"start\": \"1363197600000\",\r\n" + 
				"			\"end\":   \"1363629686400\"\r\n" + 
				"		},\r\n" + 
				"		{\r\n" + 
				"			\"id\": \"295\",\r\n" + 
				"			\"title\": \"Event 3\",\r\n" + 
				"			\"url\": \"http://www.example.com/\",\r\n" + 
				"			\"class\": \"event-important\",\r\n" + 
				"			\"start\": \"1364320800000\",\r\n" + 
				"			\"end\":   \"1364407286400\"\r\n" + 
				"		}\r\n" + 
				"	]\r\n" + 
				"}";*/
		return jsonString;
	}
	
}
