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
			<h1>Testimonials</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> >
		</div>
	</div>
	<c:set var="videocount" value="0"></c:set>
	<div class="container" id="main-content">
		<div class="row row-eq-height">

			<div class="col-12 col-sm-12 col-lg-12">
				<h2>Testimonials</h2>
				<c:if test="${valueType==1}">
					<c:forEach items="${testImonial}" var="testImonial"
						varStatus="count">
						<div class="row">
							<div class="col-12 col-sm-12 col-lg-12">
								<div class="success-stories testimonials-detail">
									<div class="testimonials-user-photo">
										<c:choose>
											<c:when test="${not empty testImonial.imageName}">

												<img
													src="${sessionScope.gallryImageURL}${testImonial.imageName}"
													alt="${testImonial.fromName}"
													title="${testImonial.fromName}"
													class="img-responsive thumbnail"
													style="width: 100px; height: 100px;">
											</c:when>
											<c:otherwise>
												<img
													src="${pageContext.request.contextPath}/resources/images/team.jpg"
													alt="" class="img-responsive thumbnail">
											</c:otherwise>
										</c:choose>
									</div>
									<p>
										<span class="icon-quote-left quote"></span>${testImonial.message}</p>
									<p>
										<strong>${testImonial.fromName}</strong>
										<!--   <span class="sup-text">adsfgthukik</span> -->
									</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${valueType==2}">
					<c:forEach items="${testImonial}" var="testImonial"
						varStatus="count">
						<div class="row">
							<div class="col-12 col-sm-12 col-lg-12">
								<c:set var="videocount" value="${videocount+1}"></c:set>
								<div class="success-stories testimonials-detail">


									<%-- <iframe width="100%" height="300" src="${testImonial.message}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen=""></iframe>
                     --%>


									<p>
										<span class="icon-quote-left quote"></span>
									</p>
									<p id="video${videocount}">
										<span style="margin-left: 200px"></span>
										<iframe width="100%" height="315"
											src="https://www.youtube.com/embed/${testImonial.message}?rel=0&amp;controls=1&amp&amp;showinfo=0&amp;modestbranding=0"
											frameborder="0" allowfullscreen></iframe>
									</p>
									<p>
										<strong>${testImonial.fromName}</strong>
										<!--   <span class="sup-text">adsfgthukik</span> -->
									</p>
									<input id="videolink${videocount}"
										value="${testImonial.message}" type="hidden">

								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>

		</div>
	</div>
	<input id="videoct" value="${videocount}" type="hidden">
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>

	<script>
		var tag = document.createElement('script');
		tag.src = "//www.youtube.com/iframe_api";
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
		var videoct = document.getElementById("videoct").value;
		var vids = [];

		function onYouTubeIframeAPIReady() {

			for (var i = 0; i < videoct; i++) {

				var videolink = document.getElementById("videolink" + (i + 1)).value;
				var player = "video" + (i + 1);

				var video = new YT.Player(player, {
					videoId : videolink,
					playerVars : {
						rel : 0,
						showinfo : 0,
						ecver : 2
					},
					events : {
						'onStateChange' : onPlayerStateChange
					}
				});
				vids.push(video);

			}

		}

		function onPlayerStateChange(event) {

			if (event.data == YT.PlayerState.PLAYING) {
				stopVideo(event.target.a.id);

			}

		}

		function stopVideo(player_id) {

			for (var i = 0; i < vids.length; i++) {
				if (player_id != vids[i].a.id)
					vids[i].stopVideo();
			}
		}
	</script>

</body>
</html>

