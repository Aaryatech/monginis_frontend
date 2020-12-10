<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate,java.util.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
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


<!--rightNav-->

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.selectlistbox.js"></script>


<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/menuzord.js"></script>

<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#menuzord").menuzord({
			align : "left"
		});
	});
</script>

<style type="text/css">
select {
	width: 130px;
	height: 30px;
}
</style>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<!---------------Script For Translate Special Instructions------->
<script type="text/javascript">
	// Load the Google Transliterate API
	google.load("elements", "1", {
		packages : "transliteration"
	});//984

	function onLoad() {
		var options = {
			sourceLanguage : google.elements.transliteration.LanguageCode.ENGLISH,
			destinationLanguage : [ google.elements.transliteration.LanguageCode.HINDI ],
			shortcutKey : 'ctrl+g',
			transliterationEnabled : true
		};

		// Create an instance on TransliterationControl with the required
		// options.
		var control = new google.elements.transliteration.TransliterationControl(
				options);

		// Enable transliteration in the textbox with id
		// 'transliterateTextarea'.
		control.makeTransliteratable([ 'transliterateTextarea' ]);
	}
	google.setOnLoadCallback(onLoad);
</script>
<!--------------------------------END------------------------------------>
<!--new css added by kalpesh -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" type="text/css" />

<!--new css added by kalpesh -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/jquery.mCustomScrollbar.css">

<style>
.fileUpload {
	margin: 0px 0px 0px 0px;
	padding-top: 1px;
}
</style>
</head>

<style>

/* Absolute Center Spinner */
.loading {
	position: fixed;
	z-index: 999;
	height: 2em;
	width: 2em;
	overflow: show;
	margin: auto;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
}

/* Transparent Overlay */
.loading:before {
	content: '';
	display: block;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: radial-gradient(rgba(20, 20, 20, .8), rgba(0, 0, 0, .8));
	background: -webkit-radial-gradient(rgba(20, 20, 20, .8),
		rgba(0, 0, 0, .8));
}

/* :not(:required) hides these rules from IE9 and below */
.loading
:not
 
(
:required
 
)
{
/* hide "loading..." text */
font
:
 
0/0
a
;

	
color
:
 
transparent
;

	
text-shadow
:
 
none
;

	
background-color
:
 
transparent
;

	
border
:
 
0;
}
.loading:not (:required ):after {
	content: '';
	display: block;
	font-size: 10px;
	width: 1em;
	height: 1em;
	margin-top: -0.5em;
	-webkit-animation: spinner 150ms infinite linear;
	-moz-animation: spinner 150ms infinite linear;
	-ms-animation: spinner 150ms infinite linear;
	-o-animation: spinner 150ms infinite linear;
	animation: spinner 150ms infinite linear;
	border-radius: 0.5em;
	-webkit-box-shadow: rgba(255, 255, 255, 0.75) 1.5em 0 0 0,
		rgba(255, 255, 255, 0.75) 1.1em 1.1em 0 0, rgba(255, 255, 255, 0.75) 0
		1.5em 0 0, rgba(255, 255, 255, 0.75) -1.1em 1.1em 0 0,
		rgba(255, 255, 255, 0.75) -1.5em 0 0 0, rgba(255, 255, 255, 0.75)
		-1.1em -1.1em 0 0, rgba(255, 255, 255, 0.75) 0 -1.5em 0 0,
		rgba(255, 255, 255, 0.75) 1.1em -1.1em 0 0;
	box-shadow: rgba(255, 255, 255, 0.75) 1.5em 0 0 0,
		rgba(255, 255, 255, 0.75) 1.1em 1.1em 0 0, rgba(255, 255, 255, 0.75) 0
		1.5em 0 0, rgba(255, 255, 255, 0.75) -1.1em 1.1em 0 0,
		rgba(255, 255, 255, 0.75) -1.5em 0 0 0, rgba(255, 255, 255, 0.75)
		-1.1em -1.1em 0 0, rgba(255, 255, 255, 0.75) 0 -1.5em 0 0,
		rgba(255, 255, 255, 0.75) 1.1em -1.1em 0 0;
}

/* Animation */
@
-webkit-keyframes spinner { 0% {
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	-ms-transform: rotate(0deg);
	-o-transform: rotate(0deg);
	transform: rotate(0deg);
}

100%
{
-webkit-transform


:

 

rotate


(360
deg
);


    

-moz-transform


:

 

rotate


(360
deg
);


    

-ms-transform


:

 

rotate


(360
deg
);


    

-o-transform


:

 

rotate


(360
deg
);


    

transform


:

 

rotate


(360
deg
);


  

}
}
@
-moz-keyframes spinner { 0% {
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	-ms-transform: rotate(0deg);
	-o-transform: rotate(0deg);
	transform: rotate(0deg);
}

100%
{
-webkit-transform


:

 

rotate


(360
deg
);


    

-moz-transform


:

 

rotate


(360
deg
);


    

-ms-transform


:

 

rotate


(360
deg
);


    

-o-transform


:

 

rotate


(360
deg
);


    

transform


:

 

rotate


(360
deg
);


  

}
}
@
-o-keyframes spinner { 0% {
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	-ms-transform: rotate(0deg);
	-o-transform: rotate(0deg);
	transform: rotate(0deg);
}

100%
{
-webkit-transform


:

 

rotate


(360
deg
);


    

-moz-transform


:

 

rotate


(360
deg
);


    

-ms-transform


:

 

rotate


(360
deg
);


    

-o-transform


:

 

rotate


(360
deg
);


    

transform


:

 

rotate


(360
deg
);


  

}
}
@
keyframes spinner { 0% {
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	-ms-transform: rotate(0deg);
	-o-transform: rotate(0deg);
	transform: rotate(0deg);
}
100%
{
-webkit-transform


:

 

rotate


(360
deg
);


    

-moz-transform


:

 

rotate


(360
deg
);


    

-ms-transform


:

 

rotate


(360
deg
);


    

-o-transform


:

 

rotate


(360
deg
);


    

transform


:

 

rotate


(360
deg
);


  

}
}
</style>

<body onload="onload()">
	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<c:url var="findAvailableSlot" value="/getAvailableSlot" />
		<c:url var="findAddOnRate" value="/getSpAddOnRate" />
		<c:url var="getSpCakeCatFlavourBySpfId"
			value="/getSpCakeCatFlavourBySpfId" />

		<c:url var="getSpOrderCountByProdDate"
			value="/getSpOrderCountByProdDate" />



		<jsp:include page="/WEB-INF/views/include/logo.jsp"></jsp:include>



		<!--topHeader-->
		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">
				<!--leftNav-->

				<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />
				</jsp:include>


				<!-- <div class="se-pre-con" id="loader"></div> -->

				<div class="loading" id="loader" style="display: none;">
				</div>



				<!--leftNav-->

				<!--rightSidebar-->
				<div class="sidebarright">
					<div class="order-left">
						<h2 class="pageTitle">${menuTitle}</h2>

					</div>
					<!--formBox-->
					<div class="ordercake">
						<!--leftForm-->
						<div class="left">
							<form action="${pageContext.request.contextPath}/searchSpCakeCat"
								method="get" class="form-horizontal" name="form" id="myform"
								onsubmit="return validateForm()">

								<div class="fullform">
									<div class="cackleft2">Item Code</div>
									<div class="cackrighttexbox">
										<input class="texboxitemcode" id="sp_code"
											value="${album.albumCode}" name="sp_code" type="text"
											autocomplete="off" list="categories"> <input
											type="hidden" id="hiddenDeliveryDate"
											name="hiddenDeliveryDate" value="${hideDeliveryDate}">

										<datalist id="categories">
											<c:forEach items="${configuredSpCodeList}"
												var="specialCakeList">
												<option
													value="${specialCakeList.albumCode}-${specialCakeList.albumName}-${specialCakeList.spCode}"></option>
											</c:forEach>
										</datalist>

										<div class="searchrecord">
											<input name="submitForm" class="btnsearch" value=""
												type="submit" id="submitForm">
										</div>
									</div>




								</div>
							</form>

							<div class="fullform">
								<div class="cackleft">Name</div>
								<div class="cackright">
									<span class="cakename">${album.albumName}</span>
								</div>
							</div>


							<div class="fullform">
								<div class="cackleft">Category</div>
								<div class="cackright" id="sp_name">
									<span class="cakename">${specialCake.spName}</span>
								</div>
							</div>


							<div class="fullform">
								<div class="cackimg">
									<div class="cackimglable"></div>
									<img src="${url_album}${album.photo1}"
										onerror="this.src='${pageContext.request.contextPath}/resources/images/No_Image_Available.jpg';">
								</div>
							</div>


							<div class="fullform">
								<div class="cackleft">Description</div>
								<div class="cackright" id="spDesc">
									<span class="cakename">${album.albumDesc}</span>
								</div>
							</div>


							<div class="fullform">
								<div class="cackleft">Min Weight</div>
								<div class="cackright" id="spMinWt">${album.minWt}Kg</div>
							</div>


							<div class="fullform">
								<div class="cackleft">Max Weight</div>
								<div class="cackright" id="spMaxWt">${album.maxWt}Kg</div>
							</div>


							<div class="fullform">
								<div class="cackleft">Production Time</div>
								<div class="cackright" id="spProTime">${specialCake.spBookb4}Days</div>
							</div>

							<c:set var="p" value="${specialCake.spCode}" />
							<div class="fullform">
								<div class="cackleft">Earliest Delivery Date</div>
								<div class="cackright">


									<c:set var="increment" value="${spBookb4}"></c:set>
									<c:set var="menuId" value="${menuId}"></c:set>
									<%
										int incr = (int) pageContext.getAttribute("increment");
										int menuId = (int) pageContext.getAttribute("menuId");
										// Create a Calendar object
										Calendar calendar = Calendar.getInstance();

										// Get current day from calendar
										int day = calendar.get(Calendar.DATE);
										// Get current month from calendar
										int month = calendar.get(Calendar.MONTH) + 1;
										// Get current year from calendar
										int year = calendar.get(Calendar.YEAR);
										calendar.add(Calendar.DATE, incr);

										day = calendar.get(Calendar.DATE);
										month = calendar.get(Calendar.MONTH);
										year = calendar.get(Calendar.YEAR);

										Calendar cal = Calendar.getInstance();
										cal.setTime(new Date()); // Now use today date.
										if (menuId != 68) {
											cal.add(Calendar.DATE, 1); // Adding 1 days
										}
										Date date = cal.getTime();
										SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

										String fDate = formatter.format(date);
										System.out.println("" + fDate);
										SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");

										String fDate1 = formatter1.format(date);
									%>
									<%=fDate1%>
								</div>
							</div>

						</div>


						<!----------------------------------------Form Start-------------------------------------------------->
						<form action="${pageContext.request.contextPath}/orderSpCakeCat"
							method="post" class="form-horizontal" name="from_ord"
							id="validation-form" enctype="multipart/form-data"
							onsubmit="return validate()">

							<input type="hidden" name="menu_id" id="menu_id"
								value="${menuId}"> <input type="hidden"
								name="menu_title" value="${menuTitle}"> <input
								type="hidden" name="mode_add" id="mode_add" value="add_book">
							<input type="hidden" name="sp_id" id="sp_id"
								value="${specialCake.spId}">
							<%-- <input type="hidden" name="sp_min_weight" id="sp_min_weight" value="${specialCake.spMinwt}">
<input type="hidden" name="sp_max_weight" id="sp_max_weight" value="${specialCake.spMaxwt}">
 --%>

							<input type="hidden" name="sp_min_weight" id="sp_min_weight"
								value="${album.minWt}"> <input type="hidden"
								name="sp_max_weight" id="sp_max_weight" value="${album.maxWt}">

							<input type="hidden" name="sp_pro_time" id="sp_pro_time"
								value="${specialCake.spBookb4}"> <input type="hidden"
								name="sp_est_del_date" id="sp_est_del_date" value="<%=fDate1%>">
							<input type="hidden" name="production_time" id="production_time"
								value="${specialCake.spBookb4} "> <input type="hidden"
								name="sp_code" id="sp_code" value="${specialCake.spCode}">
							<input type="hidden" name="sp_name" id="sp_name"
								value="${specialCake.spName}"> <input type="hidden"
								name="fr_code" id="fr_code" value="4"> <input
								type="hidden" name="spPhoUpload" id="spPhoUpload"
								value="${specialCake.spPhoupload}"> <input type="hidden"
								name="isCustCh" id="isCustCh"
								value="${specialCake.isCustChoiceCk}"> <input
								type="hidden" name="prevImage" id="prevImage"
								value="${album.photo1}"> <input type="hidden"
								name="isFound" id="isFound" value="${isFound}"
								onchange="onChangeValue()"> <input type="hidden"
								name="isCustChoiceCk" id="isCustChoiceCk"
								value="${specialCake.isCustChoiceCk}"> <input
								type="hidden" name="spPhoUpload" id="spPhoUpload"
								value="${specialCake.spPhoupload}"> <input type="hidden"
								name="isSlotUsed" id="isSlotUsed"
								value="${specialCake.isSlotUsed}"> <input type="hidden"
								name="isSameDayApplicable" id="isSameDayApplicable"
								value="${isSameDayApplicable}"> <input type="hidden"
								name="album_code" id="album_code" value="${album.albumCode}">
							<input type="hidden" name="album_id" id="album_id"
								value="${album.albumId}"> <input type="hidden"
								name="album_name" id="album_name" value="${album.albumName}">


							<!--centerForm-->

							<div class="center">


								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">Delivery Date</div>
									</div>
									<div class="col2">
										<c:choose>
											<c:when test="${menuId==68}">
												<input id="date" class="texboxitemcode texboxcal"
													value="<%=fDate%>" type="text" readonly>
												<input id="datepicker" class="texboxitemcode texboxcal"
													value="<%=fDate%>" name="datepicker" type="hidden" />

											</c:when>
											<c:when test="${menuId==72 || menuId==69 || menuId==73}">

												<input id="datepicker"
													class="texboxitemcode texboxcal deliveryDate"
													value="${hideDeliveryDate}" name="datepicker" type="text"
													required>

											</c:when>
											<c:otherwise>
												<input id="datepicker"
													class="texboxitemcode texboxcal deliveryDate"
													value="<%=fDate%>" name="datepicker" type="text" required>
											</c:otherwise>
										</c:choose>



									</div>
									<div class="col2">
										<!-- <a href="javascript:void(0)" style="background: #ec268f;    text-align: center;margin: 0px;padding: 7px 10px;cursor: pointer;border: 2px solid #ec268f;color: #fff;font-size: 12px;" onclick="getOrderCountByProdDate()">Check Limit</a> -->

										<input type="button" value="Check Slot"
											style="background: #ec268f; text-align: center; margin: 0px; padding: 7px 10px; cursor: pointer; border: 2px solid #ec268f; color: #fff; font-size: 12px;"
											onclick="getOrderCountByProdDate()">

										<c:if test="${specialCake.isSlotUsed=='1'}">
											<span class="cakename" id="slotUsedSpan">Check Slots
												availability</span>
										</c:if>
									</div>
								</div>



								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">Type</div>
									</div>
									<div class="col2full">
										<select name="sptype" tabindex="-1" id="sptype" required>
											<option value="">Select Type</option>
											<c:set var="spCakeType" value="${specialCake.spType}"></c:set>
											<c:choose>

												<c:when test="${spCakeType=='1'}">
													<option value="1">Chocolate</option>
												</c:when>
												<c:when test="${spCakeType=='2'}">
													<option value="2">FC</option>
												</c:when>
												<c:otherwise>

													<option value="1">Chocolate</option>
													<option value="2">FC</option>
												</c:otherwise>
											</c:choose>

										</select>
									</div>
								</div>

								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">Flavour</div>
									</div>
									<div class="col2full">
										<select name="spFlavour" tabindex="-1"
											onchange="onChangeFlavour()" id="spFlavour" required>
											<option value="">Select Flavour</option>
										</select>
									</div>
								</div>

								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">Weight</div>
									</div>
									<div class="col2">
										<c:set var="dbRate" scope="session" value="${sprRate}" />
										<input type="hidden" name="dbRate" id="dbRate"
											value="${sprRate}"> <input type="hidden"
											name="spBackendRate" id="spBackendRate"
											value="${spBackendRate}"> <select name="spwt"
											id="spwt" onchange="onChange('${dbRate}')" required>
											<c:forEach items="${weightList}" var="weightList">
												<option value="${weightList}">${weightList}</option>
											</c:forEach>

										</select>
										<div class="err" style="display: none;">Please Enter
											Weight</div>
									</div>
								</div>


								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">Message</div>
									</div>
									<div class="col2">
										<select name="sp_event" id="sp_event" required>

											<c:forEach items="${eventList}" var="eventList">
												<option value="${eventList.spMsgText}"><c:out
														value="${eventList.spMsgText}" /></option>
											</c:forEach>
										</select>
									</div>
									<div class="col3">
										<input class="texboxitemcode" placeholder="Name"
											name="event_name" type="text" id="event_name">
									</div>
								</div>



								<c:choose>
									<c:when test="${specialCake.isCustChoiceCk=='1'}">

										<div class="colOuter">
											<div class="col1">
												<div class="col1title"
													style="font-weight: bold; color: black;">Photo Cake1</div>
											</div>
											<div class="col2full">
												<div class="editimg">
													<div class="editpics">
														<div class="fileUpload">
															<span> <i class="fa fa-pencil"></i></span> <input
																class="upload" type="file" id="order_photo"
																name="order_photo" />

														</div>
													</div>
													<img id="image" />
												</div>
											</div>
										</div>
										<div class="colOuter">
											<div class="col1">
												<div class="col1title"
													style="font-weight: bold; color: black;">Photo Cake2</div>
											</div>
											<div class="col2full">
												<div class="editimg">
													<div class="editpics">
														<div class="fileUpload">
															<span> <i class="fa fa-pencil"></i></span> <input
																class="upload" type="file" id="cust_choice_ck"
																name="cust_choice_ck" />
														</div>
													</div>
													<img id="img" />
												</div>
											</div>
										</div>


									</c:when>
									<c:when test="${specialCake.spPhoupload=='1'}">

										<div class="colOuter">
											<div class="col1">
												<div class="col1title"
													style="font-weight: bold; color: black;">Photo Cake</div>
											</div>
											<div class="col2full">
												<div class="editimg">
													<div class="editpics">
														<div class="fileUpload">
															<span> <i class="fa fa-pencil"></i></span> <input
																class="upload" type="file" id="order_photo"
																name="order_photo" />

														</div>
													</div>
													<img id="image" />
												</div>
											</div>
										</div>

									</c:when>
								</c:choose>

								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">Select
											Language</div>
									</div>
									<div class="col2full">
										<select id="show" class="form-control" name="showtextarea"
											onchange="showDiv(this)" required>
											<option value="1" id="marathi">Marathi</option>
											<option value="2" id="english">English</option>
										</select>
									</div>
								</div>

								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">Special
											Instructions</div>
									</div>

									<div class="col1full" id="marathiDiv">
										<textarea id="transliterateTextarea" name="sp_inst1" cols=""
											rows="" style="width: 250px; height: 60px" maxlength="300"></textarea>
									</div>

									<div class="col1full" id="englishDiv" style="display: none;">
										<textarea id="textarea" name="sp_inst2" cols="" rows=""
											style="width: 200px; height: 90px" maxlength="300"></textarea>
									</div>
								</div>

								<%-- <div class="colOuter">
									<div class="col1">
										<div class="col1title">Delivery Date</div>
									</div>
									<div class="col2">
										<c:choose>
											<c:when test="${menuId==68}">
												<input id="date" class="texboxitemcode texboxcal"
													value="<%=fDate%>" type="text" readonly>
												<input id="datepicker" class="texboxitemcode texboxcal"
													value="<%=fDate%>" name="datepicker" type="hidden" />

											</c:when>
											<c:when test="${menuId==72 || menuId==69 || menuId==73}">

												<input id="datepicker"
													class="texboxitemcode texboxcal deliveryDate"
													value="${hideDeliveryDate}" name="datepicker" type="text"
													required>

											</c:when>
											<c:otherwise>
												<input id="datepicker"
													class="texboxitemcode texboxcal deliveryDate"
													value="<%=fDate%>" name="datepicker" type="text" required>
											</c:otherwise>
										</c:choose>




									</div>
									<div class="col2">
										<c:if test="${specialCake.isSlotUsed=='1'}">
											<span class="cakename" id="slotUsedSpan">Check Slots
												availability</span>
										</c:if>
									</div>
								</div> --%>


								<div class="colOuter">
									<div class="col1">
										<div class="col1title" style="font-weight: bold; color: red;">Fill
											this column in case of Cross Delivery (fill in Marathi/Hindi
											only)</div>
									</div>
									<div class="col2full">
										<input class="texboxitemcode"
											placeholder="Delivery at Other Location in Marathi/Hindi only"
											name="sp_place" id="sp_place" type="text" required>
									</div>
								</div>


								<div class="colOuter">
									<div class="col2">
										<input id="datepicker3" class="texboxitemcode texboxcal"
											placeholder="<%=fDate%>" name="datepicker3" type="hidden"
											required>
									</div>
								</div>


								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">Customer Name</div>
									</div>
									<div class="col2full">
										<input class="texboxitemcode texboxcal2"
											placeholder="Customer Name" name="sp_cust_name" type="text"
											id="sp_cust_name" required>
									</div>


									<%-- 		<div class="col3"><input id="datepicker4" class="texboxitemcode texboxcal" placeholder="<%=fDate %>" name="datepicker4" type="text"required></div>
 --%>
								</div>
								<div class="colOuter" style="display: none;">
									<div class="col1">
										<div class="col1title">DOB</div>
									</div>

									<div class="col2full">
										<input id="datepicker4" autocomplete="off"
											class="texboxitemcode texboxcal" placeholder="<%=fDate%>"
											name="datepicker4" type="text" required>
									</div>
								</div>
								<div class="colOuter" style="display: none;">
									<div class="col1">
										<div class="col1title">Mobile</div>
									</div>

									<div class="col2full">
										<input class="texboxitemcode" placeholder="Mobile No."
											name="sp_cust_mobile_no" type="text" id="sp_cust_mobile_no"
											required>
									</div>

								</div>
								<div class="colOuter">
									<div class="col1">
										<div class="col1title"
											style="font-weight: bold; color: black;">GSTIN</div>
									</div>

									<div class="col2full">
										<input class="texboxitemcode" placeholder="GSTIN No."
											name="gstin" type="text" id="gstin">
									</div>

								</div>
								<span class="cakename" id="slotsNotAvailable"></span>

								<div class="colOuter">
									<div class="col1">
										<input class="texboxitemcode texboxcal2"
											placeholder="Booked For" name="sp_booked_for_name"
											type="hidden" id="sp_booked_for_name">
									</div>
									<div class="col2">
										<input id="datepicker5" class="texboxitemcode texboxcal"
											placeholder="<%=fDate%>" name="datepicker5" type="hidden">
									</div>
									<div class="col3">
										<input class="texboxitemcode" placeholder="Mobile No."
											name="sp_book_for_number" type="hidden"
											id="sp_book_for_number">
									</div>
								</div>


								<div class="cackleft" id="error">
									<span class="cakename"> <c:if
											test="${not empty errorMessage}">
											<h3>
												<c:out value="${errorMessage}" />
											</h3>
										</c:if></span>
								</div>
							</div>

							<!--centerForm-->

							<!--rightForm-->
							<div class="right">
								<div class="priceBox">
									<h2 class="inrbox" id="INR">INR - ${(sprRate*album.minWt)}</h2>
									<input type="hidden" name="sp_grand" id="sp_grand"
										value="${(sprRate*album.minWt)}">
									<div class="inrboxmiddle">
										<ul>
											<li>
												<div class="priceLeft">Type</div>
												<div class="priceRight">
													<span>Premium</span>
												</div>
											</li>
											<li>
												<div class="priceLeft">Price</div>
												<div class="priceRight" id="price">${sprRate*album.minWt}</div>
												<input name="sp_calc_price" id="sp_calc_price"
												value="${sprRate*album.minWt}" type="hidden">
											</li>
											<li>
												<div class="priceLeft">Add Rate</div>
												<div class="priceRight" id="rate">00</div> <input
												name="sp_add_rate" id="sp_add_rate" type="hidden" value="0">
											</li>
											<li>
												<div class="priceLeft">Sub Total</div>
												<div class="priceRight" id="subtotal">${sprRate*album.minWt}</div>
												<input name="sp_sub_total" id="sp_sub_total" type="hidden"
												value="${sprRate*album.minWt}">
											</li>
											<li>
												<div class="priceLeft">GST (%)</div>
												<div class="priceRight" id="taxPer3">
													${specialCake.spTax1+specialCake.spTax2}</div> <input
												type="hidden" id="tax3" name="tax3"
												value="${specialCake.spTax1+specialCake.spTax2}">
											</li>
											<li>
												<div class="priceLeft">GST IN RS.</div> <c:set
													var="varGstRs"
													value="${(((sprRate*album.minWt)*100)/((specialCake.spTax1+specialCake.spTax2)+100))*(specialCake.spTax1+specialCake.spTax2)/100}" />
												<fmt:formatNumber var="fGstRs" minFractionDigits="2"
													maxFractionDigits="2" type="number" value="${varGstRs}" />

												<div class="priceRight" id="gstrs">
													<c:out value="${fGstRs}" />
												</div> <input type="hidden" id="gst_rs" name="gst_rs"
												value="${fGstRs}">
											</li>
											<li class="total"><c:set var="varMgstamt"
													value="${(((sprRate*album.minWt)*100)/((specialCake.spTax1+specialCake.spTax2)+100))}" />
												<fmt:formatNumber var="fMgstamt" minFractionDigits="2"
													maxFractionDigits="2" type="number" value="${varMgstamt}" />

												<div class="priceLeft" id="mgstamt">
													AMT-
													<c:out value="${fMgstamt}"></c:out>
												</div> <input type="hidden" name="m_gst_amt" id="m_gst_amt"
												type="hidden" value="${fMgstamt}">

												<div class="priceRight" id="tot">TOTAL-${(sprRate*album.minWt)}</div>

												<input type="hidden" name="total_amt" id="total_amt"
												value="${(sprRate*album.minWt)}"></li>

											<li class="advance">
												<div class="priceLeft">Advance</div>
												<div class="priceRight">
													<input name="adv" id="adv" value="00" class="tableInput"
														type="text" onkeyup="advanceFun()">
												</div>

											</li>
										</ul>
									</div>
									<div class="remainamount">
										<div class="priceLeft">Remaining Amount</div>
										<div class="priceRight" id="rmAmt">${(sprRate*album.minWt)}</div>
										<input type="hidden" name="rm_amount" id="rm_amount"
											value="${(sprRate*album.minWt)}">
									</div>
								</div>

								<div class="order-btn">
									<input name="" class="btnSubmit" value="SUBMIT" type="button"
										id="click"> <input name="" class="btnReset"
										value="RESET" type="hidden">
								</div>

							</div>
							<input type="hidden" id="tax1" name="tax1"
								value="${specialCake.spTax1}"> <input type="hidden"
								id="tax2" name="tax2" value="${specialCake.spTax2}">


							<c:if test="${specialCake.spTax1==0 or specialCake.spTax1==0.00}">
								<input type="hidden" id="t1amt" name="t1amt" value="0.0">
							</c:if>
							<c:if test="${specialCake.spTax1!=0 or specialCake.spTax1!=0.00}">
								<input type="hidden" id="t1amt" name="t1amt"
									value="${(sprRate*album.minWt)*(specialCake.spTax1)/100}">

							</c:if>
							<c:if test="${specialCake.spTax2==0 or specialCake.spTax2!=0.00}">
								<input type="hidden" id="t2amt" name="t2amt" value="0.0">
							</c:if>
							<c:if test="${specialCake.spTax2!=0 or specialCake.spTax2!=0.00}">
								<input type="hidden" id="t2amt" name="t2amt"
									value="${(sprRate*album.minWt)*(specialCake.spTax2)/100}">

							</c:if>

							<input type="hidden" id="dbAdonRate" name="dbAdonRate" value="">
							<input type="hidden" id="dbPrice" name="dbPrice"
								value="${sprRate}"> <input type="hidden" id="sp_id"
								name="sp_id" value="${specialCake.spId}">
						</form>
						<!--rightForm-->


						<!--formBox-->



					</div>
					<!--rightSidebar-->

				</div>
				<!--fullGrid-->
			</div>
			<!--rightContainer-->

		</div>

		<script>
			$(function() {
				$('#sp_code').change(function() {
					$('.col').hide();
					$('#' + $(this).val()).show();
				});
			});
		</script>

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

		<!------------------------GETTING FLAVOURS BY SELECTED FLAVOUR TYPE---------------------------->
		<script type="text/javascript">
			$(document)
					.ready(
							function() {
								$('#sptype')
										.change(
												function() {
													$
															.getJSON(
																	'${getSpCakeCatFlavourBySpfId}',
																	{
																		spType : $(
																				this)
																				.val(),
																		ajax : 'true'
																	},
																	function(
																			data) {
																		var html = '<option value="">Flavour</option>';

																		var len = data.length;

																		for (var i = 0; i < len; i++) {
																			html += '<option value="' + data[i].spfId + '">'
																					+ data[i].spfName
																					+ '</option>';
																		}
																		html += '</option>';
																		$(
																				'#spFlavour')
																				.html(
																						html);
																		$('#spFlavour').form
																				- control('refresh');

																	});
												});
							});
		</script>
		<!------------------------------------------------END------------------------------------------------>
		<!------------------------CALLING FUNCTION WHEN WEIGHT CHANGE---------------------------------------->

		<script type="text/javascript">
			function onChange(dbRate) {
				var wt = $('#spwt').find(":selected").text();
				var flavourAdonRate = $("#dbAdonRate").val();
				var tax3 = parseFloat($("#tax3").val());
				var tax1 = parseFloat($("#tax1").val());
				var tax2 = parseFloat($("#tax2").val());
				//alert("tax1:"+tax1+"tax2"+tax2+"tax3"+tax3);

				var totalCakeRate = wt * dbRate;
				var totalFlavourAddonRate = wt * flavourAdonRate;
				var add = parseFloat(totalCakeRate + totalFlavourAddonRate);
				var grandTotal = parseFloat(add);
				var spSubtotal = add;

				var mrpBaseRate = parseFloat((spSubtotal * 100) / (tax3 + 100));

				var gstInRs = 0;
				var taxPerPerc1 = 0;
				var taxPerPerc2 = 0;
				var tax1Amt = 0;
				var tax2Amt = 0;
				if (tax3 == 0) {
					gstInRs = 0;

				} else {
					gstInRs = (mrpBaseRate * tax3) / 100;

					if (tax1 == 0) {
						taxPerPerc1 = 0;
					} else {
						taxPerPerc1 = parseFloat((tax1 * 100) / tax3);
						tax1Amt = parseFloat((gstInRs * taxPerPerc1) / 100);

					}
					if (tax2 == 0) {
						taxPerPerc2 = 0;
					} else {
						taxPerPerc2 = parseFloat((tax2 * 100) / tax3);
						tax2Amt = parseFloat((gstInRs * taxPerPerc2) / 100);

					}
				}

				$('#gstrs').html(gstInRs.toFixed(2));
				document.getElementById("gst_rs").setAttribute('value',
						gstInRs.toFixed(2));

				var mGstAmt = mrpBaseRate;
				$('#mgstamt').html('AMT-' + mGstAmt.toFixed(2));
				document.getElementById("m_gst_amt").setAttribute('value',
						mGstAmt.toFixed(2));

				$('#price').html(wt * dbRate);
				$('sp_calc_price').html(wt * dbRate);
				$('#rate').html(wt * flavourAdonRate);
				document.getElementById("sp_add_rate").setAttribute('value',
						wt * flavourAdonRate);
				$('#subtotal').html(grandTotal);
				document.getElementById("sp_sub_total").setAttribute('value',
						add);

				$('#INR').html('INR-' + grandTotal);
				document.getElementById("sp_grand").setAttribute('value',
						grandTotal);
				$('#tot').html('TOTAL-' + grandTotal);
				document.getElementById("total_amt").setAttribute('value',
						grandTotal);
				$('#rmAmt').html(grandTotal);
				document.getElementById("rm_amount").setAttribute('value',
						grandTotal);

				document.getElementById("t1amt").setAttribute('value',
						tax1Amt.toFixed(2));

				document.getElementById("t2amt").setAttribute('value',
						tax2Amt.toFixed(2));

			}
		</script>
		<!------------------------------------------------END------------------------------------------------>
		<!------------------------CALLING FUNCTION WHEN FLAVOUR CHANGE FOR GETTING ADDON RATE---------------->
		<script type="text/javascript">
			$(document)
					.ready(
							function() {
								$('#spFlavour')
										.change(
												function() {

													//alert("SP ID ----- "+$(this).val());

													$
															.getJSON(
																	'${findAddOnRate}',
																	{
																		spfId : $(
																				this)
																				.val(),
																		ajax : 'true'
																	},
																	function(
																			data) {
																		//alert("ADD ON RATE ---------------- "+JSON.stringify(data));
																		$(
																				'#rate')
																				.empty();
																		$(
																				"#dbAdonRate")
																				.val(
																						data.spfAdonRate);
																		$(
																				"#rate")
																				.html(
																						data.spfAdonRate);

																		document
																				.getElementById(
																						"sp_add_rate")
																				.setAttribute(
																						'value',
																						data.spfAdonRate);

																		var wt = $(
																				'#spwt')
																				.find(
																						":selected")
																				.text();

																		var flavourAdonRate = data.spfAdonRate;

																		var tax3 = parseFloat($(
																				"#tax3")
																				.val());
																		var tax1 = parseFloat($(
																				"#tax1")
																				.val());
																		var tax2 = parseFloat($(
																				"#tax2")
																				.val());

																		var price = $(
																				"#dbPrice")
																				.val();

																		var totalFlavourAddonRate = wt
																				* flavourAdonRate;

																		var totalCakeRate = wt
																				* price;
																		var totalAmount = parseFloat(totalCakeRate
																				+ totalFlavourAddonRate);

																		var mrpBaseRate = parseFloat((totalAmount * 100)
																				/ (tax3 + 100));
																		/*  var gstInRs=parseFloat((mrpBaseRate*tax3)/100);
																		 
																		    var taxPerPerc1=parseFloat((tax1*100)/tax3);
																			var taxPerPerc2=parseFloat((tax2*100)/tax3);
																		 
																			var tax1Amt=parseFloat((gstInRs*taxPerPerc1)/100);
																			var tax2Amt=parseFloat((gstInRs*taxPerPerc2)/100); */
																		var gstInRs = 0;
																		var taxPerPerc1 = 0;
																		var taxPerPerc2 = 0;
																		var tax1Amt = 0;
																		var tax2Amt = 0;
																		if (tax3 == 0) {
																			gstInRs = 0;

																		} else {
																			gstInRs = (mrpBaseRate * tax3) / 100;

																			if (tax1 == 0) {
																				taxPerPerc1 = 0;
																			} else {
																				taxPerPerc1 = parseFloat((tax1 * 100)
																						/ tax3);
																				tax1Amt = parseFloat((gstInRs * taxPerPerc1) / 100);

																			}
																			if (tax2 == 0) {
																				taxPerPerc2 = 0;
																			} else {
																				taxPerPerc2 = parseFloat((tax2 * 100)
																						/ tax3);
																				tax2Amt = parseFloat((gstInRs * taxPerPerc2) / 100);

																			}
																		}

																		var grandTotal = parseFloat(totalCakeRate
																				+ totalFlavourAddonRate);

																		$(
																				'#price')
																				.html(
																						totalCakeRate);
																		$(
																				'#sp_calc_price')
																				.html(
																						totalCakeRate);
																		$(
																				'#rate')
																				.html(
																						totalFlavourAddonRate);
																		$(
																				'#sp_add_rate')
																				.html(
																						totalFlavourAddonRate);
																		document
																				.getElementById(
																						"sp_add_rate")
																				.setAttribute(
																						'value',
																						totalFlavourAddonRate);
																		$(
																				'#subtotal')
																				.html(
																						totalCakeRate
																								+ totalFlavourAddonRate);

																		document
																				.getElementById(
																						"sp_sub_total")
																				.setAttribute(
																						'value',
																						totalCakeRate
																								+ totalFlavourAddonRate);
																		$(
																				'#INR')
																				.html(
																						'INR-'
																								+ grandTotal);
																		document
																				.getElementById(
																						"sp_grand")
																				.setAttribute(
																						'value',
																						grandTotal);
																		$(
																				'#tot')
																				.html(
																						'TOTAL-'
																								+ grandTotal);
																		document
																				.getElementById(
																						"total_amt")
																				.setAttribute(
																						'value',
																						grandTotal);
																		$(
																				'#rmAmt')
																				.html(
																						grandTotal);
																		document
																				.getElementById(
																						"rm_amount")
																				.setAttribute(
																						'value',
																						grandTotal);

																		document
																				.getElementById(
																						"t1amt")
																				.setAttribute(
																						'value',
																						tax1Amt
																								.toFixed(2));

																		document
																				.getElementById(
																						"t2amt")
																				.setAttribute(
																						'value',
																						tax2Amt
																								.toFixed(2));

																		$(
																				'#gstrs')
																				.html(
																						gstInRs
																								.toFixed(2));
																		document
																				.getElementById(
																						"gst_rs")
																				.setAttribute(
																						'value',
																						gstInRs
																								.toFixed(2));
																		$(
																				'#mgstamt')
																				.html(
																						'AMT-'
																								+ mrpBaseRate
																										.toFixed(2));
																		document
																				.getElementById(
																						"m_gst_amt")
																				.setAttribute(
																						'value',
																						mrpBaseRate
																								.toFixed(2));

																	});
												});
							});
		</script>
		<!------------------------------------------------END------------------------------------------------>
		<!------------------------------------REMAINING AMOUNT ONKEYUP FUNCTION------------------------------>
		<script type="text/javascript">
			function advanceFun() {
				var advance = $("#adv").val();
				var rmamt = $("#total_amt").val();
				$('#rmAmt').html(rmamt - advance);
				document.getElementById("rm_amount").setAttribute('value',
						rmamt - advance);
			}
		</script>
		<!------------------------------------------------END------------------------------------------------>
		<!------------------------------BLANK VALIDATION FOR SPCODE------------------------------------------>

		<script type="text/javascript">
			function validateForm() {
				var spCode = document.forms["form"]["sp_code"].value;
				if (spCode == "") {
					alert("Special Cake Code must be filled out");
					document.getElementById('sp_code').focus();
					return false;
				}
			}
		</script>
		<!-------------------------------------------ALL VALIDATIONS----------------------------------------->
		<script type="text/javascript">
			function validate() {

				var phoneNo = /^\d{10}$/;

				var eventName, spId, spCustName, spPlace, spCustMob, spType, spFlavour, spCode, spWt;
				eventName = document.getElementById("event_name").value;
				spPlace = document.getElementById("sp_place").value;
				spCustName = document.getElementById("sp_cust_name").value;
				spCustMob = document.getElementById("sp_cust_mobile_no").value;
				spType = document.getElementById("sptype").value;
				spFlavour = document.getElementById("spFlavour").value;
				spCode = document.getElementById("sp_code").value;
				spWt = document.getElementById("spwt").value;
				var isValid = true;
				
				
				//var photo1=document.getElementById("order_photo").value;
				//var photo2=document.getElementById("cust_choice_ck").value;
				
				//var isCustPhotoCake=${specialCake.isCustChoiceCk};
				//var isPhoto=${specialCake.spPhoupload};
				//alert(isPhoto);
				
				

				if (spCode == "") {
					alert("Special Cake Code must be filled out");

					isValid = false;
				} else if (spType == "") {
					alert("Please Select Special Cake Type");

					isValid = false;
				} else if (spWt == "") {
					alert("Please Select Special Cake Weight");

					isValid = false;
				} else if (spFlavour == "") {
					alert("Please Select Flavour");

					isValid = false;
				} else if (eventName == "") {
					alert("Please Enter Message");
					document.getElementById('event_name').focus();

					isValid = false;
				} 
				/* else if (spPlace == "") {
					alert("Please Enter Place of delivery");
					document.getElementById('sp_place').focus();

					isValid = false;
				} */
				else if (spCustName == "") {
					alert("Please Enter Customer Name");
					document.getElementById('sp_cust_name').focus();

					isValid = false;
				} 
				
				
				
				
/* 				
			  	else if(isCustPhotoCake == 1 && isPhoto==1){
			  		
					
					 if(photo1 == ""){
						
						alert("Please Select Photo 1");
						isValid = false;
						
					}else if(photo2 == ""){
						
						alert("Please Select Photo 2");
						isValid = false;
						
					} 
					
				} 
				 */
				
			  	/* else if(isCustPhotoCake == 0 && isPhoto==1){
			  		
					
					 if(photo1 == ""){
						
						alert("Please Select Photo 1");
						isValid = false;
						
					}
					
				} */ 
				
			/* 	else if(isPhoto==1){
					if(photo1 == ""){				
						alert("Please Select Photo 1");
						isValid = false;	
					}
				} */
				
				/* else if (spCustMob.match(phoneNo)) {
					return true;
				} else {
					alert("Not a valid Mobile Number");
					document.getElementById('sp_cust_mobile_no').value = "";
					document.getElementById('sp_cust_mobile_no').focus();
					return false;
				} */

				return isValid;

			}
		</script>
		<!------------------------------------------------END------------------------------------------------>
		<!------------------------------------------SELECT PHOTO SCRIPT-------------------------------------->

		<script>
			document.getElementById("order_photo").onchange = function() {
				var reader = new FileReader();

				reader.onload = function(e) {
					// get loaded data and render thumbnail.
					document.getElementById("image").src = e.target.result;
				};

				// read the image file as a data URL.
				reader.readAsDataURL(this.files[0]);
			};
		</script>
		<script>
			document.getElementById("cust_choice_ck").onchange = function() {
				var reader = new FileReader();

				reader.onload = function(e) {
					// get loaded data and render thumbnail.
					document.getElementById("img").src = e.target.result;
				};

				// read the image file as a data URL.
				reader.readAsDataURL(this.files[0]);
			};
		</script>
		<!------------------------------------------------END------------------------------------------------>

		<!-------------------------------Getting Available Slots ON Date Selection---------------------------->

		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
		<script>
			var todaysDate = new Date();
			var min = new Date(todaysDate.setDate(todaysDate.getDate() + 1));

			$(function() {
				$("#datepicker")
						.datepicker(
								{
									dateFormat : 'dd-mm-yy',
									minDate : min,
									onSelect : function(date) {

										//alert("hi");

										var isSlotUsed = $("#isSlotUsed").val();

										var produTime = $("#sp_pro_time").val();

										if (isSlotUsed == '1') {
											$
													.getJSON(
															'${findAvailableSlot}',
															{
																deldate : date,
																prodTime : produTime,
																ajax : 'true'
															},
															function(
																	availableSlots) {

																if (availableSlots > 0) {

																	$(
																			"#slotUsedSpan")
																			.html(
																					availableSlots
																							+ ' Slots Available');

																} else {

																	$(
																			"#slotUsedSpan")
																			.html(
																					'No Slots Available');

																}

															});
										}

										if (document.getElementById("menu_id").value == 72
												|| document
														.getElementById("menu_id").value == 69
												|| document
														.getElementById("menu_id").value == 73) {

											document
													.getElementById("hiddenDeliveryDate").value = date;
											//document.getElementById("myForm").submit();
											document.getElementById(
													"submitForm").click();

										}

										//alert("hi");
										getOrderCountByProdDate();

									}

								});
			});
			$(function() {
				$("#datepicker1").datepicker({
					dateFormat : 'dd-mm-yy'
				});
			});
			$(function() {
				$("#datepicker2").datepicker({
					dateFormat : 'dd-mm-yy'
				});
			});
			$(function() {
				$("#datepicker3").datepicker({
					dateFormat : 'dd-mm-yy'
				});
			});
			$(function() {
				$("#datepicker4").datepicker({
					dateFormat : 'dd-mm-yy'
				});
			});
			$(function() {
				$("#datepicker5").datepicker({
					dateFormat : 'dd-mm-yy'
				});
			});
		</script>
		<!-----------------------------------------END----------------------------------------------------->
		<!-------------------------Getting Available Slots On Submit Click -------------------------------->

		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
		<script>
			$(document)
					.ready(
							function() {
								$("#click")
										.click(
												function() {
													
														var date = $('#datepicker')
														.datepicker(
																{
																	dateFormat : 'dd-mm-yy'
																}).val();
												
												

												var isSlotUsed = $(
														"#isSlotUsed")
														.val();

												var produTime = $(
														"#sp_pro_time")
														.val();

												if (isSlotUsed == '1') {

													$
															.getJSON(
																	'${findAvailableSlot}',
																	{
																		deldate : date,
																		prodTime : produTime,
																		ajax : 'true'
																	},
																	function(
																			availableSlots) {

																		if (availableSlots > 0) {
																			$(
																					"#slotUsedSpan")
																					.html(
																							availableSlots
																									+ ' Slots Available');
																			var valid = validate();

																			if (valid) {
																				
																				submitGetOrderCountByProdDate();
																				
																				/* document.forms["from_ord"]
																						.submit(); */
																			}

																		} else {

																			$(
																					"#slotsNotAvailable")
																					.html(
																							'No Slots Available');
																			alert("Sorry, No Slots Available !");
																		}

																	});
												} else {
													var valid = validate();

													if (valid) {
														
														submitGetOrderCountByProdDate();
														
														/* document.forms["from_ord"]
																.submit(); */
													}

												}
														
													
													

												
													
													
													
													
												});
							});
		</script>
		<!-----------------------------------------END----------------------------------------------------->
		<!---------Hide And Show Div For Marathi And English Textarea------- -->
		<script>
			function showDiv(elem) {
				if (elem.value == 1) {
					document.getElementById('marathiDiv').style.display = "block";
					document.getElementById('englishDiv').style = "display:none";
				} else if (elem.value == 2) {
					document.getElementById('englishDiv').style.display = "block";
					document.getElementById('marathiDiv').style = "display:none";
				}

			}
		</script>
		<!------------------------END-------------------------------------------->



		<!-- 		<script type="text/javascript">
		
		
		
		$(document).ready(function() {
			
			var mId=document.getElementById("menu_id").value;
		   
		});
		
		</script> -->


		<script type="text/javascript">
		
		function getOrderCountByProdDate(){
			
			var prodDate = $('#datepicker')
			.datepicker(
					{
						dateFormat : 'dd-mm-yy'
					}).val();
			
			
			var bookBefore =document.getElementById("sp_pro_time").value;
			
			$("#loader").show();
			
				$.getJSON('${getSpOrderCountByProdDate}', {
					prodDate : prodDate,
					bookBefore : bookBefore,
					menuId : ${menuId},
					ajax : 'true'
				}, function(data) {
					//alert(JSON.stringify(data));
					
					$("#loader").hide();
					
					if(data.message=='false'){
						alert("Slot Full - Daily Limit Exceeded!");
					}else{
						alert("Slot Available");
					}

				});

			}
		
		
		function submitGetOrderCountByProdDate(){
			
			var prodDate = $('#datepicker')
			.datepicker(
					{
						dateFormat : 'dd-mm-yy'
					}).val();
			
			var bookBefore =document.getElementById("sp_pro_time").value;
			
			$("#loader").show();
			
				$.getJSON('${getSpOrderCountByProdDate}', {
					prodDate : prodDate,
					bookBefore : bookBefore,
					menuId : ${menuId},
					ajax : 'true'
				}, function(data) {
					//alert(JSON.stringify(data));
					
					
					
					if(data.message=='false'){
						$("#loader").hide();
						alert("Slot Full - Daily Limit Exceeded!");
					}else{
						//alert("ok");
						 document.forms["from_ord"].submit(); 
					}

				});

			}
		
		</script>
</body>
</html>
