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
			%><h1>वापरसुलभता</h1>
			<%
				} else {
			%><h1>Accessibility Statement</h1>
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
				href="${pageContext.request.contextPath}/accessibility">वापरसुलभता</a>
			<%
				} else {
			%><a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/accessibility">Accessibility
				Statement</a>
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
					<b>वापरसुलभता</b>
				</h2>

				<p style="text-align: justify;">
					कोणत्याही उपकरणांचा, तंत्रज्ञानाचा किवा क्षमतेचा वापर करून रुसा
					महाराष्ट्रचे संकेत स्थळ बघता येईल यासाठी आम्ही वचनबद्ध आहोत. संकेत
					स्थळला भेट देणाऱ्या व्यक्तीला जास्तीत जास्त उपयोगता व सुलभता व्हावी
					या उद्देशाने हे संकेत स्थळ तयार करण्यात आले आहे.<br> <br>परिणामी
					संकेत स्थळ विविध उपकरणात बघणे शक्य होईल, जसेकी वेब सक्रीय मोबाईल,
					वॅप फोन, पी. डि. ए. आणि संकेत स्थळावरील माहिती सहज उपलब्द्ध
					होण्याच्या दृष्टीने आम्ही सर्वोतोपरी प्रयत्न केले आहे, अंध
					व्यक्तींना संकेत स्थळावरील माहिती स्क्रीन रीडर व भिंगाचा वापर करून
					बघता येईल उदारणार्थ एक उपयोगकर्ता डोळ्यांनी आंधळा आहे ते सुद्धा
					सहायक तंत्रज्ञान वापरून संकेत स्थळाचा वापर करू शकतो, जसेकी
					पडद्यावरील वाचक आणि भिंगाचा वापर (मैग्निफायर्स). संकेत स्थळ तयार
					करताना आम्ही जागतीक स्तरावर वापरण्यात येणाऱ्या माणकांचा वापर
					करण्याचा प्रयत्न केला आहे जेणे करून संकेत स्थळाला भेट देणाऱ्या
					व्यक्तींला मदत होईल हा उद्देश आहे.<br> <br>या संकेत
					स्थळाच्या वापर विषयी तुम्हाला काही समस्या किवा सुचवायचे असेल तर,
					आम्हाला कळवा आणि आम्हाला एक उपयोगी प्रतिक्रिया करण्यसाठी सक्षम
					बनवा.
				</p>
				<br>

				<p>
					<b>सुगमता वैशिष्ट्येः</b>
				</p>

				<ul>
					<li style="text-align: justify;"><b>मुख्य विषयाकडे
							जाण्यासाठीः </b>&nbsp;कळफलकाचा वापर करून परत परत पानांमध्ये न जाता
						पानाच्या मुख्य गाभ्यामध्ये जलद प्रवेश होण्याची तरतूद.</li>
					<li style="text-align: justify;"><b>मुख्य पानावर
							जाण्यासाठीः </b> &nbsp;मुख्य पानाच्या पटलावर जलद प्रवेश होण्याची
						तरतूद ज्याद्वारे विविध उपविभाग जसे की नागरिक, शासन आणि निर्देशिका
						यामध्ये प्रवेश करणे शक्य होते.</li>
					<li style="text-align: justify;"><b>सुगमता पर्यायः</b>
						-&nbsp;मजकुराचा आकार बदलण्याची आणि रंग योजना स्थापन करण्याच्या
						पर्यायाची तरतूद केलेली आहे. उदाहरणार्थ या संकेत स्थळावर प्रवेश
						करण्यासाठी जर तुम्ही डेस्कटॉपचा वापर करीत असाल तर पडद्यावरील मजकूर
						काहीसा लहान दिसेल ज्यामुळे तो वाचणे कठीण होईल. अशा प्रसंगी स्पष्ट
						दिसण्यासाठी आणि सुलभ वाचनीयतेसाठी मजकुराच्या आकारात वाढ करणा-या
						पर्यायाचा तुम्ही वापर करू शकता.</li>
					<li style="text-align: justify;"><b>वर्णनात्मक जोडण्यांचा
							मजकूरः</b> &nbsp;मजकुराच्या जोडणीनुसार &quot;अधिक वाचा&quot; आणि
						&quot;येथे क्लिक करा&quot; या शब्दाचा वापर न करता वर्णनात्मक
						वाक्प्रयोगाचा वापर करून संक्षिप्त वर्णनाच्या जोडणीची तरतूद करण्यात
						आलेली आहे. उदाहरणार्थ जर जोडणीने पीडीएफ फाईल उघडली, तर या फाईलचा
						आकार असलेले वर्णन विनिर्दिष्ट होईल. पुढे जोडणीने जर नवीन संकेत
						स्थळाचे तावदान उघडले तर तसेच वर्णन विनिर्दिष्ट होईल.</li>
					<li style="text-align: justify;"><b>तक्त्याचे शीर्षलेख </b>:&nbsp;तक्त्याची
						शीर्षे चिन्हित आणि एकत्रिकरणासह त्या त्या कोष्ठाच्या प्रत्येक
						रांगेमध्ये करता येतात. उदा. जर तक्त्यामध्ये 30 रांगा आणि 5 स्तंभ
						असतील तर दृष्टीहीन वापरकर्त्यास कोणत्या माहितीचा कोष्ठ कोणत्या
						शीर्षाशी संबंधित आहे हे ओळखणे कठीण होईल. अशा स्थितीत
						वापरकर्त्यासाठी सहाय्यकारी उपकरण जसे स्क्रीन रीडर जो कोणत्याही
						कोष्ठाचा स्तंभ शीर्षलेख वाचू शकतो.</li>
					<li style="text-align: justify;"><b>शीर्षके </b>:&nbsp;वेब
						पृष्ठाच्या आशयाचा मजकुराचे संघटन, वाचनीय संरचनेची तरतूद असलेली
						समर्पक शीर्षके आणि उपशीर्षके वापरून केले जाते. एच -1 मुख्य शीर्ष
						दर्शवितो त्या अर्थी एच &ndash; 2 हे उपशीर्ष दर्शविते. या शिवाय
						स्क्रीन रीडरच्या वापरकर्त्यांसाठी या संकेत स्थळामध्ये दडलेली
						शीर्षे आहेत. जी उत्कृष्ट वाचनीयतेसाठी स्क्रीन रीडरद्वारे वाचली जाऊ
						शकतात.</li>
					<li style="text-align: justify;"><b>नावे </b>:&nbsp;प्रत्येक
						वेब पृष्ठासाठी समर्पक नाव विनिर्दिष्ट करावे ज्यामुळे पृष्ठाचा आतील
						मजकूर ओळखणे तुम्हाला सोपे जाईल.</li>
					<li style="text-align: justify;"><b>एक सोडून एक मजकूर</b>
						:&nbsp;दृष्टीने विकलांग (अंधांसाठी) असलेल्या वापरकर्त्यांसाठी
						&zwj;संक्षिप्त वर्णन असलेल्या प्रतिमेची तरतूद केलेली आहे. जर
						तुम्ही मजकूर आधारित ब्राऊझर वापरत असाल किंवा प्रतिमेचे प्रदर्शन
						बंद केले असले तरीही प्रतिमेचे संपूर्ण स्वरुप काय असू शकेल याचे
						प्रतिमा नसतानाही मजकूर एक सोडून एक वाचल्यास तुम्हाला समजू शकेल.</li>
					<li style="text-align: justify;"><b>खूण चिठ्ठी (लेबल)
							संघाचा स्पष्ट नमुना </b>:&nbsp;खूण चिठ्ठी ही संबंधित नियंत्रकाशी
						जोडलेली असते. जसे की मजकूर पेटी, तपासणी पेटी, रेडीओ बटन आणि
						अधोकर्षक सूची (ड्रॉप डाऊन) याद्वारे सहाय्यकारी उपकराणांना
						नमुन्यावरील नियंत्रणासाठी असलेल्या खुण चिठ्ठया ओळखणे शक्य होते.</li>
					<li style="text-align: justify;"><b> पानाच्या सातत्याची
							यंत्रणा </b>:&nbsp;सादरीकरणाच्या सातत्याची पध्दत संकेत स्थळावर
						सर्वत्र समाविष्ट आहे.</li>
					<li style="text-align: justify;">विस्तारक्षम आणि निपाती
						यादी&nbsp;-</li>
				</ul>
				<br>

				<h2>
					<b>सुगमतेचे पर्याय</b>
				</h2>

				<p style="text-align: justify;">
					पटलावरील मजकूर वाचणे आपल्याला कठीण वाटते का ?<br /> पटलावर दिसणारी
					माहिती स्पष्टपणे दिसू शकत नाही का ?<br /> <br /> उत्तर
					&quot;हो&quot; असल्यास पटल प्रदर्शन नियंत्रणासाठी या संकेत स्थळावर
					पुरवण्यात आलेल्या सुगमता पर्यायाचा वापर करा. अधिक चांगली दृष्यमानता
					आणि वाचनीयता प्राप्त करण्यासाठी मजकुराचा आकार आणि रंगसंगती
					बदलण्याची सुविधा या पर्यायांद्वारे उपलब्ध आहे.

				</p>
				<br>

				<h2>
					<b>मजकुराचा आकार बदलणे</b>
				</h2>

				<p style="text-align: justify;">
					मजकुराचा आकार प्रमाणित आकारापेक्षा कमी अथवा जास्त करणे, हे
					मजकुराच्या आकार बदलाशी संबंधित आहे. वाचनीयतेवर प्रभाव पाडणारे 3
					पर्याय तुम्हाला सुचवण्यात आले असून मजकुराचा आकार वाढवण्याची सुविधा
					हे पर्याय उपलब्ध करुन देतात. पर्याय पुढीलप्रमाणे -<br /> <br /> <b>विशाल</b>:&nbsp;विशाल
					आकारामध्ये माहिती प्रदर्शित करतो.<br /> <b>मोठा</b>:&nbsp;प्रमाणित
					आकारापेक्षा मोठया आकारात माहिती प्रदर्शित करतो.<br /> <b>मध्यम</b>:&nbsp;माहिती
					प्रमाणित आकारात अर्थात मूळ आकारात प्रदर्शित करतो.<br /> <br /> *
					मजकुराचा आकार बदलण्यासाठी कोणत्याही पानाच्या वरच्या भागात
					&quot;मजकूर आकार&quot; या बटणावर क्लिक करा.

				</p>


				<%
					} else {
				%>
				<h2>Accessibility Statement</h2>

				<p style="text-align: justify;">
					We are committed to ensure that the RUSA Maharashtra portal is
					accessible to all the users irrespective of device in use,
					technology or ability. It has been built, with an aim, to provide
					maximum accessibility and usability to its users. As a result, this
					portal can be viewed from a variety of devices, such as web-enabled
					mobile devices, WAP phones, PDAs and so on. <br> <br>We
					have put in our best efforts to ensure that all the information on
					this portal is accessible to people with disabilities. For example,
					a user with visual disability can access this portal using
					assistive technologies, such as screen readers and magnifiers. <br>
					<br>We also aim to be standards compliant and follow
					principles of usability and universal design, which should help all
					visitors of this portal. If you have any problem or suggestion
					regarding the accessibility of this portal, please contact us.
				</p>
				<br>
				<p>
					<b>Accessibility Features:</b>
				</p>

				<ul>
					<li style="text-align: justify;"><b>Skip to Main Content</b>:
						Quick access to the core content on the page is provided without
						going through repetitive navigation using the keyboard.</li>
					<li style="text-align: justify;"><b>Skip to Navigation</b>:
						Quick access to the navigation pane is provided that enables
						accessing the different sections, such as Citizens, Government,
						and Directories.</li>
					<li style="text-align: justify;"><b>Accessibility Options</b>:
						Options to change the size of the text and set a colour scheme are
						provided. For example, if you are using desktop to access this
						portal, the text might appear smaller on the screen that makes it
						difficult to read. In such a situation, you can use this option to
						increase the size of the text for clear visibility and better
						readability.</li>
					<li style="text-align: justify;"><b>Descriptive Link Text</b>:
						Brief description of a link is provided using descriptive phrases
						instead of just using words such as 'Read more' and 'Click here'
						as linked text. For example, if a link opens a PDF file, the
						description specifies its file size. Further, if a link opens a
						Web site in a new window, the description specifies the same.</li>
					<li style="text-align: justify;"><b>Table Headers</b>: The
						table headings are marked and associated with their corresponding
						cells in each row. For example, if there are 30 rows and 5 columns
						in a table, it is difficult for a user with visual disability to
						identify which data cell belongs to which header. In this
						situation, an assistive device such as a screen reader can read
						the column header of any cell for the user. In addition, captions
						are also specified for each table that act as labels and indicate
						what data is provided in the table.</li>
					<li style="text-align: justify;"><b>Headings</b>: The Web page
						content is organized using appropriate headings and subheadings
						that provide a readable structure. H1 indicates the main heading,
						whereas H2 indicates a subheading. In addition, for the screen
						reader users, there are hidden headings in this portal that are
						read out by a screen reader for better readability.</li>
					<li style="text-align: justify;"><b>Titles</b>: An appropriate
						name for each Web page is specified that helps you to understand
						the page content easily.</li>
					<li style="text-align: justify;"><b>Alternate Text</b>: Brief
						description of an image is provided for users with visual
						disability. If you are using a browser that supports only text or
						have turned off the image display, you can still know what the
						image is all about by reading the alternate text in absence of an
						image.</li>
					<li style="text-align: justify;"><b>Explicit Form Label
							Association</b>: A label is linked to its respective control, such as
						text box, check box, radio button, and drop-down list. This
						enables the assistive devices to identify the labels for the
						controls on a form.</li>
					<li style="text-align: justify;"><b>Consistent Navigation
							Mechanism</b>: Consistent style of presentation throughout the portal
						is incorporated.</li>
					<li style="text-align: justify;"><b>Customized Text Size</b>:
						The size of the text on the Web page can be changed either through
						the browser or through the accessibility options feature.</li>
					<li style="text-align: justify;"><b>JavaScript Independent</b>:
						Web page information and functionalities are independent of
						JavaScript, irrespective of the browser support for the scripting
						language.</li>
				</ul>
				<br>

				<h2>Accessibility Options</h2>

				<p style="text-align: justify;">
					Do you find it difficult to read the contents on the screen?<br />
					Is the displayed information not clearly visible to you?<br /> <br />
					If yes, use the accessibility options provided by this portal to
					control the screen display. These options allow changing the text
					size and colour scheme for clear visibility and better readability.
				</p>
				<br>

				<h2>Changing the Text Size</h2>

				<p style="text-align: justify;">
					Changing the size of the text refers to making the text appearing
					smaller or bigger from its standard size. There are three options
					provided to you to set the size of the text that affects the
					readability. These are: <br /> <br /> <b>Largest</b>: Displays
					information in the largest font size.<br /> <b> Larger</b>:
					Displays information in a font size larger than the standard font
					size. <br /> <b>Medium</b>: Displays information in a standard
					font size, which is the default size.<br /> <br /> * To change
					the text size, click the text-size icons present at the top of any
					page.

				</p>

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