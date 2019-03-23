<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" 
  import = "java.text.SimpleDateFormat"%> 
 
   

<%
   Date date = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("dd MMM, yyyy | hh:mm a z", Locale.ENGLISH);	
   out.print( "<div class=\"date\">" +sf.format(date)+"</div>");
    
%>

  <div class="top-section">
 
        <div class="top-right-menu">
        	<ul>
            	<li><a href="#main-content" class="dropdown-arrow"><span>Skip to main content</span></a></li>
                <li> <a href="#slider" class="dropdown-arrow"><span>Skip to navigation</span></a></li>
                    <li> <a href="${pageContext.request.contextPath}/screenReader" class="dropdown-arrow"><span>Screen Reader Access</span></a></li>
           <li> <a href="javascript:void(0);" class="black" data-rel="High Contrast" title="High Contrast">A</a>
            <a href="javascript:void(0);" class="white" data-rel="Low Contrast" title="Low Contrast">A</a></li>
            <li><a href="avascript:void(0);"><strong>Text Size</strong></a>
            <a href="javascript:void(0);" title="Text Size: Decrease" id="btn-decrease" class="decrease">A-</a>
            <a href="javascript:void(0);" title="Text Size: Normal" id="btn-orig" class="reset">A</a>
            <a href="javascript:void(0);" title="Text Size: Increase" id="btn-increase" class="increase">A+</a></li>
        	<li class="login-re"><a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/registration">Register</a></li>
                <li><a href="${pageContext.request.contextPath}/changeLangage/1-/">English</a>
                <a href="${pageContext.request.contextPath}/changeLangage/2-/">मराठी</a></li>
            </ul>
            
           
        </div>
		
        <div class="clearfix"></div>        
    </div>
	

        <div class="clearfix"></div>        
    </div>
    </html>