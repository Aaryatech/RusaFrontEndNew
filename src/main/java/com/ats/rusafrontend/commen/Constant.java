package com.ats.rusafrontend.commen;

/*import org.springframework.http.client.support.BasicAuthorizationInterceptor;*/
import org.springframework.web.client.RestTemplate;

public class Constant {

	//public static final String url = "http://localhost:8094/";

	//public static final String url = "http://115.124.111.54:8080/RusaSiteWebService/";
	public static final String url="http://10.9.63.2:8080/RusaSiteWebService/";

	/*
	 * public static final String getLgogImageURL =
	 * "http://192.168.2.17:8080/media/logo/"; public static final String
	 * getBannerImageURL = "http://192.168.2.17:8080/media/banenr/"; public static
	 * final String getUploadDocURL = "http://192.168.2.17:8080/media/pdf/"; public
	 * static final String getGallryImageURL =
	 * "http://192.168.2.17:8080/media/gallery/"; public static final String
	 * getCmsPdf = "http://192.168.2.17:8080/media/pdf/"; public static final String
	 * getUserProfileURL = "http://192.168.2.17:8080/media/userprofile/"; public
	 * static final String userProfileURL =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/userprofile/";
	 * public static final String cmsPdf =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/pdf/"; public
	 * static final String siteFrontEndUrl = "http://localhost:8081/rusafrontend/";
	 * public static final String siteDomainUrl = "http://localhost:8081/"; public
	 * static final String userDocURL =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/userdocument/";
	 * public static final String getUserDocURL =
	 * "http://192.168.2.17:8080/media/userdocument/";
	 */

	/*
	 * public static final String getLgogImageURL =
	 * "http://ats.aaryatechindia.in:15063/media/logo/"; public static final String
	 * getBannerImageURL = "http://ats.aaryatechindia.in:15063/media/banenr/";
	 * public static final String getUploadDocURL =
	 * "http://ats.aaryatechindia.in:15063/media/pdf/"; public static final String
	 * getGallryImageURL = "http://ats.aaryatechindia.in:15063/media/gallery/";
	 * public static final String getCmsPdf =
	 * "http://ats.aaryatechindia.in:15063/media/pdf/"; public static final String
	 * getUserProfileURL = "http://ats.aaryatechindia.in:15063/media/userprofile/";
	 * public static final String siteFrontEndUrl =
	 * "http://ats.aaryatechindia.in:15063/rusafrontend/"; public static final
	 * String siteDomainUrl = "http://ats.aaryatechindia.in:15063/"; public static
	 * final String userProfileURL =
	 * "/home/tomcataaryatechi/ats.aaryatechindia.in/tomcat-8.0.18/webapps/media/userprofile/";
	 * public static final String userDocURL =
	 * "/home/tomcataaryatechi/ats.aaryatechindia.in/tomcat-8.0.18/webapps/media/userdocument/";
	 * public static final String getUserDocURL =
	 * "http://ats.aaryatechindia.in:15063/media/userdocument/"; public static final
	 * String cmsPdf =
	 * "/home/tomcataaryatechi/ats.aaryatechindia.in/tomcat-8.0.18/webapps/media/pdf/";
	 */

	public static final String getLgogImageURL = "http://115.124.111.54:8080/mediarusa/logo/";
	public static final String getBannerImageURL = "http://115.124.111.54:8080/mediarusa/banenr/";
	public static final String getUploadDocURL = "http://115.124.111.54:8080/mediarusa/pdf/";
	public static final String getGallryImageURL = "http://115.124.111.54:8080/mediarusa/gallery/";
	public static final String getCmsPdf = "http://115.124.111.54:8080/mediarusa/pdf/";
	public static final String getUserProfileURL = "http://115.124.111.54:8080/mediarusa/userprofile/";
	public static final String siteFrontEndUrl = "http://115.124.111.54:8080/Rusaweb/";
	public static final String siteDomainUrl = "http://115.124.111.54:8080/";
	public static final String getUserDocURL = "http://115.124.111.54:8080/mediarusa/userUploadeddocument/";
	public static final String userDocURL = "/opt/tomcat/webapps/mediarusa/userUploadeddocument/";
	public static final String userProfileURL = "/opt/tomcat/webapps/mediarusa/userprofile/";
	public static final String cmsPdf = "/opt/tomcat/webapps/mediarusa/pdf/";

	public static final String secretKey = "6LfXSJYUAAAAALy3h-8ulTPu7DdW4kFVwFAlFiJL";
	public static final String siteKey = "6LfXSJYUAAAAAPrR2Jkt9ZpittUp2qTAM6OzG-Ce";
	public static String[] values = { "jpg", "jpeg", "gif", "png" };
	public static String[] pdf = { "pdf", "PDF" };
	public static String[] files = { "pdf", "xlsx", "csv", "docx", "jpg", "jpeg", "gif", "png", "JPG", "JPEG", "GIF",
			"PNG" };

	public static int totalEventCount = 10;

	public static RestTemplate rest = new RestTemplate();

	public static RestTemplate getRestTemplate() {
		rest = new RestTemplate();
		rest.getInterceptors().add(new BasicAuthorizationInterceptor("aaryatech", "Aaryatech@1234567"));
		return rest;

	}

}
