<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
	


 <%
//allow access only if session exists
String user = null;
if(session.getAttribute("menuList") == null){
	response.sendRedirect("changeLangage//");
} 
%>
 <!DOCTYPE html>
<html lang="en">
    <head>
          <jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>
         <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.png" type="image/x-icon" /> 
    </head>
    <body>
         <div class="top-menu" id="top-menu">
	<div>
        <div class="navbar navbar-expand-md ">
         <div class="container">	
          <a class="navbar-brand justify-content-md-center" style="margin:0 auto;" ><img
					src="${logoUrl}${logo.logoMain}" alt=""></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample01" aria-controls="navbarsExample01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
        	</div>
        </div> 
	</div>
</div>	
        <div class="inner-slider" id="slider">
            <div class="container">
            </div>
        </div>
        <div class="bridcrumb">
            <div class="container">
                
            </div>
        </div>
    
        <div class="container" id="main-content">
        <div class="row">
        	<div class="col-12 col-sm-12 col-lg-12 ">
        
            	 <h2 style="text-align: center;">${maintainance.message}</h2> 
            </div>
        </div>
            
         </div>
         
        
       
    </body>
</html>