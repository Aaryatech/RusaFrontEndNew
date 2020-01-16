package com.ats.rusafrontend.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import com.ats.rusafrontend.commen.Constant;
import com.ats.rusafrontend.commen.DateConvertor;
import com.ats.rusafrontend.commen.Info;
import com.ats.rusafrontend.commen.VpsImageUpload;
import com.ats.rusafrontend.model.DocType;
import com.ats.rusafrontend.model.Maintainance;
import com.ats.rusafrontend.model.Registration;
import com.ats.rusafrontend.model.RegistrationUserDetail;
import com.ats.rusafrontend.model.UploadDocument;

@Controller
@Scope("session")
public class DocumentUploadController {

	@RequestMapping(value = "/documentUpload", method = RequestMethod.GET)
	public String documentUpload(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();
		String mav = new String();
		try {

			session.setAttribute("mapping", "documentUpload");

			Maintainance maintainance = Constant.getRestTemplate().getForObject(Constant.url + "/checkIsMaintenance",
					Maintainance.class);
			if (maintainance.getMaintenanceStatus() == 1) {

				mav = "maintainance";
				model.addAttribute("maintainance", maintainance);
			} else {
				mav = "documentUpload";
				int userDetail = (int) session.getAttribute("UserDetail");
				DocType[] docType = Constant.getRestTemplate().getForObject(Constant.url + "/getDocTypeList",
						DocType[].class);
				List<DocType> docTypelist = new ArrayList<>(Arrays.asList(docType));
				model.addAttribute("docTypelist", docTypelist);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("regId", userDetail);
				UploadDocument[] uploadDocument = Constant.getRestTemplate()
						.postForObject(Constant.url + "/getDocumentByRegId", map, UploadDocument[].class);
				List<UploadDocument> uploadDocumentlist = new ArrayList<>(Arrays.asList(uploadDocument));

				for (int i = 0; i < uploadDocumentlist.size(); i++) {

					long bytes = uploadDocumentlist.get(i).getDocSize();
					String size = new String();
					try {
						int unit = true ? 1000 : 1024;
						if (bytes < unit)
							size = bytes + " B";
						int exp = (int) (Math.log(bytes) / Math.log(unit));
						String pre = (true ? "kMGTPE" : "KMGTPE").charAt(exp - 1) + (true ? "" : "i");
						size = String.format("%.1f %sB", bytes / Math.pow(unit, exp), pre);
						uploadDocumentlist.get(i).setExtraVarchar1(size);
					} catch (Exception e) {
						uploadDocumentlist.get(i).setExtraVarchar1("1kb");
					}
				}

				model.addAttribute("uploadDocumentlist", uploadDocumentlist);
				model.addAttribute("frontDocUrl", Constant.getUserDocURL);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav = "login";
		}

		return mav;
	}

	@RequestMapping(value = "/submitUploadDocForm", method = RequestMethod.POST)
	public String submitUploadDocForm(@RequestParam("docName") List<MultipartFile> docName, HttpServletRequest request,
			HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();

		try {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			int typeId = Integer.parseInt(request.getParameter("typeId"));
			String title = request.getParameter("docTitle");

			try {

				VpsImageUpload upload = new VpsImageUpload();
				Date date = new Date();
				SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
				String imageName = new String();
				imageName = dateTimeInGMT.format(date) + "_" + docName.get(0).getOriginalFilename();
				Info info = upload.saveUploadedFiles(docName.get(0), Constant.userDocURL, Constant.files, imageName);

				if (info.isError() == false) {
					int userDetail = (int) session.getAttribute("UserDetail");

					UploadDocument save = new UploadDocument();
					save.setDelStatus(1);
					save.setDocSize(docName.get(0).getSize());
					save.setFileName(imageName);
					save.setTypeId(typeId);
					save.setRegId(userDetail);
					save.setTitle(HtmlUtils.htmlEscape(title));
					save.setUploadDateTime(sf.format(date));

					UploadDocument res = Constant.getRestTemplate().postForObject(Constant.url + "/saveUploadDocument",
							save, UploadDocument.class);
					session.setAttribute("success", "Document Uploaded Successfully ");
				} else {
					session.setAttribute("errorMsg", "Failed to upload !");
				}

			} catch (Exception e) {
				session.setAttribute("errorMsg", "Failed to upload !");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to upload !");
		}

		return "redirect:/documentUpload";
	}

}
