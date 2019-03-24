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
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.png" type="image/x-icon" /> 
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description"
	content="${sessionScope.homePageMetaData.metaDescription}">
<meta name="author"
	content="${sessionScope.homePageMetaData.metaAuthor}">
<link rel="icon" href="../../favicon.ico">
<title>${sessionScope.homePageMetaData.siteTitle}</title>
<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>
</head>
<body>
	<c:url var="checkMaintainance" value="/checkMaintainance" />
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Site Map</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/siteMap">Site Map</a>

		</div>
	</div>
	<div class="container main-content" id="main-content">
		<div class="row row-eq-height">
			<div class="col-12 col-sm-3 col-lg-3">
				<div class="leftColm">
					<h3>Site Map</h3>
					<ul class="menu">
						<c:forEach items="${sessionScope.menuList.sectionlist}"
							var="menuList">

							<li><c:choose>
									<c:when test="${not empty menuList.externalUrl}">

										<c:set value="${menuList.externalUrl}" var="string"></c:set>

										<c:choose>
											<c:when test="${fn:contains(string, 'http')}">
												<c:choose>
													<c:when test="${menuList.externalUrlTarget==1}">

														<a onclick="checkMaintainance()"
															title="${menuList.sectionName}"
															href="${menuList.externalUrl}" target="_blank">${menuList.sectionName}</a>

													</c:when>
													<c:otherwise>
														<a onclick="checkMaintainance()"
															title="${menuList.sectionName}"
															href="${menuList.externalUrl}">${menuList.sectionName}</a>

													</c:otherwise>

												</c:choose>

											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${menuList.externalUrlTarget==1}">

														<a onclick="checkMaintainance()"
															title="${menuList.sectionName}"
															href="${pageContext.request.contextPath}/${menuList.externalUrl}"
															target="_blank">${menuList.sectionName}</a>

													</c:when>
													<c:otherwise>
														<a onclick="checkMaintainance()"
															title="${menuList.sectionName}"
															href="${pageContext.request.contextPath}/${menuList.externalUrl}">${menuList.sectionName}</a>

													</c:otherwise>

												</c:choose>
											</c:otherwise>
										</c:choose>

									</c:when>
									<c:otherwise>
										<a onclick="checkMaintainance()"
											href="${pageContext.request.contextPath}/info/${menuList.sectionSlugname}"
											href="cyber-security-courses.html">${menuList.sectionName}
										</a>

									</c:otherwise>
								</c:choose></li>

						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="col-12 col-sm-9 col-lg-9 right-Colm">
				<div id="site-map">
					<div class="site-map-menus">

						<c:forEach items="${sessionScope.menuList.sectionlist}"
							var="menuList">
							<div
								class="site-map-box-menu site-map-box-menu-menu-about-mhrd-menu site-map-box-menu site-map-box-menu-menu-accessibility-statement site-map-box">
								<h5 class="title">
									<c:choose>
										<c:when test="${not empty menuList.externalUrl}">

											<c:set value="${menuList.externalUrl}" var="string"></c:set>

											<c:choose>
												<c:when test="${fn:contains(string, 'http')}">
													<c:choose>
														<c:when test="${menuList.externalUrlTarget==1}">

															<a onclick="checkMaintainance()"
																href="${menuList.externalUrl}"
																title="${menuList.sectionName}" target="_blank">${menuList.sectionName}</a>

														</c:when>
														<c:otherwise>
															<a onclick="checkMaintainance()"
																href="${menuList.externalUrl}"
																title="${menuList.sectionName}">${menuList.sectionName}</a>

														</c:otherwise>

													</c:choose>

												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${menuList.externalUrlTarget==1}">

															<a onclick="checkMaintainance()"
																href="${pageContext.request.contextPath}/${menuList.externalUrl}"
																title="${menuList.sectionName}" target="_blank">${menuList.sectionName}</a>

														</c:when>
														<c:otherwise>
															<a onclick="checkMaintainance()"
																href="${pageContext.request.contextPath}/${menuList.externalUrl}"
																title="${menuList.sectionName}">${menuList.sectionName}</a>

														</c:otherwise>

													</c:choose>
												</c:otherwise>
											</c:choose>

										</c:when>
										<c:otherwise>
											<a onclick="checkMaintainance()"
												href="${pageContext.request.contextPath}/info/${menuList.sectionSlugname}"
												title="${menuList.sectionName}">${menuList.sectionName}</a>
										</c:otherwise>
									</c:choose>

								</h5>
								<div class="content">
									<c:forEach items="${sessionScope.menuList.categoryList}"
										var="catList">

										<c:if test="${catList.sectionId==menuList.sectionId}">
											<ul class="site-map-menu list">

												<c:choose>
													<c:when test="${not empty catList.externalUrl}">

														<c:set value="${catList.externalUrl}" var="string"></c:set>

														<c:choose>
															<c:when test="${fn:contains(string, 'http')}">
																<c:choose>
																	<c:when test="${catList.externalUrlTarget==1}">

																		<span style="padding-right: 20px;"></span>
																		<a onclick="checkMaintainance()"
																			href="${catList.externalUrl}"
																			title="${catList.catName}" target="_blank">${catList.catName}</a>
																		<br>
																	</c:when>
																	<c:otherwise>

																		<span style="padding-right: 20px;"></span>
																		<a onclick="checkMaintainance()"
																			href="${catList.externalUrl}"
																			title="${catList.catName}">${catList.catName}</a>
																		<br>
																	</c:otherwise>

																</c:choose>

															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${catList.externalUrlTarget==1}">

																		<span style="padding-right: 20px;"></span>
																		<a onclick="checkMaintainance()"
																			href="${pageContext.request.contextPath}/${catList.externalUrl}"
																			title="${catList.catName}" target="_blank">${catList.catName}</a>
																		<br>

																	</c:when>
																	<c:otherwise>
																		<span style="padding-right: 20px;"></span>
																		<a onclick="checkMaintainance()"
																			href="${pageContext.request.contextPath}/${catList.externalUrl}"
																			title="${catList.catName}">${catList.catName}</a>
																		<br>

																	</c:otherwise>

																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<span style="padding-right: 20px;"></span>
														<a onclick="checkMaintainance()"
															href="${pageContext.request.contextPath}/info/${catList.slugName}"
															title="${catList.catName}">${catList.catName}</a>
														<br>
													</c:otherwise>
												</c:choose>

												<c:forEach items="${sessionScope.menuList.subCatList}"
													var="subCatList">
													<c:if test="${subCatList.parentId==catList.catId}">
														<!-- <li class="leaf"> -->
														<c:choose>
															<c:when test="${not empty subCatList.externalUrl}">

																<c:set value="${subCatList.externalUrl}" var="string"></c:set>

																<c:choose>
																	<c:when test="${fn:contains(string, 'http')}">
																		<c:choose>
																			<c:when test="${subCatList.externalUrlTarget==1}">

																				<span style="padding-right: 40px;"></span>
																				<a onclick="checkMaintainance()"
																					href="${subCatList.externalUrl}"
																					title="${subCatList.subCatName}">${subCatList.subCatName}<br>
																				</a>

																			</c:when>
																			<c:otherwise>
																				<span style="padding-right: 40px;"></span>
																				<a onclick="checkMaintainance()"
																					href="${subCatList.externalUrl}"
																					title="${subCatList.subCatName}">${subCatList.subCatName}<br>
																				</a>

																			</c:otherwise>

																		</c:choose>

																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${catList.externalUrlTarget==1}">
																				<span style="padding-right: 40px;"></span>
																				<a onclick="checkMaintainance()"
																					href="${pageContext.request.contextPath}/${subCatList.externalUrl}"
																					title="${subCatList.subCatName}" target="_blank">${subCatList.subCatName}<br>
																				</a>
																			</c:when>
																			<c:otherwise>
																				<span style="padding-right: 40px;"></span>
																				<a onclick="checkMaintainance()"
																					href="${pageContext.request.contextPath}/${subCatList.externalUrl}"
																					title="${subCatList.subCatName}">${subCatList.subCatName}<br>
																				</a>

																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>

															</c:when>
															<c:otherwise>
																<span style="padding-right: 40px;"></span>
																<a onclick="checkMaintainance()"
																	href="${pageContext.request.contextPath}/info/${subCatList.subSlugName}"
																	title="${subCatList.subCatName}">${subCatList.subCatName}<br>
																</a>
															</c:otherwise>
														</c:choose>

														<!-- </li> -->
													</c:if>
												</c:forEach>
											</ul>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</c:forEach>

					</div>
				</div>
			</div>

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