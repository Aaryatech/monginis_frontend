<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


<!--rightNav
<script type="text/javascript">
jQuery(document).ready(function(){
	
	
	
});
</script>-->



<style>
.main-table tbody>tr:hover {
	background-color: #ffa;
}

.alert {
	padding: 15px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}

a:link {
	color: black;
}

a:hover {
	color: black;
}
</style>



<c:url var="qtyValidation" value="/quantityValidation"></c:url>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->


<!--wrapper-start-->
<div class="wrapper">

	<!--topHeader-->

	<jsp:include page="/WEB-INF/views/include/logo.jsp">
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
				<c:choose>
					<c:when test="${isSameDayApplicable=='2'}">
						<c:if test="${not empty qtyMessage}">
							<div class="alert">
								<span class="closebtn"
									onclick="this.parentElement.style.display='none';">&times;</span>
								<strong>Alert!</strong> ${qtyMessage}
							</div>
						</c:if>
					</c:when>
				</c:choose>
				<div class="order-left">
					<h2 class="pageTitle">${menuTitle}</h2>
					<h3 class="pageTitle2">Order Date :
						${orderDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Delivery Date :
						${deliveryDate}</h3>

					<input type="hidden" name="menuId" value="${menuId}"> <input
						type="hidden" name="rateCat" value="${frDetails.frRateCat}">
					<input type="hidden" value="${isSameDayApplicable}"
						id="isSameDayApplicable" />

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


				<c:if test="${trayApplicable==1}">
					<div class="messages messagesErr">
						<div class=row>
							<div class="col-md-3">
								Other Menu Qty = ${otherMenuQty.trayQty}
							</div>
							<div class="col-md-3">
								Current Menu Qty = ${sameMenuQty}
							</div>
							<div class="col-md-3">
								Total Tray Qty =
									${otherMenuQty.trayQty+sameMenuQty}
							</div>
							<div class="col-md-3">
								Tray Limit =
									${frDetails.frTarget}
							</div>
							
						</div>
					</div>
				</c:if>

				<c:if test="${not empty errorMessage}">
					<!-- here would be a message with a result of processing -->
					<div class="messages messagesErr">
						<h3>${errorMessage}</h3>
					</div>
				</c:if>

<c:if test="${not empty errorMessage}">
<%-- <h6>${itemList}</h6> --%>

<%-- <h6>${subCatListTitle}</h6> --%>
</c:if>

				<!-- <div class="messages messagesErr" id="errorMsg" style="display: none;"><input type="text" id="error"></div> -->









				<%-- <form action="${pageContext.request.contextPath}/saveOrder"
					name="form1" method="post"> --%>

				<form action="${pageContext.request.contextPath}/saveOrder"
					name="form1" method="post" id="form1">
					<input type="hidden" name="menuTitle" value="${menuTitle}">
					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->
						<nav>
							<ul class="cd-tabs-navigation">

								<c:forEach var="tab" items="${subCatListTitle}" varStatus="loop">


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

							<c:forEach var="tabs" items="${subCatListTitle}" varStatus="loop">


								<c:choose>
									<c:when test='${loop.index==0}'>
										<li data-content='${tabs.name}' class="selected">
									</c:when>
									<c:otherwise>
										<li data-content='${tabs.name}'>
									</c:otherwise>
								</c:choose>



								<div class="clearfix"></div>



								<div id="table-scroll" class="table-scroll">

									<div id="faux-table" class="faux-table" aria="hidden">

										<table id="table_grid" class="main-table">
											<thead>
												<tr class="bgpink">
													<th class="col-md-2">Item Name</th>
													<th class="col-md-1">Shelf Life</th>
													<th class="col-md-1">Min Quantity</th>
													<c:if test='${currentMenuId==31}'>
														<th class="col-md-1">Limit</th>
													</c:if>
													<th class="col-md-1">Quantity</th>
													<th class="col-md-1">MRP</th>
													<th class="col-md-1">Rate</th>
													<th class="col-md-1">Total</th>
												</tr>
											</thead>
										</table>

									</div>
									<div class="table-wrap">

										<table id="table_grid" class="main-table">
											<thead>
												<tr class="bgpink">
													<th class="col-md-2">Item Name</th>
													<th class="col-md-1">Shelf Life</th>
													<th class="col-md-1">Min Quantity</th>
													<c:if test='${currentMenuId==31}'>
														<th class="col-md-1">Limit</th>
													</c:if>
													<th class="col-md-1">Quantity</th>
													<th class="col-md-1">MRP</th>
													<th class="col-md-1">Rate</th>
													<th class="col-md-1">Total</th>
												</tr>
											</thead>
											<tbody>


												<c:set var="menuTime" value="${menu.timing}" />


												<c:forEach var="items" items="${itemList}" varStatus="loop">
													<c:if test="${items.subCatName eq tabs.name}">

														<c:choose>
															<c:when test="${frDetails.frRateCat=='1'}">
																<tr>

																	<td class="col-md-2"><a
																		href="${url}${items.itemImage}"
																		data-lightbox="image-1" tabindex="-1"><c:out
																				value='${items.itemName}' /></a></td>

																	<td class="col-md-1"><c:out
																			value='${items.itemShelfLife}' /></td>

																	<td class="col-md-1"><c:out
																			value='${items.minQty}' /></td>

																	<c:if test='${currentMenuId==31}'>
																		<td class="col-md-1"><c:out
																				value='${items.qtyLimit}' /></td>
																	</c:if>

																	<%-- <td class="col-md-1"><input name='${items.id}'
																				id='${items.id}' value='${items.itemQty}'
																				class="tableInput" type="text"
																				onkeydown="myFunction()"
																				onchange="onChangeLimit('${items.itemRate1}',${items.id},${items.qtyLimit})">

																				<input type="hidden" value="${items.minQty}"
																				id="minqty${items.id}" /></td> --%>

																	<c:choose>
																		<c:when test='${currentMenuId==31}'>
																			<td class="col-md-1"><input name='${items.id}'
																				id='${items.id}' value='${items.itemQty}'
																				class="tableInput" type="text"
																				onkeydown="myFunction()"
																				onchange="onChangeLimit('${items.itemRate1}',${items.id},${items.qtyLimit})">

																				<input type="hidden" value="${items.minQty}"
																				id="minqty${items.id}" /></td>
																		</c:when>
																		<c:otherwise>
																			<td class="col-md-1"><input name='${items.id}'
																				id='${items.id}' value='${items.itemQty}'
																				class="tableInput" type="text"
																				onkeydown="myFunction()"
																				onchange="onChange('${items.itemRate1}',${items.id})">

																				<input type="hidden" value="${items.minQty}"
																				id="minqty${items.id}" /></td>
																		</c:otherwise>
																	</c:choose>





																	<td class="col-md-1"><c:out
																			value='${items.itemMrp1}' /></td>

																	<td class="col-md-1"><c:out
																			value='${items.itemRate1}' /></td>
																	<c:set var="rate" value="${items.itemRate1}" />
																	<c:set var="qty" value="${items.itemQty}" />
																	<td class="col-md-1" id="total${items.id}"><c:out
																			value='${rate * qty}' /></td>


																</tr>
															</c:when>

															<c:when test="${frDetails.frRateCat=='2'}">
																<tr>

																	<td class="col-md-1"><a
																		href="${url}${items.itemImage}"
																		data-lightbox="image-1" tabindex="-1"><c:out
																				value='${items.itemName}' /></a></td>

																	<td class="col-md-1"><c:out
																			value='${items.itemShelfLife}' /></td>

																	<td class="col-md-1"><c:out
																			value='${items.minQty}' /></td>



																	<c:if test='${currentMenuId==31}'>
																		<td class="col-md-1"><c:out
																				value='${items.qtyLimit}' /></td>
																	</c:if>


																	<c:choose>
																		<c:when test='${currentMenuId==31}'>
																			<td class="col-md-1"><input name='${items.id}'
																				id='${items.id}' value='${items.itemQty}'
																				class="tableInput" type="text"
																				onkeydown="myFunction()"
																				onchange="onChangeLimit('${items.itemRate2}',${items.id},${items.qtyLimit})">

																				<input type="hidden" value="${items.minQty}"
																				id="minqty${items.id}" /></td>
																		</c:when>
																		<c:otherwise>
																			<td class="col-md-1"><input name='${items.id}'
																				id='${items.id}' value='${items.itemQty}'
																				class="tableInput" type="text"
																				onkeydown="myFunction()"
																				onchange="onChange('${items.itemRate2}',${items.id})">

																				<input type="hidden" value="${items.minQty}"
																				id="minqty${items.id}" /></td>
																		</c:otherwise>
																	</c:choose>








																	<%-- <td class="col-md-1"><input name='${items.id}'
																		id='${items.id}' value='${items.itemQty}'
																		class="tableInput" type="text"
																		onchange="onChange('${items.itemRate2}',${items.id})">

																		<input type="hidden" value="${items.minQty}"
																		id="minqty${items.id}" /></td> --%>

																	<td class="col-md-1"><c:out
																			value='${items.itemMrp2}' /></td>

																	<td class="col-md-1"><c:out
																			value='${items.itemRate2}' /></td>
																	<c:set var="rate" value="${items.itemRate2}" />
																	<c:set var="qty" value="${items.itemQty}" />
																	<td id="total${items.id}"><c:out
																			value='${rate * qty}' /></td>
																</tr>
															</c:when>

															<c:when test="${frDetails.frRateCat=='3'}">
																<tr>

																	<td class="col-md-1"><a
																		href="${url}${items.itemImage}"
																		data-lightbox="image-1" tabindex="-1"><c:out
																				value='${items.itemName}' /></a></td>

																	<td class="col-md-1"><c:out
																			value='${items.itemShelfLife}' /></td>

																	<td class="col-md-1"><c:out
																			value='${items.minQty}' /></td>


																	<c:if test='${currentMenuId==31}'>
																		<td class="col-md-1"><c:out
																				value='${items.qtyLimit}' /></td>
																	</c:if>


																	<c:choose>
																		<c:when test='${currentMenuId==31}'>
																			<td class="col-md-1"><input name='${items.id}'
																				id='${items.id}' value='${items.itemQty}'
																				class="tableInput" type="text"
																				onkeydown="myFunction()"
																				onchange="onChangeLimit('${items.itemRate3}',${items.id},${items.qtyLimit})">

																				<input type="hidden" value="${items.minQty}"
																				id="minqty${items.id}" /></td>
																		</c:when>
																		<c:otherwise>
																			<td class="col-md-1"><input name='${items.id}'
																				id='${items.id}' value='${items.itemQty}'
																				class="tableInput" type="text"
																				onkeydown="myFunction()"
																				onchange="onChange('${items.itemRate3}',${items.id})">

																				<input type="hidden" value="${items.minQty}"
																				id="minqty${items.id}" /></td>
																		</c:otherwise>
																	</c:choose>


																	<%-- <td class="col-md-1"><input name='${items.id}'
																		id='${items.id}' value='${items.itemQty}'
																		class="tableInput" type="text"
																		onchange="onChange('${items.itemRate3}',${items.id})">

																		<input type="hidden" value="${items.minQty}"
																		id="minqty${items.id}" /></td> --%>


																	<td class="col-md-1"><c:out
																			value='${items.itemMrp3}' /></td>

																	<td class="col-md-1"><c:out
																			value='${items.itemRate3}' /></td>
																	<c:set var="rate" value="${items.itemRate3}" />
																	<c:set var="qty" value="${items.itemQty}" />
																	<td class="col-md-1" id="total${items.id}"><c:out
																			value='${rate * qty}' /></td>
																</tr>
															</c:when>
														</c:choose>

													</c:if>
												</c:forEach>

											</tbody>

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

<script>

(function() {
  var fauxTable = document.getElementById("faux-table");
  var mainTable = document.getElementById("table_grid");
  var clonedElement = table_grid.cloneNode(true);
  var clonedElement2 = table_grid.cloneNode(true);
  clonedElement.id = "";
  clonedElement2.id = "";
  fauxTable.appendChild(clonedElement);
  fauxTable.appendChild(clonedElement2);
});


	</script>

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

              form1.submit();
                
    		/* 	if(isSameDayApplicable!=2)
    				{
    				   form1.submit();
    				}
    		else if(isSameDayApplicable==2)
    				{
   			   
    				  $.getJSON(
    							'${qtyValidation}',
    							{
    								
    								ajax : 'true'
    							},
    							function(data) {
    							
    							//	alert(data.error);
        							
   								if (data.error) {
   								//	alert("hii");
    									alert(data.message);
    									 window.location.reload();
    								
    								}
    								else
    								{
    									 form1.submit();
    								
    								}	
    							});
    				}   
 */
            }    
           
        </script>

<script type="text/javascript">
		function onChange(rate,id) {

			//calculate total value  
			var qty = $('#'+id).val();
			
			
			var minqty = $('#minqty'+id).val();
			
			if(qty % minqty==0){
			    var total = rate * qty;
			
			   $('#total'+id).html(total);
			}else
			{
				 var total =0;
				 
				alert("Please Enter Qty Multiple of Minimum Qty");
				$('#'+id).val('0');
				
				$('#total'+id).html(total);
				$('#'+id).focus();
			}
		}
	</script>


<script type="text/javascript">
		function onChangeLimit(rate,id,limit) {
			
			//alert("Limit = "+limit);

			//calculate total value  
			var qty = $('#'+id).val();
			
			
			var minqty = $('#minqty'+id).val();
			
			if(qty % minqty==0){
				
				
				if(qty<=limit){
					
					 var total = rate * qty;
						
					   $('#total'+id).html(total);
					
				}else{
					
					 var total =0;
					 
						alert("Please Enter Qty Less than Limit");
						$('#'+id).val('0');
						
						$('#total'+id).html(total);
						$('#'+id).focus();
						
				}
				
			   
			}else
			{
				 var total =0;
				 
				alert("Please Enter Qty Multiple of Minimum Qty");
				$('#'+id).val('0');
				
				$('#total'+id).html(total);
				$('#'+id).focus();
			}
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
		        if (((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))) {
		            e.preventDefault();
		        }
		   
			
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
        if (((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))) {
            e.preventDefault();
        }
    });
});
</script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>



<script type="text/javascript">

function checkTrayQty(){
$.ajax({
    type: "POST",
         url: "${pageContext.request.contextPath}/checkTrayQty",
         data: $("#form1").serialize(),
         dataType: 'json',
 success: function(data){
	alert(data);
 }
 });
 
}
 
</script>


</body>
</html>
