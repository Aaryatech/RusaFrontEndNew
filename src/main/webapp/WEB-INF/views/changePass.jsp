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
</head>
<body class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Change Password</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > >
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

					<h5>Change Password</h5>

				</div>
				<div class="col-12 col-sm-12 col-lg-3"></div>




				<div class="col-12 col-sm-12 col-lg-6">

					<form method="post"
						action="${pageContext.request.contextPath}/firstChangePassword"
						name="changePassform" id="changePassform">
						<div class="row row-eq-height">

							<div class="col-12 col-sm-12 col-lg-12" style="color: green;">
								Note :contain minimum 6 letter,one capital letter,one small letter, one digit, one special character</div>

							<!-- <div class="col-12 col-sm-12 col-lg-12">
								<div class="error_msg" id="error_msg" style="display: none">

									<div class="alert alert-warning" id="alertDiv"></div>

								</div>
							</div> -->
							<div class="col-12 col-sm-12 col-lg-12">
								<label>New Password</label> <input type="password"
									class="form-control" name="newPass" id="newPass"
									placeholder="Enter New Password" onchange="trim(this)"
									onkeyup="return passwordChanged();">
								<p class="error-msg" id="error_newpass" style="display: none">
									* Password Minimum 6</p>
							</div>


							<div class="col-12 col-sm-12 col-lg-12">
								<label>Confirm password</label> <input type="password"
									class="form-control" name="confirmPass" id="confirmPass"
									placeholder="Enter Confirm password" onchange="trim(this)">
								<p class="error-msg" id="error_confirmpass"
									style="display: none">* Confirm password.</p>
								<p class="error-msg" id="error_matchpass" style="display: none">
									* Password not matched.</p>
							</div>





							<div class="col-12 col-sm-12 col-lg-12">
								<p>
									<input id="checkbox1" type="checkbox" onclick="viewPassword()">
									<label for="apcat_price_rng[]-5">Show Password</label>
									<button type="submit" id="log-btn" class="button login-btn">Submit</button>
									<input type="hidden" id="allowPass" name="allowPass" value="0">
								</p>
								<!--    <button type="submit" id="log-btn" value="Submit" class="button login-btn"  onclick="Validate()">Save</button>
                               -->
							</div>



						</div>
					</form>
					<!-- 
                         <div class="form-group">
														<div class="col-sm-2">
															<input type="checkbox" onclick="viewPassword()">Show
															Password
														</div>
													</div> -->


				</div>





			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
	<script>
		function passwordChanged() {

			var strength = document.getElementById("error_newpass");

			var strongRegex = new RegExp(
					"^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$",
					"g");
			var mediumRegex = new RegExp(
					"^(?=.{6,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$",
					"g");
			var enoughRegex = new RegExp("(?=.{6,}).*", "g");
			var pwd = document.getElementById("newPass").value;

			if (pwd.length == 0) {
				document.getElementById("error_newpass").innerHTML = "Type Password";
				$('#error_newpass').show();
				document.getElementById("allowPass").value = 0;
			} else if (false == enoughRegex.test(pwd)) {
				document.getElementById("error_newpass").innerHTML = "More Characters";
				$('#error_newpass').show();
				document.getElementById("allowPass").value = 0;
			} else if (strongRegex.test(pwd)) {
				document.getElementById("error_newpass").innerHTML = "<span style='color:green'>Strong!</span>";
				$('#error_newpass').show();
				document.getElementById("allowPass").value = 1;
			} else if (mediumRegex.test(pwd)) {
				document.getElementById("error_newpass").innerHTML = "<span style='color:orange'>Medium!</span>";
				$('#error_newpass').show();
				document.getElementById("allowPass").value = 1;
			} else {
				document.getElementById("error_newpass").innerHTML = "<span style='color:red'>Weak!</span>";
				$('#error_newpass').show();
				document.getElementById("allowPass").value = 0;
			}
		}
	</script>
	<script type="text/javascript">
		$(document)
				.ready(
						function($) {

							$("#changePassform")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												var pass1 = $("#newPass").val();
												var pass2 = $("#confirmPass")
														.val();
												var allowPass = document
														.getElementById("allowPass").value;
												$('#error_confirmpass').hide();
												$('#error_matchpass').hide();

												if (!pass1 || allowPass == 0) {

													$('#error_newpass').show();
													return false;
												}
												if (!pass2 || pass2.length < 6) {

													$('#error_confirmpass')
															.show();
													return false;
												}

												if (pass1 != pass2) {

													$('#error_matchpass').show();
													return false;
												}

												return true;
											});
						});
	</script>

	<script type="text/javascript">
		function viewPassword() {
			var pass1 = document.getElementById("newPass");
			var pass2 = document.getElementById("confirmPass");

			if (pass1.type == "password" && pass2.type == "password") {
				pass1.type = "text";
				pass2.type = "text";
			} else {
				pass1.type = "password";
				pass2.type = "password";
			}
		}
	</script>
	<script type="text/javascript">
		function checkPassword(form) {
			password1 = form.newPass.value;
			password2 = form.confirmPass.value;

			// If password not entered 
			if (password1 == '')
				alert("Please enter Password");

			// If confirm password not entered 
			else if (password2 == '')
				alert("Please enter confirm password");

			// If Not same return False.     
			else if (password1 != password2) {
				alert("\nPassword did not match: Please try again...")
				return false;
			}

			// If same return True. 
			else {
				// alert("Password Match") 
				//return true;
			}
		}
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}
	</script>


</body>
</html>