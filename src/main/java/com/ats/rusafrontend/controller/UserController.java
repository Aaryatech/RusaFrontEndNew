package com.ats.rusafrontend.controller;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.model.ContactUs;
import com.ats.rusafrontend.model.Registration;
import com.ats.rusafrontend.reCaptcha.VerifyRecaptcha;
import com.fasterxml.uuid.Generators;

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
		
			//UUID uuid1 = Generators.timeBasedGenerator().generate();
			String suuid = UUID.randomUUID().toString();
			//String corrId= uuid1;
			//registration.setCorrId(uuid1);
			registration.setAddDate(sf.format(date));
			registration.setUserPassword("0");
			registration.setUserUuid(suuid);
			registration.setIsActive(1);
			registration.setDelStatus(1);
			registration.setRegisterVia("web");
			
				// contactUs.setRemark(null);

			Registration res = rest.postForObject(Constant.url + "/saveRegistration", registration, Registration.class);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("suuid", suuid);
			map.add("type", type);
			Registration editReg = rest.postForObject(Constant.url + "/getUserByUUIDAndType", map,
					Registration.class);

			System.out.println("Send To Email Address" + editReg.getEmails());

			if (res != null) {

				final String emailSMTPserver = "smtp.gmail.com";
				final String emailSMTPPort = "587";
				final String mailStoreType = "imaps";
				final String username = "atsinfosoft@gmail.com";
				final String password = "atsinfosoft@123";

				System.out.println("username" + username);
				System.out.println("password" + password);

				Properties props = new Properties();
				props.put("mail.smtp.host", "smtp.gmail.com");
				props.put("mail.smtp.socketFactory.port", "465");
				props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.port", "587");

				Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, password);
					}
				});

			
				try {
					Store mailStore = session.getStore(mailStoreType);
					mailStore.connect(emailSMTPserver, username, password);

					String mes = " Hello ,\n Greetings !!\n ";

					String address = editReg.getEmails() + " , dhomaneneha@gmail.com";

					String subject = "Activate your account...... ";
							

					Message mimeMessage = new MimeMessage(session);
					mimeMessage.setFrom(new InternetAddress(username));
					mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(address));
					mimeMessage.setSubject(subject);
					mimeMessage.setText(mes);
					Transport.send(mimeMessage);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
			}
			} catch (Exception e1) {
				e1.printStackTrace();
			}

		return "redirect:/registration";
	}
	
}
