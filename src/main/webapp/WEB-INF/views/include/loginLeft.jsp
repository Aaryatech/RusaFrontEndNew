<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.wordwrap {
	white-space: pre-wrap; /* CSS3 */
	white-space: -moz-pre-wrap; /* Firefox */
	white-space: -pre-wrap; /* Opera <7 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-word; /* IE */
}
</style>


<div class="col-12 col-sm-12 col-lg-3">


	<div class="leftColm dashboard-left-menu">
		<div class="profile-section">
			<div class="upload-photo">
				<c:choose>
					<c:when test="${not empty sessionScope.info.imageName}">
						<div class="dashboard-profile-img">
							<img id="blah"
								src="${sessionScope.profileUrl}${sessionScope.info.imageName}"
								alt="" />
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
					<div class="user-name wordwrap">${sessionScope.info.name}</div>

					<%
						String mapping = (String) session.getAttribute("mapping");
						if (mapping.equals("editProfile")) {
					%>
					<form class="dropzone" id="myForm"
						action="${pageContext.request.contextPath}/uploadProfilePhoto"
						method="post" enctype="multipart/form-data">
						<input name="isImage" value="1" type="hidden" /> <input
							name="file" class="upload" type="file" id="imgInp"
							onchange="upImage()" /> <span>Update Picture</span>
					</form>
					<%
						}
					%>

				</div>
			</div>


			<div class="clearfix"></div>
		</div>

		<div class="clearfix"></div>
		<ul class="menu">

			<%
				if (mapping.equals("upcomingEvents") || mapping.equals("previousEvents")) {
			%>
			<li class="active">
				<%
					} else {
				%>
			
			<li>
				<%
					}
				%> <a onclick="checkMaintainance()" title="Dashboard"
				href="${pageContext.request.contextPath}/upcomingEvents">Dashboard</a>
			</li>

			<%
				if (mapping.equals("myProfile")) {
			%>
			<li class="active">
				<%
					} else {
				%>
			
			<li>
				<%
					}
				%> <a onclick="checkMaintainance()" title="About RUSA"
				href="${pageContext.request.contextPath}/myProfile">My Profile</a>
			</li>



			<%
				if (mapping.equals("changePass")) {
			%>
			<li class="active">
				<%
					} else {
				%>
			
			<li>
				<%
					}
				%><a onclick="checkMaintainance()" title="Change Password"
				href="${pageContext.request.contextPath}/changePass">Change
					Password</a></li>
					
			<%
				if (mapping.equals("documentUpload")) {
			%>
			<li class="active">
				<%
					} else {
				%>
			
			<li>
				<%
					}
				%><a onclick="checkMaintainance()" title="Upload Document"
				href="${pageContext.request.contextPath}/documentUpload">Upload
					Document</a></li>
			<li><a onclick="checkMaintainance()" title="Logout"
				href="${pageContext.request.contextPath}/logout">Logout</a></li>
		</ul>
	</div>
</div>