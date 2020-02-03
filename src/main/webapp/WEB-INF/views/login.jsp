<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	//allow access only if session exists
	//	HttpSession session = request.getSession();
	String user = null;
	if (session.getAttribute("menuList") == null) {
		String mapping = (String) session.getAttribute("mapping");
		String contextPath = request.getContextPath();
		contextPath = contextPath + "/retriveSession/" + mapping;
		response.sendRedirect(contextPath);
	}
%>


 
<%@ page import="java.util.UUID"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.math.BigInteger"%>



<%
												UUID uuid = UUID.randomUUID();
													MessageDigest md = MessageDigest.getInstance("MD5");
													byte[] messageDigest = md.digest(String.valueOf(uuid).getBytes());
													BigInteger number = new BigInteger(1, messageDigest);
													String hashtext = number.toString(16);
													session = request.getSession();
													session.setAttribute("generatedKey", hashtext);
											%>

 
											
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description"
	content="${sessionScope.homePageMetaData.metaDescription}">
<meta name="author"
	content="${sessionScope.homePageMetaData.metaAuthor}">
<title>${sessionScope.homePageMetaData.siteTitle}</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<!-- Bootstrap core CSS -->
<script src="https://www.google.com/recaptcha/api.js"></script>
<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>

<script>
	var strMsg = "This link will take you to extneranl web site.";
	var strMsgPdf = "PDF file that opens in a new window.";
</script>
<script>
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id))
			return;
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=2318373708408139";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
</script>
<style type="text/css">
msg-error {
	color: #c65848;
}

.g-recaptcha.error {
	border: solid 2px #c64848;
	padding: .2em;
	width: 19em;
}

.other-gov-site-home {
	margin-top: 43px;
}
.img-responsive{
max-width:20px!important;
}
</style>

</head>
<body class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>

	<c:url var="verifyCaptcha" value="/verifyCaptcha" />

	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Login</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/login">Login</a> >
		</div>
	</div>



	<div class="login">
		<div class="container" id="main-content">
			<c:if test="${sessionScope.success != null}">
				<div class="col-12 col-sm-12 col-lg-12 ">
					<div class="alert alert-success ">
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
						<strong>Success : </strong> ${success}
					</div>
				</div>
			</c:if>
			<%
				session.removeAttribute("success");
			%>
			<c:if test="${sessionScope.errorMsg != null}">
				<div class="col-12 col-sm-12 col-lg-12 ">
					<div class="alert alert-danger ">
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
						<strong>Error : </strong> ${errorMsg}
					</div>
				</div>
			</c:if>
			<%
				session.removeAttribute("errorMsg");
			%>



			<div class="row row-eq-height login-box">

				<div class="col-12 col-sm-12 col-lg-12 login-header">

					<h5>Login</h5>
					<p>Note : Only for Uploading the requisite Document To RUSA
						Maharashtra</p>
				</div>
				<div class="col-12 col-sm-12 col-lg-3"></div>




				<div class="col-12 col-sm-12 col-lg-6">

					<form method="post" id="login_form"
						action="${pageContext.request.contextPath}/loginResponse"
						name="login_form">
						
						<input type="hidden" value="<%out.println(hashtext);%>"
												name="token" id="token">
						
						
						<label>User Name</label> <input type="text" class="form-control"
							name="userName" placeholder="User Name" autocomplete="off">
						<label>Password</label> <input type="password"
							class="form-control" name="password" placeholder="Password"
							autocomplete="off">

						<div class="capcha-img">
							<img src="${pageContext.request.contextPath }/captcha"
								id='captchaImage'>
						</div>
						<br> <input type="text" class="form-control capcha-input"
							name="captcha" id="captcha" placeholder="Enter Text"
							autocomplete="off" onchange="trim(this)">
							
							

						<button id="captchaRef" type="button" class="repeat-btn">
							<div class="repeat">
								<img
									src="${pageContext.request.contextPath}/resources/images/repeat.png"
									alt="Repeat" class="img-responsive" title="Repeat">
							</div>
						</button>

					<span class="msg-error error" id="error_captcha"
						style="display: none; color: red; margin-bottom: 5px; margin-top: 5px;">Invalid
						Text ! </span> 
						
						<br>


						<div class="clearfix"></div>
						<p>
							<button type="submit" id="log-btn" value="submit"
								class="button login-btn">Login</button>
						</p>
						<c:choose>
							<c:when test="${eventId!=null}">
								<input type="hidden" name="eventId" id="eventId"
									value="${eventId}">
								<input type="hidden" name="file" id="file" value="${file}">
							</c:when>
							<c:otherwise>
								<input type="hidden" name="eventId" id="eventId" value="0">
								<input type="hidden" name="file" id="file" value="0">
							</c:otherwise>
						</c:choose>
					</form>

					<p>
						Need an account? <a
							href="${pageContext.request.contextPath}/registration">Create
							account</a> &nbsp &nbsp &nbsp
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp

						<a href="${pageContext.request.contextPath}/forgetPass">Forgot
							Password</a>
					</p>

				</div>

				<div class="col-12 col-sm-12 col-lg-3"></div>
			</div>
		</div>
	</div>


	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
	<script type="text/javascript">
	$(document).ready(function($){
		
		$("#login_form").submit(function(e) {
		
			var isError=false;
			 var errMsg="";    
				
				if(!$("#captcha").val()){ 					 
    				isError=true;   				
    				
    				$("#error_captcha").show()
    			} else {
    				$("#error_captcha").hide()
    			}
				 
				
				
            	 if (!isError) {
            		return  true;
				}
					return false;
			});
});
	</script>
	
	<script>
		document.oncontextmenu = document.body.oncontextmenu = function() {
			return false;
		}

		
		$(document).ready(function() {

			$.ajaxSetup({
				cache : false
			});

			var timestamp = (new Date()).getTime();

			$("#captchaRef").click(function() {
				document.getElementById('captcha').value = "";
				var timestamp = (new Date()).getTime();
				var newSrc = $("#captchaImage").attr("src").split("?");
				//  $('#captchaImage').attr('src', '').attr('src', 'Captcha.jpg');
				newSrc = newSrc[0] + "?" + timestamp;
				$("#captchaImage").attr("src", newSrc);
				$("#captchaImage").slideDown("fast");

			});
		});
	</script>
	<script>
		function verifyCaptcha() {

			//alert(validate());

			if (validate() == false) {
				var captcha = $("#captcha").val();
				//alert(captcha);
				$("#error_capmsg").hide();

				var flag = 0;

				if (captcha != "") {
					$
							.getJSON(
									'${verifyCaptcha}',
									{

										captcha : captcha,
										ajax : 'true',

									},
									function(data) {
										if (data.error == true) {
											document.getElementById("captcha").value = "";
											document
													.getElementById("error_capmsg").innerHTML = "Invalid Text !";
											$("#error_capmsg").show();
											document.getElementById(
													"captchaRef").click();
											document.getElementById("accept").value = 0;
											flag = 0;
										} else {
											document.getElementById("accept").value = 1;
											flag = 1;
											document.getElementById(
													"submitForm").submit();
										}
									});

				} else {
					document.getElementById("error_capmsg").innerHTML = "This filed required";
					$("#error_capmsg").show();
					document.getElementById("accept").value = 0;
					return true;
				}
			}

		}
	</script>
</body>
</html>