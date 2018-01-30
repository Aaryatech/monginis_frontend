<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <!DOCTYPE html>
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
<body> comment by sachin --%>

		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<jsp:include page="/WEB-INF/views/include/logo.jsp">
		
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
										<h2 class="pageTitle">Hi <span>${frDetails.frName},</span> Welcome back</h2>
            
            
					<!--slider-->
					<!--slider thum size : width:850px height:350px-->
						<div class="latestNews">
					
						<h3 class="latestNewsTitle">Latest News</h3>
							<div class="microsoft marquee">
						<c:forEach items="${schedulerLists}" var="schedulerLists"  varStatus="count">
						
					            <c:set var="colors" value=""/>
					            <c:choose>
					            <c:when test="${count.index%2==0}">
					            <c:set var="colors" value="white"/>
					           </c:when>
					           <c:otherwise>
					            <c:set var="colors" value="lightblue"/>
					          </c:otherwise>
					          </c:choose>
								<span style="color:${colors}"> ${schedulerLists.schMessage} </span>
							
						
						</c:forEach>
						</div>
					</div>
					<div id="owl-example" class="owl-carousel">




						<c:forEach items="${msgList}" var="msgList">

							<div class="item">
								<div class="screen4plan">
									<div class="homesliderImg">
									 <img src="${url}${msgList.msgImage}" height="300" width="300" />
									

									</div>
									<h3 class="homesliderTitle" style="font-size:15px "><center>${msgList.msgHeader}</center></h3>
	                                <h3 class="homesliderTitle"  ><center>${msgList.msgDetails}</center></h3>

								</div>
							</div>
						</c:forEach>





						<%-- <div class="item">
							<div class="screen4plan">
								<div class="homesliderImg">
									<img
										src="${pageContext.request.contextPath}/resources/images/slide1.jpg"
										alt="img">
								</div>
								<h3 class="homesliderTitle">
								
								Contrary to popular belief,
									Lorem Ipsum is not simply in some form, by injected humour, or
									randomised words which don't look even slightly believable.</h3>
							</div>
						</div>

						<div class="item">
							<div class="screen4plan">
								<div class="homesliderImg">
									<img
										src="${pageContext.request.contextPath}/resources/images/slide2.jpg"
										alt="img">
								</div>
								<h3 class="homesliderTitle">Contrary to popular belief,
									Lorem Ipsum is not simply in some form, by injected humour, or
									randomised words which don't look even slightly believable.</h3>
							</div>
						</div>

						<div class="item">
							<div class="screen4plan">
								<div class="homesliderImg">
									<img
										src="${pageContext.request.contextPath}/resources/images/slide1.jpg"
										alt="img">
								</div>
								<h3 class="homesliderTitle">Contrary to popular belief,
									Lorem Ipsum is not simply in some form, by injected humour, or
									randomised words which don't look even slightly believable.</h3>
							</div>
						</div>

						<div class="item">
							<div class="screen4plan">
								<div class="homesliderImg">
									<img
										src="${pageContext.request.contextPath}/resources/images/slide1.jpg"
										alt="img">
								</div>
								<h3 class="homesliderTitle">Contrary to popular belief,
									Lorem Ipsum is not simply in some form, by injected humour, or
									randomised words which don't look even slightly believable.</h3>
							</div>
						</div>

						<div class="item">
							<div class="screen4plan">
								<div class="homesliderImg">
									<img
										src="${pageContext.request.contextPath}/resources/images/slide1.jpg"
										alt="img">
								</div>
								<h3 class="homesliderTitle">Contrary to popular belief,
									Lorem Ipsum is not simply in some form, by injected humour, or
									randomised words which don't look even slightly believable.</h3>
							</div>
						</div>
 --%>
					</div>
					<!--slider-->

					<!--latestNews-->
					
					
				<%-- 	<div class="latestNews">
					
						<h3 class="latestNewsTitle">Latest News</h3>
							<div class="microsoft marquee">
						<c:forEach items="${schedulerLists}" var="schedulerLists">
						
					

								<span> ${schedulerLists.schMessage} </span>
							
						
						</c:forEach>
						</div>
					</div> --%>
					
					
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
</html>
