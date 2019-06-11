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
<!-- Bootstrap core CSS -->

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
<body class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Login</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/login">Login</a> >
		</div>
	</div>



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

					<h5>Login</h5>
					<p>Note : Only for Uploading the requisite Document To RUSA Maharashtra</p>
				</div>
				<div class="col-12 col-sm-12 col-lg-3"></div>




				<div class="col-12 col-sm-12 col-lg-6">

					<form method="post"
						action="${pageContext.request.contextPath}/loginResponse"
						name="login_form">
						<label>User Name</label> <input type="text" class="form-control"
							name="userName" placeholder="User Name"> <label>Password</label>
						<input type="password" class="form-control" name="password"
							placeholder="Password">

						<div class="clearfix"></div>
						<p>
							<button type="submit" id="log-btn" value="submit"
								class="button login-btn">Login</button>
						</p>
						<c:choose>
							<c:when test="${eventId!=null}">
								<input type="hidden" name="eventId" id="eventId"
									value="${eventId}">
									<input type="hidden" name="file" id="file" value="${file}">
							</c:when>
							<c:otherwise>
								<input type="hidden" name="eventId" id="eventId" value="0">
								<input type="hidden" name="file" id="file" value="0">
							</c:otherwise>
						</c:choose>
					</form>

					<p>
						Need an account? <a
							href="${pageContext.request.contextPath}/registration">Create
							account</a> &nbsp &nbsp &nbsp
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp

						<a href="${pageContext.request.contextPath}/forgetPass">Forgot
							Password</a>
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