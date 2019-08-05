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
			%><a href="${pageContext.request.contextPath}/">मुख्य पृष्ठ </a> >
			<%
				} else {
			%><a href="${pageContext.request.contextPath}/">Home</a> >
			<%
				}
			%>

		</div>
	</div>
	<div class="container" id="main-content">
		<div class="row row-eq-height">


			<div class="col-12 col-sm-12 col-lg-12 right-Colm">

				<div class="main-tab">
					<ul class="nav nav-tabs rusa-gallery-tab" role="tablist">

						<c:forEach items="${rusaList}" var="rusaList" varStatus="count">

							<c:choose>
								<c:when test="${rusaList.slugName eq slugname}">
									<li class="nav-item"><a class="nav-link active show"
										href="${pageContext.request.contextPath}/imgGallary?name=${rusaList.slugName}">${rusaList.catName}</a></li>
								</c:when>
								<c:otherwise>
									<li class="nav-item"><a class="nav-link"
										href="${pageContext.request.contextPath}/imgGallary?name=${rusaList.slugName}">${rusaList.catName}</a></li>

								</c:otherwise>
							</c:choose>

						</c:forEach>
						<!--  <li class="nav-item">
                                <a class="nav-link active show" data-toggle="tab" href="#eventone">Event Name</a>
                            </li>
                            
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#eventtwo">Event Name</a>
                            </li>
                            
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#recipes">Event Name</a>
                            </li>
                            
                             <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#recipes">Event Name</a>
                            </li>
                            
                             <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#recipes">Event Name</a>
                            </li>
                            
                             <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#recipes">Event Name</a>
                            </li>
                            
                             <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#recipes">Event Name</a>
                            </li> -->
					</ul>
				</div>
				<div class="tab-content">
					<div id="eventone" class="tab-pane active show">
						<!-- 
						<ul class="nav nav-tabs rusa-gallery-tab rusa-gallery-sub-tab"
							role="tablist">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#task-bar"><span
									class="icon-frame-landscape icon"></span> Photos</a></li>

							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#pre-made"><span class="icon-video-camera icon"></span>
									Videos</a></li>
						</ul> -->


						<div class="row">

							<%-- <c:forEach items="${imageList}" var="imageList" varStatus="count">
						
						<div class="col-12 col-sm-3 col-lg-3">
								<a
									href="${gallryImageURL}${imageList.fileName}"
									data-toggle="lightbox" data-gallery="plan"
									data-eventtitle="Event Name" data-title="Photo Title"
									data-footer="Image Description" class="thumbnail">
									<div class="over-effect">
										<span class="icon-search"></span>
									</div> <img
									src="${gallryImageURL}thumbnail${imageList.fileName}"
									alt="Rusa 2" title="Rusa 2" class="img-responsive">
								</a> <span class="thumbnail-heading">${imageList.title}</span>
							</div>
						
						</c:forEach> --%>

						</div>

						<div class="row">

							<c:forEach items="${imageList.imageListByCategory}"
								var="imageList" varStatus="count">

								<div class="col-12 col-sm-3 col-lg-3">

									<c:choose>
										<c:when
											test="${imageList.picCount==0 && imageList.videoCount>0}">

											<a
												href="${pageContext.request.contextPath}/imgGallaryDetail/${slugname}/${imageList.galleryCatId}/${imageList.cateName}"
												class="thumbnail thumbnail-listing"> <img
												src="${pageContext.request.contextPath}/resources/images/noimageteam.png"
												alt="Rusa 2" title="Rusa 2" class="img-responsive"
												width="261" height="190">
												<p class="thumbnail-heading">
													${imageList.cateName} <br> <span><i
														class="icon-frame-landscape icon"></i>
														(${imageList.picCount})</span> <span><i
														class="icon-video-camera icon"></i>
														(${imageList.videoCount})</span>
												</p>
											</a>

										</c:when>
										<c:otherwise>
											<a
												href="${pageContext.request.contextPath}/imgGallaryDetail/${slugname}/${imageList.galleryCatId}/${imageList.cateName}"
												class="thumbnail thumbnail-listing"> <img
												src="${gallryImageURL}thumbnail${imageList.fileName}"
												alt="Rusa 2" title="Rusa 2" class="img-responsive">
												<p class="thumbnail-heading">
													${imageList.cateName} <br> <span><i
														class="icon-frame-landscape icon"></i>
														(${imageList.picCount})</span> <span><i
														class="icon-video-camera icon"></i>
														(${imageList.videoCount})</span>
												</p>
											</a>

										</c:otherwise>
									</c:choose>

								</div>

							</c:forEach>

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

