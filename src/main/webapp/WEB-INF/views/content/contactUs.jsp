<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<script src="https://www.google.com/recaptcha/api.js"></script>
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<c:choose>
	<c:when test="${not empty pageMetaData.pageMetaTitle}">
		<meta name="description" content="${pageMetaData.pageMetaDescription}">
		<title>${pageMetaData.pageMetaTitle}</title>
	</c:when>
	<c:otherwise>
		<meta name="description"
			content="${sessionScope.homePageMetaData.metaDescription}">

		<title>${sessionScope.homePageMetaData.siteTitle}</title>
	</c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/include/meta.jsp"></jsp:include>

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
</style>

</head>
<body class="${contrast}">
	<c:url var="verifyCaptcha" value="/verifyCaptcha" />
	<c:url var="checkMaintainance" value="/checkMaintainance" />
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Contact Us</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/ContactUs">Contact Us</a>
		</div>
	</div>

	<div class="container main-content" id="main-content">

		<div class="row row-eq-height">



			<div class="col-12 col-sm-12 col-lg-12 right-Colm">



				<div class="row row-eq-height">

					<div class="col-12 col-sm-12 col-lg-6">
						<h2>Rashtriya Uchchatar Shiksha Abhiyan</h2>
						<p>State Project Directorate (SPD), Rashtriya Uchchatar
							Shiksha Abhiyan (RUSA) Maharashtra, 18th Floor, Centre 1, World
							Trade Centre, Cuffe Parade, Colaba, Mumbai - 400005.</p>
						<!-- <iframe class="map"
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d60304.577356534086!2d72.89611441799786!3d19.149897683543813!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7b86e528cb077%3A0xbeb39574202b3e0e!2sRusa+International!5e0!3m2!1sen!2sin!4v1549861576012"
							style="border: 0" allowfullscreen="" width="100%" height="540"
							frameborder="0"></iframe> -->

						<!-- <iframe class="map" width="100%" height="540"
							src="https://maps.google.com/maps?width=100%&amp;height=600&amp;hl=en&amp;q=IDBI%20TOWERS%2C%20Cuffe%20Parade%2C%20Mumbai%2C%20Maharashtra%20400005+(My%20Business%20Namsse)&amp;ie=UTF8&amp;t=p&amp;z=18&amp;iwloc=B&amp;output=embed"
							frameborder="0" style="border: 0" allowfullscreen=""> </iframe> -->

						<iframe
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4944.55328848016!2d72.81545531489864!3d18.914606687180793!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7d1d2659eb285%3A0xc2c90000ec7ef672!2sSPD+RUSA+Maharashtra!5e1!3m2!1sen!2sin!4v1559551333875!5m2!1sen!2sin"
							class="map" width="100%" height="540" frameborder="0"
							style="border: 0" allowfullscreen></iframe>

					</div>

					<div class="col-12 col-sm-12 col-lg-6">



						<%-- <c:if test="${flag=='1'}">
							<div style="color: red;">Please Verify ReCaptcha</div>
						</c:if> --%>

						<div class="container" id="main-content">
							<c:if test="${sessionScope.success != null}">

								<div class="alert alert-success ">
									<button type="button" class="close" data-dismiss="alert"
										aria-label="Close">
										<span aria-hidden="true">×</span>
									</button>
									<strong>Success : </strong> ${success}
								</div>

							</c:if>
							<%
								session.removeAttribute("success");
							%>
							<c:if test="${sessionScope.errorMsg != null}">

								<div class="alert alert-danger ">
									<button type="button" class="close" data-dismiss="alert"
										aria-label="Close">
										<span aria-hidden="true">×</span>
									</button>
									<strong>Error : </strong> ${errorMsg}
								</div>

							</c:if>
							<%
								session.removeAttribute("errorMsg");
							%>

						</div>

						<form action="${pageContext.request.contextPath}/insertContactUs"
							method="post" id="submitForm">
							<p>
								<strong>Please send your message</strong>
							</p>
							<div class="row">
								<div class="col-12 col-sm-4 col-lg-4">
									<input type="radio" name="formType" value="Query" checked
										id="radio1"> <label for="radio1"></label> <span>Query</span>
								</div>


								<div class="col-12 col-sm-4 col-lg-4">
									<input type="radio" name="formType" value="Feedback"
										id="radio2"> <label for="radio2"></label> <span>Feedback</span>
								</div>



								<!-- <div class="col-12 col-sm-6 col-lg-3">
									<input type="radio" name="formType" value="Message" id="radio3">
									<label for="radio3"></label> <span>Message</span>
								</div> -->
							</div>

							<br> <label>Your Name</label> <input type="text"
								class="form-control" name="name" id="name" placeholder="Name"
								autocomplete="off" onchange="trim(this)">
							<p class="error-msg" id="error_name" style="display: none;">Please
								Enter Your Name</p>

							<label>Your Email</label> <input type="text" class="form-control"
								name="email" id="email" placeholder="Email" autocomplete="off"
								onchange="trim(this)">
							<p class="error-msg" id="error_email" style="display: none;">Please
								Enter Valid Email</p>
							<label>Phone Number</label> <input type="text"
								class="form-control" name="mobileNo" id="mobileNo" maxlength=10
								placeholder="Mobile Number" autocomplete="off"
								onchange="trim(this)">
							<p class="error-msg" id="error_mobile" style="display: none;">Please
								Enter Valid Mobile No.</p>
							<label>Your Message</label>
							<textarea name="message" id="message" class="form-control"
								placeholder="Message" onchange="trim(this)"></textarea>
							<p class="error-msg" id="error_msg" style="display: none;">Required
								Field</p>

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

							<!-- <span class="msg-error error" id="error_capmsg"
								style="display: none; color: red; margin-bottom: 5px; margin-top: 5px;">Invalid
								Text ! </span> -->
							<p class="error-msg" id="error_capmsg" style="display: none;">Invalid
								Text !</p>
							<br>
							<button class="button send" id="btn-validate" type="button"
								onclick="verifyCaptcha()">
								<span>Send</span>
							</button>
							<input type="hidden" name="accept" id="accept" value="0">
							<!-- <button class="button send" id="captchaRef" type="button">
								<span>resend captcha </span>
							</button> -->
						</form>
					</div>


				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	<!-- JavaScript-->
	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>

	<!-- <script type="text/javascript">
		$(document).ready(function($) {

			$("#submitContactUs").submit(function(e) {
				var isError = false;
				var errMsg = "";

				var captcha = $("#captcha").val();

				
				
				/* var radioValue = $("input[name='formType']:checked").val();

				if (radioValue < 3 && !$("#message").val()) {

					$("#error_msg").show();
					return false;
				} else {
					$("#error_msg").hide();

				}

				return true; */
			});
		});
	</script> -->

	<!-- <script type="text/javascript">
		$('#btn-validate').click(function(e) {

			$("#error_msg").hide();
			   
				verifyCaptcha();
		  
		})
	</script> -->
	<script type="text/javascript">
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}

		function validateEmail(email) {

			var eml = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

			if (eml.test($.trim(email)) == false) {

				return false;

			}

			return true;

		}
		function validateMobile(mobile) {
			var mob = /^[1-9]{1}[0-9]{9}$/;

			if (mob.test($.trim(mobile)) == false) {

				//alert("Please enter a valid email address .");
				return false;

			}
			return true;

		}
	</script>

	<script>
		function validate() {

			var isError = false;
			var errMsg = "";
			$("#error_email").hide();
			$("#error_mobile").hide();
			$("#error_name").hide();
			$("#error_msg").hide();
			$("#error_capmsg").hide();

			if (!$("#name").val()) {

				isError = true;

				$("#error_name").show()
				//return false;
			}

			if (!$("#email").val() || !validateEmail($("#email").val())) {

				isError = true;

				if (!$("#email").val()) {
					document.getElementById("error_email").innerHTML = "This field is required.";
				} else {
					document.getElementById("error_email").innerHTML = "Enter valid email.";
				}

				$("#error_email").show()

			}

			if (!$("#mobileNo").val() || !validateMobile($("#mobileNo").val())) {

				isError = true;

				if (!$("#mobileNo").val()) {
					document.getElementById("error_mobile").innerHTML = "This field is required.";
				} else {
					document.getElementById("error_mobile").innerHTML = "Enter valid Mobile No.";
				}

				$("#error_mobile").show()

			}

			if (!$("#message").val()) {

				isError = true;

				$("#error_msg").show()

			}
			if (!$("#captcha").val()) {

				isError = true;

				document.getElementById("error_capmsg").innerHTML = "This filed required";
				$("#error_capmsg").show();

			}

			if (!isError) {
				return false;
			}

			return true;

		}
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

	<script type="text/javascript">
		$(document).ready(function() {

			$.ajaxSetup({
				cache : false
			});

			var timestamp = (new Date()).getTime();

			$("#captchaRef").click(function() {

				var timestamp = (new Date()).getTime();
				var newSrc = $("#captchaImage").attr("src").split("?");
				//  $('#captchaImage').attr('src', '').attr('src', 'Captcha.jpg');
				newSrc = newSrc[0] + "?" + timestamp;
				$("#captchaImage").attr("src", newSrc);
				$("#captchaImage").slideDown("fast");

			});
		});
	</script>
</body>
</html>