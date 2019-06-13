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
<style>
.other-gov-site-home {
	margin-top: 43px;
}
</style>
</head>
<body class="${contrast}">
	<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	<jsp:include page="/WEB-INF/views/include/topBar.jsp"></jsp:include>
	<%-- <jsp:include page="/WEB-INF/views/include/topBarLogin.jsp"></jsp:include> --%>
	<c:url value="/checkUniqueField" var="checkUniqueField"></c:url>
	<jsp:include page="/WEB-INF/views/include/topMenu.jsp"></jsp:include>
	<div class="inner-slider" id="slider">
		<div class="container">
			<h1>Upload Document</h1>
		</div>
	</div>
	<div class="bridcrumb">
		<div class="container">
			<a href="/">Home</a> > <a
				href="${pageContext.request.contextPath}/documentUpload">Upload
				Document</a> >
		</div>
	</div>


	<div class="container" id="main-content">
		<div class="row row-eq-height">
			<jsp:include page="/WEB-INF/views/include/loginLeft.jsp"></jsp:include>


			<div class="col-12 col-sm-12 col-lg-9">
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


					<input type="hidden" class="form-control" name="type" id="type"
						value="${editReg.userType}">
					<form action="${pageContext.request.contextPath}/submitUploadDocForm" method="post"
						name="login_form" id="submitForm" enctype="multipart/form-data">

						<input type="hidden" name="userType" value="${editReg.userType}">

						<div class="col-12 col-sm-12 col-lg-12">
							<label>Document Name <span class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="docTitle"
								onchange="trim(this)" placeholder="Name Of Document"
								id="docTitle">
							<p class="error-msg" id="error_docTitle" style="display: none;">Required
								Field.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-12">
							<label>Select Type <span class="text-danger">*</span>
							</label> <select id="typeId" name="typeId" class="form-control">
								<option value="">Select Type</option>
								<c:forEach items="${docTypelist}" var="docTypelist">
									<option value="${docTypelist.typeId}">${docTypelist.typeName}</option>
								</c:forEach>
							</select>
							<p class="error-msg" id="error_typeId" style="display: none;">Required
								Field.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-12">

							<label>Select Document <span class="text-danger">*</span>
							</label> <input type="file" class="form-control" name="docName"
								id="docName">
							<p class="error-msg" id="error_docName" style="display: none;">Required
								Field.</p>
						</div>

						<div class="col-12 col-sm-12 col-lg-12">
							<p>
								<button type="submit" id="log-btn" class="button login-btn">Upload</button>
							</p>
						</div>
					</form>
					<div class="table-responsive">
						<table align="center" cellpadding="0" cellspacing="0"
							class="table">
							<thead>
								<tr>
									<th width="7%">Sr.</th>
									<th>Document Name</th>
									<th>Type</th>
									<th>Download</th>
									<th>Size</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${uploadDocumentlist}"
									var="uploadDocumentlist" varStatus="count">
									<tr class="odd">

										<td>${count.index+1}</td>
										<td>${uploadDocumentlist.title}</td>
										<td>${uploadDocumentlist.typeName}</td>
										<td><a href="${frontDocUrl}${uploadDocumentlist.fileName}"
											target="_blank">Download</a></td>
										<td style="text-align: right;">${uploadDocumentlist.extraVarchar1}</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
					<div class="clearfix"></div>





				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/imgOpenLink.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

	<jsp:include page="/WEB-INF/views/include/footerJs.jsp"></jsp:include>

	<script type="text/javascript">
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}

		$(document).ready(function($) {

			$("#submitForm").submit(function(e) {
				var isError = false;
				var errMsg = "";

				$("#error_docTitle").hide();
				$("#error_typeId").hide();
				$("#error_docName").hide();

				if (!$("#docTitle").val()) {

					isError = true;

					$("#error_docTitle").show()

				}

				if (!$("#typeId").val()) {

					isError = true;
					$("#error_typeId").show()

				}

				if (!$("#docName").val()) {

					isError = true;
					$("#error_docName").show()

				}

				if (!isError) {

					document.getElementById("log-btn").disabled = true;
					return true;

				}

				return false;
			});
		});
	</script>

</body>
</html>
