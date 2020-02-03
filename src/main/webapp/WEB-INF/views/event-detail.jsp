<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>
<%@ page session="true"%>


<%@ page import="java.util.UUID"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.math.BigInteger"%>
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
			<h1>Event Detail</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> >
			<%-- <a
				href="${pageContext.request.contextPath}/eventList"> --%>
			Event
			<!-- </a> -->
			>
		</div>
	</div>

	<div class="container" id="main-content">
		<div class="row row-eq-height">

			<jsp:include page="/WEB-INF/views/include/loginLeft.jsp"></jsp:include>


			<div class="col-12 col-sm-12 col-lg-9">
				<div class="right-Colm news-listing-page">
					<div class="col-lg-12">

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



						<%
							UUID uuid = UUID.randomUUID();
							MessageDigest md = MessageDigest.getInstance("MD5");
							byte[] messageDigest = md.digest(String.valueOf(uuid).getBytes());
							BigInteger number = new BigInteger(1, messageDigest);
							String hashtext = number.toString(16);
							session = request.getSession();
							session.setAttribute("generatedKey", hashtext);
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

						<div class="row">
							<c:if test="${not empty event.featuredImage}">
								<div class="col-12 col-sm-6 col-lg-6">
									<img src="${sessionScope.gallryImageURL}${event.featuredImage}"
										alt="${event.heading}" title="${event.heading}"
										class="img-responsive thumbnail">
								</div>
							</c:if>
							<div class="col-12 col-sm-12 col-lg-12">

								<strong>${event.heading}</strong><br>
								<p>${event.descriptions}</p>
								<p>
									<span><i class="icon-location"></i> <strong>Venue
											:</strong> ${event.eventLocation}</span> <span><i
										class="icon-calendar"></i> <strong>Date:</strong>
										${event.eventDateFrom}</span> <span><i class="icon-man-user"></i>
										<strong>Contact Person :</strong> ${event.eventContactPerson}</span>
									<span><i class="icon-smartphone-call"></i> <strong>Contact
											:</strong> +91 ${event.eventContactNumber}</span><br>
								</p>
								<c:if test="${typeId==2}">
									<c:if test="${event.exInt2==1}">

										<c:forEach items="${ids}" var="id">
											<c:if test="${editReg.userType==id}">

												<form class="form-horizontal"
													action="${pageContext.request.contextPath}/submtEventAppliedForm"
													method="post" enctype="multipart/form-data"
													name="form_sample_2" id="form_sample_2">


													<input type="hidden" value="<%out.println(hashtext);%>"
														name="token" id="token">

													<p>
														<strong>Upload Document : </strong>
													</p>

													<div class="col-sm-7">
														<input type="file" name="pagePdf" id="pagePdf"
															class="form-control" data-parsley-minlength="2" required
															accept=".xlsx,.xls,.doc, .docx,.ppt, .pptx,.txt,.pdf,.zip" />

														<p>
															<span> <strong>Please upload :</strong> .doc,
																.docx, .pptx,.pdf and .xlsx only
															</span>
														</p>
														<p>
															<span> <strong>Document Description :</strong>
																${event.exVar1}
															</span>
														</p>
													</div>
													<input type="hidden" name="newsblogsId"
														value="${event.newsblogsId}">

													<button type="submit" class="btn button apply">Apply</button>

												</form>

											</c:if>
										</c:forEach>


									</c:if>


									<c:if test="${event.exInt2==0}">

										<c:forEach items="${ids}" var="id">
											<c:if test="${editReg.userType==id}">
												<a
													href="${pageContext.request.contextPath}/applyEvent/${event.newsblogsId}/<%out.println(hashtext);%>"
													class="btn button apply">Apply</a>

											</c:if>
										</c:forEach>
									</c:if>

								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function show() {

		}
	</script>

	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>