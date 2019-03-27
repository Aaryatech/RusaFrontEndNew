<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
			$('#log_btn').attr('disabled','disabled');
		}
		$('#log_btn').removeAttr('disabled');
	}
</script>

</head>
<body>
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
<%-- 	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include> --%>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Change Password</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/changePass">Login</a> >
				
				    <a href="${pageContext.request.contextPath}/logout" class="last-update" style="margin:left=100px;">Logout <span class="glyphicon glyphicon-log-out"></span></a>
   
		</div>
	</div>
	<!-- <div class="login"> 
    <div class="container" id="main-content">
        	
        <div class="row row-eq-height">
       
        	<div class="col-12 col-sm-12 col-lg-3"></div>
			
          	<div class="col-12 col-sm-12 col-lg-6">
            	<div class="login-box">
            	<div class="login-header">
            		<h5>Login</h5>
                    <p>Login to access your profile</p>
            	</div>
                
                            <form method="post" action="" name="login_form">  
                            <label>User Name</label>
                            <input type="text" class="form-control" name="" placeholder="User Name">
                            
                            <label>Password</label>
                            <input type="text" class="form-control" name="" placeholder="Password">
                                                    
                            <div class="clearfix"></div>
                            <p>
                            <button type="button" id="log-btn" class="button login-btn">Login</button>
                            </p>
                            
                            </form>
                            <p>Need an account? <a href="#">Create your account</a></p>
            </div>
			</div>
            	
        	<div class="col-12 col-sm-12 col-lg-3"></div>
			
            
            
        </div>
    </div>
</div>
 -->


	<div class="container" id="main-content">
		<div class="row row-eq-height">
			<div class="col-12 col-sm-3 col-lg-3">

				<div class="leftColm">
					<div class="profile-section">
						<div class="upload-photo">
							<!--    <div class="dashboard-profile-img">
  	                          <img id="blah" src="images/no-img.jpg" alt="" />
                            </div>	 -->

							<div class="fileUpload btn">
								<div class="user-name">Welcome</div>

							</div>
						</div>


						<div class="clearfix"></div>
					</div>

					<div class="clearfix"></div>
					<ul class="menu">
						    <li>
	                            <a onclick="checkMaintainance()" title="Dashboard" href="${pageContext.request.contextPath}/upcomingEvents">Dashboard</a>
                            </li>

                           <%--  <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/editProfile">My Profile</a>
                            </li>
 --%>
                            <li>
	                            <a onclick="checkMaintainance()" title="Change Password" href="${pageContext.request.contextPath}/changePass">Change Password</a>
                            </li>
                          <%--     <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/eventList">Event List</a>
                            </li> --%>
                              <li>
	                            <a onclick="checkMaintainance()" title="Logout" href="${pageContext.request.contextPath}/logout">Logout</a>
                            </li>
					</ul>
				</div>
			</div>

			<div class="col-12 col-sm-9 col-lg-9 right-Colm news-listing-page">
				<h2>Change Password</h2>

				<form method="post"
					action="${pageContext.request.contextPath}/changePassword"
					name="login_form">
					<div class="row row-eq-height">


						<div class="col-12 col-sm-12 col-lg-12">
							<label>Current password</label> <input type="password"
								class="form-control" name="pass" id="pass"
								placeholder="Current password" onchange="getCheck()" required>
						</div>

						<div class="col-12 col-sm-12 col-lg-12">
							<label>New Password</label> <input type="password"
								class="form-control" name="newPass" id="newPass"
								placeholder="New Password" required>
						</div>


						<div class="col-12 col-sm-12 col-lg-12">
							<label>Confirm password</label> <input type="password"
								class="form-control" name="confirmPass" id="confirmPass"
								placeholder="Confirm password"  required>
						</div>



						<div class="col-12 col-sm-12 col-lg-12">
							<input type="submit" id="log_btn" value="Submit"
								class="button login-btn" onchange="Validate()" />
							  <!--    <button type="submit" id="log-btn" value="Submit" class="button login-btn"  onclick="Validate()">Save</button>
                               -->
						</div>

					</div>
				</form>



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

			$.getJSON('${getPasswordCheck}', {

				pass : pass,
				ajax : 'true',

			}, function(data) {
				
				if (data.error == true) {
					alert(data.msg);
					$('#log_btn').attr('disabled','disabled');
				} else {
					alert(data.msg);
					$('#log_btn').removeAttr('disabled');
				}
			}

			);

		}
	</script>

</body>
</html>