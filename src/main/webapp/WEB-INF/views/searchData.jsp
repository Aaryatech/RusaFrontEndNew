<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>


<%
	//allow access only if session exists
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
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<title>${sessionScope.homePageMetaData.siteTitle}</title>
<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>
<style>
.other-gov-site-home {
	margin-top: 43px;
}
</style>
</head>
<body onload="clearWordSession()" class="${contrast}">
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>${pageContent.pageName}</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a>
		</div>
	</div>
	<div class="container main-content" id="main-content">
		<div class="row row-eq-height">

			<div class="col-12 col-sm-12 col-lg-12 right-Colm search-result">


				<c:set var="find" value="0"></c:set>

				<c:if test="${searchData.cmsSerchList.size()>0}">

					<c:forEach items="${searchData.cmsSerchList}" var="cmsSerchList">



						<div class="row">
							<div class="col-12 col-sm-9 col-lg-9">
								<h2>
									<a
										href="${pageContext.request.contextPath}/info/${cmsSerchList.pageSlug}">${cmsSerchList.heading}</a>
								</h2>


								<c:set var="string2" value="${cmsSerchList.pageDesc}" />


								<%
									String resp = (String) pageContext.getAttribute("string2"); //No exception.
											int stringlength = resp.length();

											String finalDesc = ".....";
								%>

								<c:forEach items="${searchData.searchWorld}"
									var="searchWorldList">



									<c:set var="searchWorld" value="${searchWorldList}" />

									<%
										String searchWorld = (String) pageContext.getAttribute("searchWorld");

													/* resp = resp.replaceAll("(?i)" + searchWorld, "<strong>" + searchWorld + "</strong>");
													finalDesc = finalDesc+resp.substring(idx, idx+100)+"....."; */
													try {
														int idx = resp.toLowerCase().indexOf(searchWorld.toLowerCase());
														if (finalDesc.toLowerCase().contains(searchWorld.toLowerCase())) {
															finalDesc = finalDesc.replaceAll("(?i)" + searchWorld,
																	"<strong>" + searchWorld + "</strong>");
														} else {
															resp = resp.replaceAll("(?i)" + searchWorld, "<strong>" + searchWorld + "</strong>");
															finalDesc = finalDesc + resp.substring(idx, idx + 100) + ".....";
														}

													} catch (Exception e) {

													}
									%>


								</c:forEach>

								<p>
									<%
										out.println(finalDesc);
									%>
								</p>
							</div>

						</div>


					</c:forEach>

					<c:set var="find" value="1"></c:set>
				</c:if>

				<c:if test="${searchData.faqSerchList.size()>0}">
					FAQ's
 
					<c:forEach items="${searchData.faqSerchList}" var="faqSerchList">


						<div class="row">
							<div class="col-12 col-sm-9 col-lg-9">
								<h2>
									<a
										href="${pageContext.request.contextPath}/info/${faqSerchList.pageSlug}">${faqSerchList.faqQue}</a>
								</h2>
								<c:set var="string1" value="${faqSerchList.faqAns}" />

								<%
									String finalDesc = (String) pageContext.getAttribute("string1"); //No exception.
								%>

								<c:forEach items="${searchData.searchWorld}"
									var="searchWorldList">



									<c:set var="searchWorld" value="${searchWorldList}" />

									<%
										String searchWorld = (String) pageContext.getAttribute("searchWorld");

													/* resp = resp.replaceAll("(?i)" + searchWorld, "<strong>" + searchWorld + "</strong>");
													finalDesc = finalDesc+resp.substring(idx, idx+100)+"....."; */
													try {

														finalDesc = finalDesc.replaceAll("(?i)" + searchWorld,
																"<strong>" + searchWorld + "</strong>");
														System.out.println(finalDesc);
													} catch (Exception e) {

													}
									%>


								</c:forEach>

								<p>
									<%
										out.println(finalDesc);
									%>
								</p>
							</div>

						</div>
					</c:forEach>
					<c:set var="find" value="1"></c:set>
				</c:if>

				<c:if test="${searchData.newsSerchList.size()>0}">
					News

					<c:forEach items="${searchData.newsSerchList}" var="newsSerchList">

						<div class="row">
							<div class="col-12 col-sm-3 col-lg-2 search-image">

								<c:choose>
									<c:when test="${not empty newsSerchList.featuredImage}">
										<img src="${getGallryImageURL}${newsSerchList.featuredImage}"
											alt="${newsSerchList.heading}"
											title="${newsSerchList.heading}" class="img-responsive">
									</c:when>
									<c:otherwise>
										<img
											src="${pageContext.request.contextPath}/resources/images/noimageteam.png" 
											 class="img-responsive">
									</c:otherwise>
								</c:choose>

							</div>
							<div class="col-12 col-sm-6 col-lg-6">
								<h2>
									<a
										href="${pageContext.request.contextPath}/NewsDetails/${newsSerchList.exVar1}">${newsSerchList.heading}</a>
								</h2>

								<c:set var="string1" value="${newsSerchList.descriptions}" />
								<c:set var="string2" value="${fn:substring(string1, 0, 500)}" />
								<p>${string2}.....</p>
							</div>

						</div>


					</c:forEach>
					<c:set var="find" value="1"></c:set>
				</c:if>

				<%-- <c:if test="${searchData.gallerySerchList.size()>0}">
					<h2>Gallery</h2>
					<c:forEach items="${searchData.gallerySerchList}"
						var="gallerySerchList">

						<h2>
							<a
								href="${pageContext.request.contextPath}/info/${gallerySerchList.pageSlug}">${gallerySerchList.title}</a>
						</h2>

						<br>
					</c:forEach>
					<hr>
					<c:set var="find" value="1"></c:set>
				</c:if> --%>

				<c:if test="${searchData.documentSerchList.size()>0}">
					<h2>Document</h2>
					<c:forEach items="${searchData.documentSerchList}"
						var="documentSerchList">

						<div class="row">
							<div class="col-12 col-sm-9 col-lg-9">
								<h2>
									<a
										href="${pageContext.request.contextPath}/info/${documentSerchList.pageSlug}">${documentSerchList.fileName}</a>
								</h2>

							</div>

						</div>

					</c:forEach>
					<c:set var="find" value="1"></c:set>
				</c:if>

				<c:if test="${find==0}">
					<h2 style="text-align: center;">No Record Found</h2>
				</c:if>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	<!-- JavaScript-->
	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>

	<script>
		function clearWordSession() {
	<%session.removeAttribute("seachSentence");%>
		}
	</script>



</body>
</html>