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
                    <div class="col-12 col-sm-4 col-lg-3">
                        <h6>Contact Us</h6>
                        <p>Unit No.7, 19th floor, Center No. 1,
                         World Trade Centre, Cuffe Parade,<br>
                            Colaba, Mumbai-400005.<br>
                            Phone: 011 - 49725600
                        </p>
                    </div>
                    <div class="col-12 col-sm-5 col-lg-5">
                        <h6>Important Links</h6>
                        <ul>
                            <li><a href="/">Home</a></li>
                            <li><a href="https://www.ugc.ac.in/">UGC</a></li>
                            <li><a href="https://mhrd.gov.in/">MHRD</a></li>
                            <li><a href="http://www.naac.gov.in/">NAAC</a></li>
                            <li><a href="https://www.maharashtra.gov.in/1125/Home">Maharashtra government</a></li>
                         
                          <li><a href=" http://aishe.gov.in/aishe/aisheCode">AISHE code</a></li>
                          <li><a href="${pageContext.request.contextPath}/siteMap">Site Map</a></li>
                        </ul>
                    </div>
                    <div class="col-12 col-sm-4 col-lg-4 social-link">
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
                    	   
                       			  <c:if test="${socialChannelData[3].isActive==1}">
                       			<a href="${socialChannelData[2].urllinks}" target="_blank"><span class="icon-linkedin-logo"></span></a>
                       			</c:if>
                       			<c:if test="${socialChannelData[3].isActive==1}">
                       			
                       				<a href="${socialChannelData[3].urllinks}" class="skype"><span><img src="${pageContext.request.contextPath}/resources/images/index.png"></span></a>
                       		
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
          <c:if test="${setting[0].isActive==1}">
          ${setting[0].keyValues}
          </c:if>
      <!--   Go to www.addthis.com/dashboard to customize your tools -->
<!-- <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5c812bc21e70ebf7"></script>
 -->
  <c:if test="${setting[4].isActive==1}">
    ${setting[4].keyValues}+1
  </c:if>