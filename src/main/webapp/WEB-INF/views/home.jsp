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
<link rel="icon" href="../../favicon.ico">
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
</head>
<body>
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>

	<div id="myCarousel" class="carousel slide  slider"
		data-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img class="first-slide"
					src="${pageContext.request.contextPath}/resources/images/slider2.jpg"
					alt="First slide">
				<div class="container">
					<div class="carousel-caption">
						<h1>${editbanner.sliderName}<br> <span>${editbanner.text1}</span>
						</h1>
						<p>${editbanner.text2}</p>
						<a href="${editbanner.urlLink}" class="btn button "><span>${editbanner.linkName}</span></a>
					</div>
				</div>


				<div>
					<div class="container"></div>
				</div>
			</div>

		</div>
		<a class="carousel-control-prev" href="#myCarousel" role="button"
			data-slide="prev"> <span class="carousel-control-prev-icon"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#myCarousel" role="button"
			data-slide="next"> <span class="carousel-control-next-icon"
			aria-hidden="true"></span> <span class="sr-only">Next</span>
		</a>
	</div>


	<%-- <div class="slider" id="slider">
		<div class="container">
			<h1>${editbanner.sliderName}<br> <span>${editbanner.text1}</span>
			</h1>
			<p>${editbanner.text2}</p>
			<a href="${editbanner.urlLink}" class="btn button "><span>${editbanner.linkName}</span></a>
		</div>
	</div> --%>
	<div class="card sub-link">
		<div class="container">
			<div class="row">

				<c:forEach items="${getCMSDesc}" var="getCMSDesc" varStatus="count">

					<div class="col-12 col-sm-3 col-lg-3">
						<div class="sub-link-icon">
							<img
								src="${pageContext.request.contextPath}/resources/images/icon.png"
								alt="">
						</div>
						<c:set var="string1" value="${getCMSDesc.pageDesc}" />
						<c:set var="string2" value="${fn:substring(string1, 0, 256)}" />
						<h2>${getCMSDesc.heading}</h2>
						<p>${string2}</p>
						<div class="more" style="clear: both">
							<a
								href="${pageContext.request.contextPath}/info/${getCMSDesc.pageSlug}">more...
							</a>
						</div>
					</div>

				</c:forEach>
			</div>
		</div>
	</div>

	<div class="container main-content" id="main-content">

		<div class="row">
			<div class="col-12 col-sm-4 col-lg-4 news-notifications">
				<h3>News and Notification</h3>
				<div class="border-box">
					<div class="tab-content">
						<div id="update" class="tab-pane active">
							<div class="tab-content-section">
								<c:forEach items="${sessionScope.event}" var="eventList"	varStatus="count">
								<h5>
									<a href="#"> ${eventList.heading}</a>
								</h5>		
					
							<c:set var="string4" value="${eventList.descriptions}"/>
							<c:set var="string3" value="${fn:substring(string4, 0,130)}" />
							<p>${string3}</p>
					</c:forEach>
							</div>
						</div>
					</div>
					<a href="#">Read More</a>
				</div>
			</div>



			<div class="col-12 col-sm-4 col-lg-4 gallery">
				<h3>Recent Gallery</h3>
				<c:if test="${photoList.size()>0}">
					<div class="border-box">
						<div id="carouselExampleControls" class="carousel slide"
							data-ride="carousel">
							<div class="carousel-inner">

								<c:forEach items="${photoList}" var="editPhotoDetail"
									varStatus="count">

									<c:choose>
										<c:when test="${count.last}">
											<div class="carousel-item active">
												<a
													href="${sessionScope.gallryImageURL}${editPhotoDetail.fileName}"
													data-toggle="lightbox" data-gallery="plan" data-title=""
													class="thumbnail">
													<div class="over-effect">
														<span class="icon-search"></span>
													</div> <img
													src="${sessionScope.gallryImageURL}${editPhotoDetail.fileName}"
													alt="${editPhotoDetail.title}" class="img-responsive">
												</a>
											</div>
										</c:when>
										<c:otherwise>
											<div class="carousel-item">
												<a
													href="${sessionScope.gallryImageURL}${editPhotoDetail.fileName}"
													data-toggle="lightbox" data-gallery="plan" data-title=""
													class="thumbnail">
													<div class="over-effect">
														<span class="icon-search"></span>
													</div> <img
													src="${sessionScope.gallryImageURL}${editPhotoDetail.fileName}"
													alt="${editPhotoDetail.title}" class="img-responsive">
												</a>
											</div>
										</c:otherwise>
									</c:choose>


								</c:forEach>

							</div>
							<a class="carousel-control-prev" href="#carouselExampleControls"
								role="button" data-slide="prev"> <span
								class="carousel-control-prev-icon" aria-hidden="true"></span> <span
								class="sr-only">Previous</span>
							</a> <a class="carousel-control-next" href="#carouselExampleControls"
								role="button" data-slide="next"> <span
								class="carousel-control-next-icon" aria-hidden="true"></span> <span
								class="sr-only">Next</span>
							</a>
						</div>

					</div>
				</c:if>
			</div>


			<div class="col-12 col-sm-4 col-lg-4 gallery">
				<h3>Video</h3>

				<div class="border-box">
					<div id="videoslide" class="carousel " data-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								${videoGalleryDetail[0].fileName}</div>




							<a class="carousel-control-prev" href="#videoslide" role="button"
								data-slide="prev"> <span class="carousel-control-prev-icon"
								aria-hidden="true"></span> <span class="sr-only">Previous</span>
							</a> <a class="carousel-control-next" href="#videoslide"
								role="button" data-slide="next"> <span
								class="carousel-control-next-icon" aria-hidden="true"></span> <span
								class="sr-only">Next</span>
							</a>
						</div>
					</div>
				</div>


			</div>





		</div>
	</div>
	<div class="news-section">
		<div class="container main-content">
			<div class="row">
				<h2>
					<span>Updates</span>
				</h2>
				<c:forEach items="${newsBlogsList}" var="newsBlogsList"
					varStatus="count">
					<div class="col-12 col-sm-3 col-lg-3">
						<div class="news-box">
							<div class="new-img">
								<a href="${newsBlogsList.newsSourceUrlName}"><img
									src="${sessionScope.gallryImageURL}${newsBlogsList.featuredImage}"
									width="250" height="228" alt="${newsBlogsList.heading}"></a>
							</div>
							<h4> ${newsBlogsList.heading}</h4>
							<c:set var="string4" value="${newsBlogsList.descriptions}" />
							<c:set var="string3" value="${fn:substring(string4, 0, 100)}" />
							<p>${string3}
								<a
									href="${pageContext.request.contextPath}/NewsDetails/${newsBlogsList.languageId}/${newsBlogsList.pageId}/${newsBlogsList.newsblogsId}">Read
									More</a>
							</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>


	<div class="container main-content">
		<div class="row bottom-section">
			<c:if test="${setting[2].isActive==1}">
				<div class="col-12 col-sm-3 col-lg-3">
					<div class="twitter border-box">${setting[2].keyValues}</div>
				</div>
			</c:if>
			<c:if test="${setting[3].isActive==1}">
				<div class="col-12 col-sm-3 col-lg-3">
					<div class="twitter border-box">${setting[3].keyValues}</div>
				</div>
			</c:if>
			<div class="col-12 col-sm-6 col-lg-6"></div>

		</div>


	</div>

	<div class="testimonials">
		<div class="container">
			<h5>Testimonials</h5>
			<div id="carouselExampleControls2" class="carousel slide"
				data-ride="carousel">
				<div class="carousel-inner">
					<c:forEach items="${sessionScope.testImonial}" var="testImonial"
						varStatus="count">
						<c:choose>
							<c:when test="${count.last}">

								<div class="carousel-item active">
									<c:set var="imgfind" value="0"></c:set>

									<c:if test="${not empty testImonial.imageName}">

										<img
											src="${sessionScope.gallryImageURL}${testImonial.imageName}"
											width="100" height="100" alt="${testImonial.fromName}"
											class="user">
										<p>
											<strong>${testImonial.fromName}</strong>
										</p>

										<c:set var="string4" value="${testImonial.message}" />
										<c:set var="string3" value="${fn:substring(string4, 0, 180)}" />
										<p>${string3}...</p>
										<c:set var="imgfind" value="1"></c:set>

									</c:if>
									<c:if test="${imgfind==0}">
										<img
											src="${pageContext.request.contextPath}/resources/images/user.png"
											class="user">
										<p>
											<strong>${testImonial.fromName}</strong>
										</p>

										<c:set var="string4" value="${testImonial.message}" />
										<c:set var="string3" value="${fn:substring(string4, 0, 180)}" />
										<p>${string3}...</p>
									</c:if>
								</div>
							</c:when>
							<c:otherwise>
								<div class="carousel-item ">
									<c:set var="imgfind" value="0"></c:set>

									<c:if test="${not empty testImonial.imageName}">

										<img
											src="${sessionScope.gallryImageURL}${testImonial.imageName}"
											width="100" height="100" alt="${testImonial.fromName}"
											class="user">
										<p>
											<strong>${testImonial.fromName}</strong>
										</p>

										<c:set var="string4" value="${testImonial.message}" />
										<c:set var="string3" value="${fn:substring(string4, 0, 180)}" />
										<p>${string3}...</p>
										<c:set var="imgfind" value="1"></c:set>

									</c:if>
									<c:if test="${imgfind==0}">
										<img
											src="${pageContext.request.contextPath}/resources/images/user.png"
											class="user">
										<p>
											<strong>${testImonial.fromName}</strong>
										</p>

										<c:set var="string4" value="${testImonial.message}" />
										<c:set var="string3" value="${fn:substring(string4, 0, 180)}" />
										<p>${string3}...</p>
									</c:if>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<a class="carousel-control-prev" href="#carouselExampleControls2"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#carouselExampleControls2"
					role="button" data-slide="next"> <span
					class="carousel-control-next-icon" aria-hidden="true"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>

