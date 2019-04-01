<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%
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
 <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.png" type="image/x-icon" /> 
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap1.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style1.css"
	rel="stylesheet">
	 <link href="${pageContext.request.contextPath}/resources/assets/plugins/pace/pace-theme-flash.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/resources/assets/fonts/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/resources/assets/css/animate.min.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/perfect-scrollbar/perfect-scrollbar.css" rel="stylesheet" type="text/css"/>
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
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/verifyOtp">Verify OTP</a>
			>
		</div>
	</div>
		<div class="login">
		<div class="container" id="main-content">
	<div class="row row-eq-height login-box">
			
				<div class="col-12 col-sm-12 col-lg-12 login-header">
            
            		<h5>Verify OTP</h5>
                 
            	</div>	<div class="col-12 col-sm-12 col-lg-3"></div>
          
                <div class="col-12 col-sm-12 col-lg-6">
                            <form action="${pageContext.request.contextPath}/verifyOtpProcess" method="post" onsubmit="return confirm('Do you really want to submit the form?');" name="login_form">  
                         
               		       
            
                            <label>One Time Pin(OTP) <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="userOtp" placeholder="Enter One-Time-Pin(OTP) Here" required>
                            <input type="hidden" class="form-control" name="uuid" value="${uuid}" required>
                                                                     
                            <div class="clearfix"></div>                          
                            <button type="submit" id="log-btn" class="button login-btn">Verify</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/resendOtpProcess" method="post" onsubmit="return confirm('Do you really want to submit the form?');" name="login_form">  
                            <input type="hidden" class="form-control" name="uuid" value="${uuid}" required>
                          
                            <button type="submit" id="log-btn" class="button login-btn">Resend</button>
                           
                            </form>                       
           
				</div>

				<div class="col-12 col-sm-12 col-lg-3"></div>

</div>
</div>
			</div>
		<br>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>

