package com.ats.rusafrontend;



import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.ArrayUtils;
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

		RestTemplate rest = new RestTemplate();
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

			TopMenuList sectionTree = rest.postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);

			ImageLink[] image = rest.getForObject(Constant.url + "/getAllImageLinkList", ImageLink[].class);
			List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));

			Setting[] settingList = rest.getForObject(Constant.url + "/getAllSettingList", Setting[].class);
			List<Setting> setting = new ArrayList<Setting>(Arrays.asList(settingList));
			
			BannerImages editbanner = rest.getForObject(Constant.url + "/getLastSliderImagesByStatus",
					BannerImages.class);
		
			MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
			map2.add("id", 1);
			Logo logo = rest.postForObject(Constant.url + "/getLogoListById", map2, Logo.class);

			GallaryDetail[] galleryDetail = rest.getForObject(Constant.url + "/getLastTenVideos",
					GallaryDetail[].class);
			List<GallaryDetail> gerGalleryList = new ArrayList<GallaryDetail>(Arrays.asList(galleryDetail));

			GallaryDetail[] photoDetail = rest.getForObject(Constant.url + "/getLastTenPhotos", GallaryDetail[].class);
			List<GallaryDetail> photoList = new ArrayList<GallaryDetail>(Arrays.asList(photoDetail));

			CmsSearchData[] getCMSDescList = rest.postForObject(Constant.url + "/getCMSDescByExInt1", map,
					CmsSearchData[].class);
			List<CmsSearchData> getCMSDesc = new ArrayList<CmsSearchData>(Arrays.asList(getCMSDescList));

			TestImonial[] testImonialList = rest.getForObject(Constant.url + "/getLastFiveTestImonials",
					TestImonial[].class);
			List<TestImonial> testImonial = new ArrayList<TestImonial>(Arrays.asList(testImonialList));

			NewsDetails[] getPagesModule = rest.postForObject(Constant.url + "/getLastFourNewsByLangId", map,
					NewsDetails[].class);
			List<NewsDetails> newsBlogsList = new ArrayList<NewsDetails>(Arrays.asList(getPagesModule));
			
			SocialChannels[] socialList = rest.getForObject(Constant.url + "/getAllSocialList",
					SocialChannels[].class);
			List<SocialChannels> socialChannelData = new ArrayList<SocialChannels>(Arrays.asList(socialList));
			System.out.println("List :"+socialChannelData.toString());
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

			MetaData metaData = rest.postForObject(Constant.url + "/getHomePageMetaDataByLangId", map, MetaData.class);
			session.setAttribute("homePageMetaData", metaData);

			System.out.println(metaData);

		} catch (Exception e) {
			e.printStackTrace();
		}

		ModelAndView model = new ModelAndView("home");

		Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
		if (maintainance.getMaintenanceStatus() == 1) {
			model = new ModelAndView("maintainance");
			model.addObject("maintainance", maintainance);
		}
		return model;
	}

	@RequestMapping(value = "/checkMaintainance", method = RequestMethod.GET)
	public @ResponseBody Maintainance checkMaintainance(HttpServletRequest request, HttpServletResponse response) {

		RestTemplate rest = new RestTemplate();
		Maintainance maintainance = new Maintainance();

		try {
			System.out.println("in Maintainance ");
			HttpSession session = request.getSession();

			maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
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
		RestTemplate rest = new RestTemplate();

		Maintainance maintainance = rest.getForObject(Constant.url + "/checkIsMaintenance", Maintainance.class);
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

				TopMenuList sectionTree = rest.postForObject(Constant.url + "/getTopMenuList", map, TopMenuList.class);
				session.setAttribute("menuList", sectionTree);

				ImageLink[] image = rest.getForObject(Constant.url + "/getAllImageLinkList", ImageLink[].class);
				List<ImageLink> imagList = new ArrayList<ImageLink>(Arrays.asList(image));

				map = new LinkedMultiValueMap<String, Object>();
				map.add("id", 1);
				Logo logo = rest.postForObject(Constant.url + "/getLogoListById", map, Logo.class);
				session.setAttribute("logo", logo);
				session.setAttribute("logoUrl", Constant.getLgogImageURL);
				session.setAttribute("image", imagList);
				session.setAttribute("url", Constant.getBannerImageURL);

				session.setAttribute("siteFrontEndUrl", Constant.siteFrontEndUrl);
				session.setAttribute("siteDomainUrl", Constant.siteDomainUrl);

				map = new LinkedMultiValueMap<String, Object>();
				map.add("langId", 1);
				MetaData metaData = rest.postForObject(Constant.url + "/getHomePageMetaDataByLangId", map,
						MetaData.class);
				session.setAttribute("homePageMetaData", metaData);

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
}
