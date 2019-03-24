<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/login">Login</a>
			>
		</div>
	</div>
	
	   <div class="container" id="main-content">
        <div class="row row-eq-height">
        	<div class="col-12 col-sm-3 col-lg-3">
				<div class="leftColm">
                	<h3>Gallery</h3>
                    <ul class="menu">
                    	<li><a href="about.html">About RUSA</a></li>
                        <li><a href="rusa-structure.html" class="active">RUSA Structure</a></li>
                        <li><a href="message-education-minister.html">Message from Education Minister</a></li>
                        <li><a href="message-state-project-director.html">Message from State Project Director</a></li>
                        <li><a href="rusa-achievements.html">RUSA Achievements</a></li>
                        <li><a href="rusa-photo-gallery.html">RUSA Photo Gallery</a></li>

                	</ul>
                </div>
            </div>
            
            <div class="col-12 col-sm-9 col-lg-9 right-Colm news-listing-page">
                    <div class="row">
                    <div class="col-12 col-sm-6 col-lg-6">
                    <img src="http://tomcat.aaryatechindia.in:6435/media/gallery/thumbnail2019-03-01_18:46:08_2019-02-15_12_58_10_Digital-Launch-5.jpg" alt="Digital-Launch" title="Digital-Launch" class="img-responsive thumbnail">	
                    </div>
                    <div class="col-12 col-sm-12 col-lg-12">
                    		
                    <strong>${eventList.heading}</strong><br>
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </p>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. 
					It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>                    
					<p><span><i class="icon-location"></i> <strong>Venue:</strong> Lorem Ipsum is simply dummy text of the printing and typesetting industry.</span> 
					<span><i class="icon-calendar"></i> <strong>Date:</strong> 17 Mar 2019</span>
					<span><i class="icon-man-user"></i> <strong>Contact Person:</strong> Kishore Mishra</span>
                    <span><i class="icon-smartphone-call"></i> <strong>Contact:</strong> +91 8888888888</span><br> 
                    <span><i class="icon-download-2"></i> <strong>Download Attachment:</strong> <a href="#">Event Detail</a></span>
                    </p>
                   
                    
                    <a href="#" class="btn button apply">Apply</a>
                  
                    </div>
                    </div>
                    
                    
    
                    
                    
                    
                    
                    
            </div>
            
            
        </div>
    </div>
 
	
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>