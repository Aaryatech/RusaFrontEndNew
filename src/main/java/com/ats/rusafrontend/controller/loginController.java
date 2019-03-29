package com.ats.rusafrontend.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.FilenameUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.commen.VpsImageUpload;
import com.ats.rusafrontend.model.ContentImages;
import com.ats.rusafrontend.model.OtpResponse;
import com.ats.rusafrontend.model.Registration;


@Controller
@Scope("session")
public class loginController {
	RestTemplate rest = new RestTemplate();
	Registration editReg = new Registration();
	/*
	 * @RequestMapping(value = "/editProfile", method = RequestMethod.GET) public
	 * ModelAndView editProfile(HttpServletRequest request, HttpServletResponse
	 * response) {
	 * 
	 * ModelAndView model = new ModelAndView("edit-profile"); try {
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return model; }
	 */
	
	@RequestMapping(value = "/myProfile", method = RequestMethod.GET)
	public ModelAndView myProfile(HttpServletRequest request,	HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = new ModelAndView("edit-profile");
		try {
			int userDetail = (int) session.getAttribute("UserDetail");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("regId", userDetail); 
			editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
			String dobDate = DateConvertor.convertToDMY(editReg.getDob());
			model.addObject("editReg", editReg);
			model.addObject("dobDate", dobDate);
			model.addObject("isEdit",1);
		//	model.addObject("url", Constant.bannerImageURL);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	@RequestMapping(value = "/editProfile", method = RequestMethod.GET)
	public ModelAndView editProfile(HttpServletRequest request,	HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = new ModelAndView("edit-my-profile");
		try {
			int userDetail = (int) session.getAttribute("UserDetail");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("regId", userDetail); 
			editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
			String dobDate = DateConvertor.convertToDMY(editReg.getDob());
			model.addObject("editReg", editReg);
			model.addObject("dobDate", dobDate);
			model.addObject("isEdit",1);
		//	model.addObject("url", Constant.bannerImageURL);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	@RequestMapping(value = "/editUserRegistration", method = RequestMethod.POST)
	public String editUserRegistration(HttpServletRequest request, HttpServletResponse response) {

		String redirect = null;
		String uuid=editReg.getUserUuid();
		try {
			Date date = new Date(); // your date
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			int type = Integer.parseInt(request.getParameter("userType"));
			System.out.println("Type: "+uuid);
			if (type == 1) {
				String email = request.getParameter("email");
				String altEmail1 = request.getParameter("altEmail");
				String name = request.getParameter("name");
				String collegeName = request.getParameter("collegeName");
				String university = request.getParameter("university");
				String dept = request.getParameter("dept");
				String dob = request.getParameter("dob");
				String mobile = request.getParameter("mobile");
				String authour = request.getParameter("authour");

			
				editReg.setAlternateEmail(altEmail1);
				editReg.setName(name);
				editReg.setCollegeName(collegeName);
				editReg.setUnversityName(university);
				editReg.setDepartmentName(dept);
				editReg.setUserType(1);
				editReg.setAuthorizedPerson(authour);
				editReg.setDob(DateConvertor.convertToYMD(dob));
				
				if(editReg.getEmails().equals(email))
				{
					editReg.setEmails(email);
				}
				else
				{
					System.out.println("Email new");
					editReg.setExVar1(email);
				}
				if(editReg.getMobileNumber().equals(mobile))
				{
					editReg.setMobileNumber(mobile);
					editReg.setEditDate(sf.format(date)); 
					Registration res = rest.postForObject(Constant.url + "/saveRegistration", editReg,  Registration.class); 
					redirect="redirect:/editProfile";
				}
				else
				{
					System.out.println("1. mobile number");
					editReg.setExVar2(mobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveReg", editReg, Registration.class);
					redirect="redirect:/ editVerifyOtp /"+ uuid +"";
				}	
				
			}
			if (type == 2) {
				String collegeEmail = request.getParameter("collegeEmail");
				String altEmail2 = request.getParameter("altEmail");
				String institute = request.getParameter("institute");
				String aisheName1 = request.getParameter("aisheName");
				String univ = request.getParameter("univ");
				String collegeDept = request.getParameter("collegeDept");
				String collegeMobile = request.getParameter("collegeMobile");
				String designation = request.getParameter("designationCollege");
				String cAuthour = request.getParameter("collegeAuthour");

			
				
				editReg.setAlternateEmail(altEmail2);
				editReg.setName(institute);
				editReg.setAuthorizedPerson(cAuthour);
				editReg.setAisheCode(aisheName1);
				editReg.setUnversityName(univ);
				editReg.setDepartmentName(collegeDept);
				editReg.setDesignationName(designation);
				editReg.setUserType(2);
				
				if(editReg.getEmails().equals(collegeEmail))
				{
					editReg.setEmails(collegeEmail);
				}
				else
				{
					System.out.println("Email new");
					editReg.setExVar1(collegeEmail);
				}
				
				if(editReg.getMobileNumber().equals(collegeMobile))
				{
					editReg.setMobileNumber(collegeMobile);
					editReg.setEditDate(sf.format(date)); 
					Registration res = rest.postForObject(Constant.url + "/saveRegistration", editReg,  Registration.class); 
					redirect="redirect:/editProfile";
				}
				else
				{
					System.out.println("Email new");
					editReg.setExVar2(collegeMobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveReg", editReg, Registration.class);
					redirect="redirect:/ editVerifyOtp /"+ uuid +"";
				}
				
			}
			if (type == 3) {
				String uniEmail = request.getParameter("uniEmail");
				String altEmail3 = request.getParameter("altEmail");
				String uniName = request.getParameter("uniName");
				String aisheName2 = request.getParameter("aisheName");
				String uniDept = request.getParameter("uniDept");
				String uniMobile = request.getParameter("uniMobile");
				String uniDes = request.getParameter("uniDes");
				String uniAuthour = request.getParameter("uniAuthour");

				editReg.setExVar2(uniMobile);
				editReg.setExVar1(uniEmail);
				editReg.setAlternateEmail(altEmail3);
				editReg.setAisheCode(aisheName2);
				editReg.setName(uniName);
				editReg.setAuthorizedPerson(uniAuthour);
				editReg.setDepartmentName(uniDept);
				editReg.setDesignationName(uniDes);
				editReg.setUserType(3);
				

				if(editReg.getEmails().equals(uniEmail))
				{
					editReg.setEmails(uniEmail);
				}
				else
				{
					System.out.println("Email new");
					editReg.setExVar1(uniEmail);
				}

				if(editReg.getMobileNumber().equals(uniMobile))
				{
					editReg.setMobileNumber(uniMobile);
					editReg.setEditDate(sf.format(date)); 
					Registration res = rest.postForObject(Constant.url + "/saveRegistration", editReg,  Registration.class); 
					redirect="redirect:/editProfile";
				}
				else
				{
					System.out.println("Email new");
					editReg.setExVar2(uniMobile);
					editReg.setEditDate(sf.format(date));
					Registration res = rest.postForObject(Constant.url + "/saveReg", editReg, Registration.class);
					redirect="redirect:/ editVerifyOtp /"+ uuid +"";
				}
				
				
				
			}
			System.out.println("Data: "+editReg.toString());
			
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		return redirect ;
	}
	
	@RequestMapping(value = "/editVerifyOtp/{uuid}", method = RequestMethod.GET)
	public ModelAndView editVerifyOtp( @PathVariable("uuid") String uuid, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("editRegOtp");
		try {
			/*
			 * HttpSession session = request.getSession(); session.setAttribute("suuid",
			 * suuid);
			 */
			model.addObject("uuid", uuid);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
	
	@RequestMapping(value = "/verifyEditOtpProcess", method = RequestMethod.POST)
	public ModelAndView verifyEditOtpProcess(HttpServletRequest request, HttpServletResponse res) throws IOException {

		String userOtp = request.getParameter("userOtp");
		String uuid = request.getParameter("uuid");
		HttpSession session = request.getSession();
		//int type = Integer.parseInt(request.getParameter("type")); 
		//int userDetail = (int) session.getAttribute("UserDetail");
		System.out.println("UUID :" + uuid + ", UserOTP :" + userOtp);

		ModelAndView mav = new ModelAndView("editRegOtp");
		mav.addObject("uuid", uuid);
		RestTemplate rest = new RestTemplate();
		res.setContentType("text/html");
	
		try {

			if (userOtp.equalsIgnoreCase("") || userOtp == null) {
				mav = new ModelAndView("editRegOtp");
				mav.addObject("uuid", uuid);
				mav.addObject("msg", "Invalid Otp");
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("userOtp", userOtp);
				map.add("uuid", uuid);

				OtpResponse verifyOtp = rest.postForObject(Constant.url + "/verifyOtpResponse", map, OtpResponse.class);

				if (verifyOtp.isError() == false) {
					mav = new ModelAndView("edit-my-profile");
					
					//mav.addObject("userDetail",userDetail);
				} else {
					mav = new ModelAndView("editRegOtp");
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

	@RequestMapping(value = "/resendEditOtpProcess", method = RequestMethod.POST)
	public ModelAndView resendEditOtpProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("editRegOtp");
		try {

			String uuid = request.getParameter("uuid");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("uuid", uuid);

			OtpResponse verifyOtp = rest.postForObject(Constant.url + "/verifyEditResendOtp", map,
					OtpResponse.class);

			if (verifyOtp.isError() == false) {
				mav = new ModelAndView("editRegOtp");
				mav.addObject("uuid", uuid);
				System.out.println(" update ragistration table new :");
			} else {
				mav = new ModelAndView("edit-my-profile");
			}

			mav.addObject("uuid", uuid);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	@RequestMapping(value = "/uploadProfilePhoto", method = RequestMethod.POST)
	public ModelAndView uploadProfilePhoto(@RequestParam("file") List<MultipartFile> file, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav=new ModelAndView("content/upcoming-dashboard");
		HttpSession session = request.getSession();
		try {
			System.out.println("Profile Photo");
			 
		   Date date = new Date();
		   SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
		   String imageName = new String(); 
			imageName =  dateTimeInGMT.format(date)+"_"+file.get(0).getOriginalFilename();
			VpsImageUpload upload = new VpsImageUpload();
			 
			int userDetail = (int) session.getAttribute("UserDetail");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("regId", userDetail);
			 try {
				// upload.saveUploadedImge(file.get(0), Constant.otherDocURL,imageName,Constant.values,0,0,0,0,0);
					editReg = rest.postForObject(Constant.url + "/getRegUserbyRegId", map, Registration.class);
				
				 upload.saveUploadedImge(file.get(0), Constant.gallryImageURL,imageName,Constant.DocValues,0,0,0,0,0);
				 editReg.setImageName(imageName);
				 System.out.println("Data :"+editReg.toString());				 
				 Registration res = rest.postForObject(Constant.url + "/saveRegistration", editReg,  Registration.class);
				 
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				} 
			 session.setAttribute("gallryImageURL", Constant.gallryImageURL);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	/*
	 * @RequestMapping(value = "/uploadPhoto", method = RequestMethod.GET) public
	 * ModelAndView uploadPhoto( HttpServletRequest request, HttpServletResponse
	 * response) {
	 * 
	 * ModelAndView model = new ModelAndView("change-pass"); try {
	 * 
	 * List<ContentImages> list = new ArrayList<ContentImages>();
	 * 
	 * File folder = new File(Constant.otherDocURL); File[] listOfFiles =
	 * folder.listFiles();
	 * 
	 * for (int i = 0; i < listOfFiles.length; i++) { if (listOfFiles[i].isFile()) {
	 * 
	 * 
	 * ContentImages contentImages = new ContentImages();
	 * contentImages.setImage(listOfFiles[i].getName());
	 * contentImages.setThumb(Constant.getOtherDocURL+listOfFiles[i].getName());
	 * 
	 * contentImages.setLastmod(String.valueOf(listOfFiles[i].lastModified()));
	 * contentImages.setType(Files.probeContentType(listOfFiles[i].toPath()));
	 * 
	 * 
	 * DiskFileItem fileItem = new DiskFileItem(listOfFiles[i].getName(),
	 * contentImages.getType(), false, listOfFiles[i].getName(), (int)
	 * listOfFiles[i].length() , listOfFiles[i].getParentFile());
	 * fileItem.getOutputStream(); MultipartFile multipartFile = new
	 * CommonsMultipartFile(fileItem);
	 * contentImages.setSize(FilenameUtils.getExtension(multipartFile.
	 * getOriginalFilename()));
	 * 
	 * 
	 * list.add(contentImages); } } System.out.println(list);
	 * 
	 * model.addObject("list", list);
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return model; }
	 */
	
}
