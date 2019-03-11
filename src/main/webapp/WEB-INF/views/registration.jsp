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
<body onload="hideText()">
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>REGISTRATION</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/registration">Login</a>
			>
		</div>
	</div>
<div class="login"> 
    <div class="container" id="main-content">
        <div class="row row-eq-height">
        	<div class="col-12 col-sm-12 col-lg-3"></div>
			
          	<div class="col-12 col-sm-12 col-lg-6">
            	<div class="login-box">
            	<div class="login-header">
            		<h5>Register</h5>
                    <p>Register to access your profile</p>
            	</div>
                
                            <form action="${pageContext.request.contextPath}/insertUserRegistration"
							onsubmit="return confirm('Do you really want to submit the form?');"
							method="post" name="login_form">  
                          
                            <label for="userType">Select Type</label>
                            <select id="userType" name="userType"  class="form-control" onchange="showForm()" required>
							<option >Select Type</option>
                            <option value="1">Individual</option>
                            <option value="2">Colleges</option>
                            <option value="3">University</option>
                            </select>
                         	<div class="form-group" style="display:none" id="individual">
                           				 <label>Email-ID <span class="text-danger">*</span></label>
                         			  		 <input type="email" class="form-control" name="email" placeholder="Email" id="email">
                            
                          				 <label>Alternate Email-ID</label>
                        					   <input type="email" class="form-control" name="altEmail" placeholder="Email" id="altEmail">
                            
                     	   			    <label>Full Name <span class="text-danger">*</span></label>
                     					       <input type="text" class="form-control" name="name" placeholder="Name" id="fullname">
                     					       
                     					<label>Mobile No.<span class="text-danger">*</span></label>
                     					       <input type="text" class="form-control" name="mobile"  pattern="[7-9]{1}[0-9]{9}" maxlength="10" placeholder="Mobile No." id="mobile" maxlength="10">
                            
                      			       <label>College Name  <span class="text-danger">*</span></label>
                       						   <input type="text" class="form-control" name="collegeName" placeholder="College Name" id="collegeName">
                            
                        			    <label>University Affiliated <span class="text-danger">*</span></label>
                       						     <input type="text" class="form-control" name="university" placeholder="University Affiliated" id="uniAff">
                            
                        			    <label>Name of Department <span class="text-danger">*</span></label>
                     						       <input type="text" class="form-control" name="dept" placeholder="Name of Department" id="depatment">
                            
                       				     <label>Date Of Birth <span class="text-danger">*</span></label>
                          						  <input type="text" class="form-control" name="dob" placeholder="Name of Department" id="dob">
                           	  </div>
                           	   	<div class="form-group" style="display:none" id="college">
                           				 <label>Email-ID <span class="text-danger">*</span></label>
                         			  		 <input type="email" class="form-control" name="collegeEmail" placeholder="Email" id="collegeEmail">
                            
                          				 <label>Alternate Email-ID</label>
                        					   <input type="email" class="form-control" name="altEmail" placeholder="Email" id="altEmail">
                            
                            				       
                     					<label>Mobile No.<span class="text-danger">*</span></label>
                     					       <input type="text" class="form-control" name="collegeMobile"  pattern="[7-9]{1}[0-9]{9}" maxlength="10" placeholder="Mobile No." id="collegeNo" maxlength="10">
        
                     	   			    <label>Institute Name <span class="text-danger">*</span></label>
                     					       <input type="text" class="form-control" name="institute" placeholder="Institute Name" id="instituteName">
                            
                      			       <label>AISHE Code</label>
                       						   <input type="text" class="form-control" name="aisheName" placeholder="AISHE Code" id="aisheName">
                            
                        			    <label>University Affiliated <span class="text-danger">*</span></label>
                       						     <input type="text" class="form-control" name="univ" placeholder="University Affiliated" id="univ">
                            
                        			    <label>Name of Department <span class="text-danger">*</span></label>
                     						       <input type="text" class="form-control" name="dept" placeholder="Name of Department" id="collegeDept">     
                     						       
                     						        <label>Designation  <span class="text-danger">*</span></label>
                     						       <input type="text" class="form-control" name="designationCollege" placeholder="Designation of Person" id="designationCollege">                     
                             	  </div>
                           	   	<div class="form-group" style="display:none" id="university">
                           				 <label>Email-ID <span class="text-danger">*</span></label>
                         			  		 <input type="email" class="form-control" name="uniEmail" placeholder="Email" id="uniEmail">
                            
                          				 <label>Alternate Email-ID</label>
                        					   <input type="email" class="form-control" name="altEmail" placeholder="Email" id="altEmail">
                            
                            		       
                     					<label>Mobile No.<span class="text-danger">*</span></label>
                     					       <input type="text" class="form-control" name="uniMobile"  pattern="[7-9]{1}[0-9]{9}" maxlength="10" placeholder="Mobile No." id="uniNo" maxlength="10">
        
                     	   		 	  <label>AISHE Code</label>
                       						   <input type="text" class="form-control" name="aisheName" placeholder="AISHE Code" id="aisheName">
                            
                      			       <label>University Name <span class="text-danger">*</span></label>
                       						   <input type="text" class="form-control" name="uniName" placeholder="University Name" id="uniName">
                            
                        			  
                        			    <label>Name of Department <span class="text-danger">*</span></label>
                     						       <input type="text" class="form-control" name="uniDept" placeholder="Name of Department" id="uniDept">
                     						       
                            			 <label>Designation  <span class="text-danger">*</span></label>
                     						       <input type="text" class="form-control" name="uniDes" placeholder="Designation of Person" id="uniDes">
                            
                       				   
                           	  </div>
                            <div class="clearfix"></div>
                            <p>
                            
                            <button type="submit" id="log-btn" class="button login-btn">Register</button>
                            </p>
                            
                            </form>
                            <p>Already Member <a href="#">Login</a></p>
            </div>
			</div>
            	
        	<div class="col-12 col-sm-12 col-lg-3"></div>

            
            
        </div>
    </div>
</div>
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
			document.getElementById("dob").setAttribute("required","true"); 
			document.getElementById("mobile").setAttribute("required","true");
			
		} 
		else{
			
			document.getElementById("email").removeAttribute("required");
			document.getElementById("fullname").removeAttribute("required");
			document.getElementById("collegeName").removeAttribute("required");
			document.getElementById("uniAff").removeAttribute("required");
			document.getElementById("depatment").removeAttribute("required");
			document.getElementById("dob").removeAttribute("required");
			document.getElementById("mobile").removeAttribute("required");
			
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
			
		} 
		else{
			document.getElementById("collegeEmail").removeAttribute("required");
			document.getElementById("instituteName").removeAttribute("required");		
			document.getElementById("univ").removeAttribute("required");
			document.getElementById("collegeDept").removeAttribute("required");		
			document.getElementById("designationCollege").removeAttribute("required");
			document.getElementById("collegeNo").removeAttribute("required");
			
			document.getElementById("college").style = "display:none"
		}
		if (userType == 3) {

			document.getElementById("university").style = "visible"
			
			document.getElementById("uniEmail").setAttribute("required","true");			 	
			document.getElementById("uniName").setAttribute("required","true");		
			document.getElementById("uniDept").setAttribute("required","true");
			document.getElementById("uniDes").setAttribute("required","true");
			document.getElementById("uniNo").setAttribute("required","true");
			
		} 
		else{
			document.getElementById("uniEmail").removeAttribute("required");			
		 	document.getElementById("uniName").removeAttribute("required");			
			document.getElementById("uniDept").removeAttribute("required");
			document.getElementById("uniDes").removeAttribute("required");
			document.getElementById("uniNo").removeAttribute("required");
			
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