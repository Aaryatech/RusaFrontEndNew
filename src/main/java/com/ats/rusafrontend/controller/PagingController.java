package com.ats.rusafrontend.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
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
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.commen.EmailUtility;
import com.ats.rusafrontend.commen.InitializeSession;
import com.ats.rusafrontend.commen.XssEscapeUtils;
import com.ats.rusafrontend.model.Maintainance;
import com.ats.rusafrontend.model.NewsDetails;
import com.ats.rusafrontend.model.Registration;

@Controller
@Scope("session")
public class PagingController {

	 
	
	@RequestMapping(value = "/listOFEvent/{page}", method = RequestMethod.GET)
	public ModelAndView listOFEvent(@PathVariable("page") String page, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/eventList");
		try {
			page = XssEscapeUtils.jsoupParse(page);
			HttpSession session = request.getSession();
			session.setAttribute("mapping", "listOFEvent");
			 
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				
				if(session.getAttribute("menuList") == null) {
					InitializeSession.intializeSission(request);
				}
					 
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			int langId = (Integer) session.getAttribute("langId");
			map.add("langId", langId);
			NewsDetails[] eventConutList = Constant.getRestTemplate().postForObject(Constant.url + "/getAllEventsL", map,
					NewsDetails[].class);
			List<NewsDetails> eventCount = new ArrayList<NewsDetails>(Arrays.asList(eventConutList));
			System.out.println("Event List Count :"+eventCount.size());
		 
			
			int totalPage=eventCount.size()/Constant.totalEventCount;
			System.out.println("totalPage 1:"+totalPage);
			if(totalPage==0)
			{
				totalPage=1;
			
			}		
				System.out.println("totalPage 3:"+totalPage);
			
				int pageidnew=Integer.parseInt(page);  
			//String spageid=request.getParameter("page");  
			int pageid=Integer.parseInt(page);  
			int total=Constant.totalEventCount;  
			if(pageid==1){}  
			else{  
			    pageid=pageid-1;  
			    pageid=pageid*total+1;  
			}  

			
			MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
			map1.add("langId", langId);
			map1.add("pageid", pageid);
			map1.add("total", total);
			NewsDetails[] eventList = Constant.getRestTemplate().postForObject(Constant.url + "/getAllEventsByLimit", map1,
					NewsDetails[].class);
			List<NewsDetails> event = new ArrayList<NewsDetails>(Arrays.asList(eventList));
			for (int i = 0; i < event.size(); i++) {
				//event.get(i).setEventDateFrom(DateConvertor.convertToDMY(event.get(i).getEventDateFrom()));
				event.get(i).setExVar1(EmailUtility.Encrypt(String.valueOf(event.get(i).getNewsblogsId())));

			}
			//pageid=pageid-1;
			
			session.setAttribute("gallryImageURL", Constant.getGallryImageURL);
			model.addObject("event", event);
			model.addObject("total", total);
			model.addObject("pageid", pageidnew);
			model.addObject("totalPage", totalPage);
			
			//model.addObject("page", page);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	@RequestMapping(value = "/listOFNews/{page}", method = RequestMethod.GET)
	public ModelAndView listOFNews(@PathVariable("page") String page, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/news-list");
		try {
			page = XssEscapeUtils.jsoupParse(page);
			HttpSession session = request.getSession();
			session.setAttribute("mapping", "listOFNews");
			 
			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {
				
				if(session.getAttribute("menuList") == null) {
					InitializeSession.intializeSission(request);
				}
				
				int langId = (Integer) session.getAttribute("langId");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("langId", langId);
				NewsDetails[] newsConutList = Constant.getRestTemplate().postForObject(Constant.url + "/getAllNewsByLangId", map,
						NewsDetails[].class);
				List<NewsDetails> newsCount = new ArrayList<NewsDetails>(Arrays.asList(newsConutList));
				System.out.println("News List Count :"+newsCount.size());
			 
				
				int totalPage=newsCount.size()/Constant.totalEventCount;
				System.out.println("totalPage 1:"+totalPage);
				if(totalPage==0)
				{
					totalPage=1;				
				}		
				int pageidnew=Integer.parseInt(page); 			
				int pageid=Integer.parseInt(page);  
				int total=Constant.totalEventCount;  
				if(pageid==1)
				{
					
				}  
				else
				{
				    pageid=pageid-1;  
				    pageid=pageid*total+1;  
				}  
			
			MultiValueMap<String, Object> map1 = new LinkedMultiValueMap<String, Object>();
			map1.add("langId", langId);
			map1.add("pageid", pageid);
			map1.add("total", total);
			NewsDetails[] newsList = Constant.getRestTemplate().postForObject(Constant.url + "/getAllNewsByLimit", map1,
					NewsDetails[].class);
			List<NewsDetails> newsAllList = new ArrayList<NewsDetails>(Arrays.asList(newsList));
			
			for(int i=0;i<newsAllList.size() ; i++) {
				newsAllList.get(i).setDescriptions((Jsoup.parse(newsAllList.get(i).getDescriptions()).text()));
				newsAllList.get(i).setExVar1(EmailUtility.Encrypt(String.valueOf(newsAllList.get(i).getNewsblogsId())));
			}
			
			model.addObject("newsBlogsList", newsAllList);
			session.setAttribute("gallryImageURL", Constant.getGallryImageURL);
			model.addObject("siteKey", Constant.siteKey);
			model.addObject("event", newsAllList);
			model.addObject("total", total);
			model.addObject("pageid", pageidnew);
			model.addObject("totalPage", totalPage);
			
			//model.addObject("page", page);
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}

		return model;
	}
}
