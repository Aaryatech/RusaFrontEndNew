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
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
<jsp:include page="/WEB-INF/views/include/topBarLogin.jsp"></jsp:include>
	
<%-- 
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include> --%>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
		
	  <div class="inner-slider" id="slider">
    	 <div class="container">
			<h1>Dashboard</h1>
         </div>
    </div>
	<div class="bridcrumb">
    	<div class="container">
        	<a href="${pageContext.request.contextPath}/">Home</a> > <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
         
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
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">�</span></button>
                <strong>Success : </strong> ${sessionScope.successMsg}</div>
        	                                       </div> 
            </c:if> --%>
        <%--    <p> ${msg}</p> --%>
    <div class="container" id="main-content">
        <div class="row row-eq-height">
        	<div class="col-12 col-sm-3 col-lg-3">
            	
				<div class="leftColm">
                    <div class="profile-section">
                        <div class="upload-photo">
                            <div class="dashboard-profile-img">
  	                          <img id="blah" src="${sessionScope.gallryImageURL}${editReg.imageName}" alt="" />
                            </div>	
                        
                            <div class="fileUpload btn">
                                <div class="user-name">${editReg.name}</div>
                                <%-- 	<form class="dropzone" id="myForm"
										action="${pageContext.request.contextPath}/uploadProfilePhoto"
										method="post" enctype="multipart/form-data">
										<input name="isImage" value="1" type="hidden" />
									
											<input name="file" class="upload" type="file" id="imgInp" onchange="upImage()" />
								   </form>
                               <!--  <input type="file" class="upload" id="imgInp" /> -->
                                <span>Update Picture</span> --%>
                            </div>	
                        </div>
                        
                        
                        <div class="clearfix"></div>
                    </div>
                    
                    <div class="clearfix"></div>
                        <ul class="menu">
                            <li>
	                            <a onclick="checkMaintainance()" title="Dashboard" href="${pageContext.request.contextPath}/upcomingEvents">Dashboard</a>
                            </li>

                            <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/myProfile">My Profile</a>
                            </li>
 
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
            	<h2>Dashboard</h2>

				<ul class="nav nav-tabs rusa-gallery-tab rusa-gallery-sub-tab" role="tablist">
                                <li class="nav-item">
                                <a class=" nav-link active"  href="${pageContext.request.contextPath}/upcomingEvents"><span class="icon-calendar-with-a-clock-time-tools icon"></span> Upcoming Events</a>
                                </li>
                                
                                <li class="nav-item">
                                <a class="nav-link "  href="${pageContext.request.contextPath}/previousEvents"><span class="icon-calendar icon"></span> Previous Events </a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                <div id="upcoming" class="tab-pane active"> 
                                    <table align="center" cellpadding="0" cellspacing="0"  class="table">
                                    <thead>
                                        <tr>
                                            <th>Sr.no</th>
                                            <th>Event Name</th>
                                            <th>Event Date</th>
                                            <th>Details</th>
                                          
                                        </tr>
                                    </thead>
                                    <tbody>

                                     
                                        <c:forEach items="${upcoming}" var="upcoming" varStatus="count">
									   <tr class="odd">
                                          	<td>${count.index+1}</td>
                                            <td>${upcoming.heading}</td>
                                            <td>${upcoming.eventDateFrom}</td>
                                            <td><a href="${pageContext.request.contextPath}/eventDetail/${upcoming.newsblogsId}/${typeId}">Detail</a></td>
                                               </tr>
                                            </c:forEach>
                                       
                                    
                                       
                                    </tbody>
                                    </table>
                                
                                </div>
                                
                                <div id="previous" class="tab-pane"> 
                                	 <table align="center" cellpadding="0" cellspacing="0"  class="table">
                                    <thead>
                                        <tr>
                                            <th>Sr. no</th>
                                            <th>Event Name</th>
                                            <th>Download</th>
                                          
                                            <th>Detail</th>
                                        </tr>
                                    </thead>
                                    <tbody>
 								 <c:forEach items="${previous}" var="previous"	varStatus="count">
                                        <tr class="odd">
                                        
                                            <td>${count.index+1}</td>
                                            <td>${previous.heading}</td>
                                            <td><a href="#"><span class="icon-download-2"></span> Download</a></td>
                                            <td><a href="${pageContext.request.contextPath}/eventDetail/${previous.newsblogsId}">Detail</a></td>
                                          
                                        </tr>
                                        </c:forEach>
                                      
                                    </tbody>
                                    </table>	
                                </div>
                            </div>	
                
            </div>
            
            
        </div>
    </div>
 <br>
	<script>
	function upImage() {

		//alert("hi");
		document.getElementById("myForm").submit();

			}
	</script>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
</body>
</html>