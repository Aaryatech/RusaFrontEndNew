<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>
<%@ page session="true"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"
	import="java.text.SimpleDateFormat"%>
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
<script type="text/javascript">
	var st_url = "${sessionScope.siteFrontEndUrl}";
	var dm_url = "${sessionScope.siteDomainUrl}";

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
		js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=809225772483402";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
</script>
<style>
.news-section h4 {
	height: 47px;
}
</style>

</head>
<body class="${contrast}">
	<!-- <div id="fb-root"></div>
	<script async defer crossorigin="anonymous"
		src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v3.3&appId=2318373708408139&autoLogAppEvents=1"></script> -->
	<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v3.3"></script>
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>

	<div id="myCarousel " class="carousel slide slider"
		data-ride="carousel">
		<div class="carousel-inner" id="slider">
			<div class="carousel-item active">
				<img class="first-slide"
					src="${sessionScope.url}${editbanner.sliderImage}"
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

	<c:set var="videocount" value="0"></c:set>
	<div class="card sub-link">
		<div class="container" id="main-content">
			<div class="row">

				<c:forEach items="${getCMSDesc}" var="getCMSDesc" varStatus="count">

					<div class="col-12 col-sm-6 col-lg-3" style="text-align: justify;">
						<%-- <div class="sub-link-icon">
							<img
								src="${pageContext.request.contextPath}/resources/images/icon.png"
								alt="">
						</div> --%>
						<c:set var="string1" value="${getCMSDesc.pageDesc}" />
						<c:set var="string2" value="${fn:substring(string1, 0, 250)}" />
						<h2>${getCMSDesc.heading}</h2>
						<p>${string2}</p>
						<div class="more" style="clear: both">
							<a
								href="${pageContext.request.contextPath}/info/${getCMSDesc.pageSlug}">Read
								More </a>
						</div>
					</div>

				</c:forEach>
			</div>
		</div>
	</div>

	<div class="container main-content">

		<div class="row">
			<div class="col-12 col-sm-12 col-lg-4 news-notifications">
				<h3>News and Notification</h3>
				<div class="border-box">
					<div class="tab-content">

						<c:set var="cnt" value="0"></c:set>
						<div id="update" class="tab-pane active">

							<c:forEach items="${sessionScope.event}" var="eventList"
								varStatus="count">

								<div class="tab-content-section">

									<c:set var="string3"
										value="${fn:substring(eventList.heading, 0,70)}" />
									<h5>
										<a
											href="${pageContext.request.contextPath}/eventDetailfront/${eventList.exVar1}">
											${string3} </a>
									</h5>

									<p>
										<span><i class="icon-calendar"></i> <strong>Date:</strong>
											${eventList.eventDateFrom}</span>
									</p>
									<c:set var="cnt" value="${cnt+1}"></c:set>
								</div>
							</c:forEach>


							<c:forEach items="${sessionScope.expireEventList}"
								var="expireEventList" varStatus="count">
								<c:if test="${cnt<10}">
									<div class="tab-content-section">

										<c:set var="string3"
											value="${fn:substring(expireEventList.heading, 0,70)}" />
										<h5>
											<a
												href="${pageContext.request.contextPath}/eventDetailfront/${expireEventList.exVar1}">
												${string3} </a>
										</h5>

										<p>
											<span><i class="icon-calendar"></i> <strong>Date:</strong>
												${expireEventList.eventDateFrom}</span>
										</p>
										<c:set var="cnt" value="${cnt+1}"></c:set>
									</div>
								</c:if>
							</c:forEach>



						</div>
					</div>

					<a href="${pageContext.request.contextPath}/listOFEvent/1">Read
						More</a>

				</div>
			</div>



			<div class="col-12 col-sm-12 col-lg-4 gallery">
				<h3>
					<a href="${pageContext.request.contextPath}/imgGallary">Photos
						Gallery</a>
				</h3>
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


			<div class="col-12 col-sm-12 col-lg-4 gallery">
				<h3>Videos Gallery</h3>

				<div class="border-box">
					<div id="videoslide" class="carousel " data-ride="carousel">
						<div class="carousel-inner">

							<%-- <c:forEach items="${videoGalleryDetail}" var="videoGalleryDetail"
								varStatus="count">

								<c:choose>
									<c:when test="${count.last}">
										<div class="carousel-item active" id="video${count.index+1}">
											${videoGalleryDetail.fileName}</div>
									</c:when>
									<c:otherwise>
										<div class="carousel-item" id="video${count.index+1}">
											${videoGalleryDetail.fileName}</div>
									</c:otherwise>
								</c:choose>
								<c:set var="videocount" value="${videocount+1}"></c:set>
							</c:forEach> --%>

							<c:forEach items="${videoGalleryDetail}" var="videoGalleryDetail"
								varStatus="count">

								<c:choose>
									<c:when test="${count.last}">
										<div class="carousel-item active" id="video${count.index+1}">
											<iframe width="100%" height="100%"
												src="https://www.youtube.com/embed/${videoGalleryDetail.fileName}?rel=0&amp;controls=1&amp&amp;showinfo=0&amp;modestbranding=0"
												frameborder="0" allowfullscreen></iframe>
										</div>
									</c:when>
									<c:otherwise>
										<div class="carousel-item" id="video${count.index+1}">
											<iframe width="100%" height="100%"
												src="https://www.youtube.com/embed/${videoGalleryDetail.fileName}?rel=0&amp;controls=1&amp&amp;showinfo=0&amp;modestbranding=0"
												frameborder="0" allowfullscreen></iframe>
										</div>
									</c:otherwise>
								</c:choose>

								<input id="videolink${count.index+1}"
									value="${videoGalleryDetail.fileName}" type="hidden">

								<c:set var="videocount" value="${videocount+1}"></c:set>
							</c:forEach>


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
					<div class="col-12 col-sm-6 col-lg-3">
						<div class="news-box" style="text-align: justify;">
							<div class="new-img">

								<c:choose>
									<c:when test="${not empty newsBlogsList.featuredImage}">
										<a href="${newsBlogsList.newsSourceUrlName}"><img
											src="${sessionScope.gallryImageURL}${newsBlogsList.featuredImage}"
											alt="${newsBlogsList.heading}"></a>
									</c:when>
									<c:otherwise>
										<a href="#"><img
											src="${pageContext.request.contextPath}/resources/images/noimage.png"
											alt="${newsBlogsList.heading}"></a>
									</c:otherwise>
								</c:choose>
								<!-- width="250" height="228" -->

							</div>
							<h4>${fn:substring(newsBlogsList.heading, 0, 80)}</h4>
							<p>${fn:substring(newsBlogsList.descriptions, 0, 80)}</p>
							<a
								href="${pageContext.request.contextPath}/NewsDetails/${newsBlogsList.exVar1}">Read
								More</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>


	<div class="container main-content">
		<div class="row bottom-section">
			<c:if test="${setting[2].isActive==1}">
				<div class="col-12 col-sm-6 col-lg-4">
					<div class="twitter border-box bootom-box">${setting[2].keyValues}</div>
				</div>
			</c:if>
			<c:if test="${setting[3].isActive==1}">
				<div class="col-12 col-sm-6 col-lg-4">
					<div class="twitter border-box bootom-box">
						${setting[3].keyValues}</div>
				</div>
			</c:if>
			<div class="col-12 col-sm-12 col-lg-4">
				<div class="border-box bootom-box">
					<div class="btn-group">
						<!--  <button class="btn btn-primary button btn-calendar prev" data-calendar-nav="prev">< Prev </button> -->
						<button class="btn btn-default button btn-calendar today"
							data-calendar-nav="today">Today</button>
						<!--   <button class="btn btn-primary button btn-calendar next" data-calendar-nav="next">Next ></button> -->
					</div>
					<h3></h3>
					<div id="calendar"></div>
					<a href="${pageContext.request.contextPath}/listOFEvent/1">See
						All Events</a>
				</div>
			</div>

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

							<c:when test="${testImonial.exInt1==1}">
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

												<p>${testImonial.message}</p>
												<c:set var="imgfind" value="1"></c:set>

											</c:if>
											<c:if test="${imgfind==0}">
												<img
													src="${pageContext.request.contextPath}/resources/images/user.png"
													class="user">
												<p>
													<strong>${testImonial.fromName}</strong>
												</p>


												<p>${testImonial.message}</p>
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

												<p>${testImonial.message}</p>
												<c:set var="imgfind" value="1"></c:set>

											</c:if>
											<c:if test="${imgfind==0}">
												<img
													src="${pageContext.request.contextPath}/resources/images/user.png"
													class="user">
												<p>
													<strong>${testImonial.fromName}</strong>
												</p>

												<p>${testImonial.message}</p>
											</c:if>
										</div>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${testImonial.exInt1==2}">

								<c:set var="videocount" value="${videocount+1}"></c:set>

								<c:choose>
									<c:when test="${count.last}">

										<div class="carousel-item active" id="video${videocount}">
											<iframe width="100%" height="315"
												src="https://www.youtube.com/embed/${testImonial.message}?rel=0&amp;controls=1&amp&amp;showinfo=0&amp;modestbranding=0"
												frameborder="0" allowfullscreen></iframe>
										</div>
									</c:when>
									<c:otherwise>
										<div class="carousel-item ">
											<div class="row">
												<div class="col-12 col-sm-12 col-lg-3"></div>
												<div class="col-12 col-sm-12 col-lg-6"
													id="video${videocount}">
													<iframe width="100%" height="315"
														src="https://www.youtube.com/embed/${testImonial.message}?rel=0&amp;controls=1&amp&amp;showinfo=0&amp;modestbranding=0"
														frameborder="0" allowfullscreen></iframe>
												</div>
												<div class="col-12 col-sm-12 col-lg-3"></div>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
								<input id="videolink${videocount}"
									value="${testImonial.message}" type="hidden">

							</c:when>
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
	<input id="videoct" value="${videocount}" type="hidden">
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/underscore-min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/calendar.js"></script>
	<%--    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/app.js"></script> --%>
	<%-- <script
		src="${pageContext.request.contextPath}/resources/js/ekko-lightbox.js"></script> --%>

	<script type="text/javascript">
		(function($) {
	<%Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			out.print("var date_var = '" + sf.format(date) + "' ");%>
		"use strict";
			//	 alert(date_var);

			var options = {
				events_source : st_url + 'eventJson',
				view : 'month',
				tmpl_path : st_url + 'resources/tmpls/',
				tmpl_cache : false,
				day : date_var,
				onAfterEventsLoad : function(events) {
					if (!events) {
						return;
					}
					var list = $('#eventlist');
					list.html('');

					$.each(events, function(key, val) {
						$(document.createElement('li')).html(
								'<a href="' + val.url + '">' + val.title
										+ '</a>').appendTo(list);
					});
				},
				onAfterViewLoad : function(view) {
					$('.page-header h3').text(this.getTitle());
					$('.btn-group button').removeClass('active');
					$('button[data-calendar-view="' + view + '"]').addClass(
							'active');
				},
				classes : {
					months : {
						general : 'label'
					}
				}
			};

			var calendar = $('#calendar').calendar(options);

			$('.btn-group button[data-calendar-nav]').each(function() {
				var $this = $(this);
				$this.click(function() {
					calendar.navigate($this.data('calendar-nav'));
				});
			});

			$('.btn-group button[data-calendar-view]').each(function() {
				var $this = $(this);
				$this.click(function() {
					calendar.view($this.data('calendar-view'));
				});
			});

			$('#first_day').change(function() {
				var value = $(this).val();
				value = value.length ? parseInt(value) : null;
				calendar.setOptions({
					first_day : value
				});
				calendar.view();
			});

			$('#language').change(function() {
				calendar.setLanguage($(this).val());
				calendar.view();
			});

			$('#events-in-modal').change(function() {
				var val = $(this).is(':checked') ? $(this).val() : null;
				calendar.setOptions({
					modal : val
				});
			});
			$('#format-12-hours').change(function() {
				var val = $(this).is(':checked') ? true : false;
				calendar.setOptions({
					format12 : val
				});
				calendar.view();
			});
			$('#show_wbn').change(function() {
				var val = $(this).is(':checked') ? true : false;
				calendar.setOptions({
					display_week_numbers : val
				});
				calendar.view();
			});
			$('#show_wb').change(function() {
				var val = $(this).is(':checked') ? true : false;
				calendar.setOptions({
					weekbox : val
				});
				calendar.view();
			});
			$('#events-modal .modal-header, #events-modal .modal-footer')
					.click(function(e) {
						//e.preventDefault();
						//e.stopPropagation();
					});
		}(jQuery));
		$(document)
				.ready(
						function($) {

							// delegate calls to data-toggle="lightbox"
							$(document)
									.delegate(
											'*[data-toggle="lightbox"]',
											'click',
											function(event) {
												event.preventDefault();
												return $(this)
														.ekkoLightbox(
																{
																	onShown : function() {
																		if (window.console) {
																			return console
																					.log('Checking our the events huh?');
																		}
																	},
																	onNavigate : function(
																			direction,
																			itemIndex) {
																		if (window.console) {
																			return console
																					.log('Navigating '
																							+ direction
																							+ '. Current item: '
																							+ itemIndex);
																		}
																	}
																});
											});

							//Programatically call
							$('#open-image').click(function(e) {
								e.preventDefault();
								$(this).ekkoLightbox();
							});
							$('#open-youtube').click(function(e) {
								e.preventDefault();
								$(this).ekkoLightbox();
							});

						});
	</script>
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
					playerVars: {rel: 0, showinfo: 0, ecver: 2},
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
	 
	<script type="text/javascript">
		$('.carousel').carousel({
			interval : false
		});
	</script>
	
	<!--  <script>
  var youtubeReady = false;

  function onYouTubeIframeAPIReady(){
    youtubeReady = true;
  }

  $('.carousel').on('slide', function(){
    if(youtubeReady){
      console.log("setting player");
      var iframeID = $(this).find('.active').find('iframe').attr("id");
      player = new YT.Player(iframeID); 
      player.stopVideo(); 
    }
  });
  </script> -->
</body>
</html>

