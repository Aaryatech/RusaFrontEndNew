package com.ats.rusafrontend;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.ArrayUtils;
import org.jsoup.Jsoup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.ats.rusafrontend.commen.EmailUtility;
import com.ats.rusafrontend.commen.Info;
import com.ats.rusafrontend.model.*;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) {

		 
		try {
			int langId = 1;

			HttpSession session = request.getSession();

			try {
				langId = (Integer) session.getAttribute("langId");
			} catch (Exception e) {
				// e.printStackTrace();
				session.setAttribute("langId", langId);
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("langId", langId);
			map.add("type", 1);
			TopMenuList sectionTree = Constant.getRestTemplate().postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);

			ImageLink[] image = Constant.getRestTemplate().getForObject(Constant.url + "/getAllImageLinkList", ImageLink[].class);
			List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));

			Setting[] settingList = Constant.getRestTemplate().postForObject(Constant.url + "/getAllSettingList",map, Setting[].class);
			List<Setting> setting = new ArrayList<Setting>(Arrays.asList(settingList));
			 
			BannerImages editbanner = Constant.getRestTemplate().postForObject(Constant.url + "/getLastSliderImagesByStatus",map,
					BannerImages.class);
		
			MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
			map2.add("id", 1);
			Logo logo = Constant.getRestTemplate().postForObject(Constant.url + "/getLogoListById", map2, Logo.class);

			GallaryDetail[] galleryDetail = Constant.getRestTemplate().getForObject(Constant.url + "/getLastTenVideos",
					GallaryDetail[].class);
			List<GallaryDetail> gerGalleryList = new ArrayList<GallaryDetail>(Arrays.asList(galleryDetail));

			GallaryDetail[] photoDetail = Constant.getRestTemplate().getForObject(Constant.url + "/getLastTenPhotos", GallaryDetail[].class);
			List<GallaryDetail> photoList = new ArrayList<GallaryDetail>(Arrays.asList(photoDetail));

			CmsSearchData[] getCMSDescList = Constant.getRestTemplate().postForObject(Constant.url + "/getCMSDescByExInt1", map,
					CmsSearchData[].class);
			List<CmsSearchData> getCMSDesc = new ArrayList<CmsSearchData>(Arrays.asList(getCMSDescList));

			for(int i=0;i<getCMSDesc.size() ; i++) {
				getCMSDesc.get(i).setPageDesc(Jsoup.parse(getCMSDesc.get(i).getPageDesc()).text());
			}
			
			TestImonial[] testImonialList = Constant.getRestTemplate().postForObject(Constant.url + "/getLastFiveTestImonials",map,
					TestImonial[].class);
			List<TestImonial> testImonial = new ArrayList<TestImonial>(Arrays.asList(testImonialList));

			for(int i=0;i<testImonial.size() ; i++) {
				
				if(testImonial.get(i).getExInt1()==1) { 
				 testImonial.get(i).setMessage(Jsoup.parse(testImonial.get(i).getMessage()).text()); 
				}
				 
			}
			
			//System.out.println(testImonial);
			 
			NewsDetails[] getPagesModule = Constant.getRestTemplate().postForObject(Constant.url + "/getLastFourNewsByLangId", map,
					NewsDetails[].class);
			List<NewsDetails> newsBlogsList = new ArrayList<NewsDetails>(Arrays.asList(getPagesModule));
			
			for(int i=0;i<newsBlogsList.size() ; i++) {
				newsBlogsList.get(i).setDescriptions((Jsoup.parse(newsBlogsList.get(i).getDescriptions()).text()));
				newsBlogsList.get(i).setExVar1(EmailUtility.Encrypt(String.valueOf(newsBlogsList.get(i).getNewsblogsId())));
			}
			
			SocialChannels[] socialList = Constant.getRestTemplate().getForObject(Constant.url + "/getAllSocialList",
					SocialChannels[].class);
			List<SocialChannels> socialChannelData = new ArrayList<SocialChannels>(Arrays.asList(socialList));
			//System.out.println("event :"+event.toString());
			
			
			session.setAttribute("socialChannelData", socialChannelData);
			session.setAttribute("newsBlogsList", newsBlogsList);
			session.setAttribute("testImonial", testImonial);
			session.setAttribute("getCMSDesc", getCMSDesc);
			session.setAttribute("photoList", photoList);
			session.setAttribute("videoGalleryDetail", gerGalleryList);
			session.setAttribute("logo", logo);
			session.setAttribute("logoUrl", Constant.getLgogImageURL);
			session.setAttribute("editbanner", editbanner);
			session.setAttribute("image", imagList);
			session.setAttribute("url", Constant.getBannerImageURL);
			session.setAttribute("mapping", "/");
			session.setAttribute("menuList", sectionTree);
			session.setAttribute("setting", setting);
			session.setAttribute("gallryImageURL", Constant.getGallryImageURL);

			session.setAttribute("siteFrontEndUrl", Constant.siteFrontEndUrl);
			session.setAttribute("siteDomainUrl", Constant.siteDomainUrl);

			MetaData metaData = Constant.getRestTemplate().postForObject(Constant.url + "/getHomePageMetaDataByLangId", map, MetaData.class);
			session.setAttribute("homePageMetaData", metaData);

			NewsDetails[] eventList = Constant.getRestTemplate().postForObject(Constant.url + "/newsListForHomePage",map,
					NewsDetails[].class);
			List<NewsDetails> event = new ArrayList<NewsDetails>(Arrays.asList(eventList));
			session.setAttribute("event", event);
			
			for(int i=0 ; i<event.size() ; i++) {
				event.get(i).setExVar1(EmailUtility.Encrypt(String.valueOf(event.get(i).getNewsblogsId())));
			}
			
			NewsDetails[] expireEvent = Constant.getRestTemplate().postForObject(Constant.url + "/newsExpiredListForHomePage",map,
					NewsDetails[].class);
			List<NewsDetails> expireEventList = new ArrayList<NewsDetails>(Arrays.asList(expireEvent));
			session.setAttribute("expireEventList", expireEventList);
			
			for(int i=0 ; i<expireEventList.size() ; i++) {
				expireEventList.get(i).setExVar1(EmailUtility.Encrypt(String.valueOf(expireEventList.get(i).getNewsblogsId())));
			}
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("langId", 1); 
			Setting[] settingListct = Constant.getRestTemplate().postForObject(Constant.url + "/getAllSettingList",map, Setting[].class);
			List<Setting> settingct = new ArrayList<Setting>(Arrays.asList(settingListct));
			session.setAttribute("settingcount", settingct);
			
			//System.out.println(metaData);

		} catch (Exception e) {
			e.printStackTrace();
		}

		ModelAndView model = new ModelAndView("home");

		Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
		if (maintainance.getMaintenanceStatus() == 1) {
			model = new ModelAndView("maintainance");
			model.addObject("maintainance", maintainance);
		}
		return model;
	}

	@RequestMapping(value = "/checkMaintainance", method = RequestMethod.GET)
	public @ResponseBody Maintainance checkMaintainance(HttpServletRequest request, HttpServletResponse response) {

		 
		Maintainance maintainance = new Maintainance();

		try {
			System.out.println("in Maintainance ");
			HttpSession session = request.getSession();

			maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
			session.setAttribute("maintainance", maintainance);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return maintainance;
	}

	@RequestMapping(value = "/siteInMaintainance", method = RequestMethod.GET)
	public ModelAndView siteInMaintainance(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("maintainance");

		try {

		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/retriveSession/{url}", method = RequestMethod.GET)
	public String retriveSession(@PathVariable("url") String url, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		String[] arry = url.split("-");
		 

		Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
		if (maintainance.getMaintenanceStatus() == 1) {
			session.setAttribute("maintainance", maintainance);
			return "maintainance";
		} else {

			try {
				System.out.println(url);
				System.out.println(Arrays.toString(arry));

				session.setAttribute("langId", 1);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("langId", 1);
				map.add("type", 1);
				TopMenuList sectionTree = Constant.getRestTemplate().postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);
				session.setAttribute("menuList", sectionTree);

				ImageLink[] image = Constant.getRestTemplate().getForObject(Constant.url + "/getAllImageLinkList", ImageLink[].class);
				List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));

				map = new LinkedMultiValueMap<String, Object>();
				map.add("id", 1);
				Logo logo = Constant.getRestTemplate().postForObject(Constant.url + "/getLogoListById", map, Logo.class);
				session.setAttribute("logo", logo);
				session.setAttribute("logoUrl", Constant.getLgogImageURL);
				session.setAttribute("image", imagList);
				session.setAttribute("url", Constant.getBannerImageURL);

				session.setAttribute("siteFrontEndUrl", Constant.siteFrontEndUrl);
				session.setAttribute("siteDomainUrl", Constant.siteDomainUrl);

				map = new LinkedMultiValueMap<String, Object>();
				map.add("langId", 1);
				MetaData metaData = Constant.getRestTemplate().postForObject(Constant.url + "/getHomePageMetaDataByLangId", map,
						MetaData.class);
				session.setAttribute("homePageMetaData", metaData);
				
				Setting[] settingList = Constant.getRestTemplate().getForObject(Constant.url + "/getAllSettingList", Setting[].class);
				List<Setting> setting = new ArrayList<Setting>(Arrays.asList(settingList));
				session.setAttribute("setting", setting);
				
				SocialChannels[] socialList = Constant.getRestTemplate().getForObject(Constant.url + "/getAllSocialList",
						SocialChannels[].class);
				List<SocialChannels> socialChannelData = new ArrayList<SocialChannels>(Arrays.asList(socialList)); 
				session.setAttribute("socialChannelData", socialChannelData);

			} catch (Exception e) {
				e.printStackTrace();
			}

			try {

				String ret = new String();

				 if (ArrayUtils.contains(arry, "info")) {
					ret = "info" + "/";
					for (int i = 1; i < arry.length; i++) {

						if (i == 1) {

							ret = ret + arry[i];
						} else {
							ret = ret + "-" + arry[i];
						}

					}

				}else if(url.contains("/")) {
					
					 arry = url.split("/");
					 
					 for (int i = 1; i < arry.length; i++) {

							if (i == 1) {

								ret = ret + arry[i];
							} else {
								ret = ret + "/" + arry[i];
							}

						}
					
				} else {
					for (int i = 0; i < arry.length; i++) {

						if (i == 0) {

							ret = ret + arry[i];
						} else {
							ret = ret + "-" + arry[i];
						}

					}
				}
				System.out.println("ret" + ret); 

				return "redirect:/" + ret;

			} catch (Exception e) {
				return "redirect:/";
			}
		}

	}
	
	@RequestMapping(value = "/changeLangage/{url}", method = RequestMethod.GET)
	public String changeLangage(@PathVariable("url") String url, HttpServletRequest request,
			HttpServletResponse response) {

		 
		HttpSession session = request.getSession();

		Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
		if (maintainance.getMaintenanceStatus() == 1) {
			
			session.setAttribute("maintainance", maintainance);
			return "maintainance";
			
		} else {

			String[] arry = url.split("-");

			try {
				System.out.println(url);
				System.out.println(Arrays.toString(arry));

				session.setAttribute("langId", Integer.parseInt(arry[0]));

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("langId", arry[0]);
				map.add("type", 1);
				TopMenuList sectionTree = Constant.getRestTemplate().postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);

				session.setAttribute("menuList", sectionTree);

			} catch (Exception e) {
				e.printStackTrace();
			}

			try {

				String ret = new String();

				 if (ArrayUtils.contains(arry, "info")) {
					ret = "info" + "/";
					for (int i = 2; i < arry.length; i++) {

						if (i == 2) {

							ret = ret + arry[i];
						} else {
							ret = ret + "-" + arry[i];
						}

					}

				}else if(url.contains("/")) {
					
					 arry = url.split("/");
					 
					 for (int i = 1; i < arry.length; i++) {

							if (i == 1) {

								ret = ret + arry[i];
							} else {
								ret = ret + "/" + arry[i];
							}

						}
					
				}else {
					for (int i = 1; i < arry.length; i++) {

						if (i == 1) {

							ret = ret + arry[i];
						} else {
							ret = ret + "-" + arry[i];
						}

					}
				}
				System.out.println("ret" + ret); 

				return "redirect:/" + ret;
 
			} catch (Exception e) {
				return "redirect:/";
			}

		}

	}
	
	@RequestMapping(value = "/changelang", method = RequestMethod.GET)
	public @ResponseBody Info changelang(HttpServletRequest request,
			HttpServletResponse response) {

		 
		HttpSession session = request.getSession();
		Info info = new Info();
		try {
			
			int langId = Integer.parseInt(request.getParameter("id"));
			session.setAttribute("langId", langId);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("langId", langId);
			map.add("type", 1);
			TopMenuList sectionTree = Constant.getRestTemplate().postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);
			session.setAttribute("menuList", sectionTree);

			ImageLink[] image = Constant.getRestTemplate().getForObject(Constant.url + "/getAllImageLinkList", ImageLink[].class);
			List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));

			map = new LinkedMultiValueMap<String, Object>();
			map.add("id", 1);
			Logo logo = Constant.getRestTemplate().postForObject(Constant.url + "/getLogoListById", map, Logo.class);
			session.setAttribute("logo", logo);
			session.setAttribute("logoUrl", Constant.getLgogImageURL);
			session.setAttribute("image", imagList);
			session.setAttribute("url", Constant.getBannerImageURL);

			session.setAttribute("siteFrontEndUrl", Constant.siteFrontEndUrl);
			session.setAttribute("siteDomainUrl", Constant.siteDomainUrl);

			map = new LinkedMultiValueMap<String, Object>();
			map.add("langId", langId);
			MetaData metaData = Constant.getRestTemplate().postForObject(Constant.url + "/getHomePageMetaDataByLangId", map,
					MetaData.class);
			session.setAttribute("homePageMetaData", metaData);
			
			Setting[] settingList = Constant.getRestTemplate().postForObject(Constant.url + "/getAllSettingList",map, Setting[].class);
			List<Setting> setting = new ArrayList<Setting>(Arrays.asList(settingList));
			session.setAttribute("setting", setting);
			 
			SocialChannels[] socialList = Constant.getRestTemplate().getForObject(Constant.url + "/getAllSocialList",
					SocialChannels[].class);
			List<SocialChannels> socialChannelData = new ArrayList<SocialChannels>(Arrays.asList(socialList)); 
			session.setAttribute("socialChannelData", socialChannelData);
			info.setError(false);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("langId", 1); 
			Setting[] settingListct = Constant.getRestTemplate().postForObject(Constant.url + "/getAllSettingList",map, Setting[].class);
			List<Setting> settingct = new ArrayList<Setting>(Arrays.asList(settingListct));
			session.setAttribute("settingcount", settingct);
			
		}catch(Exception e) {
			e.printStackTrace();
			info.setError(true);
		}
		
		return info;
 

	}
	
	@RequestMapping(value = "/fixContrast", method = RequestMethod.GET)
	public @ResponseBody Info fixContrast(HttpServletRequest request,
			HttpServletResponse response) {

		
		HttpSession session = request.getSession();
		Info info = new Info();
		try {
			 String contrast = request.getParameter("contrast");
			 
			session.setAttribute("contrast", contrast);
 
			info.setError(false);
			
		}catch(Exception e) {
			e.printStackTrace();
			info.setError(true);
		}
		
		return info;
 

	}
	
	@RequestMapping(value = "/refreshtime", method = RequestMethod.GET)
	public @ResponseBody Info refreshtime(HttpServletRequest request,
			HttpServletResponse response) {

		 
		Info info = new Info();
		try {
			 
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("dd MMM,yyyy | hh:mm:ss a z ", Locale.ENGLISH);
			sf.setTimeZone(TimeZone.getTimeZone("IST"));
			info.setError(false);
			info.setMsg(sf.format(date));
			
		}catch(Exception e) {
			e.printStackTrace();
			info.setError(true);
		}
		
		return info;
 

	}
	
	@RequestMapping(value = "/visitorCount", method = RequestMethod.GET)
	public @ResponseBody Info visitorCount(HttpServletRequest request,
			HttpServletResponse response) {

		 
		Info info = new Info();
		try {
			
			 
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("key", "website_visitor_hit"); 
			info = Constant.getRestTemplate().postForObject(Constant.url + "/updateCouunt",map,
					Info.class);
			 
		}catch(Exception e) {
			e.printStackTrace();
			info.setError(true);
		}
		
		return info;
 

	}
	
	
}
