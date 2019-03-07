<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>
    <link href="../assets/fonts/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">
    <link rel="shortcut icon" href="../assets/images/favicon.png" type="image/x-icon">
 <footer>
            <div class="container">
                <div class="row">
                    <div class="col-12 col-sm-4 col-lg-4">
                        <h6>Contact Us</h6>
                        <p>Unit No.7, 19th floor, Center No. 1, World Trade Centre, Cuffe Parade,<br>
                            Colaba, Mumbai-400005.<br>
                            Phone: 011 - 49725600
                        </p>
                    </div>
                    <div class="col-12 col-sm-5 col-lg-5">
                        <h6>Useful Links</h6>
                        <ul>
                            <li><a href="index.html">Home</a></li>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Terms & Conditions</a></li>
                            <li><a href="#">Feedback</a></li>
                            <li><a href="${pageContext.request.contextPath}/siteMap">Site Map</a></li>
                            <li><a href="#">Associate with</a></li>
                            <li><a href="#">FAQ</a></li>
                              <li><a href="#">Recruitment</a></li>
                            <li><a href="#">MyGov in Media</a></li>
                            <li><a href="#">Website Policies</a></li>
                        </ul>
                    </div>
                    <div class="col-12 col-sm-3 col-lg-3 social-link">
                        <h6>Follow us on:</h6>
                         <%--  <c:forEach items="${socialChannelData}" var="socialChannel"
								varStatus="count">
								 --%>
										
                      <c:if test="${socialChannelData[0].isActive==1}">
                  			    <a href="${socialChannelData[0].urllinks}" target="_blank"><span class="icon-facebook55"></span></a>
                  			    </c:if>		
                  			      <c:if test="${socialChannelData[1].isActive==1}">						                     
                    	   <a href="${socialChannelData[1].urllinks}" target="_blank"><span class="icon-twitter"></span></a>
                    		 </c:if>
                    	   <c:if test="${socialChannelData[2].isActive==1}">
                       			<a href="${socialChannelData[2].urllinks}" target="_blank"><span class="icon-twitter"></span></a>
                       			</c:if>
                       			  <c:if test="${socialChannelData[3].isActive==1}">
                       			<a href="${socialChannelData[3].urllinks}" target="_blank"><span class="icon-linkedin-logo"></span></a>
                       			</c:if>
                       			  <c:if test="${socialChannelData[4].isActive==1}">
                       			<a href="${socialChannelData[4].urllinks}" target="_blank"><span class="icon-google-plus-logo"></span></a> 
                       			</c:if>
                       			
                  
                       <!--  <a href="#"><span class="icon-twitter"></span></a>
                        <a href="#"><span class="icon-youtube-logo"></span></a> -->
                      <%--   </c:forEach> --%>
                    </div>
                </div>
            </div>  
        </footer>
        <div class="copy-right">
            Copyright 2018 RUSA, Govt. of Maharashtra. | <a href="#">Disclaimer</a> | <a href="#">Privacy Policy</a>
            <p>Design & Developed By: <a href="http://aaryatechindia.in/atsuc/" target="_blank">Aaryatech Solutions</a></p>
        </div>