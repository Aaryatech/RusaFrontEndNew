<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>


<c:url var="checkMaintainance" value="/checkMaintainance" />
<div class="top-menu" id="top-menu">
	<div>
		<div class="navbar navbar-expand-md menusats"><%-- ${logoUrl}${logo.logoMain} --%>
			<div class="container">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/"><img
					src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""></a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarsExample01" aria-controls="navbarsExample01"
					aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				  <div class="collapse navbar-collapse justify-content-md-end">
				<form class="form-inline my-2 my-md-0 search-section"
					action="${pageContext.request.contextPath}/searchData" method="get">
					<input class="form-control" type="text" placeholder="Search"
						name="word" value="${seachSentence}">
					<button type="submit" id="contact-btn" class="btn button search">
						<span class="icon-search icon"></span>
					</button>
				</form>
                </div>
	
			</div>
		</div>
	<nav class="navbar navbar-expand-md bg-dark_new justify-content-md-center">
			<div>
				<div class="collapse navbar-collapse" id="navbarsExample01">
					<ul class="navbar-nav mr-end">
						
						
						<c:forEach items="${sessionScope.menuList.sectionlist}"
							var="menuList"> 
							<li class="nav-item dropdown"><c:choose>
									<c:when test="${menuList.catCount!=0}">

										<a
											href="${pageContext.request.contextPath}/info/${menuList.sectionSlugname}"
											class="dropdown-toggle nav-link dropdown-toggle"
											data-toggle="dropdown" title="${menuList.sectionName}">${menuList.sectionName}
											<span class="caret"></span>
										</a>
										<ul class="dropdown-menu">
											<c:forEach items="${sessionScope.menuList.categoryList}"
												var="catList">

												<c:if test="${menuList.sectionId==catList.sectionId}">


													<c:choose>
														<c:when test="${catList.subCatCount!=0}">

															<li class="dropdown-submenu"><c:choose>
																	<c:when test="${not empty catList.externalUrl}">

																		<c:set value="${catList.externalUrl}" var="string"></c:set>

																		<c:choose>
																			<c:when test="${fn:contains(string, 'http')}">
																				<c:choose>
																					<c:when test="${catList.externalUrlTarget==1}">

																						<a class="test" onclick="checkMaintainance()" tabindex="-1"
																							title="${catList.catName}"
																							href="${catList.externalUrl}" target="_blank">${catList.catName}<span
																							class="caret"></span></a>

																					</c:when>
																					<c:otherwise>
																						<a class="test" onclick="checkMaintainance()"
																							title="${catList.catName}"
																							href="${catList.externalUrl}">${catList.catName}<span
																							class="caret"></span></a>

																					</c:otherwise>

																				</c:choose>

																			</c:when>
																			<c:otherwise>
																				<c:choose>
																					<c:when test="${catList.externalUrlTarget==1}">

																						<a class="test" onclick="checkMaintainance()"
																							title="${catList.catName}"
																							href="${pageContext.request.contextPath}/${catList.externalUrl}"
																							target="_blank">${catList.catName}<span
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
																		<a class="test" tabindex="-1"
																			onclick="checkMaintainance()"
																			title="${catList.catName}"
																			href="${pageContext.request.contextPath}/info/${catList.slugName}">${catList.catName}<span
																			class="caret"></span></a>
																	</c:otherwise>
																</c:choose>

																<ul class="dropdown-menu">
																	<c:forEach items="${sessionScope.menuList.subCatList}"
																		var="subCatList">

																		<c:if test="${subCatList.parentId==catList.catId}">


																			<li class="dropdown-item"><c:choose>
																					<c:when test="${not empty subCatList.externalUrl}"> 
																					
																					<c:set value="${subCatList.externalUrl}"
																							var="string"></c:set>

																						<c:choose>
																							<c:when test="${fn:contains(string, 'http')}">
																								<c:choose>
																									<c:when
																										test="${subCatList.externalUrlTarget==1}">

																										<a class="test" onclick="checkMaintainance()"
																											title="${subCatList.subCatName}"
																											href="${subCatList.externalUrl}"
																											target="_blank">${subCatList.subCatName}
																										</a>

																									</c:when>
																									<c:otherwise>
																										<a class="test" onclick="checkMaintainance()"
																											title="${subCatList.subCatName}"
																											href="${subCatList.externalUrl}">${subCatList.subCatName}
																										</a>

																									</c:otherwise>

																								</c:choose>

																							</c:when>
																							<c:otherwise>
																								<c:choose>
																									<c:when test="${catList.externalUrlTarget==1}">

																										<a class="test" onclick="checkMaintainance()"
																											title="${subCatList.subCatName}"
																											href="${pageContext.request.contextPath}/${subCatList.externalUrl}" target="_blank">${subCatList.subCatName}
																										</a>

																									</c:when>
																									<c:otherwise>
																										<a class="test" onclick="checkMaintainance()"
																											title="${subCatList.subCatName}"
																											href="${pageContext.request.contextPath}/${subCatList.externalUrl}" >${subCatList.subCatName}
																										</a>

																									</c:otherwise>

																								</c:choose>
																							</c:otherwise>
																						</c:choose>

																					</c:when>
																					<c:otherwise>
																						<a class="test" onclick="checkMaintainance()"
																							title="${subCatList.subCatName}"
																							href="${pageContext.request.contextPath}/info/${subCatList.subSlugName}">${subCatList.subCatName}
																						</a>
																					</c:otherwise>
																				</c:choose></li>


																		</c:if>
																	</c:forEach>

																</ul></li>

														</c:when>
														<c:otherwise>
															<li class="dropdown-item"><c:choose>
																	<c:when test="${not empty catList.externalUrl}">

																		<c:set value="${catList.externalUrl}" var="string"></c:set>

																		<c:choose>
																			<c:when test="${fn:contains(string, 'http')}">
																				<c:choose>
																					<c:when test="${catList.externalUrlTarget==1}">

																						<a class="test" onclick="checkMaintainance()"
																							title="${catList.catName}"
																							href="${catList.externalUrl}" target="_blank">${catList.catName}<span
																							class="caret"></span></a>

																					</c:when>
																					<c:otherwise>
																						<a class="test" onclick="checkMaintainance()"
																							title="${catList.catName}"
																							href="${catList.externalUrl}">${catList.catName}<span
																							class="caret"></span></a>

																					</c:otherwise>

																				</c:choose>

																			</c:when>
																			<c:otherwise>
																				<c:choose>
																					<c:when test="${catList.externalUrlTarget==1}">

																						<a class="test" onclick="checkMaintainance()"
																							title="${catList.catName}"
																							href="${pageContext.request.contextPath}/${catList.externalUrl}"
																							target="_blank">${catList.catName}<span
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
																		<a class="test" tabindex="-1"
																			onclick="checkMaintainance()"
																			title="${catList.catName}"
																			href="${pageContext.request.contextPath}/info/${catList.slugName}">${catList.catName}<span
																			class="caret"></span></a>
																	</c:otherwise>
																</c:choose></li>
														</c:otherwise>
													</c:choose>
												</c:if>
											</c:forEach>
										</ul>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${not empty menuList.externalUrl}">
												<c:set value="${menuList.externalUrl}" var="string"></c:set>

												<c:choose>
													<c:when test="${fn:contains(string, 'http')}">
														<c:choose>
															<c:when test="${menuList.externalUrlTarget==1}">

																<a class="nav-link" onclick="checkMaintainance()"
																	title="${menuList.sectionName}"
																	href="${menuList.externalUrl}" target="_blank">${menuList.sectionName}</a>

															</c:when>
															<c:otherwise>
																<a class="nav-link" onclick="checkMaintainance()"
																	title="${menuList.sectionName}"
																	href="${menuList.externalUrl}">${menuList.sectionName}</a>

															</c:otherwise>

														</c:choose>

													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${menuList.externalUrlTarget==1}">

																<a class="nav-link" onclick="checkMaintainance()"
																	title="${menuList.sectionName}"
																	href="${pageContext.request.contextPath}/${menuList.externalUrl}"
																	target="_blank">${menuList.sectionName}</a>

															</c:when>
															<c:otherwise>
																<a class="nav-link" onclick="checkMaintainance()"
																	title="${menuList.sectionName}"
																	href="${pageContext.request.contextPath}/${menuList.externalUrl}">${menuList.sectionName}</a>

															</c:otherwise>

														</c:choose>
													</c:otherwise>
												</c:choose>


											</c:when>
											<c:otherwise>
												<a class="nav-link" onclick="checkMaintainance()"
													title="${menuList.sectionName}"
													href="${pageContext.request.contextPath}/info/${menuList.sectionSlugname}">${menuList.sectionName}</a>
											</c:otherwise>
										</c:choose>

									</c:otherwise>
								</c:choose></li>
						</c:forEach>
					</ul>
				</div>
				
			</div>
		
		</nav>

	</div>
</div>
<script>
	function checkMaintainance() {

	}
</script>
