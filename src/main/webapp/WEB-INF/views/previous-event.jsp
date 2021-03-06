<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.ats.rusafrontend.model.Maintainance"%>
<%@ page session="true"%>
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
	
	int userDetail=0;
	
	try {
		userDetail = (int) session.getAttribute("UserDetail");
		System.out.println("userDetail: "+userDetail);
	} catch (Exception e) {
		userDetail = 0;
		e.printStackTrace();
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
<style>
.other-gov-site-home {
    margin-top: 43px;
}
</style>
</head>
<body class="${contrast}">
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
<% if(userDetail==0){%>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<% } %>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
		<div class="inner-slider" id="slider">
		<div class="container">
				<h1>Event Detail</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/eventList">Event</a>
			>
		</div>
	</div>

            <div class="container" id="main-content">
        <div class="row row-eq-height">
        
       <div class="col-12 col-sm-3 col-lg-3">
            	
				<div class="leftColm">
                    <div class="profile-section"> 
                        <div class="upload-photo">
                            <!-- <div class="dashboard-profile-img">
  	                          <img id="blah" src="images/no-img.jpg" alt="" />
                            </div>	
                         -->
                            <div class="fileUpload btn">
                              <div class="user-name">Welcome</div>
                          
                             <!--   <a href="my-profile-edit.html"> <span>Update Picture</span></a> -->
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
                    <div class="row">
                    	<c:if test="${not empty event.featuredImage}">
                    <div class="col-12 col-sm-6 col-lg-6">  
                      <img src="${sessionScope.gallryImageURL}${event.featuredImage}" alt="${event.heading}" title="${event.heading}" class="img-responsive thumbnail">	                                   
                      </div>
                    </c:if>
                    <div class="col-12 col-sm-12 col-lg-12">
                    		
                    <strong>${event.heading}</strong><br>
					<p>${event.descriptions}</p>                    
					<p><span><i class="icon-location"></i> <strong>Venue:</strong>  ${event.eventLocation}</span> 
					<span><i class="icon-calendar"></i> <strong>Date:</strong>  ${dateEvent}</span>
					<span><i class="icon-man-user"></i> <strong>Contact Person:</strong>  ${event.eventContactPerson}</span>
                    <span><i class="icon-smartphone-call"></i> <strong>Contact:</strong> +91  ${event.eventContactNumber}</span><br> </p>
                    	<%-- <c:if test="${event.exInt2==1}">
                    		<form class="form-horizontal"
										action="${pageContext.request.contextPath}/submtEventAppliedForm"
										method="post" enctype="multipart/form-data"
										name="form_sample_2" id="form_sample_2"
										onsubmit="return confirm('Do you really want to submit the form?');">
										<div class="form-group row">
																		<label class="control-label col-sm-2" for="page_pdf">PDF
																			File :</label>
																		<div class="col-sm-7">
																			<input type="file" name="pagePdf" id="pagePdf"
																				class="form-control" data-parsley-minlength="2" required
																				accept=".xlsx,.xls,.doc, .docx,.ppt, .pptx,.txt,.pdf,.zip" />
																		<p>Please upload .xlsx,.xls,.doc, .docx,.ppt, .pptx,.txt,.pdf,.zip</p>
																		</div>
																			<input type="hidden" name="newsblogsId" value="${event.newsblogsId}">
																			
																			<button type="submit" class="btn button apply">Apply</button>
																	</div>
								
               <!--      <span><i class="icon-download-2"></i> <strong>Download Attachment:</strong> <a href="#">Event Detail</a></span> -->
              						
																			
																	
																		
																
                    </form>
                    </c:if> --%>
                    
                   <%-- 
                      	<c:if test="${event.exInt2==0}">
                    <a href="${pageContext.request.contextPath}/applyEvent/${event.newsblogsId}" class="btn button apply">Apply</a>
                  </c:if> --%>
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