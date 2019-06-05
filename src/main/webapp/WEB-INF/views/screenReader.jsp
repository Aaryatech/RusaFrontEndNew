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


				<h2>Screen Reader Access</h2>
				<h2>&nbsp;</h2>

				<p>The Ministry of Human Resource Development website complies
					with Guidelines for Indian Government Websites and World Wide Web
					Consortium (W3C) Web Content Accessibility Guidelines (WCAG) 2.0
					level A. This will enable people with visual impairments access the
					website using technologies, such as screen readers. The information
					of the website is accessible with different screen readers, such as
					JAWS, NVDA, SAFA, Supernova and Window-Eyes.</p>

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


				<!-- <div class="row"> 
				      <div class="col-12 col-sm-3 col-lg-3">
				        <a href="http://www.youtube.com/watch?v=k6mFF3VmVAs" data-toggle="lightbox" data-gallery="mixedgallery" class="col-sm-4">
				    <img src="http://i1.ytimg.com/vi/yP11r5n5RNg/mqdefault.jpg" class="img-fluid">
				</a>
				</div>
                </div> -->





			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>

