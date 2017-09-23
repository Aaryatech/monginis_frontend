<%@page import="com.monginis.ops.model.Menu"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--leftNav-->
	<div class="sidebarhome">
		<ul>
			<li><a href="#" class="active" onClick="openNav()"><div
						class="img">
						<img
							src="${pageContext.request.contextPath}/resources/images/nav-orderbook.png"
							alt="img">
					</div>
					<div class="title">
						Order <span>Booking</span>
					</div></a></li>
			<li><a href="#" onClick="openNav1()"><div class="img">
						<img
							src="${pageContext.request.contextPath}/resources/images/nav-goodsreturn.png"
							alt="img">
					</div>
					<div class="title">
						Goods <span>Return</span>
					</div></a></li>
			<li><a href="${pageContext.request.contextPath}/orderHistory"><div class="img">
						<img
							src="${pageContext.request.contextPath}/resources/images/nav-orerhistory.png"
							alt="img">
					</div>
					<div class="title">
						Order <span>History</span>
					</div></a></li>
			<li><a href="#" onClick="openNav3()"><div class="img">
						<img
							src="${pageContext.request.contextPath}/resources/images/nav-editprofile.png"
							alt="img">
					</div>
					<div class="title">
						Edit <span>Profile</span>
					</div></a></li>
		</ul>
	</div>
	<!--leftNav-->

	<!--navInner-->

	<!--1nav-->
	<div id="mySidenav" class="sidenav">
		<div class="topSlide">
			<div class="topSlide2">
				<a href="javascript:void(0)" class="closebtn" onClick="closeNav()"><img
					src="${pageContext.request.contextPath}/resources/images/closebtn.png"
					alt="monginis"></a>
				<div class="listarea">
					<ul>

						<c:forEach var="menu" items="${menuList}" varStatus="loop">
							<c:set var="menuTime" value="${menu.toTime}" />
							<c:set var="frId" value="${menu.frId}" />
							<c:set var="settingType" value="${menu.isSameDayApplicable}" />
	<c:set var="catId" value="${menu.catId}" />
 
							<%
								ZoneId z = ZoneId.of("Asia/Calcutta");
									LocalTime now = LocalTime.now(z); // Explicitly specify the desired/expected time zone.

									String menuTiming = (String) pageContext.getAttribute("menuTime");
									
									
									
									int setType = (int) pageContext.getAttribute("settingType");
									int catId = (int) pageContext.getAttribute("catId");

									System.out.println("Menu Timing" + menuTiming);

									LocalTime limit = LocalTime.parse(menuTiming);
									Boolean isLate = now.isAfter(limit);

									System.out.println("Local time" + now + "Is Late :" + isLate);

								/* 	try {
									    final SimpleDateFormat sdf = new SimpleDateFormat("H:mm");
									    final Date dateObj = sdf.parse(time);
									    System.out.println(dateObj);
									    System.out.println(new SimpleDateFormat("K:mm").format(dateObj));
									} catch (final ParseException e) {
									    e.printStackTrace();
									} */
									
									if (!isLate) {
							%>

							<li>

								<div class="listareaBox">
									<%
										if (catId != 5) {
									%>

									<a class="listareaBoximg"
										href="${pageContext.request.contextPath}/showSavouries/${loop.index}">
										<%
											} else if(catId==5 ) {
										%> <a class="listareaBoximg" href="${pageContext.request.contextPath}/showSpCakeOrder/${loop.index}">
											<%
												}
											%> <img
											src="${pageContext.request.contextPath}/resources/images/${menu.menuImage}"
											alt="monginis"> <img
											src="${pageContext.request.contextPath}/resources/images/${menu.selectedMenuImage}"
											alt="monginis">
									</a>
										<h2>
											<c:out value='${menu.menuTitle}' />
										</h2>
										<h3>
											Booking Up to
											<c:out value='${menu.time}' />
										</h3>
								</div>

							</li>


							<%
								} else {
							%>


							<li>

								<div class="listareaBox">

									<a class="listareaBoximg"
										onclick="javascript:showWindow('${menu.time}');"> <img
										src="${pageContext.request.contextPath}/resources/images/${menu.menuImage}"
										alt="monginis"> <img
										src="${pageContext.request.contextPath}/resources/images/${menu.selectedMenuImage}"
										alt="monginis"></a>


									<h2>
										<c:out value='${menu.menuTitle}' />
									</h2>
									<h3>
										Booking Up to
										<c:out value='${menu.time}' />
									</h3>
									</a>
								</div>

							</li>
							<%
								}
							%>
						</c:forEach>




					</ul>
				</div>

			</div>
		</div>
	</div>
	<!--1nav-->



	<!--2nav-->
	<div id="mySidenav1" class="sidenav">
		<div class="topSlide">
			<div class="topSlide2">
				<a href="javascript:void(0)" class="closebtn" onClick="closeNav1()"><img
					src="${pageContext.request.contextPath}/resources//images/closebtn.png"
					alt="monginis"></a>
				<div class="listarea">
					<ul>
						<li><div class="listareaBox">
								<a class="listareaBoximg"> <img
									src="${pageContext.request.contextPath}/resources/images/icon7.png"
									alt="monginis"> <img
									src="${pageContext.request.contextPath}/resources/images/icon7-h.png"
									alt="monginis"></a>
								<h2>GRN1</h2>
								<h3>Booking Up to 12.30 PM</h3>
								<div class="listareaBoxdown">
									<a href="order-savouries.html">Add <i class="fa fa-pencil"></i></a>
								</div>
								<div class="listareaBoxdown">
									<a href="order-savouries.html">Upload <i
										class="fa fa-cloud-upload"></i></a>
								</div>
							</div></li>

						<li><div class="listareaBox">
								<a class="listareaBoximg"> <img
									src="${pageContext.request.contextPath}/resources/images/icon8.png"
									alt="monginis"> <img
									src="${pageContext.request.contextPath}/resources/images/icon8-h.png"
									alt="monginis"></a>
								<h2>GRN2</h2>
								<h3>Booking Up to 12.30 PM</h3>
								<div class="listareaBoxdown">
									<a href="order-savouries.html">Add <i class="fa fa-pencil"></i></a>
								</div>
								<div class="listareaBoxdown">
									<a href="order-savouries.html">Upload <i
										class="fa fa-cloud-upload"></i></a>
								</div>
							</div></li>

						<li><div class="listareaBox">
								<a class="listareaBoximg"> <img
									src="${pageContext.request.contextPath}/resources/images/icon9.png"
									alt="monginis"> <img
									src="${pageContext.request.contextPath}/resources/images/icon9-h.png"
									alt="monginis"></a>
								<h2>GVN</h2>
								<h3>At Any Time Till Shop Closing</h3>
								<div class="listareaBoxdown">
									<a href="order-savouries.html">Add <i class="fa fa-pencil"></i></a>
								</div>
								<div class="listareaBoxdown">
									<a href="order-savouries.html">Upload <i
										class="fa fa-cloud-upload"></i></a>
								</div>
							</div></li>

					</ul>
				</div>

			</div>
		</div>
	</div>
	<!--2nav-->

	<!--3nav-->
	<div id="mySidenav3" class="sidenav">

		<div class="topSlide">
			<div class="topSlide2 textcen">
				<a href="javascript:void(0)" class="closebtn" onClick="closeNav3()"><img
					src="${pageContext.request.contextPath}/resources/images/closebtn.png"
					alt="monginis"></a>
				<div class="profileinsite">

					<div class="profileinsiteLeft">

						<div class="profile">
							<div class="profilefildset">Franchisee Name</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="franchisee Name"
									name="" type="text">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Franchisee Profile Pic</div>
							<div class="profileinput">
								<div class="editimg">
									<div class="editpics">
										<div class="fileUpload">
											<span><i class="fa fa-pencil"></i></span> <input type="file"
												class="upload" />
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
								<input class="texboxitemcode" placeholder="City Name" name=""
									type="text">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Email id</div>
							<div class="profileinput">
								<input class="texboxitemcode" name=""
									placeholder="example@gmail.com" type="text">
							</div>
						</div>



					</div>

					<div class="profileinsiteRight">
						<div class="profile">
							<div class="profilefildset">Mobile No.</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="9876543201" name=""
									type="text">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Owner Name</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="Owner Name" name=""
									type="text">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Shop Opening Date</div>
							<div class="profileinput mardis">26 Feb. 2017</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Edit Password</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="Edit Password"
									name="" type="text">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset">Confirm Password</div>
							<div class="profileinput">
								<input class="texboxitemcode" placeholder="Confirm Password"
									name="" type="text">
							</div>
						</div>

						<div class="profile">
							<div class="profileinput">
								<input name="" class="buttonsaveorder" value="SUBMIT"
									type="button">
							</div>
						</div>

					</div>

					<div class="messages messagesErr">err message</div>
					<div class="messages messagesInfo">info message</div>
					<div class="messages messagesSuccess">success message</div>


				</div>
			</div>
		</div>
	</div>
	<!--3nav-->

	<!--navInner-->
	<script>
		function openNav() {
			document.getElementById("mySidenav").style.width = "100%";
		}

		function closeNav() {
			document.getElementById("mySidenav").style.width = "0";
		}
		function openNav1() {
			document.getElementById("mySidenav1").style.width = "100%";
		}

		function closeNav1() {
			document.getElementById("mySidenav1").style.width = "0";
		}
		function openNav3() {
			document.getElementById("mySidenav3").style.width = "100%";
		}

		function closeNav3() {
			document.getElementById("mySidenav3").style.width = "0";
		}
	</script>

	<script
		src="${pageContext.request.contextPath}/resources/js/owl.carousel.min.js"></script>
	<script>
		$(document).ready(function() {
			$('.imgpath').click(function() {
				$(this).hide();
				$('.videoWrapper').show();
				$(".sproutvideo-player")[0].src += "?autoplay=1";
			});
			var owl = $("#owl-example");
			owl.owlCarousel({
				items : 2,
				loop : false,
				autoplay : false,
			});

		});
	</script>

	<script type="text/javascript">
		function showWindow(time) {
			confirm("Timeout:\n You can place order before " + time);
		}
	</script>

</body>
</html>