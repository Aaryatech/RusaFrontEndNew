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
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/calendar.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/ekko-lightbox.css"
	rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath}/resources/css/style.css"
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
<style>
.other-gov-site-home {
	margin-top: 43px;
}
</style>
</head>
<body>
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>

	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>News</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> >> <a
				href="${pageContext.request.contextPath}/listOFNews/1">News List</a> >
		</div>
	</div>
	<div class="container" id="main-content">
		<div class="row row-eq-height">

			<div class="col-12 col-sm-15 col-lg-18 right-Colm news-listing-page">
				<c:set var="find" value="0"></c:set>
				<c:forEach items="${newsBlogsList}" var="newsBlogsList"
					varStatus="count">

					<div class="row">
						<c:choose>
							<c:when test="${not empty newsBlogsList.featuredImage}">

								<div class="col-12 col-sm-3 col-lg-3">
									<img
										src="${sessionScope.gallryImageURL}${newsBlogsList.featuredImage}"
										alt="${newsBlogsList.heading}"
										title="${newsBlogsList.heading}"
										class="img-responsive thumbnail">
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-12 col-sm-3 col-lg-3">
									<img
										src="${pageContext.request.contextPath}/resources/images/noimage.png"
										alt="${newsBlogsList.heading}"
										title="${newsBlogsList.heading}"
										class="img-responsive thumbnail" width="263" height="199">
								</div>
							</c:otherwise>
						</c:choose>
						<div class="col-12 col-sm-9 col-lg-9">
							<strong> ${newsBlogsList.heading}</strong><br>
							<p>${fn:substring(newsBlogsList.descriptions, 0, 500)}</p>

							<a
								href="${pageContext.request.contextPath}/NewsDetails/${newsBlogsList.newsblogsId}"
								target="_blank">Read More</a>
						</div>
					</div>
					<c:set var="find" value="1"></c:set>
				</c:forEach>
			
				<c:if test="${find==0}">

					<h2 style="text-align: center;">No Record Found</h2>
				</c:if>
				<c:if test="${find==1}">
					<c:if test="${totalPage>1}">
					  <div class="pagination inner-page-pagination">
					 <c:forEach var="i" begin="1" end="${totalPage}">
					  <c:choose>
                        <c:when test="${pageid==i}">
                         <a href="${pageContext.request.contextPath}/listOFNews/${i}" class="activelink">${i}</a>
                        </c:when>
                        <c:otherwise>
                         <a href="${pageContext.request.contextPath}/listOFNews/${i}" class="inactive">${i}</a>
                        </c:otherwise>
                        </c:choose> 
                        </c:forEach>
					
					
					<%-- <div class="row">
						<c:forEach var="i" begin="1" end="${totalPage}">
							<div class="col-sm-1" style="max-width: 0.433333%;">
								<a href="${pageContext.request.contextPath}/listOFNews/${i}">${i}</a>
							</div>
						</c:forEach>--%>
					</div> 
					</c:if>
				</c:if>
				
				 
			</div>
		</div>


	</div>


	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>

