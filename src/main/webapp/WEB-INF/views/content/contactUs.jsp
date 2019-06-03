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
						<p>
							Unit No.7, 19th floor, Center No. 1, World Trade Centre, Cuffe
							Parade,<br> Colaba, Mumbai-400005.<br> Phone: 011 -
							49725600
						</p>
						<!-- <iframe class="map"
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d60304.577356534086!2d72.89611441799786!3d19.149897683543813!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7b86e528cb077%3A0xbeb39574202b3e0e!2sRusa+International!5e0!3m2!1sen!2sin!4v1549861576012"
							style="border: 0" allowfullscreen="" width="100%" height="540"
							frameborder="0"></iframe> -->

						<!-- <iframe class="map" width="100%" height="540"
							src="https://maps.google.com/maps?width=100%&amp;height=600&amp;hl=en&amp;q=IDBI%20TOWERS%2C%20Cuffe%20Parade%2C%20Mumbai%2C%20Maharashtra%20400005+(My%20Business%20Namsse)&amp;ie=UTF8&amp;t=p&amp;z=18&amp;iwloc=B&amp;output=embed"
							frameborder="0" style="border: 0" allowfullscreen=""> </iframe> -->

						<iframe
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4944.55328848016!2d72.81545531489864!3d18.914606687180793!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7d1d2659eb285%3A0xc2c90000ec7ef672!2sSPD+RUSA+Maharashtra!5e1!3m2!1sen!2sin!4v1559551333875!5m2!1sen!2sin"
							class="map" width="100%" height="540" frameborder="0" style="border: 0"
							allowfullscreen></iframe>

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
							method="post">
							<p>
								<strong>Please send your message</strong>
							</p>
							<div class="row">
								<div class="col-12 col-sm-6 col-lg-3">
									<input type="radio" name="formType" value="Query" checked
										id="radio1"> <label for="radio1"></label> <span>Query</span>
								</div>


								<div class="col-12 col-sm-6 col-lg-3">
									<input type="radio" name="formType" value="Feedback"
										id="radio2"> <label for="radio2"></label> <span>Feedback</span>
								</div>



								<div class="col-12 col-sm-6 col-lg-3">
									<input type="radio" name="formType" value="Message" id="radio3">
									<label for="radio3"></label> <span>Message</span>
								</div>
							</div>

							<br> <label>Your Name</label> <input type="text"
								class="form-control" name="name" id="name" placeholder="Name"
								required>
							<!-- <p class="error-msg">Please Enter Your Name</p> -->
							<label>Your Email</label> <input type="email"
								class="form-control" name="email" id="email" placeholder="Email"
								required> <label>Phone Number</label> <input type="text"
								class="form-control" name="mobileNo" id="mobileNo"
								pattern="[7-9]{1}[0-9]{9}" maxlength=10
								placeholder="Mobile Number" required> <label>Your
								Message</label>
							<textarea name="message" id="message" class="form-control"
								placeholder="Message"></textarea>
							<br> <span class="msg-error error"></span>
							<div id="recaptcha" class="g-recaptcha" data-sitekey="${siteKey}"></div>
							</br>
							<button class="button send" id="btn-validate" type="submit">
								<span>Send</span>
							</button>
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

	<script type="text/javascript">
		$('#btn-validate').click(
				function(e) {
					var $captcha = $('#recaptcha'), response = grecaptcha
							.getResponse();

					if (response.length === 0) {
						$('.msg-error').text("reCAPTCHA is mandatory");
						if (!$captcha.hasClass("error")) {
							$captcha.addClass("error");
						}
						e.preventDefault();
					} else {
						$('.msg-error').text('');
						$captcha.removeClass("error");
						//  alert( 'reCAPTCHA marked' );
					}
				})
	</script>
	<script>
		function checkMaintainance() {

		}
	</script>
</body>
</html>