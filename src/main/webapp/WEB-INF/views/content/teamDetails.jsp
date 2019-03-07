<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<c:choose>
	<c:when test="${not empty pageMetaData.pageMetaTitle}">
		<meta name="description" content="${pageMetaData.pageMetaDescription}">
		<link rel="icon" href="../../favicon.ico">
		<title>${pageMetaData.pageMetaTitle}</title>
	</c:when>
	<c:otherwise>
		<meta name="description"
			content="${sessionScope.homePageMetaData.metaDescription}">
		<link rel="icon" href="../../favicon.ico">
		<title>${sessionScope.homePageMetaData.siteTitle}</title>
	</c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>
</head>
<body>
<c:url var="checkMaintainance" value="/checkMaintainance" />
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>${pageContent.pageName}</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a href="${pageContext.request.contextPath}/info/${pageContent.slugName}">${pageContent.pageName}</a> >
		</div>
	</div>
	
		    <div class="container main-content" id="main-content">
		<div class="row row-eq-height">


			<div class="col-12 col-sm-3 col-lg-3">
				<div class="leftColm">
					<c:forEach items="${sessionScope.menuList.sectionlist}"
						var="menuList">
						<c:if test="${menuList.sectionId==pageMetaData.sectionId}">
							<h3>${menuList.sectionName}</h3>
							<ul class="menu">

								<c:forEach items="${sessionScope.menuList.categoryList}"
									var="catList">
									<!-- class="active" -->

									<c:if test="${catList.sectionId==pageMetaData.sectionId}">
										<li><c:choose>
												<c:when test="${not empty catList.externalUrl}">
													<a  onclick="checkMaintainance()"
														title="${catList.catName}"
														href="${pageContext.request.contextPath}/${catList.externalUrl}">${catList.catName}<span
														class="caret"></span></a>
												</c:when>
												<c:otherwise>
													<a   onclick="checkMaintainance()"
														title="${catList.catName}"
														href="${pageContext.request.contextPath}/info/${catList.slugName}">${catList.catName}<span
														class="caret"></span></a>
												</c:otherwise>
											</c:choose></li>
									</c:if>

								</c:forEach>
							</ul>

						</c:if>
					</c:forEach>

				</div>
			</div>
			 <div class="col-12 col-sm-9 col-lg-9 right-Colm">
				<div class="row team">
				 <c:forEach items="${teamList}" var="teamList"	varStatus="count">
                    	  	<div class="col-6 col-sm-4 col-lg-3">
                    	  	<c:choose>
								<c:when test="${not empty teamList.imageName}">
                    
							          <img src="${gallryImageURL}${teamList.imageName}"
							        	width="200" height="200" alt="">
						       </c:when>
						      <c:otherwise>
						              <img src="${pageContext.request.contextPath}/resources/images/noimage-team.png"
							        	width="200" height="200" alt="">
						      </c:otherwise>
						  </c:choose>
                    	<c:set var="string1" value="${teamList.message}" />
						<c:set var="string2" value="${fn:substring(string1, 0, 256)}" />
					    <p><strong>${teamList.fromName}</strong> <br>
						<span>${string2}</span></p>
						   </div>
						</c:forEach>
                 
                    
              
                                    	
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