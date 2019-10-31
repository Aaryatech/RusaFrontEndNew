<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>


<%
	//allow access only if session exists
	String user = null;
	if (session.getAttribute("menuList") == null) {
		String mapping = (String) session.getAttribute("mapping");
		String contextPath = request.getContextPath();
		contextPath = contextPath + "/retriveSession/" + mapping;
		response.sendRedirect(contextPath);
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description"
	content="${sessionScope.homePageMetaData.metaDescription}">
<meta name="author"
	content="${sessionScope.homePageMetaData.metaAuthor}">
<title>${sessionScope.homePageMetaData.siteTitle}</title>
<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>
<style>
.other-gov-site-home {
	margin-top: 43px;
}
</style>
</head>
<body class="${contrast}">
	<c:url var="checkMaintainance" value="/checkMaintainance" />
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<%
				String contextPath = request.getContextPath();

				int langId = 1;
				try {
					langId = (Integer) session.getAttribute("langId");

				} catch (Exception e) {
					session.setAttribute("langId", langId);
					langId = 1;

				}

				if (langId == 2) {
			%><h1>उत्तरदायित्वास नकार आणि धोरणे</h1>
			<%
				} else {
			%><h1>Disclaimer and Privacy Policy</h1>
			<%
				}
			%>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<%
				if (langId == 2) {
			%><a href="${pageContext.request.contextPath}/">मुख्य पृष्ठ </a> > <a
				href="${pageContext.request.contextPath}/privacyPolicy">उत्तरदायित्वास
				नकार आणि धोरणे</a>
			<%
				} else {
			%><a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/privacyPolicy">Disclaimer
				and Privacy Policy</a>
			<%
				}
			%>

		</div>
	</div>
	<div class="container main-content" id="main-content">
		<div class="row row-eq-height">


			<div class="col-12 col-sm-12 col-lg-12 right-Colm">
				<%
					if (langId == 2) {
				%>

				<h2>
					<b>उत्तरदायित्वास नकार</b>
				</h2>

				<p style="text-align: justify;">या पोर्टलवर विविध विभागांच्या
					अखत्यारीतील संकेतस्थळांची माहिती आणि मजकूर काळजीपूर्वक आणि
					परिश्रमपूर्वक उपलब्ध करून देण्यात आला असला, तरी या माहितीचा केला
					जाणारा वापर अथवा वापरामुळे उद्भवणाऱ्या कोणत्याही परिस्थितीची
					जबाबदारी रुसा महाराष्ट्र स्वीकारीत नाही. कोणत्याही प्रकारची विसंगती
					/ संभ्रमासंदर्भात अधिक स्पष्टीकरणासाठी वापरकर्त्याने रुसा
					महाराष्ट्र संबंधित विभागाशी/अधिकाऱ्याशी संपर्क साधावा.</p>
				<br>

				<h2>
					<b>हायपरलिंकिंग बाबतचे धोरण</b>
				</h2>

				<p style="text-align: justify;">
					<b>बाह्य संकेतस्थळे/ पोर्टल्ससाठी जोडणी (लिंक)</b><br /> संकेत
					स्थळावर अनेक ठिकाणी आपणास अन्य संकेत स्थळे/ पोर्टल्स यांच्या
					जोडण्या दिसतील. यांची निर्मिती आणि देखभाल अशासकीय/ खाजगी
					संघटनेमार्फत केली जाते. या जोडण्या तुमच्या सुविधेसाठी उपलब्ध करून
					दिल्या आहेत. जेव्हा तुम्ही बाह्य जोडणीची निवड करता, तेव्हा तुम्ही
					रुसा महाराष्ट्रच्या संकेत स्थळावरून बाहेर पडता. तुमची गोपनीयता आणि
					सुरक्षा धोरण &lsquo;त्या&#39; बाह्य जोडणीच्या मालकाकडे /
					प्रायोजकाकडे जाते. या बाह्य संकेतस्थळाची माहिती आणि विश्र्वसनीयता
					यासाठी रुसा महाराष्ट्र जबाबदार राहणार नाही. त्यात तुम्ही व्यक्त
					केलेल्या दृष्टिकोनाचे आम्ही समर्थन करत नाही. या संकेतस्थळावर उपलब्ध
					जोडण्या आणि त्यांच्या यादीला आमचे समर्थन गृहीत धरू नका.<br /> <br />
					<b>इतर संकेत स्थळांव्दारे / पोर्टलव्दारे महाराष्ट्र शासनच्या
						संकेत स्थळाशी लिंक</b><br /> अन्य संकेत स्थळांव्दारे / पोर्टलव्दारे
					रुसा महाराष्ट्रच्या संकेत स्थळाची जोडणी &ndash; तुम्ही आमच्या संकेत
					स्थळावरील माहितीची जोडणी देऊ इच्छीत असाल, तर त्यासाठी पूर्व
					परवानगीची आवश्यकता नाही. मात्र तुमच्या संकेत स्थळाच्या चौकटीमध्ये
					आमचे पृष्ठ दाखवण्याची परवानगी आम्ही देत नाही. आमच्या संकेत
					स्थळावरील पृष्ठे, वापरकर्त्याच्या नवीन ब्राउजर विंडोमध्ये उघडायला
					हवी.

				</p>
				<br>

				<h2>
					<b>अटी आणि शर्ती</b>
				</h2>

				<p style="text-align: justify;">
					या संकेतस्थळाची रचना, विकसन आणि देखभाल रुसा&nbsp; महाराष्ट्रच्या
					माहिती तंत्रज्ञान संचालनालयामार्फत केली जाते. या संकेतस्थळावरील
					माहिती रुसा महाराष्ट्रने पुरविली आहे. संकेतस्थळाचा वापर करताना,
					वापराबाबतचे नियम आणि अटी तुम्ही बिनशर्त मान्य करता असे गृहीत धरले
					जाते. हे नियम आणि अटी तुम्हांला मान्य नसतील तर कृपया या
					संकेतस्थळाचा वापर करू नका.<br /> <br /> संकेतस्थळावरील मजकुराच्या
					सत्यतेबाबत सर्वतोपरी खबरदारी घेतली गेली असली, तरी हा मजकूर
					कोणत्याही कायदेशीर कारणासाठी पुरावा म्हणून वापरता येणार नाही.
					याबाबत कोणत्याही प्रकारची शंका असल्यास वापरकर्त्याने संबंधीत विभाग
					अथवा स्रोताशी शहानीशा करून घ्यावी आणि व्यावसायिक सल्ला घ्यावा.<br />
					<br /> या संकेतस्थळाचा वापर करीत असताना कोणत्याही प्रकारचा खर्च,
					तोटा, दुष्पपरिणाम अथवा हानी झाल्यास त्यासाठी रुसा महाराष्ट्र
					जबाबदार राहणार नाही.<br /> <br /> या संकेतस्थळावरील माहिती हायपर
					टेक्स्ट म्हणून घेतली जाऊ शकते. अथवा अशासकीय / खाजगी संघटनांमार्फत
					माहितीचा मुद्दा म्हणून वापरू शकते. वापरकर्त्यांची माहिती आणि सुविधा
					विचारात घेऊन &quot;माहिती तंत्रज्ञान संचालनालय&quot;, या जोडण्या
					उपलब्ध करून देत आहे.<br /> <br /> भारतीय कायद्यानुसार या अटी आणि
					नियमांचे नियंत्रण केले जाईल. या अटी आणि नियमासंदर्भातील कोणत्याही
					प्रकारचा वाद भारताच्या न्यायालयीन अधिकार क्षेत्रात राहील.

				</p>
				<br>

				<h2>
					<b>गोपनीयता धोरण</b>
				</h2>

				<p style="text-align: justify;">
					एक सर्वसाधारण नियम म्हणून हे संकेत स्थळ तुमची व्यक्तिगत ओळख स्पष्ट
					करणारी कोणत्याही प्रकारची माहिती (जसे नाव, दूरध्वनी क्र. अथवा
					ई-मेल) स्वयंचलितरित्या आपल्याकडे ठेवत नाही. हे पोर्टल तुमच्या
					भेटीच्या वेळा आणि सत्रप्रवेश अशा प्रकारच्या माहितीची, सांख्यिकीय
					हेतूसाठी (जसे इंटरनेट प्रोटोकॉल, डोमेन नेम, ब्राउजर प्रकार,
					ऑपरेटिंग सिस्टम, भेटीची तारीख आणि वेळ इ.) नोंद घेते.<br /> <br />
					आम्ही या माहितीचा उपयोग तुमच्या वैयक्तिक भेटीची ओळख म्हणून ठेवत
					नाही. या संकेत स्थळाच्या सुरक्षेला बाधा पोहोचवण्याचा प्रयत्न
					झाल्यास त्याचा मागोवा घेण्यासाठी आम्हांला या माहितीचा उपयोग होतो.
					आम्ही उपयोगकर्ता किवा त्यांच्या ब्राउजिंग गतीविधीवर लक्ष ठेवत नाही.<br />
					<br /> रुसा महाराष्ट्रच्या पोर्टलने तुमच्याकडून वैयक्तिक माहिती
					देण्याची मागणी केल्यास, ती कशाप्रकारे वापरली जाईल, हे तुम्हांला
					सांगितले जाईल, तसेच या माहितीची गोपनीयता राखण्यासाठी पुरेशी खबरदारी
					घेतली जाईल.

				</p>
				<br>

				<h2>
					<b>कॉपीराइट धोरणे</b>
				</h2>

				<p style="text-align: justify;">या संकेत स्थळावरील माहिती संकलित
					केली गेली आहे. ती नि:शुल्कपणे कुठल्याही स्वरुपात किवा माध्यमात,
					कुठलीही विशिष्ट परवानगी न घेता पुनर्मुद्रित करता यईल. माहिती जशी
					आहे, तशी तंतोतंत वापरण्यात यावी. तसेच अप्रतिष्ठाकारक पद्धतीने अथवा
					दिशाभूल करण्याच्या संदर्भात वापरता येणार नाही. जेव्हा या माहितीचे
					किवा सामग्रीचे प्रकाशन किवा वापर कराल त्या वेळेस स्रोत प्रामुख्याने
					अभिस्वीकृत केला गेला पाहिजे. ह्या संकेत स्थळावरील माहितीचे
					पुनर्मुद्रण करण्याची अनुमतीमध्ये या संकेत स्थळावरील माहितीचा
					विस्तार करू शकत नाही जे की त्रयस्थ पक्षाचे सर्वाधिकार धोरण म्हणून
					ओळखले जाते. या प्रकारच्या सामग्रीचे पुनर्मुद्रण करायच्या
					अधिकारासाठी सर्वाधिकार धोरण धारकाशी संपर्क साधावा.</p>

				<%
					} else {
				%>
				<h2>Disclaimer and Policies</h2>

				<p style="text-align: justify;">Although information and
					contents of various departmental websites of this portal have been
					put with care and diligence,&nbsp; RUSA Maharashtra does not take
					responsibility on how this information is used or the consequences
					of its use. In case of any inconsistency/confusion, the user should
					contact the concerned Officer of RUSA Maharashtra for further
					clarifications.</p>
				<br>

				<h2>Hyperlinking Policies</h2>

				<p style="text-align: justify;">
					<b>Links to External Websites/Portals</b><br /> At many places in
					this portal, you shall find links to other websites/portals created
					and maintained by other Government, non-Government / private
					organisations. These links have been placed for your convenience.
					When you select a link you are navigated to that website. Once on
					that website, you are subject to the privacy and security policies
					of the owners / sponsors of the website. RUSA Maharashtra is not
					responsible for the contents and reliability of the linked websites
					and does not necessarily endorse the views expressed in them. Mere
					presence of the link or its listing on this portal should not be
					assumed as endorsement of any kind.<br /> <br /> <b>Links to
						the RUSA Maharashtra Website by Other Websites/Portals</b><br /> We
					do not object you for linking directly to the information that is
					hosted on our site and no prior permission is required for the
					same.We do not permit our pages to be loaded into frames on your
					site. Our Department&#39;s pages must load into a newly opened
					browser window of the user.

				</p>
				<br>

				<h2>Terms And Conditions</h2>

				<p style="text-align: justify;">
					This website is designed, developed and maintained by RUSA
					Maharashtra. The content for the website is provided by RUSA
					Maharashtra and by accessing this website, you unconditionally
					accept to be legally bound by the terms and conditions. If you do
					not agree to the mentioned terms and conditions, please do not
					access the website.<br /> <br /> Efforts have been made to ensure
					the accuracy and currency of the content on this website; however,
					the same should not be interpreted as a statement of law or used
					for any legal purposes. In case of any ambiguity or doubts, users
					are advised to verify / check with the concerned Department(s) and
					/ or other source(s), and obtain appropriate professional advice.<br />
					<br /> Under no circumstances RUSA Maharashtra will be liable for
					any expense, loss or damage including, without limitation, indirect
					or consequential loss or damage or any expense, loss or damage
					whatsoever arising from use, or loss of use, of data, arising out
					of or in connection with the use of this website.<br /> <br />
					These terms and conditions shall be governed by and construed in
					accordance with the Indian Laws. Any dispute arising under these
					terms and conditions shall be subject to the jurisdiction of the
					courts of India.

				</p>
				<br>

				<h2>Privacy Policy</h2>

				<p style="text-align: justify;">As a general rule, this portal
					does not automatically capture any specific personal information
					from you, (like name, phone number or e-mail address), that allows
					us to identify you individually. This portal records your visit and
					logs the following information for statistical purposes, such as
					Internet Protocol (IP) addresses, domain name, browser type,
					operating system, the date and time of the visit and the pages
					visited. We make no attempt to link these addresses with the
					identity of individuals visiting our site unless an attempt to
					damage the site has been detected We will not identify users or
					their browsing activities, except when a law enforcement agency may
					exercise a warrant to inspect the service provider&#39;s logs. If
					RUSA Maharashtra portal requests you to provide personal
					information, you will be informed how it will be used if you choose
					to give it and adequate security measures will be taken to protect
					your personal information.</p>
				<br>

				<h2>Copyright Policy</h2>

				<p style="text-align: justify;">Material featured on this portal
					may be reproduced free of charge in any format or media without
					requiring specific permission. This is subject to the material
					being reproduced accurately and not being used in a derogatory
					manner or in a misleading context. Where the material is being
					published or issued to others, the source must be prominently
					acknowledged. However, the permission to reproduce this material
					does not extend to any material on this site which is identified as
					being the copyright of the third party. Authorization to reproduce
					such material is obtained from the copyright holders concerned.</p>
				<%
					}
				%>

			</div>

		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	<!-- JavaScript-->
	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>



	<script>
		function checkMaintainance() {

		}
	</script>

</body>
</html>