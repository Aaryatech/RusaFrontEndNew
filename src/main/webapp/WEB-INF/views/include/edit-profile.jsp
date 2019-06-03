<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
 <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.png" type="image/x-icon" /> 
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
<!-- 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
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
<body onload="upcomingEvents" class="${contrast}">
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button><%-- 
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include> --%>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
		
	  <div class="inner-slider" id="slider">
    	 <div class="container">
			<h1>Dashboard</h1>
         </div>
    </div>
	<div class="bridcrumb">
    	<div class="container">
        	<a href="/">Home</a> > <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
         
               <a href="${pageContext.request.contextPath}/logout" class="last-update" style="margin:left=100px;">Logout <span class="glyphicon glyphicon-log-out"></span></a>
      <!--   <a href="#">
          <span class="glyphicon glyphicon-log-out"></span>
        </a>
      -->
         
        </div> 
    </div>   
   <%--     <c:if test="${sessionScope.successMsg!=null}">
            <div class="col-lg-12">
    		          <div class="alert alert-success alert-dismissible fade in">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                <strong>Success : </strong> ${sessionScope.successMsg}</div>
        	                                       </div> 
            </c:if> --%>
    <div class="container" id="main-content">
        <div class="row row-eq-height">
        	<div class="col-12 col-sm-3 col-lg-3">
            	
				<div class="leftColm">
                    <div class="profile-section">
                        <div class="upload-photo">
                         <!--    <div class="dashboard-profile-img">
  	                          <img id="blah" src="images/no-img.jpg" alt="" />
                            </div> -->	
                        
                            <div class="fileUpload btn">
                                <div class="user-name">Welcome</div>
                          
                              <!--  <a href="my-profile-edit.html"> <span>Update Picture</span></a> -->
                            </div>	
                        </div>
                        
                        
                        <div class="clearfix"></div>
                    </div>
                    
                    <div class="clearfix"></div>
                        <ul class="menu">
                            <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="/${pageContext.request.contextPath}/dashboard">Dashboard</a>
                            </li>

                            <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/editProfile">My Profile</a>
                            </li>

                            <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/changePass">Change Password</a>
                            </li>
                          <%--     <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/eventList">Event List</a>
                            </li> --%>
                              <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/logout">Logout</a>
                            </li>
                        </ul>
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
						<div class="col-12 col-sm-12 col-lg-12">
							<label ">Select Type</label> <select id="userType"
								name="userType" class="form-control" onchange="showForm()"
								required>
								<option>Select Type</option>
								<option value="1">Individual</option>
								<option value="2">Colleges</option>
								<option value="3">University</option>
							</select>
					
					
							<div class="form-group" style="display: visible" id="individual">

								<label>Email-ID <span class="text-danger">*</span></label> <input
									type="email" class="form-control" name="email"
									placeholder="Email" id="email"> <label>Alternate
									Email-ID</label> <input type="email" class="form-control"
									name="altEmail" placeholder="Alternate Email" id="altEmail">


								<label>Full Name <span class="text-danger">*</span></label> <input
									type="text" class="form-control" name="name" placeholder="Name"
									id="fullname"> <label>Mobile No.<span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" name="mobile" pattern="[7-9]{1}[0-9]{9}"
									maxlength="10" placeholder="Mobile No." id="mobile"
									maxlength="10"> <label>College Name <span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" name="collegeName"
									placeholder="College Name" id="collegeName"> <label>University
									Affiliated <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="university"
									placeholder="University Affiliated" id="uniAff"> <label>Name
									of Department <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="dept"
									placeholder="Name of Department" id="depatment"> <label>Date
									Of Birth <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="dob"
									placeholder="Date Of Birth" id="dob"> <label>Authorized
									Name <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="authour"
									placeholder="Name of Authorized" id="authour">

							</div>
				
						
							<div class="form-group" style="display: none" id="college">
								<label>Email-ID <span class="text-danger">*</span></label> <input
									type="email" class="form-control" name="collegeEmail"
									placeholder="Email" id="collegeEmail"> <label>Alternate
									Email-ID</label> <input type="email" class="form-control"
									name="altEmail" placeholder="Alternate Email" id="altEmail">


								<label>Mobile No.<span class="text-danger">*</span></label> <input
									type="text" class="form-control" name="collegeMobile"
									pattern="[7-9]{1}[0-9]{9}" maxlength="10"
									placeholder="Mobile No." id="collegeNo" maxlength="10">

								<label>Institute Name <span class="text-danger">*</span></label>
								<input type="text" class="form-control" name="institute"
									placeholder="Institute Name" id="instituteName"> <label>AISHE
									Code</label> <input type="text" class="form-control" name="aisheName"
									placeholder="AISHE Code" id="aisheName"> <label>University
									Affiliated <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="univ"
									placeholder="University Affiliated" id="univ"> <label>Name
									of Department <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="dept"
									placeholder="Name of Department" id="collegeDept"> <label>Designation
									<span class="text-danger">*</span>
								</label> <input type="text" class="form-control"
									name="designationCollege" placeholder="Designation of Person"
									id="designationCollege"> <label>Authorized Name
									<span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="collegeAuthour"
									placeholder="Name of Authorized" id="cAuthour">
							</div>
						</div>
					
							<div class="form-group" style="display: none" id="university">
								<label>Email-ID <span class="text-danger">*</span></label> <input
									type="email" class="form-control" name="uniEmail"
									placeholder="Email" id="uniEmail"> <label>Alternate
									Email-ID</label> <input type="email" class="form-control"
									name="altEmail" placeholder="Alternate Email" id="altEmail">


								<label>Mobile No.<span class="text-danger">*</span></label> <input
									type="text" class="form-control" name="uniMobile"
									pattern="[7-9]{1}[0-9]{9}" maxlength="10"
									placeholder="Mobile No." id="uniNo" maxlength="10"> <label>AISHE
									Code</label> <input type="text" class="form-control" name="aisheName"
									placeholder="AISHE Code" id="aisheName"> <label>University
									Name <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="uniName"
									placeholder="University Name" id="uniName"> <label>Name
									of Department <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="uniDept"
									placeholder="Name of Department" id="uniDept"> <label>Designation
									<span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="uniDes"
									placeholder="Designation of Person" id="uniDes"> <label>Authorized
									Name <span class="text-danger">*</span>
								</label> <input type="text" class="form-control" name="uniAuthour"
									placeholder="Name of Authorized" id="uniAuthour">

							
						</div>
						<div class="clearfix"></div>

						<div class="col-12 col-sm-12 col-lg-12">
							<p>
								<button type="submit" id="log-btn" class="button login-btn">Register</button>
							</p>
						</div>

					</div>
				</form>


				<p>
					Already Member <a href="/login">Login</a>
				</p>
			</div>
		</div>
	</div>
            
        </div>
    </div>
 <br>
	
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>