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
<style>
.other-gov-site-home {
	margin-top: 43px;
}
</style>
</head>
<body class="${contrast}">
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
			%><h1>बातमी तपशील</h1>
			<%
				} else {
			%><h1>News Detail</h1>
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
				href="${pageContext.request.contextPath}/listOFNews/1">बातम्या</a>
			<%
				} else {
			%><a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/listOFNews/1">News List</a>
			<%
				}
			%>


		</div>
	</div>

	<div class="container" id="main-content">
		<div class="row row-eq-height">
			<div class="col-12 col-sm-15 col-lg-18 right-Colm news-listing-page">
				<div class="row">
					<c:if test="${not empty image.featuredImage}">
						<div class="col-12 col-sm-6 col-lg-6">
							<img src="${sessionScope.gallryImageURL}${image.featuredImage}"
								alt="${image.heading}" title="${image.heading}"
								class="img-responsive thumbnail">
						</div>
					</c:if>
					<div class="col-12 col-sm-12 col-lg-12">

						<strong>${image.heading}</strong><br>
						<p>${image.descriptions}</p>

						<div>
							Source Link : <a href="${image.newsSourceUrlName}"
								target="_blank"> ${image.newsSourceUrlName}</a>
						</div>

					</div>
				</div>
			</div>


		</div>
	</div>


	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>