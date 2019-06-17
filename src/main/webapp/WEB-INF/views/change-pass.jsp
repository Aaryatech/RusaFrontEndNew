<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<c:url var="getPasswordCheck" value="/getPasswordCheck" />

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

<script type="text/javascript">
	/* /* $('#log_btn').click(
	 function(e) {
	 var password = document.getElementById("newPass").value;
	 var confirmPassword = document.getElementById("confirmPass").value;
	 alert(password);
	 //  alert(confirmPassword);
	 if (!password.match(confirmPassword)) {
	 alert("Passwords do not match.");
	 //e.preventDefault();

	 }
	
	 });
	 */

	function Validate() {
		var password = document.getElementById("newPass").value;
		var confirmPassword = document.getElementById("confirmPass").value;
		/// alert(password);
		//  alert(confirmPassword);

		if (password != confirmPassword) {
			alert("Passwords do not match.");
			$('#log_btn').attr('disabled', 'disabled');
		}
		$('#log_btn').removeAttr('disabled');
	}
</script>

</head>
<body class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<%-- <jsp:include page="/WEB-INF/views/include/topBarLogin.jsp"></jsp:include> --%>

	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Change Password</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/changePass">Change
				Password</a> >


		</div>
	</div>

	<div class="container" id="main-content">
		<div class="row row-eq-height">
			<jsp:include page="/WEB-INF/views/include/loginLeft.jsp"></jsp:include>

			<div class="col-12 col-sm-12 col-lg-9">
				<div class="right-Colm news-listing-page">
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
					<h2>Change Password</h2>

					<form method="post"
						action="${pageContext.request.contextPath}/changePassword"
						onSubmit="return checkPassword(this)" name="login_form">


						<div id="currentPassDiv" class="col-12 col-sm-12 col-lg-12">
							<div class="col-12 col-sm-12 col-lg-12">
								<label>Current password</label> <input type="password"
									class="form-control" name="pass" id="pass"
									placeholder="Current password" required>
								<p class="error-msg" id="error_msg" style="display: none">*
									Enter correct password.</p>
							</div>

							<div class="col-12 col-sm-12 col-lg-12">

								<button type="button" id="search" class="button login-btn"
									onclick="getCheck()">Submit</button>
								<!--    <button type="submit" id="log-btn" value="Submit" class="button login-btn"  onclick="Validate()">Save</button>
                               -->
							</div>
						</div>

						<div id="newPassDiv" style="display: none"
							class="col-12 col-sm-12 col-lg-12">
							<div class="col-12 col-sm-12 col-lg-12">
								<label>New Password</label> <input type="password"
									class="form-control" name="newPass" id="newPass"
									placeholder="New Password">
								<p class="error-msg" id="error_newpass" style="display: none">
									* Password Minimum 6</p>
							</div>

							<div class="col-12 col-sm-12 col-lg-12">
								<label>Confirm password</label> <input type="password"
									class="form-control" name="confirmPass" id="confirmPass"
									placeholder="Confirm password">
								<p class="error-msg" id="error_confirmpass"
									style="display: none">* Confirm password.</p>
								<p class="error-msg" id="error_matchpass" style="display: none">
									* Password not matched.</p>
							</div>




							<div class="col-12 col-sm-12 col-lg-12">

								<button type="submit" id="log-btn" class="button login-btn">Submit</button>
								<!--    <button type="submit" id="log-btn" value="Submit" class="button login-btn"  onclick="Validate()">Save</button>
                               -->
							</div>
						</div>

					</form>



				</div>
			</div>

		</div>
	</div>
	<br>


	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>

	<script type="text/javascript">
		function getCheck() {

			//	alert("hi");
			var pass = $("#pass").val();

			$('#error_newpass').hide();
			$('#error_confirmpass').hide();
			$('#error_matchpass').hide();

			$.getJSON('${getPasswordCheck}', {

				pass : pass,
				ajax : 'true',

			}, function(data) {

				if (data.error == true) {

					$('#error_msg').show();
				} else {

					$('#error_msg').hide();
					$('#currentPassDiv').hide();
					$('#newPassDiv').show();
				}
			}

			);

		}

		function upImage() {

			alert("hi");
			document.getElementById("myForm").submit();

		}
	</script>
	<script type="text/javascript">
		function checkPassword(form) {
			password1 = form.newPass.value;
			password2 = form.confirmPass.value;
			$('#error_newpass').hide();
			$('#error_confirmpass').hide();
			$('#error_matchpass').hide();

			// If password not entered 
			if (password1 == '' || password1.length < 6) {
				$('#error_newpass').show();
				return false;
			}
			// If confirm password not entered 
			else if (password2 == '') {
				$('#error_confirmpass').show();
				return false;
			}
			// If Not same return False.     
			else if (password1 != password2) {
				$('#error_matchpass').show();
				return false;
			}

			// If same return True. 
			else {
				// alert("Password Match") 
				return true;
			}
		}
	</script>
</body>
</html>