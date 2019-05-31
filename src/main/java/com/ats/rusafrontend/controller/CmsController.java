package com.ats.rusafrontend.controller;

import java.util.ArrayList;
import java.util.Arrays;
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
import com.ats.rusafrontend.commen.EmailUtility;
import com.ats.rusafrontend.commen.InitializeSession;
import com.ats.rusafrontend.model.*;

@Controller
@Scope("session")
public class CmsController {

	RestTemplate rest = new RestTemplate();

	@RequestMapping(value = "/info/{slugName}", method = RequestMethod.GET)
	public ModelAndView info(@PathVariable("slugName") String slugName, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/cmsContent");
		List<NewsSectionList> newsSectionList = new ArrayList<>();
		try {
			HttpSession session = request.getSession();
			session.setAttribute("mapping", "info-" + slugName);
			int langId = (Integer) session.getAttribute("langId");
			System.out.println(slugName);

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				if (session.getAttribute("menuList") == null) {
					InitializeSession.intializeSission(request);
				}

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", slugName);
				map.add("langId", langId);
				PageContent pageContent = rest.postForObject(Constant.url + "/getDataBySlugName", map,
						PageContent.class);
				pageContent.setSlugName(slugName);
				model.addObject("pageContent", pageContent);
				model.addObject("url", Constant.getCmsPdf);
				model.addObject("gallryImageURL", Constant.getGallryImageURL);

				map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", slugName);
				PageMetaData pageMetaData = rest.postForObject(Constant.url + "/getPageMetaData", map,
						PageMetaData.class);

				try {
					for (int i = 0; i < pageContent.getDetailNewsList().size(); i++) {
						pageContent.getDetailNewsList().get(i).setExVar1(EmailUtility
								.Encrypt(String.valueOf(pageContent.getDetailNewsList().get(i).getNewsblogsId())));
					}
				} catch (Exception e) {

				}
				model.addObject("pageMetaData", pageMetaData);

				map = new LinkedMultiValueMap<String, Object>();
				map.add("sectionId", pageContent.getSectioinId());
				map.add("langId", langId);
				NewsSectionList[] news = rest.postForObject(Constant.url + "/getNewsSectionBySectionId", map,
						NewsSectionList[].class);
				newsSectionList = new ArrayList<>(Arrays.asList(news));

				for (int i = 0; i < newsSectionList.size(); i++) {
					newsSectionList.get(i)
							.setExVar1(EmailUtility.Encrypt(String.valueOf(newsSectionList.get(i).getNewsblogsId())));
				}
				model.addObject("newsSectionList", newsSectionList);
				model.addObject("langId", langId);
			}

		} catch (Exception e) {
			e.printStackTrace();

			PageContent pageContent = new PageContent();
			pageContent.setSlugName(slugName);
			model.addObject("pageContent", pageContent);
			newsSectionList = new ArrayList<>();
		}

		return model;
	}

	@RequestMapping(value = "/faqContent", method = RequestMethod.GET)
	public ModelAndView faqContent(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/faqContent");
		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "faqContent");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/siteMap", method = RequestMethod.GET)
	public ModelAndView siteMap(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/siteMap");
		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "siteMap");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/searchData", method = RequestMethod.GET)
	public ModelAndView searchData(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("searchData");
		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "searchData");

			int langId = (Integer) session.getAttribute("langId");
			String word = request.getParameter("word");
			session.setAttribute("seachSentence", word);
			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("word", word);
				map.add("langId", langId);
				SearchData searchData = rest.postForObject(Constant.url + "/serchWordFromTable", map, SearchData.class);
				model.addObject("searchData", searchData);
				session.setAttribute("getGallryImageURL", Constant.getGallryImageURL);
				
				try {
					
					for (int i = 0; i < searchData.getNewsSerchList().size(); i++) {
						searchData.getNewsSerchList().get(i).setExVar1(EmailUtility
								.Encrypt(String.valueOf(searchData.getNewsSerchList().get(i).getNewsblogsId())));
					}
					
				}catch (Exception e) {
					// TODO: handle exception
				}
				// System.out.println(searchData);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/imgGallary", method = RequestMethod.GET)
	public ModelAndView imgGallary(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/imageGallary");
		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "imgGallary");

			String slugname = new String();

			try {

				slugname = request.getParameter("name");

			} catch (Exception e) {

				slugname = "rusa-181";

			}

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				if (session.getAttribute("menuList") == null) {
					InitializeSession.intializeSission(request);
				}

				int langId = (Integer) session.getAttribute("langId");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("key", "gallarySectionId");
				Setting setting = rest.postForObject(Constant.url + "/getSettingRecordByKey", map, Setting.class);

				map = new LinkedMultiValueMap<String, Object>();
				map.add("sectionId", setting.getKeyValues());
				GetCategory[] category = rest.postForObject(Constant.url + "/getAllCatIdBySectionIdOrderByDesc", map,
						GetCategory[].class);
				List<GetCategory> categoryList = new ArrayList<GetCategory>(Arrays.asList(category));
				model.addObject("rusaList", categoryList);

				if (slugname == null) {
					slugname = categoryList.get(0).getSlugName();
				}

				map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", slugname);
				map.add("langId", langId);
				System.out.println(map);
				PageContent pageContent = rest.postForObject(Constant.url + "/getImages", map, PageContent.class);
				model.addObject("imageList", pageContent);
				model.addObject("gallryImageURL", Constant.getGallryImageURL);
				model.addObject("slugname", slugname);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/imgGallaryDetail/{slugname}/{catId}/{cateName}", method = RequestMethod.GET)
	public ModelAndView imgGallaryDetail(@PathVariable("slugname") String slugname, @PathVariable("catId") int catId,
			@PathVariable("cateName") String cateName, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("content/imgGallaryDetail");
		try {

			HttpSession session = request.getSession();
			session.setAttribute("mapping", "imgGallary");

			Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);

			if (maintainance.getMaintenanceStatus() == 1) {

				model = new ModelAndView("maintainance");
				model.addObject("maintainance", maintainance);
			} else {

				if (session.getAttribute("menuList") == null) {
					InitializeSession.intializeSission(request);
				}

				int langId = (Integer) session.getAttribute("langId");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("key", "gallarySectionId");
				Setting setting = rest.postForObject(Constant.url + "/getSettingRecordByKey", map, Setting.class);

				map = new LinkedMultiValueMap<String, Object>();
				map.add("sectionId", setting.getKeyValues());
				GetCategory[] category = rest.postForObject(Constant.url + "/getAllCatIdBySectionId", map,
						GetCategory[].class);
				List<GetCategory> categoryList = new ArrayList<GetCategory>(Arrays.asList(category));
				model.addObject("rusaList", categoryList);

				map = new LinkedMultiValueMap<String, Object>();
				map.add("slugName", slugname);
				map.add("langId", langId);
				System.out.println(map);
				PageContent pageContent = rest.postForObject(Constant.url + "/getImages", map, PageContent.class);
				model.addObject("imageList", pageContent.getGallaryDetailList());
				model.addObject("videoList", pageContent.getVideoList());
				model.addObject("gallryImageURL", Constant.getGallryImageURL);
				model.addObject("catId", catId);
				model.addObject("cateName", cateName);
				model.addObject("slugname", slugname);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "errors", method = RequestMethod.GET)
	public ModelAndView renderErrorPage(HttpServletRequest httpRequest) {

		ModelAndView errorPage = new ModelAndView("error404");
		String errorMsg = "";
		int httpErrorCode = getErrorCode(httpRequest);

		switch (httpErrorCode) {
		case 400: {
			errorMsg = "Http Error Code: 400. Bad Request";
			break;
		}
		case 401: {
			errorMsg = "Http Error Code: 401. Unauthorized";
			break;
		}
		case 404: {
			errorMsg = "Http Error Code: 404. Resource not found";
			break;
		}
		case 500: {
			errorMsg = "Http Error Code: 500. Internal Server Error";
			break;
		}
		}
		errorPage.addObject("errorMsg", errorMsg);
		return errorPage;
	}

	private int getErrorCode(HttpServletRequest httpRequest) {
		return (Integer) httpRequest.getAttribute("javax.servlet.error.status_code");
	}

}
