<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>
<%@ page session="true"%>

<%
	//allow access only if session exists
	//	HttpSession session = request.getSession();
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
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description"
	content="${sessionScope.homePageMetaData.metaDescription}">
<meta name="author"
	content="${sessionScope.homePageMetaData.metaAuthor}">
<title>${sessionScope.homePageMetaData.siteTitle}</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min2.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style2.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/jcarousel.responsive.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800|Playfair+Display:400,700,900"
	rel="stylesheet">
<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>

<script>
	var strMsg = "This link will take you to extneranl web site.";
	var strMsgPdf = "PDF file that opens in a new window.";
</script>
<script>
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id))
			return;
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=2318373708408139";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
</script>
</head>
<body class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>

	<!-- <script>
			function checkMaintainance() {

				$.getJSON('/rusafronend/checkMaintainance', {
					 ajax : 'true'
				});
			}
		</script> -->

	<div class="inner-slider" id="slider">
		<div class="container"></div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/screenReader"> Screen
				Reader Access </a>
		</div>
	</div>

	<div class="container main-content" id="main-content">
		<div class="row row-eq-height">



			<div class="col-12 ">

				<%
					int langId = (Integer) session.getAttribute("langId");
					if (langId == 2) {
				%><h2>स्क्रीन रीडर प्रवेश</h2>
				<p style="text-align: justify;">मानव संसाधन मंत्रालय विकास
					वेबसाइट भारतीय शासनासाठी दिशानिर्देशांचे पालन करते वेबसाइट्स आणि
					वर्ल्ड वाइड वेब कन्सोर्टियम (डब्ल्यू 3 सी) वेब सामग्री
					प्रवेशयोग्यता मार्गदर्शक तत्त्वे (डब्ल्यूसीएजी) 2.0 स्तर ए. हे
					सक्षम करेल व्हिज्युअल व्यंग असलेले लोक वेबसाइटवर प्रवेश करतात
					स्क्रीन वाचकांसारखे तंत्रज्ञान. च्या माहिती वेबसाइट जॅडस्सारख्या
					भिन्न स्क्रीन वाचकांद्वारे प्रवेशयोग्य आहे, जसे की, एनव्हीडीए,
					एसएएफए, सुपरनोवा आणि विंडो-आइज.</p>

				<p>
					खालील सारणी वेगळ्या स्क्रीनविषयी माहिती सूचीबद्ध करते. <br>वाचक:
				</p>

				<p>विविध स्क्रीन रीडरशी संबंधित नॉर्मेशन</p>

				<table class="table">
					<thead>
						<tr>
							<td><strong>स्क्रीन रीडर </strong></td>
							<td><strong>वेबसाइट</strong></td>
							<td><strong>विनामूल्य / व्यावसायिक </strong></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>नॉन व्हिज्युअल डेस्कटॉप प्रवेश (एनव्हीडीए)</td>
							<td><a href="http://www.nvda-project.org/" target="_blank">http://www.nvda-project.org/</a><br>
								(नवीन विंडोमध्ये उघडणारे बाह्य संकेतस्थळ)</td>
							<td>विनामूल्य</td>
						</tr>
						<tr>
							<td>जाण्यासाठी सिस्टम प्रवेश</td>
							<td><a href="http://www.satogo.com/" target="_blank">http://www.satogo.com/</a><br>
								(नवीन विंडोमध्ये उघडणारे बाह्य संकेतस्थळ)</td>
							<td>विनामूल्य</td>
						</tr>
						<tr>
							<td>वेब कुठेही</td>
							<td><a href="http://webanywhere.cs.washington.edu/wa.php"
								target="_blank">http://webanywhere.cs.washington.edu/wa.php</a><br>
								(नवीन विंडोमध्ये उघडणारे बाह्य संकेतस्थळ)</td>
							<td>विनामूल्य</td>
						</tr>
						<tr>
							<td>HAL</td>
							<td><a
								href="http://www.yourdolphin.co.uk/productdetail.asp?id=5"
								target="_blank">http://www.yourdolphin.co.uk/productdetail.asp?id=5</a><br>
								(नवीन विंडोमध्ये उघडणारे बाह्य संकेतस्थळ)</td>
							<td>व्यावसायिक</td>
						</tr>
						<tr>
							<td>JAWS</td>
							<td><a href="http://www.freedomscientific.com/jaws-hq.asp"
								target="_blank">http://www.freedomscientific.com/jaws-hq.asp</a><br>
								(नवीन विंडोमध्ये उघडणारे बाह्य संकेतस्थळ)</td>
							<td>व्यावसायिक</td>
						</tr>
						<tr>
							<td>सुपरनोवा</td>
							<td><a
								href="http://www.yourdolphin.co.uk/productdetail.asp?id=1"
								target="_blank">http://www.yourdolphin.co.uk/productdetail.asp?id=1</a><br>
								(नवीन विंडोमध्ये उघडणारे बाह्य संकेतस्थळ)</td>
							<td>व्यावसायिक</td>
						</tr>
						<tr>
							<td>Window-Eyes</td>
							<td><a href="http://www.gwmicro.com/Window-Eyes/"
								target="_blank">http://www.gwmicro.com/Window-Eyes/</a><br>
								(नवीन विंडोमध्ये उघडणारे बाह्य संकेतस्थळ)</td>
							<td>व्यावसायिक</td>
						</tr>
					</tbody>
				</table>
				<%
					} else {
				%>
				<h2>Screen Reader Access</h2>
				<p style="text-align: justify;">The Ministry of Human Resource
					Development website complies with Guidelines for Indian Government
					Websites and World Wide Web Consortium (W3C) Web Content
					Accessibility Guidelines (WCAG) 2.0 level A. This will enable
					people with visual impairments access the website using
					technologies, such as screen readers. The information of the
					website is accessible with different screen readers, such as JAWS,
					NVDA, SAFA, Supernova and Window-Eyes.</p>

				<p>Following table lists the information about different screen
					readers:</p>

				<p>Information related to the various screen readers</p>

				<table class="table">
					<thead>
						<tr>
							<td><strong>Screen Reader</strong></td>
							<td><strong>Website</strong></td>
							<td><strong>Free / Commercial</strong></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Non Visual Desktop Access (NVDA)</td>
							<td><a href="http://www.nvda-project.org/" target="_blank">http://www.nvda-project.org/</a><br>
								(External website that opens in a new window)</td>
							<td>Free</td>
						</tr>
						<tr>
							<td>System Access To Go</td>
							<td><a href="http://www.satogo.com/" target="_blank">http://www.satogo.com/</a><br>
								(External website that opens in a new window)</td>
							<td>Free</td>
						</tr>
						<tr>
							<td>Web Anywhere</td>
							<td><a href="http://webanywhere.cs.washington.edu/wa.php"
								target="_blank">http://webanywhere.cs.washington.edu/wa.php</a><br>
								(External website that opens in a new window)</td>
							<td>Free</td>
						</tr>
						<tr>
							<td>Hal</td>
							<td><a
								href="http://www.yourdolphin.co.uk/productdetail.asp?id=5"
								target="_blank">http://www.yourdolphin.co.uk/productdetail.asp?id=5</a><br>
								(External website that opens in a new window)</td>
							<td>Commercial</td>
						</tr>
						<tr>
							<td>JAWS</td>
							<td><a href="http://www.freedomscientific.com/jaws-hq.asp"
								target="_blank">http://www.freedomscientific.com/jaws-hq.asp</a><br>
								(External website that opens in a new window)</td>
							<td>Commercial</td>
						</tr>
						<tr>
							<td>Supernova</td>
							<td><a
								href="http://www.yourdolphin.co.uk/productdetail.asp?id=1"
								target="_blank">http://www.yourdolphin.co.uk/productdetail.asp?id=1</a><br>
								(External website that opens in a new window)</td>
							<td>Commercial</td>
						</tr>
						<tr>
							<td>Window-Eyes</td>
							<td><a href="http://www.gwmicro.com/Window-Eyes/"
								target="_blank">http://www.gwmicro.com/Window-Eyes/</a><br>
								(External website that opens in a new window)</td>
							<td>Commercial</td>
						</tr>
					</tbody>
				</table>
				<%
					}
				%>


			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>

