<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/menuzord.js"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery("#menuzord").menuzord({
		align:"left"
	});
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
			<jsp:param name="frDetails" value="${frDetails}" />

		</jsp:include>

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

					<%-- <div class="order-left">

						<h2 class="pageTitle">Order Savouries</h2>
						<h3 class="pageTitle2">Order Date : ${currentDate}</h3>
					</div>

					<div class="order-right">
						<div class="ordermto2px">
							<div class="orderclose">Order Closing Time :</div>
							<div class="ordercloser2">
								<span>${toTime}</span>
							</div>
						</div>
						<div class="ordermto20px">
							<div class="order-price">Total Amount :</div>
							<div class="order-amount">

								<label>INR: </label> <label id="grandtotal">${grandTotal}</label>

								
							</div>
						</div>
					</div> --%>



					<div class="order-left">
						<h2 class="pageTitle">Order Savouries</h2>
						<h3 class="pageTitle2">Order Date : ${orderDate}</h3>
						
						<input type="hidden" name="menuId" value="${menuId}">
						<input type="hidden" name="rateCat" value="${frDetails.frRateCat}">
						
					</div>

					<div class="order-right">
						<div class="ordermto2px">
							<div class="orderclose">Order Closing Time :</div>
							<div class="ordercloser2">
								<span>${toTime}</span>
							</div>
						</div>
						<div class="ordermto20px">
							<div class="order-price">Total Amount :</div>
							<div class="order-amount">INR : ${grandTotal}</div>


						</div>
					</div>
					<form action="${pageContext.request.contextPath}/saveOrder"
						name="form1" method="post">

						<!--tabNavigation-->
						<div class="cd-tabs">
							<!--tabMenu-->
							<nav>
								<ul class="cd-tabs-navigation">

									<c:forEach var="tab" items="${subCatListTitle}"
										varStatus="loop">


										<c:choose>
											<c:when test='${loop.index==0}'>
												<li><a data-content='${tab.name}' href="#0"
													class="selected"
													onClick="javascript:se_tab_id('${loop.index}')">${tab.header}</a></li>

											</c:when>
											<c:otherwise>
												<li><a data-content='${tab.name}' href="#0"
													onClick="javascript:se_tab_id('${loop.index}')">${tab.header}</a></li>

											</c:otherwise>
										</c:choose>


									</c:forEach>

								</ul>
							</nav>
							<!--tabMenu-->
							<ul class="cd-tabs-content">
								<!--tab1-->

								<c:forEach var="tabs" items="${subCatListTitle}"
									varStatus="loop">


									<c:choose>
										<c:when test='${loop.index==0}'>
											<li data-content='${tabs.name}' class="selected">
										</c:when>
										<c:otherwise>
											<li data-content='${tabs.name}'>
										</c:otherwise>
									</c:choose>


									<div class="table-responsive">
										<div class="shInnerwidth">
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0" class="table">
												<tr>
													<td align="center" valign="middle" style="padding: 0px;"><table
															width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr class="bgpink">

																<td>Item Name</td>
																<td>Quantity</td>
																<td>MRP</td>
																<td>Rate</td>
																<td>Total</td>
															</tr>


															<c:set var="menuTime" value="${menu.timing}" />


															<c:forEach var="items" items="${itemList}"
																varStatus="loop">
																<c:if test="${items.subCatName eq tabs.name}">

																	<c:choose>
																		<c:when test="${frDetails.frRateCat=='1'}">
																			<tr>

																				<td><c:out value='${items.itemName}' /></td>
																				<td><input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}' class="tableInput"
																					type="number" onkeydown="myFunction()"
																					onchange="onChange('${items.itemRate1}',${items.id})"></td>
																				<td><c:out value='${items.itemMrp1}' /></td>

																				<td><c:out value='${items.itemRate1}' /></td>
																				<c:set var="rate" value="${items.itemRate1}" />
																				<c:set var="qty" value="${items.itemQty}" />
																				<td id="total${items.id}"><c:out
																						value='${rate * qty}' /></td>
																			</tr>
																		</c:when>

																		<c:when test="${frDetails.frRateCat=='2'}">
																			<tr>

																				<td><c:out value='${items.itemName}' /></td>
																				<td><input name='${items.id}'
																					id='${items.itemId}' value='${items.itemQty}'
																					class="tableInput" type="text"
																					onchange="onChange('${items.itemRate2}',${items.id})"></td>
																				<td><c:out value='${items.itemMrp1}' /></td>

																				<td><c:out value='${items.itemRate2}' /></td>
																				<c:set var="rate" value="${items.itemRate2}" />
																				<c:set var="qty" value="${items.itemQty}" />
																				<td id="total${items.id}"><c:out
																						value='${rate * qty}' /></td>
																			</tr>
																		</c:when>

																		<c:when test="${frDetails.frRateCat=='3'}">
																			<tr>

																				<td><c:out value='${items.itemName}' /></td>
																				<td><input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}' class="tableInput"
																					type="text" 
																					onchange="onChange('${items.itemRate3}',${items.id})"></td>
																				<td><c:out value='${items.itemMrp3}' /></td>

																				<td><c:out value='${items.itemRate3}' /></td>
																				<c:set var="rate" value="${items.itemRate3}" />
																				<c:set var="qty" value="${items.itemQty}" />
																				<td id="total${items.id}"><c:out
																						value='${rate * qty}' /></td>
																			</tr>
																		</c:when>
																	</c:choose>

																</c:if>
															</c:forEach>


														</table></td>
												</tr>
											</table>
										</div>
									</div>

								</c:forEach>

							</ul>
						</div>
						<!--tabNavigation-->

						<!--<div class="order-btn"><a href="#" class="saveOrder">SAVE ORDER</a></div>-->
						<div class="order-btn textcenter">

							<input name="" class="buttonsaveorder" value="SAVE ORDER"
								type="button" ONCLICK="button1()">
						</div>



					</form>

				</div>
				<!--rightSidebar-->

			</div>
			<!--fullGrid-->
		</div>
		<!--rightContainer-->

	</div>
	<!--wrapper-end-->

	<!--easyTabs-->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<!--easyTabs-->

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

	<script type="text/javascript">
           
            function button1()
            {

             //   document.form1.buttonName.value = "SAVE ORDER";
                form1.submit();
            }    
           
        </script>

	<script type="text/javascript">
		function onChange(rate,id) {

			//calculate total value  
			var qty = $('#'+id).val();
			
			var total = rate * qty;
			
			  $('#total'+id).html(total);
			
		}
	</script>

	<script type="text/javascript">
		function onKeyDown(id) {
			alert("alert");
			var e = $('#'+id).val();
			
			if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
		             // Allow: Ctrl/cmd+A
		            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: Ctrl/cmd+C
		            (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: Ctrl/cmd+X
		            (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: home, end, left, right
		            (e.keyCode >= 35 && e.keyCode <= 39)) {
		                 // let it happen, don't do anything
		                 return;
		        }
		        // Ensure that it is a number and stop the keypress
		        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))) {
		            e.preventDefault();
		        }
		    });
			
		}
</script>
<script type="text/javascript">
$(document).ready(function() {
    $("#5").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl/cmd+A
            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: Ctrl/cmd+C
            (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: Ctrl/cmd+X
            (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))) {
            e.preventDefault();
        }
    });
});
</script>
</body>
</html>
