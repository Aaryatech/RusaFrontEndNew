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
<body>
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
		<div class="inner-slider" id="slider">
		<div class="container">
			<h1>LOGIN</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/login">Login</a>
			>
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
					<h5>Forget Password</h5>
					<p></p>
				</div>
				<div class="col-12 col-sm-12 col-lg-3"></div>
  
				<div class="col-12 col-sm-12 col-lg-6">

                            <form method="post" action="${pageContext.request.contextPath}/forgetPassword" name="login_form">  
                            <label>Email-Id</label>
                            <input type="email" class="form-control" name="userName" placeholder="Email-Id">
                            
                            <label>Mobile Number</label>
                            <input type="text" class="form-control" name="phone" pattern="[7-9]{1}[0-9]{9}"
									maxlength="10" placeholder="Mobile Number">
                                                  
                            <div class="clearfix"></div>
                            <p>
                            <button type="submit" id="log-btn" value="submit" class="button login-btn">Submit</button>
                            </p>
                            </form>
                            
					<p>
						Login to access account? <a href="${pageContext.request.contextPath}/login">Login</a>
					</p>

				</div>

				<div class="col-12 col-sm-12 col-lg-3"></div>



			</div>
		</div>
	</div>
 
	
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>