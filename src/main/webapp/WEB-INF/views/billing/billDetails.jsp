<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


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

<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#fromdatepicker").datepicker({ dateFormat: 'dd-mm-yy' });
	});
	$(function() {
		$("#todatepicker").datepicker({ dateFormat: 'dd-mm-yy' });
	});
</script>
<!--datepicker-->


<style>
#snackbar {
    visibility: hidden; /* Hidden by default. Visible on click */
    min-width: 250px; /* Set a default minimum width */
    margin-left: -125px; /* Divide value of min-width by 2 */
    background-color: #333; /* Black background color */
    color: #fff; /* White text color */
    text-align: center; /* Centered text */
    border-radius: 2px; /* Rounded borders */
    padding: 16px; /* Padding */
    position: fixed; /* Sit on top of the screen */
    z-index: 1; /* Add a z-index if needed */
    left: 50%; /* Center the snackbar */
    bottom: 30px; /* 30px from the bottom */
}

/* Show the snackbar when clicking on a button (class added with JavaScript) */
#snackbar.show {
    visibility: visible; /* Show the snackbar */

/* Add animation: Take 0.5 seconds to fade in and out the snackbar. 
However, delay the fade out process for 2.5 seconds */
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

/* Animations to fade the snackbar in and out */
@-webkit-keyframes fadein {
    from {bottom: 0; opacity: 0;} 
    to {bottom: 30px; opacity: 1;}
}

@keyframes fadein {
    from {bottom: 0; opacity: 0;}
    to {bottom: 30px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {bottom: 30px; opacity: 1;} 
    to {bottom: 0; opacity: 0;}
}

@keyframes fadeout {
    from {bottom: 30px; opacity: 1;}
    to {bottom: 0; opacity: 0;}
}
</style>

</head>
<body onload="myFunction(${billStatus})">
<c:url var="updateBillStatus" value="/updateBillStatus" />

	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<%-- <c:url var="findAddOnRate" value="/getAddOnRate" />
<c:url var="findItemsByCatId" value="/getFlavourBySpfId" />
<c:url var="findAllMenus" value="/getAllTypes" /> --%>
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


		<!--topHeader-->

		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">

				<!--leftNav-->

				<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />
				</jsp:include>


				<!--leftNav-->



				<!--rightSidebar-->
				<div class="sidebarright">
					<!-- <div class="order-left">
						<h2 class="pageTitle">Bills</h2>
						<h3 class="pageTitle2">Order Date : 22-02-2017 </h3>
					</div> -->

		<%-- 			<form name="frm_search" id="frm_search" method="post"
						action="showBillProcess">
						<input type="hidden" name="mod_ser" id="mod_ser"
							value="search_result">

						

						<div class="colOuter">
		<div class="col1"><div class="col1title">Delivery Order / GRN / GVN  Date</div></div>
		<div class="col2"><input id="datepicker" class="texboxitemcode texboxcal" placeholder="Delivery Date"  name="datepicker" type="text" value="${spDeliveryDt}" >
		</div>
	</div>
	
						<div class="colOuter">
							<div class="col2full">
								<input name="" class="buttonsaveorder" value="Search..."
									type="submit">
							</div>
						</div>

					</form> --%>
		<div class="sidebarright">
	
		<div class=" col-md-2">
		    <h2 class=" pull-left">Bill No:-  <b>${billNo}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></h4>
		</div>
	
		<div class="col-md-2">
		    <h2 class="pull-left">Bill Date:- <b> ${billDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></h4>
		</div>
			<div class="col-md-3">
		    <h2 class="pull-left">Grand Total:- <b> ${grandTotal}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></h4>
		</div>
		<div class="col-md-4 ">
			  <h2 class="pull-left">Bill Status:- <c:choose>
																	<c:when test="${billStatus==1}">
																		<b><c:out value="Pending"></c:out></b>
																	</c:when>
																	<c:when test="${billStatus==2}">
																		<b><c:out value="Receive"></c:out></b>
																		
																	</c:when>
																	<c:when test="${billStatus== 3}">
																		<b><c:out value="GVN Apply"></c:out></b>
																	</c:when>
																	<c:when test="${billStatus== 4}">
																		<b><c:out value="GVN Approve"></c:out></b>
																	</c:when>
																	<c:when test="${billStatus== 5}">
																		<b><c:out value="GRN Apply"></c:out></b>
																	</c:when>
																		<c:when test="${billStatus== 6}">
																		<b><c:out value="GRN Approve"></c:out></b>
																	</c:when>
																		<c:when test="${billStatus== 7}">
							 									<b><c:out value="Closed"></c:out></b>
																	</c:when>

																</c:choose></h4>
		</div>
		
		 <div class="col-md-2 ">
								<input name="" class="buttonsaveorder" value="Received"
									type="button" id="updateStatus" onclick="updateStatus(${billNo})">
							</div>
    </div>
					<div id="snackbar" style="background:pink;">Order Received</div>

					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->
						<ul class="cd-tabs-content">
							<!--tab1-->
							<li data-content="tab1" class="selected">
								<div class="table-responsive">
									<div class="shInnerwidth">
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
						<tr>
							<td align="center" valign="middle" style="padding:0px;">

										<table width="100%" id="table1">
											<tr class="bgpink">
												<th width="138" style="width: 18px" align="left">Sr No</th>
													<th width="138" align="left">Item Name</th>
													<th width="159" align="left">Group</th>
													<th width="105" align="left">Order Qty</th>
													<th width="270" align="right">Billed Qty</th>
												
													<th width="159" align="left">MRP</th>
														<th width="91" align="left">Rate</th>
														<th width="105" align="left">Taxable Amt</th>
													<th width="105" align="left">GST %</th>
													
													<th width="105" align="left">Tax Amount</th>
													<th width="105" align="left">Grand Total</th>
													
													<th width="159" align="left">Remark</th>
											</tr>
													
											<c:forEach items="${billDetailsList}" var="billDetailsList" varStatus="count">
												<tr>
													<td><c:out value="${count.index+1}" /></td>
													<td><c:out value="${billDetailsList.itemName}" /></td>
													<td><c:out value="${billDetailsList.catName}" /></td>
													<td><c:out value="${billDetailsList.orderQty}" /></td>
													<td><c:out value="${billDetailsList.billQty}" /></td>
													<td><c:out value="${billDetailsList.mrp}" /></td>
													<td><c:out value="${billDetailsList.rate}" /></td>
													<td><c:out value="${billDetailsList.taxableAmt}" /></td>
													
													<c:set var="sgstPer" value="${billDetailsList.sgstPer}"/>
													<c:set var="cgstPer" value="${billDetailsList.cgstPer}"/>
													<td><c:out value="${sgstPer+cgstPer}" /></td>
													<td><c:out value="${billDetailsList.totalTax }" /></td>
													<td><c:out value="${billDetailsList.grandTotal }" /></td>
													
													<td><c:out value="${billDetailsList.remark}" /></td>
													
												</tr>
												</c:forEach>
											
										</table>
										</td>
										</tr>
										</table>
										

									</div>
								</div>
							</li>

						</ul>
					</div>
					<!--tabNavigation-->

				

				</div>
				<!--rightSidebar-->

			</div>
			<!--fullGrid-->
		</div>
		<!--rightContainer-->

	</div>
	<!--wrapper-end-->

	<!--easyTabs-->
	<!--easyTabs-->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<!--easyTabs-->

<script type="text/javascript">
function myFunction(status){
	//alert(status);
	if(status==2)
		document.getElementById("updateStatus").style="display:none";
		
}

function updateStatus(billNo)
{
	var x = document.getElementById("snackbar")
	$.getJSON('${updateBillStatus}',{
		
		billNo : billNo,
		
		ajax : 'true',

	});
	document.getElementById("updateStatus").style="display:none";
	x.className = "show";
	setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
</script>


</body>
</html>
