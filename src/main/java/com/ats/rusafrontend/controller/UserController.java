package com.ats.rusafrontend.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

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
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.model.OtpResponse;
import com.ats.rusafrontend.model.Registration;

@Controller
@Scope("session")
public class UserController {

	RestTemplate rest = new RestTemplate();
	
	/*<dependency>
    <groupId>com.fasterxml.uuid</groupId>
    <artifactId>java-uuid-generator</artifactId>
    <version>3.1.4</version>
	</dependency>*/
	
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

		String uuid =null;
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
				String authour = request.getParameter("authour");
				
				registration.setEmails(email);
				registration.setAlternateEmail(altEmail1);
				registration.setName(name);
				registration.setCollegeName(collegeName);
				registration. setUnversityName(university);
				registration.setDepartmentName(dept);				
				registration.setUserType(1);
				registration.setMobileNumber(mobile);
				registration.setAuthorizedPerson(authour);
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
				String designation = request.getParameter("designationCollege");
				String cAuthour = request.getParameter("collegeAuthour");
				
				registration.setMobileNumber(collegeMobile);
				registration.setEmails(collegeEmail);
				registration.setAlternateEmail(altEmail2);
				registration.setName(institute);
				registration.setAuthorizedPerson(cAuthour);
				registration.setAisheCode(aisheName1);
				registration.setUnversityName(univ);
				registration.setDepartmentName(collegeDept);	
				registration.setDesignationName(designation);	
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
				String uniDes = request.getParameter("uniDes");
				String uniAuthour = request.getParameter("uniAuthour");
				
				registration.setMobileNumber(uniMobile);				
				registration.setEmails(uniEmail);
				registration.setAlternateEmail(altEmail3);
				registration.setAisheCode(aisheName2);
				registration.setName(uniName);
				registration.setAuthorizedPerson(uniAuthour);
				registration.setDepartmentName(uniDept);
				registration.setDesignationName(uniDes);	
				registration.setUserType(3);			
								
			}
			
			
			Date date = new Date(); // your date
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
		
		
			uuid = UUID.randomUUID().toString();
			
			registration.setAddDate(sf.format(date));
			registration.setUserPassword("0");
			registration.setUserUuid(uuid);
			registration.setIsActive(1);
			registration.setDelStatus(1);
			registration.setRegisterVia("web");
			
			// contactUs.setRemark(null);

			Registration res = rest.postForObject(Constant.url + "/saveReg", registration, Registration.class);
			
		        
		
			} catch (Exception e1) {
				e1.printStackTrace();
			}

		return "redirect:/ verifyOtp /"+uuid;
	}
	

	@RequestMapping(value = "/verifyOtp/{uuid}", method = RequestMethod.GET)
	public ModelAndView verifyOtp(@PathVariable("uuid") String uuid ,HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("otp");
		try {
			/*
			 * HttpSession session = request.getSession(); 
			 * session.setAttribute("suuid", suuid);
			 */
			model.addObject("uuid", uuid);
			
			

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	@RequestMapping(value="/verifyOtpProcess" , method = RequestMethod.POST)
	public ModelAndView verifyOtpProcess(HttpServletRequest request, HttpServletResponse res) throws IOException {

		String userOtp = request.getParameter("userOtp");
		String uuid = request.getParameter("uuid");
		
		System.out.println("UUID :"+uuid+", UserOTP :"+userOtp);
		
		ModelAndView mav = new ModelAndView("otp");
		 mav.addObject("uuid", uuid);
		RestTemplate rest = new RestTemplate();
		res.setContentType("text/html");
		HttpSession session = request.getSession();
		try {
			
			if (userOtp.equalsIgnoreCase("") || userOtp == null ) 
			{
				  mav = new ModelAndView("otp");
				  mav.addObject("uuid", uuid);
				  mav.addObject("msg", "Invalid Otp");
			} 
			else
			{
 
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("userOtp", userOtp);
				map.add("uuid", uuid);
				
				OtpResponse verifyOtp = rest.postForObject(Constant.url + "/verifyOtpResponse", map,
						OtpResponse.class);
			
				if (verifyOtp.isError()==false) 
				{					 				
					mav = new ModelAndView("registration");					
				} 
				else 
				{						
					  mav = new ModelAndView("otp");
					  mav.addObject("uuid", uuid);

					  System.out.println("Invalid login credentials"); 
					  mav.addObject("msg", "Invalid login");
				}							
			}
		} catch (Exception e) {
			System.out.println("HomeController Login API Excep:  " + e.getMessage());
			e.printStackTrace();
			mav.addObject("msg", "Invalid login");
		}

		return mav;
	}
	

	
}
