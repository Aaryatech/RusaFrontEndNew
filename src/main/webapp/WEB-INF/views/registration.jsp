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
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chosen.css">
<meta name="description"
	content="${sessionScope.homePageMetaData.metaDescription}">
<meta name="author"
	content="${sessionScope.homePageMetaData.metaAuthor}">
<title>${sessionScope.homePageMetaData.siteTitle}</title>

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
	<c:url value="/getInstituteInformation" var="getInstituteInfo"></c:url>
	<c:url value="/getAshecodeByInstiid" var="getAshecode"></c:url>
	<c:url value="/getInstitute" var="getInstituteList"></c:url>
	<c:url value="/checkUniqueField" var="checkUniqueField"></c:url>
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Registration</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/registration">Registration</a>
			>
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
			<div class="login-box register-box">
				<div class="login-header">
					<h5>Register</h5>
					<p>Note : Only for Uploading the requisite Document To RUSA
						Maharashtra</p>
				</div>
				<form
					action="${pageContext.request.contextPath}/insertUserRegistration"
					method="post" name="login_form" id="submitForm">
					<div class="row row-eq-height" id="typeDiv">
						<div class="col-12 col-sm-12 col-lg-3"></div>
						<div class="col-12 col-sm-12 col-lg-3"></div>
						<div class="col-12 col-sm-12 col-lg-3"></div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Select Type </label>
							<!-- <select
								id="userType" name="userType" class="form-control"
								onchange="showForm()" required>

								<option value="1">Individual</option>
								<option value="2">Colleges</option>
								<option value="3">University</option>
							</select> -->
							<div class="row">
								<div class="col-12 col-sm-6 col-lg-3">
									<input type="radio" name="userType" value="1" id="userType1"
										onchange="showForm(1)"> <label for="userType1"></label>
									<span>Individual</span>
								</div>


								<div class="col-12 col-sm-6 col-lg-3">
									<input type="radio" name="formType" value="2" id="userType2"
										onchange="showForm(2)"> <label for="userType2"></label>
									<span>Institute</span>
								</div>

								<div class="col-12 col-sm-6 col-lg-3">
									<input type="radio" name="formType" value="3" id="userType3"
										onchange="showForm(3)"> <label for="userType3"></label>
									<span>University</span>
								</div>
							</div>
						</div>
					</div>



					<div class="col-12 col-sm-12 col-lg-3"></div>

					<div class="form-group row row-eq-height" style="display: none;"
						id="individual">

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Select University<span class="text-danger">*</span>
							</label> <select id="university" name="university" class="form-control"
								onchange="getInstituteList()">
								<option value="">Select University</option>
								<c:forEach items="${universityList}" var="universityList">
									<option value="${universityList.uniId}">${universityList.uniName}</option>
								</c:forEach>
							</select>
							<p class="error-msg" id="error_university" style="display: none;">Please
								Select University</p>
							<!-- <input type="text" class="form-control" name="university"
								onchange="trim(this)" placeholder="University Affiliated"
								id="uniAff" required> chosen-select-->
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label> Select Institute <span class="text-danger">*</span></label>
							<!-- <input
								type="text" class="form-control" name="collegeName"
								onchange="trim(this)" placeholder="College Name"
								id="collegeName"> -->
							<select id="collegeName" name="collegeName" class="form-control"
								onchange="getAshecode()">
								<option value="">Select Institute</option>
							</select>
							<p class="error-msg" id="error_collegeName"
								style="display: none;">Please Select Institute</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>AISHE Code </label> <input type="text"
								class="form-control" name="indAshecode" onchange="trim(this)"
								placeholder="AISHE Code" id="indAshecode" readonly>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">

							<label>Full Name <span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="name" placeholder="Name"
								onchange="trim(this)" id="name">
							<p class="error-msg" id="error_name" style="display: none;">Please
								Enter Full Name</p>
						</div>


						<div class="col-12 col-sm-12 col-lg-6">
							<label>Designation of Person <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="inddesognation"
								onchange="trim(this)" placeholder="Designation of Person"
								id="inddesognation">
							<p class="error-msg" id="error_inddesognation"
								style="display: none;">Required Field.</p>
						</div>
						<div class="col-12 col-sm-12 col-lg-6">

							<label>Name of Department <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="depatment"
								onchange="trim(this)" placeholder="Name of Department"
								id="depatment">
							<p class="error-msg" id="error_depatment" style="display: none;">Required
								Field.</p>
						</div>



						<div class="col-12 col-sm-12 col-lg-6">
							<label>Mobile No.<span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="mobile"
								onchange="checkUnique(this.value,1,1)" maxlength="10"
								placeholder="Mobile No." id="mobile">
							<p class="error-msg" id="error_mobile" style="display: none;">Required
								Field.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Email-ID <span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="email"
								onchange="checkUnique(this.value,2,1)" placeholder="Email"
								id="email">
							<p class="error-msg" id="error_email" style="display: none;">Required
								Field.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Alternate Email-ID</label> <input type="text"
								onchange="trim(this)" class="form-control" name="altEmail"
								placeholder="Alternate Email" id="altEmail">
							<p class="error-msg" id="error_altEmail" style="display: none;">Enter
								Valid Email.</p>
						</div>
					</div>


					<div class="form-group row row-eq-height" style="display: none"
						id="college">

						<div class="col-12 col-sm-12 col-lg-6">
							<label>AISHE Code <span class="text-danger">*</span>
							</label> <input type="text" class="form-control"
								onchange="trim(this);getInstituteInfo()" name="instiaisheCode"
								placeholder="AISHE Code" value="C-" id="instiaisheCode"
								maxlength="7" style="text-transform: uppercase">
							<p class="error-msg" id="error_instiaisheCode"
								style="display: none;">Invalid AISHE Code.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>University Name </label> <input type="text"
								class="form-control" name="univ" onchange="trim(this)"
								placeholder="University Affiliated" id="univ" readonly>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Institute Name </label> <input type="text"
								class="form-control" name="institute" placeholder="College Name"
								id="institute" readonly>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Authorized Person Name <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="cAuthour"
								onchange="trim(this)" placeholder="Authorized Person Name"
								id="cAuthour">
							<p class="error-msg" id="error_cAuthour" style="display: none;">Required
								Field.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Designation of Person<span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="instidesignation"
								placeholder="Designation of Person" onchange="trim(this)"
								id="instidesignation">
							<p class="error-msg" id="error_instidesignation"
								style="display: none;">Required Field.</p>
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Name of Department <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="instiDept"
								onchange="trim(this)" placeholder="Name of Department"
								id="instiDept">
							<p class="error-msg" id="error_instiDept" style="display: none;">Required
								Field.</p>
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Mobile No.<span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="instiMobile"
								onchange="checkUnique(this.value,1,2)" maxlength="10"
								placeholder="Mobile No." id="instiMobile">
							<p class="error-msg" id="error_instiMobile"
								style="display: none;">Required Field.</p>
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Email-ID <span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="instiEmail"
								onchange="checkUnique(this.value,2,2)" placeholder="Email"
								id="instiEmail">
							<p class="error-msg" id="error_instiEmail" style="display: none;">Required
								Field.</p>
						</div>


						<div class="col-12 col-sm-12 col-lg-6">
							<label>Alternate Email-ID</label> <input type="text"
								class="form-control" name="instialtEmail" onchange="trim(this)"
								placeholder="Alternate Email" id="instialtEmail">
							<p class="error-msg" id="error_instialtEmail"
								style="display: none;">Enter Valid Email.</p>
						</div>
					</div>


					<div class="form-group row row-eq-height" style="display: none"
						id="universitydiv">

						<div class="col-12 col-sm-12 col-lg-6">
							<label>AISHE Code <span class="text-danger">*</span></label> <input
								type="text" class="form-control"
								onchange="trim(this);getuniInfo()" name="uniaisheName"
								placeholder="AISHE Code" id="uniaisheName" value="U-"
								style="text-transform: uppercase" maxlength="7">
							<p class="error-msg" id="error_uniaisheName"
								style="display: none;">Invalid AISHE Code.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>University Name <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="uniName"
								onchange="trim(this)" placeholder="University Name" id="uniName"
								readonly>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Institute Name </label> <input type="text"
								class="form-control" name="uniinstitute"
								placeholder="Institute Name" id="uniinstitute" readonly>
						</div>


						<div class="col-12 col-sm-12 col-lg-6">

							<label>Authorized Person Name <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="uniAuthour"
								onchange="trim(this)" placeholder="Authorized Person Name"
								id="uniAuthour">
							<p class="error-msg" id="error_uniAuthour" style="display: none;">Required
								Field.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Designation of Person<span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="uniDes"
								onchange="trim(this)" placeholder="Designation of Person"
								id="uniDes">
							<p class="error-msg" id="error_uniDes" style="display: none;">Required
								Field.</p>
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Name of Department <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="uniDept"
								onchange="trim(this)" placeholder="Name of Department"
								id="uniDept">
							<p class="error-msg" id="error_uniDept" style="display: none;">Required
								Field.</p>
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Mobile No.<span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="uniMobile"
								onchange="checkUnique(this.value,1,3)" maxlength="10"
								placeholder="Mobile No." id="uniMobile">
							<p class="error-msg" id="error_uniMobile" style="display: none;">Required
								Field.</p>
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Email-ID <span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="uniEmail"
								onchange="checkUnique(this.value,2,3)" placeholder="Email"
								id="uniEmail">
							<p class="error-msg" id="error_uniEmail" style="display: none;">Required
								Field.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Alternate Email-ID</label> <input type="text"
								class="form-control" name="unialtEmail" onchange="trim(this)"
								placeholder="Alternate Email" id="unialtEmail">
							<p class="error-msg" id="error_unialtEmail"
								style="display: none;">Required Field.</p>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="col-12 col-sm-12 col-lg-12" id="regbutton"
						style="display: none;">
						<p>
							<button type="button" onclick="submitform()" id="log-btn"
								class="button login-btn">Register</button>
							<input type="hidden" class="form-control" name="type" id="type">
							<input type="hidden" class="form-control" name="yesNo" id="yesNo"
								value="0">
						</p>
					</div>
					<p>
						Already Member <a href="${pageContext.request.contextPath}/login">Login</a>
					</p>

				</form>
			</div>
		</div>
	</div>

	<div class="col-12 col-sm-12 col-lg-3"></div>


	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery-2.1.4.min.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/chosen.jquery.min.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/init.js"
		type="text/javascript" charset="utf-8"></script>
	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>


	<script type="text/javascript">
		function checkUnique(inputValue, valueType, seqId) {

			var primaryKey = 0;

			$("#error_email").hide();
			$("#error_instiEmail").hide();
			$("#error_uniEmail").hide();
			$("#error_mobile").hide();
			$("#error_instiMobile").hide();
			$("#error_uniMobile").hide();

			var valid = true;
			if (valueType == 1) {

				if (inputValue.length == 10) {
					valid = true;

				} else {
					valid = false;
				}
			} else if (valueType == 2) {

				var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
				if (inputValue.match(mailformat)) {
					valid = true;

				} else {
					valid = false;

				}
			}
			if (valid == true) {

				$
						.getJSON(
								'${checkUniqueField}',
								{

									inputValue : inputValue,
									valueType : valueType,
									primaryKey : primaryKey,
									ajax : 'true',

								},
								function(data) {

									if (data.error == true) {

										if (valueType == 2) {
											//alert("This Email Id is Already Exist in Database. Please Login with Your Credential.");

											if (seqId == 1) {
												document
														.getElementById("email").value = "";
												document
														.getElementById("error_email").innerHTML = "Email Already Register.";

												$("#error_email").show();

											} else if (seqId == 2) {
												document
														.getElementById("instiEmail").value = "";
												document
														.getElementById("error_instiEmail").innerHTML = "Email Already Register.";

												$("#error_instiEmail").show();
											} else {
												document
														.getElementById("uniEmail").value = "";
												document
														.getElementById("error_uniEmail").innerHTML = "Email Already Register.";

												$("#error_uniEmail").show();
											}

										} else {

											//alert("This Mobile No is Already Exist in Database. Please Login with Your Credential.");

											if (seqId == 1) {
												document
														.getElementById("mobile").value = "";

												document
														.getElementById("error_mobile").innerHTML = "Mobile No Already Register.";

												$("#error_mobile").show();

											} else if (seqId == 2) {
												document
														.getElementById("instiMobile").value = "";
												document
														.getElementById("error_instiMobile").innerHTML = "Mobile No Already Register.";

												$("#error_instiMobile").show();
											} else {
												document
														.getElementById("uniMobile").value = "";
												document
														.getElementById("error_uniMobile").innerHTML = "Mobile No Already Register.";

												$("#error_uniMobile").show();
											}

										}
									}
								});
			}
		}

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

			var type = $("#type").val()

			//alert(type);

			if (type == 1) {

				$("#error_university").hide();
				$("#error_collegeName").hide();
				$("#error_name").hide();
				$("#error_inddesognation").hide();
				$("#error_depatment").hide();
				$("#error_mobile").hide();
				$("#error_email").hide();
				$("#error_altEmail").hide();

				if ($("#university").val() == "") {

					isError = true;

					$("#error_university").show();
					//return false;
				}

				if ($("#collegeName").val() == "") {

					isError = true;

					$("#error_collegeName").show()

				}

				if (!$("#name").val()) {

					isError = true;

					$("#error_name").show()

				}

				if (!$("#inddesognation").val()) {

					isError = true;

					$("#error_inddesognation").show()

				}

				if (!$("#depatment").val()) {

					isError = true;

					$("#error_depatment").show()

				}

				if (!$("#mobile").val() || !validateMobile($("#mobile").val())) {

					isError = true;

					if (!$("#mobile").val()) {
						document.getElementById("error_mobile").innerHTML = "This field is required.";
					} else {
						document.getElementById("error_mobile").innerHTML = "Enter valid Mobile No.";
					}

					$("#error_mobile").show()

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

				if ($("#altEmail").val() != ""
						&& !validateEmail($("#altEmail").val())) {

					isError = true;

					document.getElementById("error_altEmail").innerHTML = "Enter valid email.";

					$("#error_altEmail").show()

				}

				if (!isError) {

					return false;
				}

			}

			if (type == 2) {

				$("#error_instiaisheCode").hide();
				$("#error_instidesignation").hide();
				$("#error_instiDept").hide();
				$("#error_instiMobile").hide();
				$("#error_cAuthour").hide();
				$("#error_instiEmail").hide();
				$("#error_instialtEmail").hide();

				if (!$("#instiaisheCode").val()) {

					isError = true;

					$("#error_instiaisheCode").show();
					//return false;
				}

				if (!$("#univ").val()) {

					isError = true;

					document.getElementById("error_instiaisheCode").innerHTML = "Invalid AISHE Code.";

					$("#error_instiaisheCode").show();

				}

				if (!$("#cAuthour").val()) {

					isError = true;

					$("#error_cAuthour").show();

				}

				if (!$("#instidesignation").val()) {

					isError = true;

					$("#error_instidesignation").show();

				}

				if (!$("#instidesignation").val()) {

					isError = true;

					$("#error_instidesignation").show();

				}

				if (!$("#instiDept").val()) {

					isError = true;

					$("#error_instiDept").show();

				}

				if (!$("#instiMobile").val()
						|| !validateMobile($("#instiMobile").val())) {

					isError = true;

					if (!$("#instiMobile").val()) {
						document.getElementById("error_instiMobile").innerHTML = "This field is required.";
					} else {
						document.getElementById("error_instiMobile").innerHTML = "Enter valid Mobile No.";
					}

					$("#error_instiMobile").show();

				}

				if (!$("#instiEmail").val()
						|| !validateEmail($("#instiEmail").val())) {

					isError = true;

					if (!$("#instiEmail").val()) {
						document.getElementById("error_instiEmail").innerHTML = "This field is required.";
					} else {
						document.getElementById("error_instiEmail").innerHTML = "Enter valid email.";
					}

					$("#error_instiEmail").show();

				}

				if ($("#instialtEmail").val() != ""
						&& !validateEmail($("#instialtEmail").val())) {

					isError = true;

					document.getElementById("error_instialtEmail").innerHTML = "Enter valid email.";

					$("#error_instialtEmail").show();

				}

				if (!isError) {

					return false;
				}

			}

			if (type == 3) {

				$("#error_uniaisheName").hide();
				$("#error_uniAuthour").hide();
				$("#error_uniDes").hide();
				$("#error_uniDept").hide();
				$("#error_uniMobile").hide();
				$("#error_uniEmail").hide();
				$("#error_unialtEmail").hide();

				if (!$("#uniaisheName").val()) {

					isError = true;

					$("#error_uniaisheName").show();
					//return false;
				}

				if (!$("#uniName").val()) {

					isError = true;

					document.getElementById("error_uniaisheName").innerHTML = "Invalid AISHE Code.";

					$("#error_uniaisheName").show();

				}

				if (!$("#uniAuthour").val()) {

					isError = true;
					$("#error_uniAuthour").show();

				}

				if (!$("#uniDes").val()) {

					isError = true;
					$("#error_uniDes").show();

				}
				if (!$("#uniDept").val()) {

					isError = true;
					$("#error_uniDept").show();

				}

				if (!$("#uniMobile").val()
						|| !validateMobile($("#uniMobile").val())) {

					isError = true;

					if (!$("#uniMobile").val()) {
						document.getElementById("error_uniMobile").innerHTML = "This field is required.";
					} else {
						document.getElementById("error_uniMobile").innerHTML = "Enter valid Mobile No.";
					}

					$("#error_uniMobile").show();

				}

				if (!$("#uniEmail").val()
						|| !validateEmail($("#uniEmail").val())) {

					isError = true;

					if (!$("#uniEmail").val()) {
						document.getElementById("error_uniEmail").innerHTML = "This field is required.";
					} else {
						document.getElementById("error_uniEmail").innerHTML = "Enter valid email.";
					}

					$("#error_uniEmail").show();

				}

				if ($("#unialtEmail").val() != ""
						&& !validateEmail($("#unialtEmail").val())) {

					isError = true;

					document.getElementById("error_unialtEmail").innerHTML = "Enter valid email.";

					$("#error_unialtEmail").show();

				}

				if (!isError) {

					return false;
				}

			}

		}

		//
	</script>

	<script>
		function submitform() {

			if (validate() == false) {

				var yesNo = document.getElementById("yesNo").value;
				var type = document.getElementById("type").value;

				if (yesNo == 0 || type == 1) {
					document.getElementById("submitForm").submit();
				} else {

					document.getElementById("error_uniaisheName").innerHTML = "Institute Registered";
					document.getElementById("error_instiaisheCode").innerHTML = "Institute Registered";
					$("#error_instiaisheCode").show();
					$("#error_uniaisheName").show();
				}

			}

		}
	</script>

	<script>
		/* document.oncontextmenu = document.body.oncontextmenu = function() {
			return false;
		} */
		$(document).keypress(function(e) {
			if (e.which == 13) {
				/* alert('enter key is pressed');
				console.log('enter key is pressed'); */
				document.getElementById("log-btn").click();
			}
		});
	</script>

	<script type="text/javascript">
		function getInstituteList() {

			var university = document.getElementById("university").value;

			$.post('${getInstituteList}', {

				uniId : university, 
				ajax : 'true',

			}, function(data) {

				var html = '<option value=""> Select Institute </option>';

				var len = data.length;
				for (var i = 0; i < len; i++) {

					html += '<option value="' + data[i].mhInstId + '">'
							+ data[i].insName + '</option>';

				}
				html += '</option>';
				$('#collegeName').html(html);
				$("#collegeName").trigger("chosen:updated");

			});
		}
		function getAshecode() {

			var collegeName = document.getElementById("collegeName").value;

			$.getJSON('${getAshecode}', {

				instiId : collegeName,
				ajax : 'true',

			}, function(data) {

				document.getElementById("indAshecode").value = data.aisheCode;

			});
		}
		function getInstituteInfo() {
			$("#error_instiaisheCode").hide();

			var instiaisheCode = document.getElementById("instiaisheCode").value;

			//alert(instiaisheCode);

			$
					.getJSON(
							'${getInstituteInfo}',
							{

								instiaisheCode : instiaisheCode,
								ajax : 'true',

							},
							function(data) {

								//alert(data.mhInstId);
								if (data.mhInstId != 0) {
									document.getElementById("institute").value = data.insName;
									document.getElementById("univ").value = data.uniName;
									if (data.yesNo == 1) {
										document.getElementById("yesNo").value = 1;
										document
												.getElementById("error_instiaisheCode").innerHTML = "Institute Registered";
										$("#error_instiaisheCode").show();
									} else {
										document.getElementById("yesNo").value = 0;
									}
								} else {
									document.getElementById("institute").value = "";
									document.getElementById("univ").value = "";
									document.getElementById("yesNo").value = 0;
									document
											.getElementById("error_instiaisheCode").innerHTML = "Invalid AISHE Code.";
									$("#error_instiaisheCode").show();
								}

							});
		}

		function getuniInfo() {
			$("#error_uniaisheName").hide();

			var instiaisheCode = document.getElementById("uniaisheName").value;

			//alert(instiaisheCode);

			$
					.getJSON(
							'${getInstituteInfo}',
							{

								instiaisheCode : instiaisheCode,
								ajax : 'true',

							},
							function(data) {

								//alert(data.mhInstId);
								if (data.mhInstId != 0) {
									document.getElementById("uniinstitute").value = data.insName;
									document.getElementById("uniName").value = data.uniName;
									if (data.yesNo == 1) {
										document.getElementById("yesNo").value = 1;
										document
												.getElementById("error_uniaisheName").innerHTML = "Institute Registered";
										$("#error_uniaisheName").show();
									} else {
										document.getElementById("yesNo").value = 0;
									}
								} else {
									document.getElementById("uniinstitute").value = "";
									document.getElementById("uniName").value = "";
									document.getElementById("yesNo").value = 0;
									document
											.getElementById("error_uniaisheName").innerHTML = "Invalid AISHE Code.";
									$("#error_uniaisheName").show();
								}

							});
		}
	</script>

	<script type="text/javascript">
		function showForm(userType) {
			//document.getElementById("abc").style = "display:none"
			//var userType = document.getElementById("userType").value;
			//alert("qualType::" + userType);

			if (userType == 1) {
				$("#universitydiv").hide();
				$("#college").hide();
				$("#individual").show();
				$("#regbutton").show();
				$("#typeDiv").hide();
				document.getElementById("type").value = 1;
			} else if (userType == 2) {
				$("#universitydiv").hide();
				$("#college").show();
				$("#individual").hide();
				$("#regbutton").show();
				$("#typeDiv").hide();
				document.getElementById("type").value = 2;
			} else {
				$("#universitydiv").show();
				$("#college").hide();
				$("#individual").hide();
				$("#regbutton").show();
				$("#typeDiv").hide();
				document.getElementById("type").value = 3;
			}

		}
	</script>



</body>
</html>