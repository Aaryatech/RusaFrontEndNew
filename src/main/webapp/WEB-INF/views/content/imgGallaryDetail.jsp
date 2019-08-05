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
			<h1>
				<%
					int langId = 1;
					try {
						langId = (Integer) session.getAttribute("langId");

					} catch (Exception e) {
						session.setAttribute("langId", langId);
						langId = 1;
					}

					if (langId == 2) {
				%>
				फोटो गॅलरी
				<%
					} else {
				%>
				Photo Gallery
				<%
					}
				%>
			</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<%
				if (langId == 2) {
			%><a href="${pageContext.request.contextPath}/">मुख्य पृष्ठ </a> > <a
				href="${pageContext.request.contextPath}/imgGallary?name=${slugname}">फोटो
				गॅलरी</a>
			<%
				} else {
			%><a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/imgGallary?name=${slugname}">Photo
				Gallery</a>
			<%
				}
			%>
		</div>
	</div>

	<c:set var="videocount" value="0"></c:set>

	<div class="container" id="main-content">
		<div class="row row-eq-height">


			<div class="col-12 col-sm-12 col-lg-12 right-Colm">

				<div class="main-tab">
					<ul class="nav nav-tabs rusa-gallery-tab" role="tablist">


						<li class="nav-item"><a class="nav-link" href="#">${cateName}</a></li>



					</ul>
				</div>
				<div class="tab-content">

					<ul class="nav nav-tabs rusa-gallery-tab rusa-gallery-sub-tab"
						role="tablist">



						<li class="nav-item"><a class="nav-link active show"
							data-toggle="tab" href="#photos"><span
								class="icon-frame-landscape icon"></span> Photos</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab"
							href="#videos"><span class="icon-video-camera icon"></span>
								Videos</a></li>

					</ul>
					<div id="photos" class="tab-pane active show">
						<div class="row">

							<c:forEach items="${imageList}" var="imageList" varStatus="count">
								<c:if test="${imageList.galleryCatId==catId}">
									<div class="col-12 col-sm-3 col-lg-3">
										<a href="${gallryImageURL}${imageList.fileName}"
											data-toggle="lightbox" data-gallery="plan"
											data-eventtitle="${cateName}" data-title="${imageList.title}"
											class="thumbnail">
											<div class="over-effect">
												<span class="icon-search"></span>
											</div> <img src="${gallryImageURL}thumbnail${imageList.fileName}"
											alt="Rusa 2" title="Rusa 2" class="img-responsive">
										</a> <span class="thumbnail-heading">${imageList.title}</span>
									</div>
								</c:if>
							</c:forEach>

						</div>
					</div>

					<div id="videos" class="tab-pane">
						<div class="row">

							<c:forEach items="${videoList}" var="videoList" varStatus="count">
								<c:if test="${videoList.galleryCatId==catId}">
									<div class="col-12 col-sm-3 col-lg-3" id="video${videocount+1}"
										style="width: 100%; height: 100%;">

										<iframe width="100%" height="100%"
											src="https://www.youtube.com/embed/${videoList.fileName}"
											frameborder="0"
											allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
											allowfullscreen> </iframe>

										<input id="videolink${videocount+1}"
											value="${videoList.fileName}" type="hidden">

										<c:set var="videocount" value="${videocount+1}"></c:set>
									</div>
								</c:if>
							</c:forEach>

						</div>
					</div>

				</div>

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

