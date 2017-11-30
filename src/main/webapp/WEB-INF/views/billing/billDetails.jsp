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
<!--new css added by kalpesh -->
	<link href="/ops/resources/css/style.css"
	rel="stylesheet" type="text/css" />
	
	<!--new css added by kalpesh -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.mCustomScrollbar.css">
	
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


				<!--leftNav-->



				<!--rightSidebar-->
				<div class="sidebarright">
					
		<div class="sidebarright">
		<br>
	
		<div class=" col-md-2">
		    <h2 class=" pull-left">Bill No:-  <b>${billNo}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></h2>
		</div>
	
		<div class="col-md-2">
		    <h2 class="pull-left">Bill Date:- <b> ${billDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></h2>
		</div>
			<div class="col-md-3">
		    <h2 class="pull-left">Grand Total:- <b> ${grandTotal}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></h2>
		</div>
		<div class="col-md-4 ">
			  <h2 class="pull-left">Bill Status:- <c:choose>
																	<c:when test="${billStatus==1}">
																		<b><c:out value="Pending"></c:out></b>
																	</c:when>
																	<c:when test="${billStatus==2}">
																		<b><c:out value="Received"></c:out></b>
																		
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

																</c:choose></h2>
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
					<div class="clearfix"></div>


				<div id="table-scroll" class="table-scroll">
					<div id="faux-table" class="faux-table" aria="hidden"></div>
					<div class="table-wrap">
						<table id="table_grid" class="main-table">
							<thead>
								<tr class="bgpink">
											<tr class="bgpink">
												<th width="138" style="width: 18px" align="left">Sr No</th>
													<th class="col-md-1">Item Name</th>
													<th class="col-md-1">Group</th>
													<th class="col-md-1">Order Qty</th>
													<th class="col-md-1">Billed Qty</th>
												
													<th class="col-md-1">MRP</th>
														<th class="col-md-1">Rate</th>
														<th class="col-md-1">Taxable Amt</th>
													<th class="col-md-1">GST %</th>
													
													<th class="col-md-1">Tax Amt</th>
													<th class="col-md-1">Total</th>
													
													<th class="col-md-1">Remark</th>
											</tr>
											</thead>
							<tbody>
													
											<c:forEach items="${billDetailsList}" var="billDetailsList" varStatus="count">
												<tr>
													<td class="col-md-1"><c:out value="${count.index+1}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.itemName}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.catName}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.orderQty}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.billQty}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.mrp}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.rate}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.taxableAmt}" /></td>
													
													<c:set var="sgstPer" value="${billDetailsList.sgstPer}"/>
													<c:set var="cgstPer" value="${billDetailsList.cgstPer}"/>
													<td class="col-md-1"><c:out value="${sgstPer+cgstPer}" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.totalTax }" /></td>
													<td class="col-md-1"><c:out value="${billDetailsList.grandTotal }" /></td>
													
													<td class="col-md-1"><c:out value="${billDetailsList.remark}" /></td>
													
												</tr>
												</c:forEach>
											
										</tbody>

						</table>
					</div>
				</div>

					</div><br>
					<div align="center">
								<input name="" class="buttonsaveorder" value="Go Back"
									 onclick="goBack()" align="center" type="button">
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
function goBack() {
    window.history.back();
}
</script>

<script>
	/*
//  jquery equivalent
jQuery(document).ready(function() {
   jQuery(".main-table").clone(true).appendTo('#table-scroll .faux-table').addClass('clone');
   jQuery(".main-table.clone").clone(true).appendTo('#table-scroll .faux-table').addClass('clone2'); 
 });
*/
(function() {
  var fauxTable = document.getElementById("faux-table");
  var mainTable = document.getElementById("table_grid");
  var clonedElement = table_grid.cloneNode(true);
  var clonedElement2 = table_grid.cloneNode(true);
  clonedElement.id = "";
  clonedElement2.id = "";
  fauxTable.appendChild(clonedElement);
  fauxTable.appendChild(clonedElement2);
})();


	</script>
</body>
</html>
