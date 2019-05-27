package com.ats.rusafrontend.commen;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.ats.rusafrontend.model.ImageLink;
import com.ats.rusafrontend.model.Logo;
import com.ats.rusafrontend.model.MetaData;
import com.ats.rusafrontend.model.Setting;
import com.ats.rusafrontend.model.SocialChannels;
import com.ats.rusafrontend.model.TopMenuList;

public class InitializeSession {
	
	   
	
	public static void intializeSission(HttpServletRequest request) {
			 
		 RestTemplate rest = new RestTemplate();
		 
		HttpSession session = request.getSession();
		session.setAttribute("langId", 1);

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("langId", 1);
		map.add("type", 1);
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
		
		Setting[] settingList = rest.getForObject(Constant.url + "/getAllSettingList", Setting[].class);
		List<Setting> setting = new ArrayList<Setting>(Arrays.asList(settingList));
		session.setAttribute("setting", setting);
		
		SocialChannels[] socialList = rest.getForObject(Constant.url + "/getAllSocialList",
				SocialChannels[].class);
		List<SocialChannels> socialChannelData = new ArrayList<SocialChannels>(Arrays.asList(socialList)); 
		session.setAttribute("socialChannelData", socialChannelData);
			
		}

}
