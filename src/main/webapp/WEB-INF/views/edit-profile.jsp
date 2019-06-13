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
<style>
.other-gov-site-home {
	margin-top: 43px;
}

.wordwrap {
	white-space: pre-wrap; /* CSS3 */
	white-space: -moz-pre-wrap; /* Firefox */
	white-space: -pre-wrap; /* Opera <7 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-word; /* IE */
}
</style>
<body class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<%-- <jsp:include page="/WEB-INF/views/include/topBarLogin.jsp"></jsp:include> --%>

	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Edit Profile</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/myProfile">My Profile</a> >
		</div>
	</div>


	<div class="container" id="main-content">
		<div class="row row-eq-height">
			  <jsp:include page="/WEB-INF/views/include/loginLeft.jsp"></jsp:include>

			<div class="col-12 col-sm-12 col-lg-9">
				<div class="right-Colm news-listing-page">
					<h2>
						My Profile
						<c:if test="${editReg.userType==1}">
            	(Individual)
							</c:if>
						<c:if test="${editReg.userType==2}">
									(Institute)
								</c:if>
						<c:if test="${editReg.userType==3}">
									(University)
									</c:if>
						<a href="${pageContext.request.contextPath}/editProfile"
							class="edit-profile">Edit Profile</a>
					</h2>

					<form
						action="${pageContext.request.contextPath}/editUserRegistration"
						onsubmit="return confirm('Do you really want to submit the form?');"
						method="post" name="login_form">




						<input type="hidden" name="userType" value="${editReg.userType}">



						<%-- <c:if test="${editReg.userType==1}"> --%>
						<!-- <div class="form-group row row-eq-height"> -->

						<div class="col-12 col-sm-12 col-lg-12">
							<c:if test="${editReg.userType==1}">
								<label>Full Name : </label>
								<Strong>${editReg.name}</Strong>
							</c:if>
							<c:if test="${editReg.userType==2 || editReg.userType==3}">
								<label>Institute Name : </label>
								<Strong>${editReg.name}</Strong>
							</c:if>
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>AISHE Code : </label> <Strong>${editReg.aisheCode}</Strong>
						</div>
						<c:if test="${editReg.userType==1}">
							<div class="col-12 col-sm-12 col-lg-12">
								<label>Institute Name : </label> <Strong>${editReg.instName}</Strong>
							</div>
						</c:if>
						<div class="col-12 col-sm-12 col-lg-12">
							<label>University Name : </label> <Strong>${editReg.uniName}</Strong>
						</div>
						<c:if test="${editReg.userType==2 || editReg.userType==3}">
							<div class="col-12 col-sm-12 col-lg-12">
								<label>Authorized Person Name : </label> <Strong>${editReg.authorizedPerson}</Strong>
							</div>
						</c:if>

						<div class="col-12 col-sm-12 col-lg-12">
							<label>Designation of Person : </label> <Strong>${editReg.designationName}</Strong>
						</div>

						<div class="col-12 col-sm-12 col-lg-12">

							<label>Name of Department : </label> <Strong>${editReg.departmentName}</Strong>
						</div>

						<div class="col-12 col-sm-12 col-lg-12">
							<label>Mobile No. : </label> <Strong>${editReg.mobileNumber}</Strong>
						</div>


						<div class="col-12 col-sm-12 col-lg-12">
							<label>Email-ID :</label> <Strong>${editReg.emails}</Strong>
						</div>

						<div class="col-12 col-sm-12 col-lg-12">
							<label>Alternate Email-ID</label> :
							<c:choose>
								<c:when test="${not empty editReg.alternateEmail}">
									<Strong>${editReg.alternateEmail}</Strong>
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</div>



						<!-- </div> -->
						<%-- </c:if> --%>



						<%-- <c:if test="${editReg.userType==2}">
							<div class="form-group row row-eq-height">

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Institute Name <span class="text-danger">*</span></label>
									<input type="text" class="form-control" name="institute"
										onchange="trim(this)" value="${editReg.name}"
										placeholder="Institute Name" id="instituteName" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>AISHE Code</label> <input type="text"
										class="form-control" onchange="trim(this)" name="aisheName"
										value="${editReg.aisheCode}" placeholder="AISHE Code"
										id="aisheName" readonly>
								</div>
								<div class="col-12 col-sm-12 col-lg-6">
									<label>University Affiliated <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="univ"
										onchange="trim(this)" value="${editReg.unversityName}"
										placeholder="University Affiliated" id="univ" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Authorized Name <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="collegeAuthour"
										onchange="trim(this)" value="${editReg.authorizedPerson}"
										placeholder="Name of Authorized" id="cAuthour" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Designation <span class="text-danger">*</span>
									</label> <input type="text" class="form-control"
										name="designationCollege" placeholder="Designation of Person"
										onchange="trim(this)" value="${editReg.designationName}"
										id="designationCollege" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Name of Department <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="dept"
										onchange="trim(this)" value="${editReg.departmentName}"
										placeholder="Name of Department" id="collegeDept" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Mobile No.<span class="text-danger">*</span></label> <input
										type="text" class="form-control" name="collegeMobile"
										onchange="trim(this)" value="${editReg.mobileNumber}"
										pattern="[7-9]{1}[0-9]{9}" maxlength="10"
										placeholder="Mobile No." id="collegeNo" maxlength="10"
										readonly>
								</div>
								<div class="col-12 col-sm-12 col-lg-6">
									<label>Email-ID <span class="text-danger">*</span></label> <input
										type="email" class="form-control" name="collegeEmail"
										onchange="trim(this)" value="${editReg.emails}"
										placeholder="Email" id="collegeEmail" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Alternate Email-ID</label> <input type="email"
										class="form-control" onchange="trim(this)"
										value="${editReg.alternateEmail}" name="altEmail"
										placeholder="Alternate Email" id="altEmail" readonly>
								</div>

							</div>
						</c:if> --%>

						<%-- <c:if test="${editReg.userType==3}">
							<div class="form-group row row-eq-height">

								<div class="col-12 col-sm-12 col-lg-6">
									<label>University Name <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="uniName"
										onchange="trim(this)" value="${editReg.name}"
										placeholder="University Name" id="uniName" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>AISHE Code</label> <input type="text"
										class="form-control" onchange="trim(this)" name="aisheName"
										value="${editReg.aisheCode}" placeholder="AISHE Code"
										id="aisheName" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">

									<label>Authorized Name <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="uniAuthour"
										onchange="trim(this)" value="${editReg.authorizedPerson}"
										placeholder="Name of Authorized" id="uniAuthour" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Designation <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="uniDes"
										onchange="trim(this)" value="${editReg.designationName}"
										placeholder="Designation of Person" id="uniDes" readonly>
								</div>
								<div class="col-12 col-sm-12 col-lg-6">
									<label>Name of Department <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="uniDept"
										onchange="trim(this)" value="${editReg.departmentName}"
										placeholder="Name of Department" id="uniDept" readonly>
								</div>
								<div class="col-12 col-sm-12 col-lg-6">
									<label>Mobile No.<span class="text-danger">*</span></label> <input
										type="text" class="form-control" name="uniMobile"
										onchange="trim(this)" value="${editReg.mobileNumber}"
										pattern="[7-9]{1}[0-9]{9}" maxlength="10"
										placeholder="Mobile No." id="uniNo" maxlength="10" readonly>
								</div>
								<div class="col-12 col-sm-12 col-lg-6">
									<label>Email-ID <span class="text-danger">*</span></label> <input
										type="email" class="form-control" name="uniEmail"
										onchange="trim(this)" value="${editReg.emails}"
										placeholder="Email" id="uniEmail" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Alternate Email-ID</label> <input type="email"
										class="form-control" onchange="trim(this)"
										value="${editReg.alternateEmail}" name="altEmail"
										placeholder="Alternate Email" id="altEmail" readonly>
								</div>



							</div>
						</c:if> --%>

						<div class="clearfix"></div>

						<!-- <div class="col-12 col-sm-12 col-lg-12">
							<p>
								<button type="submit" id="log-btn" class="button login-btn">Save</button>
							</p>
						</div> -->


					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
	<script type="text/javascript">
		function showForm() {
			//document.getElementById("abc").style = "display:none"
			var userType = document.getElementById("userType").value
			//alert("qualType::"+qualType);

			if (userType == 1) {

				document.getElementById("individual").style = "visible"

				document.getElementById("email").setAttribute("required",
						"true");
				document.getElementById("fullname").setAttribute("required",
						"true");
				document.getElementById("collegeName").setAttribute("required",
						"true");
				document.getElementById("uniAff").setAttribute("required",
						"true");
				document.getElementById("depatment").setAttribute("required",
						"true");
				document.getElementById("dob").setAttribute("required", "true");
				document.getElementById("mobile").setAttribute("required",
						"true");
				document.getElementById("authour").setAttribute("required",
						"true");

			} else {

				document.getElementById("email").removeAttribute("required");
				document.getElementById("fullname").removeAttribute("required");
				document.getElementById("collegeName").removeAttribute(
						"required");
				document.getElementById("uniAff").removeAttribute("required");
				document.getElementById("depatment")
						.removeAttribute("required");
				document.getElementById("dob").removeAttribute("required");
				document.getElementById("mobile").removeAttribute("required");
				document.getElementById("authour").removeAttribute("required");

				document.getElementById("individual").style = "display:none"
			}
			if (userType == 2) {

				document.getElementById("college").style = "visible"

				document.getElementById("collegeEmail").setAttribute(
						"required", "true");
				document.getElementById("instituteName").setAttribute(
						"required", "true");
				document.getElementById("univ")
						.setAttribute("required", "true");
				document.getElementById("collegeDept").setAttribute("required",
						"true");
				document.getElementById("designationCollege").setAttribute(
						"required", "true");
				document.getElementById("collegeNo").setAttribute("required",
						"true");
				document.getElementById("cAuthour").setAttribute("required",
						"true");

			} else {
				document.getElementById("collegeEmail").removeAttribute(
						"required");
				document.getElementById("instituteName").removeAttribute(
						"required");
				document.getElementById("univ").removeAttribute("required");
				document.getElementById("collegeDept").removeAttribute(
						"required");
				document.getElementById("designationCollege").removeAttribute(
						"required");
				document.getElementById("collegeNo")
						.removeAttribute("required");
				document.getElementById("cAuthour").removeAttribute("required");

				document.getElementById("college").style = "display:none"
			}
			if (userType == 3) {

				document.getElementById("university").style = "visible"

				document.getElementById("uniEmail").setAttribute("required",
						"true");
				document.getElementById("uniName").setAttribute("required",
						"true");
				document.getElementById("uniDept").setAttribute("required",
						"true");
				document.getElementById("uniDes").setAttribute("required",
						"true");
				document.getElementById("uniNo").setAttribute("required",
						"true");
				document.getElementById("uniAuthour").setAttribute("required",
						"true");

			} else {
				document.getElementById("uniEmail").removeAttribute("required");
				document.getElementById("uniName").removeAttribute("required");
				document.getElementById("uniDept").removeAttribute("required");
				document.getElementById("uniDes").removeAttribute("required");
				document.getElementById("uniNo").removeAttribute("required");
				document.getElementById("uniAuthour").removeAttribute(
						"required");

				document.getElementById("university").style = "display:none"
			}

		}

		function hideText() {
			//alert("hii");
			document.getElementById("college").style = "display:none"
		}
	</script>
	<br>

</body>
</html>
