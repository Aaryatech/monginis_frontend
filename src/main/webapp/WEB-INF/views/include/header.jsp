<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
</head>
<body>


<!--topHeader-->
<div class="fullGrid center logoBarbg slideposi">
	<div class="wrapperIn positionR">
    	<div class="logoBarLeft"><a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/resources/images/monginislogo.jpg" alt="monginis"></a></div>  
        <div class="logoBarRight"><div id="menuzord" class="menuzord red menuzord-responsive">
            <ul class="menuzord-menu menuzord-right menuzord-indented scrollable">
                <li><a href="#"><div class="usericon">${frDetails.frName} 
                </div> <div class="userimg">
                <img src="${frDetails.frImage}" onerror="this.src='${pageContext.request.contextPath}/resources/images/user.png';"></div> </a>
                	<ul class="dropdown">
                       
						<li><a href="${pageContext.request.contextPath}/editProfile">Edit Profile</a></li>
						<li><a href="${pageContext.request.contextPath}/logout">Log out</a></li>
					</ul>
                </li>
            </ul>
        </div></div>
    </div>
</div>
<!--topHeader-->





</body>
</html>
