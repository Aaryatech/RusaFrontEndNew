<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>


<footer>
	<div class="container">
		<div class="row">
			<div class="col-12 col-sm-12 col-lg-3">

				<c:set var="vistrcnt" value="Visitor Count"></c:set>
				<c:set var="update" value="Last Update"></c:set>
				<%
					int langId = 1;
					try {
						langId = (Integer) session.getAttribute("langId");

					} catch (Exception e) {
						session.setAttribute("langId", langId);
						langId = 1;
					}

					if (langId == 2) {
				%><h6>
					<b>संपर्क साधा</b>
				</h6>
				<%
					} else {
				%>
				<h6>Contact Us</h6>
				<%
					}
				%>
				<c:if test="${setting[8].isActive==1}">
          				 ${setting[8].keyValues}
       			 		  </c:if>
			</div>
			<div class="col-12 col-sm-12 col-lg-5 important-link">

				<%
					if (langId == 2) {
				%><h6>महत्त्वपूर्ण</h6>
				<%
					} else {
				%>
				<h6>Important Links</h6>
				<%
					}
				%>


				<c:if test="${setting[7].isActive==1}">
          				 ${setting[7].keyValues}
       			 		  </c:if>
				<%--  <ul>
                            <li><a href="/">Home</a></li>
                            <li><a href="https://www.ugc.ac.in/">UGC</a></li>
                            <li><a href="https://mhrd.gov.in/">MHRD</a></li>
                            <li><a href="http://www.naac.gov.in/">NAAC</a></li>
                            <li><a href="https://www.maharashtra.gov.in/1125/Home">Maharashtra government</a></li>
                         
                          <li><a href=" http://aishe.gov.in/aishe/aisheCode">AISHE code</a></li>
                          <li><a href="${pageContext.request.contextPath}/siteMap">Site Map</a></li>
                        </ul> --%>
			</div>
			<div class="col-12 col-sm-12 col-lg-4 social-link">

				<%
					if (langId == 2) {
				%><h6>अनुसरण कराः</h6>
				<c:set var="vistrcnt" value="अभ्यागत गणना "></c:set>
				<c:set var="update" value="शेवटचे अपडेट "></c:set>
				<%
					} else {
				%>
				<h6>Follow us on:</h6>
				<%
					}
				%>

				<%--  <c:forEach items="${socialChannelData}" var="socialChannel"
								varStatus="count">
								 --%>

				<c:if test="${socialChannelData[0].isActive==1}">
					<a href="${socialChannelData[0].urllinks}" target="_blank"><span
						class="icon-facebook55"></span></a>
				</c:if>
				<c:if test="${socialChannelData[1].isActive==1}">
					<a href="${socialChannelData[1].urllinks}" target="_blank"><span
						class="icon-twitter"></span></a>
				</c:if>

				<c:if test="${socialChannelData[3].isActive==1}">
					<a href="${socialChannelData[2].urllinks}" target="_blank"><span
						class="icon-linkedin-logo"></span></a>
				</c:if>
				<c:if test="${socialChannelData[3].isActive==1}">

					<a href="${socialChannelData[3].urllinks}" target="_blank"><span
						class="icon-youtube-logo"> </span></a>

				</c:if>
				<c:if test="${socialChannelData[4].isActive==1}">
					<a href="${socialChannelData[4].urllinks}" target="_blank"> <span
						class="icon-instagram-social-network-logo-of-photo-camera"></span></a>
				</c:if>

				<p>

					<c:if test="${settingcount[4].isActive==1}">
					 ${vistrcnt}:
						<span id="visitorCnt">${settingcount[4].keyValues}</span>
						<br>
					</c:if>
					<c:if test="${settingcount[5].isActive==1}">
					 ${update}:
						${settingcount[5].keyValues}
					</c:if>


				</p>



			</div>
		</div>
	</div>
</footer>
<div class="copy-right">
	Copyright 2018 RUSA, Govt. of Maharashtra. | <a href="#">Disclaimer</a>
	| <a href="#">Privacy Policy</a>
	<p>
		Design & Developed By: <a href="http://aaryatechindia.in/atsuc/"
			target="_blank">Aaryatech Solutions</a>
	</p>
</div>

<c:if test="${setting[0].isActive==1}">
          ${setting[0].keyValues}
          </c:if>


<!--   Go to www.addthis.com/dashboard to customize your tools -->
<!-- <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5c812bc21e70ebf7"></script>
 -->
