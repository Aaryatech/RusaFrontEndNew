package com.ats.rusafrontend.controller;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.model.ContactUs;
import com.ats.rusafrontend.model.Registration;
import com.ats.rusafrontend.reCaptcha.VerifyRecaptcha;

@Controller
@Scope("session")
public class UserController {

	RestTemplate rest = new RestTemplate();
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("login");
		try {

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public ModelAndView registration(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("registration");
		try {

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	@RequestMapping(value = "/insertUserRegistration", method = RequestMethod.POST)
	public String insertUserRegistration(HttpServletRequest request, HttpServletResponse response) {

		try {
			Registration registration=new Registration();

			int type = Integer.parseInt(request.getParameter("userType"));
			if(type==1)
			{
				String email = request.getParameter("email");
				String altEmail1 = request.getParameter("altEmail");
				String name = request.getParameter("name");
				String collegeName = request.getParameter("collegeName");
				String university = request.getParameter("university");
				String dept = request.getParameter("dept");
				String dob = request.getParameter("dob");
				String mobile = request.getParameter("mobile");
				
				registration.setEmails(email);
				registration.setAlternateEmail(altEmail1);
				registration.setName(name);
				registration.setCollegeName(collegeName);
				registration. setUnversityName(university);
				registration.setDepartmentName(dept);				
				registration.setUserType(1);
				registration.setMobileNumber(mobile);
				registration.setDob(DateConvertor.convertToYMD(dob));
				
			}
			if(type==2)
			{
				String collegeEmail = request.getParameter("collegeEmail");
				String altEmail2 = request.getParameter("altEmail");
				String institute = request.getParameter("institute");
				String aisheName1 = request.getParameter("aisheName");
				String univ = request.getParameter("univ");
				String collegeDept = request.getParameter("collegeDept");
				String collegeMobile = request.getParameter("collegeMobile");
				
				registration.setMobileNumber(collegeMobile);
				registration.setEmails(collegeEmail);
				registration.setAlternateEmail(altEmail2);
				registration.setCollegeName(institute);
				registration.setAisheCode(aisheName1);
				registration.setUnversityName(univ);
				registration.setDepartmentName(collegeDept);				
				registration.setUserType(2);					
				
			}
			if(type==3)
			{
				String uniEmail = request.getParameter("uniEmail");
				String altEmail3 = request.getParameter("altEmail");
				String uniName = request.getParameter("uniName");
				String aisheName2 = request.getParameter("aisheName");				
				String uniDept = request.getParameter("uniDept");
				String uniMobile = request.getParameter("uniMobile");
				
				registration.setMobileNumber(uniMobile);				
				registration.setEmails(uniEmail);
				registration.setAlternateEmail(altEmail3);
				registration.setAisheCode(aisheName2);
				registration.setUnversityName(uniName);
				registration.setDepartmentName(uniDept);				
				registration.setUserType(3);			
								
			}
			
			
			Date date = new Date(); // your date
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
		
			
			registration.setAddDate(sf.format(date));
			registration.setUserPassword("0");
			registration.setUserUuid("0");
			registration.setIsActive(1);
			registration.setDelStatus(1);
				// contactUs.setRemark(null);

			Registration res = rest.postForObject(Constant.url + "/saveRegistration", registration, Registration.class);

		
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/ContactUs";
	}
	
}
