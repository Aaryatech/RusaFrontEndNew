<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate var="todayString" value="${today}" pattern="dd-MM-yyyy" />
<fmt:formatDate var="dateString" value="${bean.date}"
	pattern="dd/MM/yyyy" />
<%@ page import="java.util.UUID"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.math.BigInteger"%>
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
			%><h1>कार्यक्रम तपशील</h1>
			<%
				} else {
			%><h1>Event Detail</h1>
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
				href="${pageContext.request.contextPath}/listOFEvent/1">
				कार्यक्रम यादी</a>
			<%
				} else {
			%><a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/listOFEvent/1">Event
				List</a>
			<%
				}
			%>
		</div>
	</div>

	<div class="container" id="main-content">
		<div class="row row-eq-height">
			<c:set var="today_date" value="<%=new java.util.Date()%>" />

			<%
				UUID uuid = UUID.randomUUID();
				MessageDigest md = MessageDigest.getInstance("MD5");
				byte[] messageDigest = md.digest(String.valueOf(uuid).getBytes());
				BigInteger number = new BigInteger(1, messageDigest);
				String hashtext = number.toString(16);
				session = request.getSession();
				session.setAttribute("generatedKey", hashtext);
			%>

			<div class="col-12 col-sm-15 col-lg-18 right-Colm news-listing-page">
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
							<span><i class="icon-location"></i> <strong>Venue:</strong>
								${event.eventLocation}</span> <span><i class="icon-calendar"></i>
								<strong>Date:</strong> ${dateEvent} </span> <span><i
								class="icon-man-user"></i> <strong>Contact Person:</strong>
								${event.eventContactPerson}</span> <span><i
								class="icon-smartphone-call"></i> <strong>Contact:</strong> +91
								${event.eventContactNumber}</span><br>
						</p>


						<c:if test="${isapply==1}">
							<c:if test="${event.exInt2==1}">

								<%
									if (session.getAttribute("userInfo") == null) {
								%>
								<form class="form-horizontal"
									action="${pageContext.request.contextPath}/submtFrontEventAppliedForm"
									method="post" enctype="multipart/form-data"
									name="form_sample_2" id="form_sample_2">

									<label class="control-label col-sm-2" for="page_pdf">Upload
										Document :</label>
									<div class="col-sm-7">
										<input type="file" name="pagePdf" id="pagePdf"
											class="form-control" data-parsley-minlength="2" required
											accept=".xlsx,.xls,.doc, .docx,.ppt, .pptx,.txt,.pdf,.zip" />
										<p>
											<span> <strong>Please upload :</strong> .doc, .docx,
												.pptx,.pdf and .xlsx only
											</span>
										</p>
										<p>
											<span> <strong>Document Name :</strong>
												${event.exVar1}
											</span>
										</p>

									</div>
									<input type="hidden" name="newsblogsId"
										value="${event.newsblogsId}"> <input type="hidden"
										value="<%out.println(hashtext);%>" name="token" id="token">
									<button type="submit" class="btn button apply">Apply</button>

								</form>

								<%
									} else {

												int userType = (Integer) session.getAttribute("userType");

												String[] ids = (String[]) session.getAttribute("allowedType");
												int flag = 0;
												for (int i = 0; i < ids.length; i++) {

													if (userType == Integer.parseInt(ids[i])) {
								%>
								<form class="form-horizontal"
									action="${pageContext.request.contextPath}/submtFrontEventAppliedForm"
									method="post" enctype="multipart/form-data"
									name="form_sample_2" id="form_sample_2">
									<p>
										<strong>Upload Document : </strong>
									</p>
									<label class="control-label col-sm-2" for="page_pdf">Upload
										Document :</label>
									<div class="col-sm-7">
										<input type="file" name="pagePdf" id="pagePdf"
											class="form-control" data-parsley-minlength="2" required
											accept=".xlsx,.xls,.doc, .docx,.ppt, .pptx,.txt,.pdf" />
										<p>
											<span> <strong>Please upload : </strong> .doc, .docx,
												.pptx,.pdf and .xlsx only
											</span>
										</p>
										<p>
											<span> <strong>Document Name : </strong>
												${event.exVar1}
											</span>
										</p>
									</div>
									<input type="hidden" name="newsblogsId"
										value="${event.newsblogsId}"> <input type="hidden"
										value="<%out.println(hashtext);%>" name="token" id="token">
									<button type="submit" class="btn button apply">Apply</button>


								</form>

								<%
									flag = 1;
													}
												}

												if (flag == 0) {
								%>
								
								You are not applicable for this event
								<%
									}
											}
								%>

							</c:if>



							<c:if test="${event.exInt2==0}">

								<%
									if (session.getAttribute("userInfo") == null) {
								%>
								<a
									href="${pageContext.request.contextPath}/applyEventFront/${event.newsblogsId}"
									class="btn button apply">Apply</a>
								<%
									} else {
												int flag = 0;
												int userType = (Integer) session.getAttribute("userType");

												String[] ids = (String[]) session.getAttribute("allowedType");

												for (int i = 0; i < ids.length; i++) {

													if (userType == Integer.parseInt(ids[i])) {
								%>
								<a
									href="${pageContext.request.contextPath}/applyEventFront/${event.newsblogsId}"
									class="btn button apply">Apply</a>
								<%
									flag = 1;
													}
												}
												if (flag == 0) {
								%>
													
													You are not applicable for this event
													<%
									}

											}
								%>
							</c:if>
						</c:if>
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