<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon" />

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
<body   class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<%-- <jsp:include page="/WEB-INF/views/include/topBarLogin.jsp"></jsp:include> --%>

	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Edit Profile</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="${pageContext.request.contextPath}/">Home</a> > <a
				href="${pageContext.request.contextPath}/editProfile">Edit
				Profile</a> >
		</div>
	</div>


	<div class="container" id="main-content">
		<div class="row row-eq-height">
			<div class="col-12 col-sm-3 col-lg-3">

				<div class="leftColm dashboard-left-menu">
					<div class="profile-section">
						<div class="upload-photo">
							<c:choose>
								<c:when test="${not empty editReg.imageName}">
									<div class="dashboard-profile-img">
										<img id="blah"
											src="${sessionScope.profileUrl}${editReg.imageName}" alt="" />
									</div>
								</c:when>
								<c:otherwise>
									<div class="dashboard-profile-img">
										<img id="blah"
											src="${pageContext.request.contextPath}/resources/images/no-img.jpg"
											alt="" />
									</div>
								</c:otherwise>
							</c:choose>

							<div class="fileUpload btn">
								<div class="user-name">${editReg.name}</div>

							</div>
						</div>


						<div class="clearfix"></div>
					</div>

					<div class="clearfix"></div>
					<ul class="menu">
						<li><a onclick="checkMaintainance()" title="Dashboard"
							href="${pageContext.request.contextPath}/upcomingEvents">Dashboard</a>
						</li>

						<li><a onclick="checkMaintainance()" title="About RUSA"
							href="${pageContext.request.contextPath}/myProfile">My
								Profile</a></li>

						<li><a onclick="checkMaintainance()" title="Change Password"
							href="${pageContext.request.contextPath}/changePass">Change
								Password</a></li>
						<%--     <li>
	                            <a onclick="checkMaintainance()" title="About RUSA" href="${pageContext.request.contextPath}/eventList">Event List</a>
                            </li> --%>
						<li><a onclick="checkMaintainance()" title="Logout"
							href="${pageContext.request.contextPath}/logout">Logout</a></li>
					</ul>
				</div>
			</div>

			<div class="col-12 col-sm-9 col-lg-9">
				<div class="right-Colm news-listing-page">

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

					<h2>Feedback Form</h2>

					<form
						action="${pageContext.request.contextPath}/submitFeedbackForm"
						method="post" name="login_form" id="login_form">

						<input type="hidden" name="userType" value="${editReg.userType}"
							onchange="showForm()">



						<div class="col-12 col-sm-12 col-lg-3"></div>
						<div class="error_msg" id="error_msg" style="display: none">
							<div class="alert alert-warning">Please give your comments</div>

						</div>
						<div class="form-group row row-eq-height">
							<div class="col-12 col-sm-12 col-lg-12">
								<label>Please rate your overall level of satisfaction
									with our event </label>
							</div>
							<input type="hidden" name="eventId" value="${eventId}"
								id="eventId">

							<div class="col-12 col-sm-12 col-lg-12">
								<input type="radio" name="formType" value="5" id="radio1">
								<label for="radio1"></label> <span>Very Satisfied</span>
							</div>

							<div class="col-12 col-sm-12 col-lg-12">
								<input type="radio" name="formType" value="4" id="radio2">
								<label for="radio2"></label> <span>Satisfied</span>
							</div>
							<div class="col-12 col-sm-12 col-lg-12">
								<input type="radio" name="formType" value="3" id="radio3"
									checked> <label for="radio3"></label> <span>Neutral</span>
							</div>
							<div class="col-12 col-sm-12 col-lg-12">
								<input type="radio" name="formType" value="2" id="radio4">
								<label for="radio4"></label> <span>Dissatisfied</span>
							</div>
							<div class="col-12 col-sm-12 col-lg-12">
								<input type="radio" name="formType" value="1" id="radio5">
								<label for="radio5"></label> <span>Very Dissatisfied</span>
							</div>

							<div class="col-12 col-sm-12 col-lg-12">
								<label>Are there any other comments or suggestions you'd
									like to make?</label>
							</div>

							<div class="col-12 col-sm-12 col-lg-12">
								<textarea name="message" id="message" class="form-control"
									placeholder="Message"></textarea>
							</div>
						</div>



						<div class="clearfix"></div>

						<div class="col-12 col-sm-12 col-lg-12">
							<p>
								<button type="submit" id="log-btn" class="button login-btn">Save</button>
							</p>
						</div>


					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function($) {

			$("#login_form").submit(function(e) {
				var isError = false;
				var errMsg = "";

				var radioValue = $("input[name='formType']:checked").val();

				if (radioValue < 3 && !$("#message").val()) {

					$("#error_msg").show();
					return false;
				} else {
					$("#error_msg").hide();

				}

				return true;
			});
		});
	</script>

</body>
</html>
