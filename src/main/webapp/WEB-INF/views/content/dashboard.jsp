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
			<h1>Dashboard</h1>
         </div>
    </div>
	<div class="bridcrumb">
    	<div class="container">
        	<a href="/">Home</a> > <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            <a href="#" class="print"><span></span></a> <!-- 
            <p class="last-update">Last Updated on 25 Feb 2019</p>  -->
        </div>
    </div>    
    
    <div class="container" id="main-content">
        <div class="row row-eq-height">
        	<div class="col-12 col-sm-3 col-lg-3">
            	
				<div class="leftColm">
                    <div class="profile-section">
                        <div class="upload-photo">
                            <div class="dashboard-profile-img">
  	                          <img id="blah" src="images/no-img.jpg" alt="" />
                            </div>	
                        
                            <div class="fileUpload btn">
                                <div class="user-name">Jules Truong</div>
                          
                               <a href="my-profile-edit.html"> <span>Update Picture</span></a>
                            </div>	
                        </div>
                        
                        
                        <div class="clearfix"></div>
                    </div>
                    
                    <div class="clearfix"></div>
                        <ul class="menu">
                            <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="/rusafrontend/info/about-rusa9">Dashboard</a>
                            </li>

                            <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="/rusafrontend/info/about-rusa9">My Profile</a>
                            </li>

                            <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="/rusafrontend/info/about-rusa9">Change Password</a>
                            </li>
                        </ul>
                </div>
            </div>
            
            <div class="col-12 col-sm-9 col-lg-9 right-Colm news-listing-page">
            	<h2>Dashboard</h2>

				<ul class="nav nav-tabs rusa-gallery-tab rusa-gallery-sub-tab" role="tablist">
                                <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#upcoming"><span class="icon-calendar-with-a-clock-time-tools icon"></span> Upcoming Events</a>
                                </li>
                                
                                <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#previous"><span class="icon-calendar icon"></span> Previous Events </a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                <div id="upcoming" class="tab-pane active"> 
                                    <table align="center" cellpadding="0" cellspacing="0"  class="table">
                                    <thead>
                                        <tr>
                                            <th>Sr. no</th>
                                            <th>Image</th>
                                            <th>Name</th>
                                            <th>Details</th>
                                            <th>Date</th>
                                            <th>Venue</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <tr class="odd">
                                            <td>1</td>
                                            <td><img src="http://tomcat.aaryatechindia.in:6435/media/gallery/thumbnail2019-03-01_18:46:08_2019-02-15_12_58_10_Digital-Launch-5.jpg" alt="Digital-Launch" title="Digital-Launch" class="img-responsive thumbnail">	</td>
                                            <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                            <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </td>
                                            <td>5 Apr 2019</td>
                                            <td>Lorem Ipsum is simply</td>
                                        </tr>
                                    
                                        <tr class="even">
                                                <td>1</td>
                                                <td><img src="http://tomcat.aaryatechindia.in:6435/media/gallery/thumbnail2019-03-01_18:46:08_2019-02-15_12_58_10_Digital-Launch-5.jpg" alt="Digital-Launch" title="Digital-Launch" class="img-responsive thumbnail">	</td>
                                                <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                                <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </td>
                                                <td>5 Apr 2019</td>
                                                <td>Lorem Ipsum is simply</td>
                                            </tr>

                                        <tr class="odd">
                                            <td>1</td>
                                            <td><img src="http://tomcat.aaryatechindia.in:6435/media/gallery/thumbnail2019-03-01_18:46:08_2019-02-15_12_58_10_Digital-Launch-5.jpg" alt="Digital-Launch" title="Digital-Launch" class="img-responsive thumbnail">	</td>
                                            <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                            <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </td>
                                            <td>5 Apr 2019</td>
                                            <td>Lorem Ipsum is simply</td>
                                        </tr>
                                    
                                        <tr class="even">
                                                <td>1</td>
                                                <td><img src="http://tomcat.aaryatechindia.in:6435/media/gallery/thumbnail2019-03-01_18:46:08_2019-02-15_12_58_10_Digital-Launch-5.jpg" alt="Digital-Launch" title="Digital-Launch" class="img-responsive thumbnail">	</td>
                                                <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                                <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </td>
                                                <td>5 Apr 2019</td>
                                                <td>Lorem Ipsum is simply</td>
                                            </tr>

                                        <tr class="odd">
                                            <td>1</td>
                                            <td><img src="http://tomcat.aaryatechindia.in:6435/media/gallery/thumbnail2019-03-01_18:46:08_2019-02-15_12_58_10_Digital-Launch-5.jpg" alt="Digital-Launch" title="Digital-Launch" class="img-responsive thumbnail">	</td>
                                            <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                            <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </td>
                                            <td>5 Apr 2019</td>
                                            <td>Lorem Ipsum is simply</td>
                                        </tr>
                                    
                                        <tr class="even">
                                                <td>1</td>
                                                <td><img src="http://tomcat.aaryatechindia.in:6435/media/gallery/thumbnail2019-03-01_18:46:08_2019-02-15_12_58_10_Digital-Launch-5.jpg" alt="Digital-Launch" title="Digital-Launch" class="img-responsive thumbnail">	</td>
                                                <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                                <td>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </td>
                                                <td>5 Apr 2019</td>
                                                <td>Lorem Ipsum is simply</td>
                                            </tr>
                                    
                                    </tbody>
                                    </table>
                                
                                </div>
                                
                                <div id="previous" class="tab-pane"> 
                                	 <table align="center" cellpadding="0" cellspacing="0"  class="table">
                                    <thead>
                                        <tr>
                                            <th>Sr. no</th>
                                            <th>Name</th>
                                            <th>Download</th>
                                            <th>Applied status</th>
                                            <th>Feedback</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <tr class="odd">
                                            <td>1</td>
                                            <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                            <td><a href="#"><span class="icon-download-2"></span> Download</a></td>
                                            <td>Process</td>
                                            <td><a href="#" class="btn apply">Feedback</a></td>
                                        </tr>
                                        
                                         <tr class="even">
                                            <td>1</td>
                                            <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                            <td><a href="#"><span class="icon-download-2"></span> Download</a></td>
                                            <td>Process</td>
                                            <td><a href="#" class="btn apply">Feedback</a></td>
                                        </tr>
                           
                                        <tr class="odd">
                                            <td>1</td>
                                            <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                            <td><a href="#"><span class="icon-download-2"></span> Download</a></td>
                                            <td>Process</td>
                                            <td><a href="#" class="btn apply">Feedback</a></td>
                                        </tr>
                                        
                                         <tr class="even">
                                            <td>1</td>
                                            <td>Lorem Ipsum is simply dummy text typesetting industry.</td>
                                            <td><a href="#"><span class="icon-download-2"></span> Download</a></td>
                                            <td>Process</td>
                                            <td><a href="#" class="btn apply">Feedback</a></td>
                                        </tr>
                                    
                                       
                                    
                                    </tbody>
                                    </table>	
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