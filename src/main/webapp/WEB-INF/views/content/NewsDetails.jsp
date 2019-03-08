<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
	<%@ page import="com.ats.rusafrontend.model.Maintainance"%>


 <%
//allow access only if session exists
String user = null;
	if (session.getAttribute("menuList") == null) {
		String mapping = (String) session.getAttribute("mapping");
		String contextPath = request.getContextPath();
		contextPath=contextPath+"/retriveSession/"+mapping;
		response.sendRedirect(contextPath); 
	} 
%>
 <!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.png" type="image/x-icon" /> 
        <meta name="description" content="${image.pageMetaDescription}">
        <meta name="author" content="${sessionScope.homePageMetaData.metaAuthor}">
        <meta name="keywords" content="${image.pageMetaKeyword}">
        <link rel="icon" href="../../favicon.ico">
        <title>${sessionScope.homePageMetaData.siteTitle}</title>
          <jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>
    </head>
    <body>
         <jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
         <jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
        <div class="inner-slider" id="slider">
            <div class="container">
                <h1>${pageContent.pageName}</h1>
            </div>
        </div>
        <div class="bridcrumb">
            <div class="container">
                <%-- <a href="index.html">Home</a> > <a href="${pageContext.request.contextPath}/info/${pageContent.slugName}">${pageContent.pageName}</a> > --%>
            </div>
        </div>
        <div class="container main-content" id="main-content">
            <div class="row row-eq-height">
                <div class="col-12 col-sm-3 col-lg-3">
                    <div class="leftColm">
                    <%--  <c:forEach items="${menuList}" var="menuList" >
                         <c:if test="${menuList.sectionId==pageContent.sectioinId}">
                         	<h3>${menuList.sectionName}</h3>
                         	  <ul class="menu">
                         	   
                         	 <c:forEach items="${menuList.catList}" var="catList" >
                            <!-- class="active" -->
                                <li><a  href="${pageContext.request.contextPath}/info/${catList.slugName}" href="cyber-security-courses.html">${catList.catName} </a> </li>
                                <c:forEach items="${catList.subCatList}" var="subCatList" >
                                 <li><a   href="${pageContext.request.contextPath}/info/${subCatList.subSlugName}" href="cyber-security-courses.html">${subCatList.subCatName} </a></li> 
                                </c:forEach>
                           
                            </c:forEach>
                            </ul>
                            
                         </c:if>
                        </c:forEach>  --%>
                         
                    </div>
                </div>
                <div class="col-12 col-sm-9 col-lg-9 right-Colm">
           
               <div class="row row-eq-height">
                     <div class="col-12">
                        <img src="${getGallryImageURL}${image.featuredImage}" width="700" height="400" alt="${image.heading}">
                        <br><br>
                        <h2>${image.heading}</h2>
                        <p>${image.descriptions}</p>
                     <%--    <h5>Meta Title :</h5><p> ${image.pageMetaTitle}</p>
                        <h5>Meta Description :</h5> <p>${image.pageMetaDescription}</p>
                        <h5>KeyWords :</h5> <p>${image.pageMetaKeyword}</p> --%>
                     </div> 
                   </div>     
                </div>
              </div>
            </div>
         
       <jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
        
          <jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
        <!-- JavaScript-->
       <jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include> 
       
       


       
    </body>
</html>