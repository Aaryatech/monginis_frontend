<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


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

<link
	href="${pageContext.request.contextPath}/resources/css/monginis.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet" type="text/css" />

<!--rightNav-->

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/loader.css">

</head>
<body> --%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/loader.css">
!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#fromdatepicker").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#todatepicker").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
</script>
<!--datepicker-->


<c:url var="getStock" value="/getStockDetails"></c:url>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

	<!--topHeader-->


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
				<div class="order-left">
					<h2 class="pageTitle">Stock Details</h2>
					<!--<h3 class="pageTitle2">Order Date : 22-02-2017 </h3>-->
				</div>


				<div class="colOuter">
					<div class="col-md-2">
						<div class="col1title">Current Month: </div>
					</div>
					<div class="col-md-8">
						 
							<c:forEach items="${category}" var="category" varStatus="count">
								<c:forEach items="${getMonthList}" var="getMonthList" varStatus="count">
										<c:choose>
											<c:when test="${(getMonthList.catId!=5) and (getMonthList.catId!=7)}">
												<c:choose>
													 <c:when test="${getMonthList.catId==category.catId}">
													 	<c:choose>
													 		<c:when test="${getMonthList.month==1}">
													 		<c:set var="month" value="January"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==2}">
													 		<c:set var="month" value="February"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==3}">
													 		<c:set var="month" value="March"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==4}">
													 		<c:set var="month" value="April"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==5}">
													 		<c:set var="month" value="May"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==6}">
													 		<c:set var="month" value="June"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==7}">
													 		<c:set var="month" value="July"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==8}">
													 		<c:set var="month" value="Augast"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==9}">
													 		<c:set var="month" value="September"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==10}">
													 		<c:set var="month" value="Octomber"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==11}">
													 		<c:set var="month" value="November"></c:set>
													 		</c:when>
													 		<c:when test="${getMonthList.month==12}">
													 		<c:set var="month" value="December"></c:set>
													 		</c:when>
													 		<c:otherwise>
													 		<c:set var="month" value=""></c:set>
													 		</c:otherwise>
													 	</c:choose>
													 	${category.catName} : ${month}, 
													 
													 </c:when>
								 				</c:choose>
											</c:when>
										</c:choose> 
									</c:forEach> 
							</c:forEach>

						 
					</div>
 
				</div>
				<div class="colOuter">
					<div class="col-md-2">
						<div class="col1title">Select Category</div>
					</div>
					<div class="col-md-2">
						<select name="select_category" class="form-control chosen"
							tabindex="4" id="selectCategory" required>

							<option value="-1">Select Category</option>
							<c:forEach items="${category}" var="category" varStatus="count">
								<option value="${category.catId}"><c:out
										value="${category.catName}" /></option>
							</c:forEach>

						</select>
					</div>



					<div class="col-md-2">
						<div class="col1title">Select View Option</div>
					</div>
					<div class="col-md-2">
						<select name="selectStock" class="form-control chosen"
							tabindex="6" id="selectStock" onchange="showDiv(this)" required>

							<option value="-1">Select Option</option>
							<option value="1" id="currentStock">Get Current Stock</option>
						
							<option value="3" id="dateStock">Get Stock Between Dates</option>

						</select>
					</div>


				</div>



				<!-- <div class="colOuter" style="display: none" id=select_month_year>
					<div class="col-md-2">
						<div class="col1title">Select Month From :</div>
					</div>
					<div class="col-md-2" align="left">

						<input type='text' placeholder="Select From Month" id='txtDate'
							name="from_stockdate" required />
					</div>

					<div class="col3"></div>



					<div class="col-md-2">
						<div class="col1title">To :</div>
					</div>
					<div class="col-md-2" align="left">
						<input type='text' placeholder="Select To Month" id=txtDateto
							name="to_stockdate" required />
					</div>

				</div> -->



				<div class="colOuter" style="display: none" id=select_date>
					<div class="col-md-2">
						<div class="col1title">From Date:</div>
					</div>
					<div class="col-md-2" align="left">

						<input id="fromdatepicker" class="texboxitemcode texboxcal"
							placeholder="From Date" name="from_datepicker" type="text">

					</div>

					<div class="col3"></div>



					<div class="col-md-2">
						<div class="col1title">To Date:</div>
					</div>
					<div class="col-md-2" align="left">
						<input id="todatepicker" class="texboxitemcode texboxcal"
							placeholder="To Date" name="to_datepicker" type="text">
					</div>

				</div>




				<div class="colOuter">
					<div class="col1">
						<div class="col1title"></div>
					</div>
					<div class="col2">
						<input name="search_stock" class="buttonsaveorder" value="Search"
							type="button" onclick="searchStock()">

						<div align="center" id="loader" style="display: none">

							<span>
								<h4>
									<font color="#343690">Loading</font>
								</h4>
							</span> <span class="l-1"></span> <span class="l-2"></span> <span
								class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
							<span class="l-6"></span>
						</div>
					</div>



				</div>



				<div class="row">
					<div class="col-md-12">
						<!--table-->
						<form action="monthEndProcess" method="POST">
							<!-- <div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="stockTable">
														<tr class="bgpink"> -->

							<div class="clearfix"></div>


							<div id="table-scroll" class="table-scroll">
								<div id="faux-table" class="faux-table" aria="hidden"></div>
								<div class="table-wrap">
									<table id="table_grid" class="main-table">
										<thead>
											<tr class="bgpink">
												<th>Item Id</th>
												<th>Item Name</th>
												<th>Reg Op Stock</th>
												<th>Sp Op Stock</th>
												<th>Reg Pur Qty</th>
												<th>Sp Pur Qty</th>
												<th>Grn-Gvn Qty</th>
												<th>Regular Sale</th>
												<th>Sp Sale</th>
												<th>Reorder Qty</th>
												<th>Reg Cur Stock</th>
												<th>Sp Cur Stock</th>

												<c:if test="${isMonthCloseApplicable eq true}">
													<th>Physical Stock</th>
													<th>Stock Difference</th>
												</c:if>

											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>
								</div>

							</div>



							<div class="colOuter" id="monthEnd" style="display: none">
								<div class="col2full">
									<input name="" class="buttonsaveorder" value="Month End"
										type="submit">
								</div>
								</div>
						</form>
					</div>
				</div>

			</div>
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

<!-- Select Only Month and Year -->
<script>
			$(document)
					.ready(
							function() {
								$('#txtDate')
										.datepicker(
												{
													changeMonth : true,
													changeYear : true,
													dateFormat : 'MM yy',

													onClose : function() {
														var iMonth = $(
																"#ui-datepicker-div .ui-datepicker-month :selected")
																.val();
														var iYear = $(
																"#ui-datepicker-div .ui-datepicker-year :selected")
																.val();
														$(this).datepicker(
																'setDate',
																new Date(iYear,
																		iMonth,
																		1));
													},

													beforeShow : function() {
														if ((selDate = $(this)
																.val()).length > 0) {
															iYear = selDate
																	.substring(
																			selDate.length - 4,
																			selDate.length);
															iMonth = jQuery
																	.inArray(
																			selDate
																					.substring(
																							0,
																							selDate.length - 5),
																			$(
																					this)
																					.datepicker(
																							'option',
																							'monthNames'));
															$(this)
																	.datepicker(
																			'option',
																			'defaultDate',
																			new Date(
																					iYear,
																					iMonth,
																					1));
															$(this)
																	.datepicker(
																			'setDate',
																			new Date(
																					iYear,
																					iMonth,
																					1));
														}
													}
												});
							});
		</script>

<script>
			$(document)
					.ready(
							function() {
								$('#txtDateto')
										.datepicker(
												{
													changeMonth : true,
													changeYear : true,
													dateFormat : 'MM yy',

													onClose : function() {
														var iMonth = $(
																"#ui-datepicker-div .ui-datepicker-month :selected")
																.val();
														var iYear = $(
																"#ui-datepicker-div .ui-datepicker-year :selected")
																.val();
														$(this).datepicker(
																'setDate',
																new Date(iYear,
																		iMonth,
																		1));
													},

													beforeShow : function() {
														if ((selDate = $(this)
																.val()).length > 0) {
															iYear = selDate
																	.substring(
																			selDate.length - 4,
																			selDate.length);
															iMonth = jQuery
																	.inArray(
																			selDate
																					.substring(
																							0,
																							selDate.length - 5),
																			$(
																					this)
																					.datepicker(
																							'option',
																							'monthNames'));
															$(this)
																	.datepicker(
																			'option',
																			'defaultDate',
																			new Date(
																					iYear,
																					iMonth,
																					1));
															$(this)
																	.datepicker(
																			'setDate',
																			new Date(
																					iYear,
																					iMonth,
																					1));
														}
													}
												});
							});
		</script>
<script>
			function showDiv(elem) {
				if (elem.value == 1) {
					document.getElementById('select_month_year').style = "display:none";
					document.getElementById('select_date').style = "display:none";
				} else if (elem.value == 2) {
					document.getElementById('select_month_year').style.display = "block";
					document.getElementById('select_date').style = "display:none";
				} else if (elem.value == 3) {
					document.getElementById('select_date').style.display = "block";
					document.getElementById('select_month_year').style = "display:none";
				}
			}
		</script>

<script type="text/javascript">
			function searchStock() {
				
			
				
				$('#loader').show();
				
				var isMonthClose= ${isMonthCloseApplicable};
				//alert(isMonthClose);
						
				var selectedCat = $("#selectCategory").val();
				
				var selectedStockOption=$("#selectStock").val();

				$.getJSON('${getStock}', {
					cat_id : selectedCat,
					show_option : selectedStockOption,
					ajax : 'true'
				}, function(data) {
					$('#loader').hide();

					var len = data.length;
					$('#table_grid td').remove();
					//alert(isMonthClose+ "month close");			
					
					if(isMonthClose && selectedStockOption == 1){
					
				
						document.getElementById('monthEnd').style.display = "block";

						$('#table_grid th').remove();
							var tr = $('<tr class=bgpink></tr>');
						
						tr.append($('<th width=60 align=left>Item Id</th>'));
						
						tr.append($('<th width=60 align=left>Item Name</th>'));
						
						tr.append($('<th width=60 align=left>Regular Opening Stock</th>'));
						tr.append($('<th width=60 align=left>Special Opening Stock</th>'));

						
						tr.append($('<th width=60 align=left>Reg Purchase Qty</th>'));
						tr.append($('<th width=60 align=left>Sp Purchase Qty</th>'));

						tr.append($('<th width=60 align=left>GRN / GVN Qty</th>'));
						tr.append($('<th width=60 align=left>Reg Sale</th>'));
						tr.append($('<th width=60 align=left>Sp Sale</th>'));
						
						tr.append($('<th width=60 align=left>Reorder Qty</th>'));
						tr.append($('<th width=60 align=left>Regular Current Stock</th>'));
						tr.append($('<th width=60 align=left>Special Current Stock</th>'));

						tr.append($('<th width=60 align=left>Physical Stock</th>'));
						
						tr.append($('<th width=60 align=left>Stock Difference</th>'));
					
						$('#table_grid').append(tr); 
					}
					
					
					$.each(data, function(key, item) {

						
						var regCurrentStock = item.currentRegStock;
						 var reOrderQty =item.reOrderQty;
						 
						 if(regCurrentStock > reOrderQty){
								var tr = $('<tr ></tr>');

						 }else{
								var tr = $('<tr class="re-order" ></tr>');
						 }
						
						tr.append($('<td ></td>').html(item.itemId));
						tr.append($('<td style=width:20px; ></td>').html(item.itemName));
						tr.append($('<td ></td>').html(item.regOpeningStock));
						tr.append($('<td ></td>').html(item.spOpeningStock));
						tr.append($('<td ></td>').html(item.regTotalPurchase));
						tr.append($('<td ></td>').html(item.spTotalPurchase));
						tr.append($('<td ></td>').html(item.regTotalGrnGvn));
						if(item.regTotalSell<0)
							{
							tr.append($('<td ></td>').html(0));
							}
						else
							{
							tr.append($('<td></td>').html(item.regTotalSell));
							}
						tr.append($('<td></td>').html(item.spTotalSell));
			
					
						tr.append($('<td  > </td>').html(reOrderQty));
						
					 
						if(regCurrentStock<0){
						tr.append($('<td > </td>').html(0));
						}else{
							tr.append($('<td > </td>').html(regCurrentStock));
							}
						tr.append($('<td > </td>').html(item.currentSpStock));
					
						if(isMonthClose && selectedStockOption == 1){
							
						 	tr.append($('<td > <input type=number min=0 style=width:80px; onkeyup= updateStockDiff('
									+ item.itemId +','+regCurrentStock+') onchange= updateStockDiff('+ item.itemId + ','+regCurrentStock+')  id= physicalStockQty'+ item.itemId+ ' name=physicalStockQty'+item.itemId+' value = '+ regCurrentStock+ '></td>'));
							
							tr.append($('<td  name=stockDiff'+ item.itemId + ' id=stockDiff'+ item.itemId + ' value =' + 0 + '  > 0</td>'));					
						} 
																		    
							
						$('#table_grid tbody').append(tr);

					})
				});
			}
		</script>

<script type="text/javascript">
		function updateStockDiff(id, currentStock) {
			
			var physicalStockQty = $("#physicalStockQty" + id).val();
			var oldDiff = $('#stockDiff'+id).val();
			
			var stockDiff=0;
			
			if(currentStock > physicalStockQty){
				
			 stockDiff =currentStock - physicalStockQty;
			 
			}else{
				
				 stockDiff =physicalStockQty - currentStock ;

			}
			
			
			 $('#stockDiff'+id).html(stockDiff);
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