<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<style type="text/css">
.nav-tabs .nav-item:last-child .nav-link {
	border-right: 2px solid #21316c !important;
}
</style>
</head>
<body class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<%-- <jsp:include page="/WEB-INF/views/include/topBarLogin.jsp"></jsp:include> --%>

	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>

	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Dashboard</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/upcomingEvents">Dashboard</a>

			<!-- 
            <p class="last-update">Last Updated on 25 Feb 2019</p>  -->
		</div>
	</div>
	<%--     <c:if test="${sessionScope.successMsg!=null}">
            <div class="col-lg-12">
    		          <div class="alert alert-success alert-dismissible fade in">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                <strong>Success : </strong> ${sessionScope.successMsg}</div>
        	                                       </div> 
            </c:if> --%>
	<div class="container" id="main-content">
		<div class="row row-eq-height">

			<jsp:include page="/WEB-INF/views/include/loginLeft.jsp"></jsp:include>


			<div class="col-12 col-sm-12 col-lg-9">
				<div class="right-Colm news-listing-page">
					<c:if test="${sessionScope.success != null}">

						<div class="col-12 col-sm-12 col-lg-12 ">
							<div class="alert alert-success ">
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<strong>Success : </strong> ${success}
							</div>
						</div>
					</c:if>
					<%
						session.removeAttribute("success");
					%>
					<c:if test="${sessionScope.errorMsg != null}">
						<div class="col-12 col-sm-12 col-lg-12 ">
							<div class="alert alert-danger ">
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
								<strong>Error : </strong> ${errorMsg}
							</div>
						</div>
					</c:if>
					<%
						session.removeAttribute("errorMsg");
					%>
					<h2>Dashboard</h2>
					<ul class="nav nav-tabs rusa-gallery-tab rusa-gallery-sub-tab"
						role="tablist">
						<li class="nav-item"><a class="nav-link active"
							href="${pageContext.request.contextPath}/upcomingEvents"><span
								class="icon-calendar-with-a-clock-time-tools icon"></span>
								Upcoming Events</a></li>

						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/previousEvents"><span
								class="icon-calendar icon"></span> Previous Events </a></li>
					</ul>

					<div class="tab-content">
						<div id="upcoming" class="tab-pane active">
							<table align="center" cellpadding="0" cellspacing="0"
								class="table">
								<thead>
									<tr>
										<th width="7%">Sr.no</th>
										<th style="text-align: center;">Event Name</th>
										<th style="width: 15%; text-align: center;">Event Date</th>
										<th style="text-align: center;" width="15%">Is Apply</th>
										<th style="text-align: center;" width="10%">Details</th>

									</tr>
								</thead>
								<tbody>


									<c:forEach items="${upcoming}" var="upcoming" varStatus="count">
										<tr class="odd">
											<td>${count.index+1}</td>
											<td>${upcoming.heading}</td>
											<td style="text-align: center;">${upcoming.eventDateFrom}</td>
											<td style="text-align: center;"><c:choose>
													<c:when test="${upcoming.exInt1==1}">
													Applied
													</c:when>
													<c:otherwise>
													Not Apply</c:otherwise>
												</c:choose></td>
											<td><a
												href="${pageContext.request.contextPath}/eventDetail?newsblogsId=${upcoming.exVar1}&typeId=${typeId}">Detail</a></td>
										</tr>
									</c:forEach>



								</tbody>
							</table>

						</div>

						<%--  <div id="previous" class="tab-pane"> 
                                	 <table align="center" cellpadding="0" cellspacing="0"  class="table">
                                    <thead>
                                        <tr>
                                            <th>Sr. no</th>
                                            <th>Event Name</th>
                                            <th>Download</th>
                                          
                                            <th>Detail</th>
                                        </tr>
                                    </thead>
                                    <tbody>
 								 <c:forEach items="${previous}" var="previous"	varStatus="count">
                                        <tr class="odd">
                                        
                                            <td>${count.index+1}</td>
                                            <td>${previous.heading}</td>
                                            <td><a href="#"><span class="icon-download-2"></span> Download</a></td>
                                            <td><a href="${pageContext.request.contextPath}/eventDetail/${previous.newsblogsId}">Detail</a></td>
                                          
                                        </tr>
                                        </c:forEach>
                                      
                                    </tbody>
                                    </table>	
                                </div> --%>
					</div>

				</div>
			</div>



		</div>
	</div>
	<br>


	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>