<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="icon" href="../../favicon.ico">
<title>${sessionScope.homePageMetaData.siteTitle}</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap1.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style1.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/jcarousel.responsive.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800|Playfair+Display:400,700,900"
	rel="stylesheet">
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
<body onload="hideText()">
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
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/registration">Registration</a> >
		</div>
	</div>


	<div class="login">
		<div class="container" id="main-content">

			<div class="login-box register-box">
				<div class="login-header">
					<h5>Register</h5>
					<p>Register to access your profile</p>
				</div>
				<form
					action="${pageContext.request.contextPath}/insertUserRegistration"
					onsubmit="return confirm('Do you really want to submit the form?');"
					method="post" name="login_form">
					<div class="row row-eq-height">
						<div class="col-12 col-sm-12 col-lg-3"></div>


						<div class="col-12 col-sm-12 col-lg-3"></div>




						<div class="col-12 col-sm-12 col-lg-3"></div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Select Type</label> <select id="userType" name="userType"
								class="form-control" onchange="showForm()" required>

								<option value="1">Individual</option>
								<option value="2">Colleges</option>
								<option value="3">University</option>
							</select>
						</div>
					</div>

					<div class="col-12 col-sm-12 col-lg-3"></div>

					<div class="form-group row row-eq-height" style="display: visible"
						id="individual">


						<div class="col-12 col-sm-12 col-lg-6">

							<label>Full Name <span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="name" placeholder="Name"
								id="fullname">
						</div>


						<div class="col-12 col-sm-12 col-lg-6">
							<label>College Name <span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="collegeName"
								placeholder="College Name" id="collegeName">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>University Affiliated <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="university"
								placeholder="University Affiliated" id="uniAff">
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Designation of Person <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="authour"
								placeholder="Designation of Person" id="authour">
						</div>
						<div class="col-12 col-sm-12 col-lg-6">

							<label>Name of Department <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="dept"
								placeholder="Name of Department" id="depatment">
						</div>



						<div class="col-12 col-sm-12 col-lg-6">
							<label>Mobile No.<span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="mobile"
								pattern="[7-9]{1}[0-9]{9}" maxlength="10"
								placeholder="Mobile No." id="mobile" maxlength="10">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Email-ID <span class="text-danger">*</span></label> <input
								type="email" class="form-control" name="email"
								placeholder="Email" id="email">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Alternate Email-ID</label> <input type="email"
								class="form-control" name="altEmail"
								placeholder="Alternate Email" id="altEmail">
						</div>
					</div>


					<div class="form-group row row-eq-height" style="display: none"
						id="college">





						<div class="col-12 col-sm-12 col-lg-6">
							<label>College Name <span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="institute"
								placeholder="College Name" id="instituteName">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>AISHE Code</label> <input type="text" class="form-control"
								name="aisheName" placeholder="AISHE Code" id="aisheName">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>University Affiliated <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="univ"
								placeholder="University Affiliated" id="univ">
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Authorized Person Name <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="collegeAuthour"
								placeholder="Authorized Person Name" id="cAuthour">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Designation of Person<span class="text-danger">*</span>
							</label> <input type="text" class="form-control"
								name="designationCollege" placeholder="Designation of Person"
								id="designationCollege">
						</div>
<div class="col-12 col-sm-12 col-lg-6">
							<label>Name of Department <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="dept"
								placeholder="Name of Department" id="collegeDept">
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Mobile No.<span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="collegeMobile"
								pattern="[7-9]{1}[0-9]{9}" maxlength="10"
								placeholder="Mobile No." id="collegeNo" maxlength="10">
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Email-ID <span class="text-danger">*</span></label> <input
								type="email" class="form-control" name="collegeEmail"
								placeholder="Email" id="collegeEmail">
						</div>


						<div class="col-12 col-sm-12 col-lg-6">
							<label>Alternate Email-ID</label> <input type="email"
								class="form-control" name="altEmail"
								placeholder="Alternate Email" id="altEmail">
						</div>
					</div>


					<div class="form-group row row-eq-height" style="display: none"
						id="university">


						<div class="col-12 col-sm-12 col-lg-6">
							<label>University Name <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="uniName"
								placeholder="University Name" id="uniName">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>AISHE Code</label> <input type="text" class="form-control"
								name="aisheName" placeholder="AISHE Code" id="aisheName">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">

							<label>Authorized Person Name <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="uniAuthour"
								placeholder="Authorized Person Name" id="uniAuthour">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Designation of Person<span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="uniDes"
								placeholder="Designation of Person" id="uniDes">
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Name of Department <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="uniDept"
								placeholder="Name of Department" id="uniDept">
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Mobile No.<span class="text-danger">*</span></label> <input
								type="text" class="form-control" name="uniMobile"
								pattern="[7-9]{1}[0-9]{9}" maxlength="10"
								placeholder="Mobile No." id="uniNo" maxlength="10">
						</div>
						<div class="col-12 col-sm-12 col-lg-6">
							<label>Email-ID <span class="text-danger">*</span></label> <input
								type="email" class="form-control" name="uniEmail"
								placeholder="Email" id="uniEmail">
						</div>

						<div class="col-12 col-sm-12 col-lg-6">
							<label>Alternate Email-ID</label> <input type="email"
								class="form-control" name="altEmail"
								placeholder="Alternate Email" id="altEmail">
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="col-12 col-sm-12 col-lg-12">
						<p>
							<button type="submit" id="log-btn" class="button login-btn">Register</button>
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




	<script
		src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<!--     <script >

    $(function() 
    {
    	$('input[id$=dob]').datepicker({ dateFormat : 'dd-mm-yy' }); 
    }
   
    </script>
 -->
	<!-- <script type="text/javascript">
		$(function() {

			$('.datepicker').datepicker({
				autoclose : true,
				format : "dd-mm-yyyy",
				changeYear : true,
				changeMonth : true

			});
		});
	</script> -->
	<script type="text/javascript">
function showForm() {
	//document.getElementById("abc").style = "display:none"
		var userType=document.getElementById("userType").value
		//alert("qualType::"+qualType);
		
		if (userType == 1) {

			document.getElementById("individual").style = "visible"
			
			document.getElementById("email").setAttribute("required","true");
			document.getElementById("fullname").setAttribute("required","true");
		 	document.getElementById("collegeName").setAttribute("required","true");
		 	document.getElementById("uniAff").setAttribute("required","true");
			document.getElementById("depatment").setAttribute("required","true");
			
			document.getElementById("mobile").setAttribute("required","true");
			document.getElementById("authour").setAttribute("required","true");
			
		} 
		else{
			
			document.getElementById("email").removeAttribute("required");
			document.getElementById("fullname").removeAttribute("required");
			document.getElementById("collegeName").removeAttribute("required");
			document.getElementById("uniAff").removeAttribute("required");
			document.getElementById("depatment").removeAttribute("required");
		
			document.getElementById("mobile").removeAttribute("required");
			document.getElementById("authour").removeAttribute("required");
			
			document.getElementById("individual").style = "display:none"
		}
		if (userType == 2) {

			document.getElementById("college").style = "visible"
			
			document.getElementById("collegeEmail").setAttribute("required","true");
			document.getElementById("instituteName").setAttribute("required","true");		 
		 	document.getElementById("univ").setAttribute("required","true");
			document.getElementById("collegeDept").setAttribute("required","true");
			document.getElementById("designationCollege").setAttribute("required","true");
			document.getElementById("collegeNo").setAttribute("required","true");
			document.getElementById("cAuthour").setAttribute("required","true");			
			
		} 
		else{
			document.getElementById("collegeEmail").removeAttribute("required");
			document.getElementById("instituteName").removeAttribute("required");		
			document.getElementById("univ").removeAttribute("required");
			document.getElementById("collegeDept").removeAttribute("required");		
			document.getElementById("designationCollege").removeAttribute("required");
			document.getElementById("collegeNo").removeAttribute("required");
			document.getElementById("cAuthour").removeAttribute("required");
			
			document.getElementById("college").style = "display:none"
		}
		if (userType == 3) {

			document.getElementById("university").style = "visible"
			
			document.getElementById("uniEmail").setAttribute("required","true");			 	
			document.getElementById("uniName").setAttribute("required","true");		
			document.getElementById("uniDept").setAttribute("required","true");
			document.getElementById("uniDes").setAttribute("required","true");
			document.getElementById("uniNo").setAttribute("required","true");
			document.getElementById("uniAuthour").setAttribute("required","true");
			
			
		} 
		else{
			document.getElementById("uniEmail").removeAttribute("required");			
		 	document.getElementById("uniName").removeAttribute("required");			
			document.getElementById("uniDept").removeAttribute("required");
			document.getElementById("uniDes").removeAttribute("required");
			document.getElementById("uniNo").removeAttribute("required");
			document.getElementById("uniAuthour").removeAttribute("required");
			
			document.getElementById("university").style = "display:none"
		}
	
	}
	
function hideText() {
	//alert("hii");
	document.getElementById("college").style = "display:none"		
	}
	</script>


	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>