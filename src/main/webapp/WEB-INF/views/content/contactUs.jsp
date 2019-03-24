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
<script src="https://www.google.com/recaptcha/api.js"></script>
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<c:choose>
	<c:when test="${not empty pageMetaData.pageMetaTitle}">
		<meta name="description" content="${pageMetaData.pageMetaDescription}">
		<link rel="icon" href="../../favicon.ico">
		<title>${pageMetaData.pageMetaTitle}</title>
	</c:when>
	<c:otherwise>
		<meta name="description"
			content="${sessionScope.homePageMetaData.metaDescription}">
		<link rel="icon" href="../../favicon.ico">
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
</style>

</head>
<body>
	<c:url var="checkMaintainance" value="/checkMaintainance" />
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>${pageContent.pageName}</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<%-- <a href="index.html">Home</a> > <a href="${pageContext.request.contextPath}/info/${pageContent.slugName}">${pageContent.pageName}</a> > --%>
		</div>
	</div>

	<div class="container main-content" id="main-content">
		<div class="row">
			<div class="col-12 col-sm-12 col-lg-12 ">
				<iframe class="map"
					src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d60304.577356534086!2d72.89611441799786!3d19.149897683543813!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7b86e528cb077%3A0xbeb39574202b3e0e!2sRusa+International!5e0!3m2!1sen!2sin!4v1549861576012"
					style="border: 0" allowfullscreen="" width="100%" height="350"
					frameborder="0"></iframe>
			</div>
		</div>
		<div class="row row-eq-height">


			<%-- <div class="col-12 col-sm-3 col-lg-3">
				<div class="leftColm">
					<c:forEach items="${sessionScope.menuList.sectionlist}"
						var="menuList">
						<c:if test="${menuList.sectionId==pageMetaData.sectionId}">
							<h3>${menuList.sectionName}</h3>
							<ul class="menu">

								<c:forEach items="${sessionScope.menuList.categoryList}"
									var="catList">
									<!-- class="active" -->

									<c:if test="${catList.sectionId==pageMetaData.sectionId}">
										<li><c:choose>
												<c:when test="${not empty catList.externalUrl}">
													<a  onclick="checkMaintainance()"
														title="${catList.catName}"
														href="${pageContext.request.contextPath}/${catList.externalUrl}">${catList.catName}<span
														class="caret"></span></a>
												</c:when>
												<c:otherwise>
													<a   onclick="checkMaintainance()"
														title="${catList.catName}"
														href="${pageContext.request.contextPath}/info/${catList.slugName}">${catList.catName}<span
														class="caret"></span></a>
												</c:otherwise>
											</c:choose> </li>
									</c:if>

								</c:forEach>
							</ul>

						</c:if>
					</c:forEach>

				</div>
			</div> --%>
			<div class="col-12 col-sm-12 col-lg-12 right-Colm">



				<div class="row row-eq-height">

					<div class="col-12 col-sm-12 col-lg-12 right-Colm">


						<h2>Rashtriya Uchchatar Shiksha Abhiyan</h2>

						<p>
							Unit No.7, 19th floor, Center No. 1, World Trade Centre, Cuffe
							Parade,<br> Colaba, Mumbai-400005.<br> Phone: 011 -
							49725600
						</p>
						<c:if test="${flag=='1'}">
							<div style="color: red;">Please Verify ReCaptcha</div>
						</c:if>
						<%-- 	<c:choose>
								<c:when test="test="${flag=='0'}">
												
								</c:when>
								<c:otherwise>
								</c:otherwise>
												
							</c:choose> --%>


						<form action="${pageContext.request.contextPath}/insertContactUs"
							onsubmit="return confirm('Do you really want to submit the form?');"
							method="post">

							<div class="form-check-inline">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="formType" value="Query" checked>
									Query
								</label>
							</div>
							<div class="form-check-inline">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="formType" value="Feedback">
									Feedback
								</label>
							</div>
							<div class="form-check-inline disabled">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="formType" value="Message">
									Message
								</label>
							</div>
							<br> <label>Your Name</label> <input type="text"
								class="form-control" name="name" id="name" placeholder="Name"
								required> <label>Your Email</label> <input type="email"
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
							<button class="btn" id="btn-validate" type="submit">
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