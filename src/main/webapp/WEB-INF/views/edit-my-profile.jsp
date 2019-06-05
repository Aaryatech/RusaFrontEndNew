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
<style>
.other-gov-site-home {
	margin-top: 43px;
}
</style>
</head>
<body   class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<%-- <jsp:include page="/WEB-INF/views/include/topBarLogin.jsp"></jsp:include> --%>
	<c:url value="/checkUniqueField" var="checkUniqueField"></c:url>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Edit Profile</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/editProfile">Edit
				Profile</a> >
		</div>
	</div>


	<div class="container" id="main-content">
		<div class="row row-eq-height">
			<div class="col-12 col-sm-3 col-lg-3">

				<div class="leftColm dashboard-left-menu">
					<div class="profile-section">
						<div class="upload-photo">
							<c:choose>
								<c:when test="${not empty editReg.imageName}">
									<div class="dashboard-profile-img">
										<img id="blah"
											src="${sessionScope.profileUrl}${editReg.imageName}" alt="" />
									</div>
								</c:when>
								<c:otherwise>
									<div class="dashboard-profile-img">
										<img id="blah"
											src="${pageContext.request.contextPath}/resources/images/no-img.jpg"
											alt="" />
									</div>
								</c:otherwise>
							</c:choose>

							<div class="fileUpload btn">
								<div class="user-name">${editReg.name}</div>
								<form class="dropzone" id="myForm"
									action="${pageContext.request.contextPath}/uploadProfilePhoto"
									method="post" enctype="multipart/form-data">
									<input name="isImage" value="1" type="hidden" /> <input
										name="file" class="upload" type="file" id="imgInp"
										onchange="upImage()" />
								</form>
								<span>Update Picture</span>
								<!--  <input type="file" class="upload" id="imgInp" /> -->

							</div>
						</div>


						<div class="clearfix"></div>
					</div>

					<div class="clearfix"></div>
					<ul class="menu">
						<li><a onclick="checkMaintainance()" title="Dashboard"
							href="${pageContext.request.contextPath}/upcomingEvents">Dashboard</a>
						</li>

						<li><a onclick="checkMaintainance()" title="About RUSA"
							href="${pageContext.request.contextPath}/myProfile">My
								Profile</a></li>

						<li><a onclick="checkMaintainance()" title="Change Password"
							href="${pageContext.request.contextPath}/changePass">Change
								Password</a></li>
						<%--     <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/eventList">Event List</a>
                            </li> --%>
						<li><a onclick="checkMaintainance()" title="Logout"
							href="${pageContext.request.contextPath}/logout">Logout</a></li>
					</ul>
				</div>
			</div>

			<div class="col-12 col-sm-9 col-lg-9">
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

					<h2>
						Edit Profile
						<c:if test="${editReg.userType==1}">
            	(Individual)
							</c:if>
						<c:if test="${editReg.userType==2}">
									(Colleges)
								</c:if>
						<c:if test="${editReg.userType==3}">
									(University)
									</c:if>
					</h2>

					<form
						action="${pageContext.request.contextPath}/editUserRegistration"
						onsubmit="return confirm('Do you really want to submit the form?');"
						method="post" name="login_form">

						<input type="hidden" name="userType" value="${editReg.userType}">

						<c:if test="${editReg.userType==1}">
							<div class="form-group row row-eq-height">

								<div class="col-12 col-sm-12 col-lg-6">

									<label>Full Name <span class="text-danger">*</span></label> <input
										type="text" class="form-control" name="name"
										placeholder="Name" value="${editReg.name}" readonly
										id="fullname" readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>College Name <span class="text-danger">*</span></label>
									<input type="text" class="form-control" name="collegeName"
										onchange="trim(this)" value="${editReg.collegeName}"
										placeholder="College Name" id="collegeName" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>University Affiliated <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="university"
										value="${editReg.unversityName}"
										placeholder="University Affiliated" id="uniAff" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Designation of Person <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="authour"
										onchange="trim(this)" value="${editReg.designationName}"
										placeholder="Name of Authorized" id="authour" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">

									<label>Name of Department <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="dept"
										onchange="trim(this)" value="${editReg.departmentName}"
										placeholder="Name of Department" id="depatment" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Mobile No.<span class="text-danger">*</span></label> <input
										type="text" class="form-control" name="mobile"
										pattern="[7-9]{1}[0-9]{9}" maxlength="10"
										placeholder="Mobile No." id="mobile" onchange="trim(this)"
										value="${editReg.mobileNumber}"
										oninput="checkUnique(this.value,1,1)" required>
								</div>


								<div class="col-12 col-sm-12 col-lg-6">
									<label>Email-ID <span class="text-danger">*</span></label> <input
										type="email" class="form-control" name="email"
										value="${editReg.emails}" placeholder="Email" id="email"
										readonly>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Alternate Email-ID</label> <input type="email"
										class="form-control" value="${editReg.alternateEmail}"
										name="altEmail" placeholder="Alternate Email" id="altEmail"
										onchange="trim(this)">
								</div>



							</div>
						</c:if>



						<c:if test="${editReg.userType==2}">
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
										placeholder="University Affiliated" id="univ" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Authorized Name <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="collegeAuthour"
										onchange="trim(this)" value="${editReg.authorizedPerson}"
										placeholder="Name of Authorized" id="cAuthour" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Designation <span class="text-danger">*</span>
									</label> <input type="text" class="form-control"
										name="designationCollege" placeholder="Designation of Person"
										onchange="trim(this)" value="${editReg.designationName}"
										id="designationCollege" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Name of Department <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="dept"
										onchange="trim(this)" value="${editReg.departmentName}"
										placeholder="Name of Department" id="collegeDept" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Mobile No.<span class="text-danger">*</span></label> <input
										type="text" class="form-control" name="collegeMobile"
										onchange="trim(this)" value="${editReg.mobileNumber}"
										pattern="[7-9]{1}[0-9]{9}" maxlength="10"
										placeholder="Mobile No." id="collegeMobile"
										oninput="checkUnique(this.value,1,2)" maxlength="10" required>
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
										placeholder="Alternate Email" id="altEmail">
								</div>

							</div>
						</c:if>

						<c:if test="${editReg.userType==3}">
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
										placeholder="Name of Authorized" id="uniAuthour" required>
								</div>

								<div class="col-12 col-sm-12 col-lg-6">
									<label>Designation <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="uniDes"
										onchange="trim(this)" value="${editReg.designationName}"
										placeholder="Designation of Person" id="uniDes" required>
								</div>
								<div class="col-12 col-sm-12 col-lg-6">
									<label>Name of Department <span class="text-danger">*</span>
									</label> <input type="text" class="form-control" name="uniDept"
										onchange="trim(this)" value="${editReg.departmentName}"
										placeholder="Name of Department" id="uniDept" required>
								</div>
								<div class="col-12 col-sm-12 col-lg-6">
									<label>Mobile No.<span class="text-danger">*</span></label> <input
										type="text" class="form-control" name="uniMobile"
										onchange="trim(this)" value="${editReg.mobileNumber}"
										pattern="[7-9]{1}[0-9]{9}" maxlength="10"
										placeholder="Mobile No." id="uniMobile" maxlength="10"
										oninput="checkUnique(this.value,1,2)" required>
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
										placeholder="Alternate Email" id="altEmail">
								</div>



							</div>
						</c:if>

						<div class="col-12 col-sm-12 col-lg-12">
							<p>
								<button type="submit" id="log-btn" class="button login-btn">Save</button>
							</p>
						</div>
						<div class="clearfix"></div>




					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
	<script type="text/javascript">
		function checkUnique(inputValue, valueType, seqId) {
			//alert("inputValue"+inputValue);
			///alert("valueType "+valueType);
			//alert("seqId "+seqId);

			var primaryKey = 0;
			//alert("Is Edit " +isEdit);
			var valid = true;
			if (valueType == 1) {
				//alert("Its Mob no");
				if (inputValue.length == 10) {
					valid = true;
					//alert("Len 10")
				} else {
					valid = false;
				}
			} else if (valueType == 2) {
				//alert("Its Email " );

				var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
				if (inputValue.match(mailformat)) {
					valid = true;
					//alert("Valid Email Id");
				} else {
					valid = false;
					//alert("InValid Email Id");
				}
			}
			if (valid == true)
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

									//alert("Data  " +JSON.stringify(data));
									if (data.error == true) {

										if (valueType == 2) {
											alert("This Email Id is Already Exist in Database. Please Login with Your Credential.");

											if (seqId == 1) {
												document
														.getElementById("email").value = "";

											} else if (seqId == 2) {
												document
														.getElementById("collegeEmail").value = "";
											} else {
												document
														.getElementById("uniEmail").value = "";
											}

										} else {

											alert("This Mobile No is Already Exist in Database. Please Login with Your Credential.");

											if (seqId == 1) {
												document
														.getElementById("mobile").value = "";

											} else if (seqId == 2) {
												document
														.getElementById("collegeMobile").value = "";
											} else {
												document
														.getElementById("uniMobile").value = "";
											}

										}
									}
								});
		}
	</script>
	<script>
		function upImage() {

			//alert("hi");
			document.getElementById("myForm").submit();

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
