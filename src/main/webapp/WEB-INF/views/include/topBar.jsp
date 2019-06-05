<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"
	import="java.text.SimpleDateFormat"%>

<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<c:url value="/changelang" var="changelang"></c:url>
<c:url value="/refreshtime" var="refreshtime"></c:url>
<body onload="display_ct();">
<div class="top-section">
	  <%-- <%
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("dd MMM,yyyy | hh:mm:ss a z ", Locale.ENGLISH);
		sf.setTimeZone(TimeZone.getTimeZone("IST"));
		out.print("<div class=\"date\">" + sf.format(date) + "</div>");
	%>  --%> <span id='demo'  class="date" ></span>
	<div class="top-right-menu">
		<ul>
			<li class="hide-mobile"><a href="#main-content"
				class="dropdown-arrow"><span>Skip to main content</span></a></li>
			<li class="hide-mobile"><a href="#slider" class="dropdown-arrow"><span>Skip
						to navigation</span></a></li>
			<li class="hide-mobile"><a
				href="${pageContext.request.contextPath}/screenReader"
				class="dropdown-arrow"><span>Screen Reader Access</span></a></li>
			<li class="hide-mobile"><a href="javascript:void(0);"
				class="black" data-rel="High Contrast" title="High Contrast">A</a> <a
				href="javascript:void(0);" class="white" data-rel="Low Contrast"
				title="Low Contrast">A</a></li>
			<li class="hide-mobile"><a href="avascript:void(0);"><strong>Text
						Size</strong></a> <a href="javascript:void(0);" title="Text Size: Decrease"
				id="btn-decrease" class="decrease">A-</a> <a
				href="javascript:void(0);" title="Text Size: Normal" id="btn-orig"
				class="reset">A</a> <a href="javascript:void(0);"
				title="Text Size: Increase" id="btn-increase" class="increase">A+</a></li>

			<%
				String contextPath = request.getContextPath();

				if (session.getAttribute("userInfo") == null) {

					out.print("<li class='login-re'><a href='" + contextPath + "/login'>Login</a> <a href='" + contextPath
							+ "/registration'>Register</a></li>");

				} else {
					out.print("<li class='login-re'><a href='" + contextPath + "/upcomingEvents'>My Account</a> <a href='"
							+ contextPath + "/logout'>Logout</a></li>");
				}
			%>

			<%-- <li class="login-re"><a
				href="${pageContext.request.contextPath}/login">Login</a> <a
				href="${pageContext.request.contextPath}/registration">Register</a></li> --%>
			<li>
				<%-- <a
				href="${pageContext.request.contextPath}/changeLangage/1-<%out.print(session.getAttribute("mapping"));%>">English</a>
				<a href="${pageContext.request.contextPath}/changeLangage/2-<%out.print(session.getAttribute("mapping"));%>">मराठी</a> --%>
				<a href="#" onclick="changelang(1);">English</a>
				<a href="#" onclick="changelang(2);">मराठी</a>
			</li>
		</ul>


	</div>

	<div class="clearfix"></div>
</div>


<div class="clearfix"></div>
</div>
</body>
<script>
	function changelang(id) {
		 
		//alert(id);
		$.getJSON('${changelang}', {

			id : id, 
			ajax : 'true',

		}, function(data) {
			 //alert(data);
			location.reload(true);
			 
		});

	}
	
	/* var myVar=setInterval(function () {myTimer()}, 1000);
	function myTimer() {
	    var date = new Date();
	    document.getElementById("demo").innerHTML = date.toISOString();
	} */
</script> 
 <%-- <script type="text/javascript"> 
function display_c(){
var refresh=1000; // Refresh rate in milli seconds
mytime=setTimeout('display_ct()',refresh)
}

function display_ct() {
 
	'<% Date date = new Date(); 
	SimpleDateFormat sf = new SimpleDateFormat("dd MMM,yyyy | hh:mm:ss a z ", Locale.ENGLISH);
			sf.setTimeZone(TimeZone.getTimeZone("IST"));%>';
	var date = "<%=sf.format(date)%>";
	//alert(date);
	document.getElementById('demo').innerHTML = date;
	display_c(); 
 }
</script>  --%>
  <script type="text/javascript"> 
function display_c(){
	 
var refresh=1000; // Refresh rate in milli seconds
mytime=setTimeout('display_ct()',refresh)
}

function display_ct() {
/* var x = new Date()
document.getElementById('demo').innerHTML = x; */
$.getJSON('${refreshtime}', { 
	ajax : 'true',

}, function(data) {
	 //alert(data);
	document.getElementById('demo').innerHTML = data.msg;
	display_c();
});

 }
</script> 

</html>