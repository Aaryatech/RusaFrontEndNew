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
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<c:choose>
	<c:when test="${not empty pageMetaData.pageMetaTitle}">
		<meta name="description" content="${pageMetaData.pageMetaDescription}">
		<title>${pageMetaData.pageMetaTitle}</title>
	</c:when>
	<c:otherwise>
		<meta name="description"
			content="${sessionScope.homePageMetaData.metaDescription}">
		<title>${sessionScope.homePageMetaData.siteTitle}</title>
	</c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>
<style>
.other-gov-site-home {
	margin-top: 43px;
}
</style>
</head>
<body>
	<c:url var="checkMaintainance" value="/checkMaintainance" />
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>${pageContent.pageName}</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/info/${pageContent.slugName}">${pageContent.pageName}</a>
			>
		</div>
	</div>


	<div class="container main-content" id="main-content">
		<div class="row row-eq-height">

			<div class="col-12 col-sm-3 col-lg-3">
				<div class="leftColm">
					<c:forEach items="${sessionScope.menuList.sectionlist}"
						var="menuList">
						<c:if test="${menuList.sectionId==pageContent.sectioinId}">
							<h3>${menuList.sectionName}</h3>
							<ul class="menu">

								<c:forEach items="${sessionScope.menuList.categoryList}"
									var="catList">

									<c:if test="${catList.sectionId==menuList.sectionId}">

										<li><c:choose>
												<c:when test="${not empty catList.externalUrl}">

													<c:set value="${catList.externalUrl}" var="string"></c:set>

													<c:choose>
														<c:when test="${fn:contains(string, 'http')}">
															<c:choose>
																<c:when test="${catList.externalUrlTarget==1}">

																	<a onclick="checkMaintainance()"
																		title="${catList.catName}"
																		href="${catList.externalUrl}" target="_blank">${catList.catName}<span
																		class="caret"></span></a>

																</c:when>
																<c:otherwise>

																	<a onclick="checkMaintainance()"
																		title="${catList.catName}"
																		href="${catList.externalUrl}">${catList.catName}<span
																		class="caret"></span></a>


																</c:otherwise>

															</c:choose>

														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${catList.externalUrlTarget==1}">

																	<a onclick="checkMaintainance()"
																		title="${catList.catName}"
																		href="${pageContext.request.contextPath}/${catList.externalUrl}">${catList.catName}<span
																		class="caret"></span></a>

																</c:when>
																<c:otherwise>
																	<a class="test" onclick="checkMaintainance()"
																		title="${catList.catName}"
																		href="${pageContext.request.contextPath}/${catList.externalUrl}">${catList.catName}<span
																		class="caret"></span></a>

																</c:otherwise>

															</c:choose>
														</c:otherwise>
													</c:choose>

												</c:when>
												<c:otherwise>
													<a onclick="checkMaintainance()" title="${catList.catName}"
														href="${pageContext.request.contextPath}/info/${catList.slugName}">${catList.catName}<span
														class="caret"></span></a>
												</c:otherwise>
											</c:choose></li>

										<c:forEach items="${sessionScope.menuList.subCatList}"
											var="subCatList">
											<c:if test="${subCatList.parentId==catList.catId}">
												<li class="sub-menuleft"><c:choose>
														<c:when test="${not empty subCatList.externalUrl}">

															<c:set value="${subCatList.externalUrl}" var="string"></c:set>

															<c:choose>
																<c:when test="${fn:contains(string, 'http')}">
																	<c:choose>
																		<c:when test="${subCatList.externalUrlTarget==1}">

																			<a onclick="checkMaintainance()"
																				title="${subCatList.subCatName}"
																				href="${subCatList.externalUrl}" target="_blank">${subCatList.subCatName}
																			</a>

																		</c:when>
																		<c:otherwise>
																			<a onclick="checkMaintainance()"
																				title="${subCatList.subCatName}"
																				href="${subCatList.externalUrl}">${subCatList.subCatName}
																			</a>

																		</c:otherwise>

																	</c:choose>

																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${catList.externalUrlTarget==1}">

																			<a onclick="checkMaintainance()"
																				title="${subCatList.subCatName}"
																				href="${pageContext.request.contextPath}/${subCatList.externalUrl}"
																				target="_blank">${subCatList.subCatName} </a>

																		</c:when>
																		<c:otherwise>
																			<a onclick="checkMaintainance()"
																				title="${subCatList.subCatName}"
																				href="${pageContext.request.contextPath}/${subCatList.externalUrl}">${subCatList.subCatName}
																			</a>

																		</c:otherwise>

																	</c:choose>
																</c:otherwise>
															</c:choose>

														</c:when>
														<c:otherwise>
															<a onclick="checkMaintainance()"
																title="${subCatList.subCatName}"
																href="${pageContext.request.contextPath}/info/${subCatList.subSlugName}">${subCatList.subCatName}
															</a>
														</c:otherwise>
													</c:choose></li>
											</c:if>
										</c:forEach>

									</c:if>
								</c:forEach>


							</ul>

						</c:if>
					</c:forEach>

				</div>
			</div>
 
			<c:choose>

				<c:when test="${newsSectionList.size()>0}">
					<div class="col-12 col-sm-12 col-lg-6 right-Colm">
				</c:when>
				<c:otherwise>
					<div class="col-12 col-sm-12 col-lg-9 right-Colm news-listing-page">
				</c:otherwise>
			</c:choose>
			<!--  <div class="col-12 col-sm-12 col-lg-9 right-Colm">  -->
			<c:set var="find" value="0"></c:set>

			<c:if test="${pageContent.cmsContentList.size()>0}">
				<c:forEach items="${pageContent.cmsContentList}"
					var="cmsContentList">
					

					<h2>${cmsContentList.heading}</h2>
					<c:if test="${not empty cmsContentList.featuredImage}">
						<div>

							<img src="${gallryImageURL}${cmsContentList.featuredImage}"
								alt=""
								style="float:${cmsContentList.featuredImageAlignment};
								height="
								" width="">
						</div>
					</c:if>
                    ${cmsContentList.pageDesc}
                    <c:if test="${not empty cmsContentList.downloadPdf}">

						<div class="pdfIcon">
							<a href="${url}${cmsContentList.downloadPdf}" target="_blank">${cmsContentList.downloadPdf}
								<%-- - ${documentUploadList.fileSize} --%>
							</a>
						</div>
					</c:if>

				</c:forEach>
				<c:set var="find" value="1"></c:set>
			</c:if>

			<c:if test="${pageContent.faqContentList.size()>0}">
				<h2>FAQ's</h2>




				<div id="accordion" class="accordion">

					<c:forEach items="${pageContent.faqContentList}"
						var="faqContentList" varStatus="loop">
						<div class="faq-section">

							<div class="card-header " data-toggle="collapse"
								href="#collapseOne${loop.index}">
								<a class="card-title"> <span>${faqContentList.faqQue}</span>
								</a>
							</div>

							<div id="collapseOne${loop.index}" class="card-body collapse  "
								data-parent="#accordion">
								<div class="clearfix"></div>
								${faqContentList.faqAns}
							</div>
						</div>
					</c:forEach>

				</div>
				<c:set var="find" value="1"></c:set>
			</c:if>

			<c:if test="${pageContent.documentUploadList.size()>0}">
				<h5>Downloads</h5>

				<c:forEach items="${pageContent.documentUploadList}"
					var="documentUploadList">

					<div class="pdfIcon">
						<a href="${url}${documentUploadList.fileName}" target="_blank">${documentUploadList.exVar1}
							- ${documentUploadList.fileSize}</a>
					</div>

				</c:forEach>
				<c:set var="find" value="1"></c:set>
			</c:if>

			<c:if test="${pageContent.testImonialList.size()>0}">
				<h2>Testimonials</h2>
				<div class="row">
					<c:forEach items="${pageContent.testImonialList}"
						var="testImonialList">
						<c:if test="${testImonialList.sectionId==6}">
							<div class="col-12 col-sm-12 col-lg-12">
								<div class="success-stories testimonials-detail">
									<div class="testimonials-user-photo">

										<c:choose>
											<c:when test="${not empty testImonialList.imageName}">
												<img src="${gallryImageURL}${testImonialList.imageName}"
													alt="" style="height: 100px; width: 100px;">
											</c:when>
											<c:otherwise>
												<img
													src="${pageContext.request.contextPath}/resources/images/noimageteam.png"
													alt="" style="height: 100px; width: 100px;">

											</c:otherwise>
										</c:choose>



									</div>
									<p>
										<span class="icon-quote-left quote"></span>${testImonialList.message}
									</p>
									<p>
										<strong>${testImonialList.fromName}</strong> <span
											class="sup-text">${testImonialList.designation},${testImonialList.location}</span>
									</p>
								</div>
							</div>

						</c:if>
					</c:forEach>
				</div>

				<c:set var="find" value="1"></c:set>
			</c:if>

			<c:if test="${pageContent.gallaryDetailList.size()>0}">

				<div class="row">
					<c:forEach items="${pageContent.gallaryDetailList}"
						var="gallaryDetailList">
						<div class="col-12 col-sm-3 col-lg-3">
							<a href="${gallryImageURL}${gallaryDetailList.fileName}"
								data-toggle="lightbox" data-gallery="plan" data-title=""
								class="thumbnail"> <img
								src="${gallryImageURL}thumbnail${gallaryDetailList.fileName}"
								alt="${gallaryDetailList.title}"
								title="${gallaryDetailList.title}" class="img-responsive"></a>
						</div>
					</c:forEach>
				</div>
				<br>

				<c:set var="find" value="1"></c:set>
			</c:if>

			<c:if test="${pageContent.detailNewsList.size()>0}">


				<c:forEach items="${pageContent.detailNewsList}"
					var="detailNewsList">
					<div class="row row-eq-height">
						<div class="col-12">
							<c:if test="${not empty detailNewsList.featuredImage}">
								<img src="${gallryImageURL}${detailNewsList.featuredImage}"
									alt=""
									style="float:${detailNewsList.featuredImageAlignment}; padding-left:20px; padding-right:20px; padding-bottom:20px;"
									height="317px" width="555px">
							</c:if>
							<%-- 	<img src="${gallryImageURL}${detailNewsList.featuredImage}"> --%>
							<c:set var="string1" value="${detailNewsList.descriptions}" />
							<c:set var="string2" value="${fn:substring(string1, 0, 256)}" />
							<h2>${detailNewsList.heading}</h2>
							<p>${string2}</p>
							<%-- <a
									href="${pageContext.request.contextPath}/NewsDetails/${detailNewsList.languageId}/${detailNewsList.pageId}/${detailNewsList.newsblogsId}">more
								</a> --%>
							<a
								href="${pageContext.request.contextPath}/NewsDetails/${detailNewsList.newsblogsId}">more
							</a>
						</div>
					</div>

				</c:forEach>

				<c:set var="find" value="1"></c:set>
			</c:if>

			<c:if test="${pageContent.teamList.size()>0}">
				<div class="row">
					<c:forEach items="${pageContent.teamList}" var="testImonialList">

						<div class="col-6 col-sm-4 col-lg-4">
							<div class="team-wrap">
								<span class="team-candidates-status"></span>
								<figure>
									<c:choose>
										<c:when test="${not empty testImonialList.imageName}">
											<a href="#"><img
												src="${gallryImageURL}${testImonialList.imageName}" alt=""
												style="height: 200px; width: 200px;"></a>
										</c:when>
										<c:otherwise>
											<a href="#"><img
												src="${pageContext.request.contextPath}/resources/images/noimageteam.png"
												alt=""></a>

										</c:otherwise>
									</c:choose>
								</figure>
								<div class="team-candidates-text ">
									<h2>

										<a href="#">${testImonialList.fromName}</a>
									</h2>
									<span>${testImonialList.designation}</span>
								</div>
							</div>
						</div>

					</c:forEach>
				</div>
				<c:set var="find" value="1"></c:set>
			</c:if>

			<c:if test="${pageContent.successList.size()>0}">
				<div class="row" id="successstory">
					<c:forEach items="${pageContent.successList}" var="testImonialList">

						<div class="col-12 col-sm-12 col-lg-12">
							<div class="success-stories">
								<div class="row">
									<div class="col-12 col-sm-3 col-lg-3">
										<c:choose>
											<c:when test="${not empty testImonialList.imageName}">
												<a href="#"><img
													src="${gallryImageURL}${testImonialList.imageName}" alt=""
													width="184" height="134"></a>
											</c:when>
											<c:otherwise>
												<a href="#"><img
													src="${pageContext.request.contextPath}/resources/images/noimageteam.png"
													alt="" width="184" height="134"></a>

											</c:otherwise>
										</c:choose>
									</div>
									<div class="col-12 col-sm-9 col-lg-9">
										<p>
											<span class="icon-quote-left quote"></span>${testImonialList.message}
										</p>
										<p>
											<strong>${testImonialList.fromName}</strong> <span
												class="sup-text">${testImonialList.designation},${testImonialList.location}</span>
										</p>
									</div>
								</div>
							</div>
						</div>

					</c:forEach>
				</div>
				<c:set var="find" value="1"></c:set>
			</c:if>
			<c:if test="${find==0}">

				<h2 style="text-align: center;">No Record Found</h2>
			</c:if>
		</div>


		<c:if test="${newsSectionList.size()>0}">
			<div class="col-12 col-sm-12 col-lg-3 last-Colm">
				<div class="leftColm">
					<h3 class="margin-top30">News</h3>

					<c:forEach items="${newsSectionList}" var="newsSectionList">
						<p>
							<a
								href="${pageContext.request.contextPath}/NewsDetails/${newsSectionList.newsblogsId}">
								${newsSectionList.heading}</a>
						</p>
					</c:forEach>

				</div>
			</div>
		</c:if>
	</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	<!-- JavaScript-->
	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>

	<script>
		function checkMaintainance() {

		}
	</script>
</body>
</html>