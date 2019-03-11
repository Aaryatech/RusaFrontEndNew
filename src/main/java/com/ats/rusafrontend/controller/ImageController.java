package com.ats.rusafrontend.controller;

import java.net.InetAddress;
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
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.model.*;
import com.ats.rusafrontend.model.TopMenuList;
import com.ats.rusafrontend.reCaptcha.VerifyRecaptcha;

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
	@RequestMapping(value = "/NewsDetails/{langId}/{pageId}/{newsblogsId}", method = RequestMethod.GET)
	public ModelAndView getImageLink(@PathVariable int langId, @PathVariable int pageId, @PathVariable int newsblogsId,
			HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/NewsDetails");
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
				map1.add("langId", langId);
				map1.add("pageId", pageId);
				map1.add("newsblogsId", newsblogsId);
				NewsDetails image = rest.postForObject(Constant.url + "/getNewsBlogById", map1, NewsDetails.class);
				// List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));
				System.out.println("list_new: " + image.toString());
				model.addObject("image", image);
				model.addObject("getGallryImageURL", Constant.getGallryImageURL);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

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

	
}
