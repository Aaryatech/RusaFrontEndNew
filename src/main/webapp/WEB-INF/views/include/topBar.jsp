<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" 
  import = "java.text.SimpleDateFormat"%> 
<!DOCTYPE html><%-- 
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/jcarousel.responsive.css" rel="stylesheet" type="text/css" >
</head> --%>

  <div class="top-section">

<%
   Date date = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("dd MMM, yyyy | hh:mm a z", Locale.ENGLISH);	
   out.print( "<div class=\"date\">" +sf.format(date)+"</div>");
    
%>
  <div class="top-section">
   
<!-- <div class="date">21 Feb, 2019 | 11:39 AM IST</div> -->
    	<!--  <div class="date">09 Dec, 2018 | 12:38 PM IST</div> -->
        <div class="top-right-menu">
        	<ul>
            	<li><a href="#main-content" class="dropdown-arrow"><span>Skip to main content</span></a></li>
                <li> <a href="#slider" class="dropdown-arrow"><span>Skip to navigation</span></a></li>
           <li> <a href="javascript:void(0);" class="black" data-rel="High Contrast" title="High Contrast">A</a>
            <a href="javascript:void(0);" class="white" data-rel="Low Contrast" title="Low Contrast">A</a></li>
            <li><a href="avascript:void(0);"><strong>Text Size</strong></a>
            <a href="javascript:void(0);" title="Text Size: Decrease" id="btn-decrease" class="decrease">A-</a>
            <a href="javascript:void(0);" title="Text Size: Normal" id="btn-orig" class="reset">A</a>
            <a href="javascript:void(0);" title="Text Size: Increase" id="btn-increase" class="increase">A+</a></li>
        	<li class="login-re"><a href="#">Login</a>
                <a href="#">Register</a></li>
                <li><a href="${pageContext.request.contextPath}/rusafronend/changeLangage/1-/">English</a>
                <a href="${pageContext.request.contextPath}/rusafronend/changeLangage/2-/">मराठी</a></li>
            </ul>
            
           
        </div>
		
        <div class="clearfix"></div>        
    </div>
	


    	<!--  <div class="date">09 Dec, 2018 | 12:38 PM IST</div> -->
     <%--    <div class="top-right-menu">
        	
            <a href="#main-content" class="dropdown-arrow"><span>Skip to main content</span></a>
            <a href="#slider" class="dropdown-arrow"><span>Skip to navigation</span></a>
            <a href="javascript:void(0);" class="black" data-rel="." title=".">A</a>
            <a href="javascript:void(0);" class="white" data-rel="," title=",">A</a>
            <a href="javascript:void(0);" title="Text Size: Decrease" id="btn-decrease" class="decrease">A-</a>
            <a href="javascript:void(0);" title="Text Size: Normal" id="btn-orig" class="reset">A</a>
            <a href="javascript:void(0);" title="Text Size: Increase" id="btn-increase" class="increase">A+</a>
        	<a href="#">Login</a>
                <a href="#">Register</a>
                <a href="${pageContext.request.contextPath}/changeLangage/1-${mapping}">English</a>
                <a href="${pageContext.request.contextPath}/changeLangage/2-${mapping}">मराठी</a>
        </div>
		 --%>
        <div class="clearfix"></div>        
    </div>
    </html>