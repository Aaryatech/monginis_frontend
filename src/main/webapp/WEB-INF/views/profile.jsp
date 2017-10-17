<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>Monginis</title>
<link
	href="${pageContext.request.contextPath}/resources/css/monginis.css"
	rel="stylesheet" type="text/css" />
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>

<!--rightNav-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/menuzord.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#menuzord").menuzord({
			align : "left"
		});
	});
	$(".toggle").on("click", function() {
		$(".marquee").toggleClass("microsoft");
	});
</script>
<!--rightNav-->


</head>
<body>

		




	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<jsp:include page="/WEB-INF/views/include/header.jsp">
		
			<jsp:param name="fr" value="${frDetails}"/>
		</jsp:include>




		<!--topHeader-->

		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">

				<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />

				</jsp:include>

				<!--rightSidebar-->
				<div class="sidebarright">
										


					<!--slider-->
					<!--slider thum size : width:850px height:350px-->
					<div id="owl-example" class="owl-carousel">




						<%-- <c:forEach items="${msgList}" var="msgList">

							<div class="item">
								<div class="screen4plan">
									<div class="homesliderImg">
									 <img src="${url}${msgList.msgImage}" height="300" width="300" />
									

									</div>
									<h3 class="homesliderTitle" ><center>${msgList.msgHeader}</center></h3>


								</div>
							</div>
						</c:forEach> --%>

						
					</div>
					<!--slider-->

					
					
					<div class="topSlide">
			<div class="topSlide2 textcen">
				
				<div class="profileinsite">
		<form name="updateprofile" id="updateprofile" method="post" action="${pageContext.request.contextPath}/updateprofile"enctype="multipart/form-data" >
					<div class="profileinsiteLeft">

						<div class="profile">
							<div class="profilefildset">Franchisee Name</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="franchisee Name"
									name="fr_name" type="text" value="${frDetails.frName}">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Franchisee Profile Pic</div>
							<div class="profileinput">
								<div class="editimg">
									<div class="editpics">
										<div class="fileUpload">
											<span><i class="fa fa-pencil"></i></span> <input type="file"
												class="upload"name="fr_image" id="fr_image"/>
										</div>
									</div>
									<img
										src="${pageContext.request.contextPath}/resources/images/editimg.jpg"
										alt="img">
								</div>
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">City</div>
							<div class="profileinput">
							
								<input class="texboxitemcode" placeholder="City Name"
									name="fr_city" type="text" value="${frDetails.frCity}">
									
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Email id</div>
							<div class="profileinput">
								<input class="texboxitemcode" name="fr_email"
									placeholder="example@gmail.com" type="text" value="${frDetails.frEmail}">
							</div>
						</div>



					</div>

					<div class="profileinsiteRight">
						<div class="profile">
							<div class="profilefildset">Mobile No.</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="9876543201"
									name="fr_mobile" type="text" value="${frDetails.frMob}">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Owner Name</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="Owner Name"
									name="fr_owner" type="text" value="${frDetails.frOwner}">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Shop Opening Date</div>
							<div class="profileinput mardis">26 Feb. 2017</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Edit Password</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="Enter new Password"
									name="fr_password" type="password" value="${frDetails.frPassword}" id="txtNewPassword">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Confirm Password</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="Confirm new Password"
									name="fr_password" type="password"  value="${frDetails.frPassword}" id="txtConfirmPassword" onChange="checkPasswordMatch();">
							</div>
							<div  class="update FormAlert" id="divCheckPasswordMatch">
							</div>
						</div>


						

					</div>
					
					<div class="profile">
							<div class="profileinput">
								<input name="" class="buttonupdateprofile" value="SUBMIT"
									type="submit" id="btnupdate_profile">
							</div>
						</div>
						
						</form>

				</div>
			</div>
		</div>
					
					
					
					
					<!--latestNews-->

				</div>
				<!--rightSidebar-->

			</div>
			<!--fullGrid-->
		</div>
		<!--rightContainer-->

	</div>
	<!--wrapper-end-->


</body>


<script type="text/javascript">
function checkPasswordMatch() {
    var password = $("#txtNewPassword").val();
    var confirmPassword = $("#txtConfirmPassword").val();

    if (password != confirmPassword)
    	{
    	 document.getElementById("divCheckPasswordMatch").style.color = "#ff0000";
        $("#divCheckPasswordMatch").html("Passwords do not match!");
        document.getElementById("btnupdate_profile").disabled = true;
    	}
    else
    	{
    	document.getElementById("divCheckPasswordMatch").style.color = "green";
        $("#divCheckPasswordMatch").html("Passwords match.");
        document.getElementById("btnupdate_profile").disabled = false;
    	}
}

$(document).ready(function () {
   $("#txtConfirmPassword").keyup(checkPasswordMatch);
});

</script>

</html>