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
			%><h1>कार्यक्रम</h1>
			<%
				} else {
			%><h1>Events</h1>
			<%
				}
			%>

		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<%
				if (langId == 2) {
			%><a href="${pageContext.request.contextPath}/">मुख्य पृष्ठ </a> >
			कार्यक्रम यादी
			<%
				} else {
			%><a href="${pageContext.request.contextPath}/">Home</a> > Event List
			<%
				}
			%>

			>
		</div>
	</div>
	<div class="container" id="main-content">
		<div class="row row-eq-height">

			<div class="col-12 col-sm-12 col-lg-12 right-Colm news-listing-page">

				<c:set var="find" value="0"></c:set>
				<c:forEach items="${event}" var="eventList" varStatus="count">
					<div class="row">
						<div class="col-12 col-sm-9 col-lg-9">
							<strong> ${eventList.heading}</strong><br>
							<%-- <p> ${eventList.descriptions}</p> --%>
							<p>
								<span><i class="icon-location"></i> <strong>Venue:
								</strong> ${eventList.eventLocation}</span> <span><i
									class="icon-calendar"></i> <strong>Date: </strong>
									${eventList.eventDateFrom}</span> <span><i
									class="icon-smartphone-call"></i> <strong>Contact: </strong>+91
									${eventList.eventContactNumber}</span>
							</p>

							<%
								if (langId == 2) {
							%><a
								href="${pageContext.request.contextPath}/eventDetailfront/${eventList.exVar1}">सविस्तर
								वाचा</a>
							<%
								} else {
							%><a
								href="${pageContext.request.contextPath}/eventDetailfront/${eventList.exVar1}">Read
								More</a>
							<%
								}
							%>

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
										<a href="${pageContext.request.contextPath}/listOFEvent/${i}"
											class="activelink">${i}</a>
									</c:when>
									<c:otherwise>
										<a href="${pageContext.request.contextPath}/listOFEvent/${i}"
											class="inactive">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>

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

