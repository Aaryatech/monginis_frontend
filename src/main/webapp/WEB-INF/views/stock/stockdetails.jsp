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

<link
	href="${pageContext.request.contextPath}/resources/css/monginis.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet" type="text/css" />

<!--rightNav-->

<!--datepicker-->
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


</head>
<body>

	<c:url var="getStock" value="/getStockDetails"></c:url>

	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->


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
					<div class="order-left">
						<h2 class="pageTitle">Stock Details</h2>
						<!--<h3 class="pageTitle2">Order Date : 22-02-2017 </h3>-->
					</div>


					<div class="colOuter">
						<div class="col1">
							<div class="col1title">Select Category</div>
						</div>
						<div class="col2">
							<select name="select_category" class="form-control chosen"
								tabindex="6" id="selectCategory" required>

								<option value="-1">Select Category</option>
								<c:forEach items="${category}" var="category" varStatus="count">
									<option value="${category.catId}"><c:out value="${category.catName}"/></option>
								</c:forEach>

							</select>
						</div>
					</div>

					<div class="colOuter">
						<div class="col1">
							<div class="col1title">Select View Option</div>
						</div>
						<div class="col2">
							<select name="selectStock" class="form-control chosen"
								tabindex="6" id="selectStock" onchange="showDiv(this)" required>

								<option value="-1">Select Option</option>
								<option value="1" id="currentStock">Get Current Stock</option>
								<option value="2" id="monthStock">Get Stock Between Month</option>
								<option value="3" id="dateStock">Get Stock Between Dates</option>

							</select>
						</div>
					</div>





					<div class="colOuter" style="display: none" id=select_month_year>
						<div class="col1">
							<div class="col1title">Select Month From :</div>
						</div>
						<div class="col2" align="left">

							<input type='text' placeholder="Select From Month" id='txtDate'
								name="from_stockdate" required />
						</div>

						<div class="col3"></div>


						<div class="colOuter">
							<div class="col1">
								<div class="col1title">To :</div>
							</div>
							<div class="col2" align="left">
								<input type='text' placeholder="Select To Month" id=txtDateto
									name="to_stockdate" required />
							</div>
						</div>
					</div>



					<div class="colOuter" style="display: none" id=select_date>
						<div class="col1">
							<div class="col1title">From Date:</div>
						</div>
						<div class="col2" align="left">

							<input id="fromdatepicker" class="texboxitemcode texboxcal"
								placeholder="From Date" name="from_datepicker" type="text">

						</div>

						<div class="col3"></div>


						<div class="colOuter">
							<div class="col1">
								<div class="col1title">To Date:</div>
							</div>
							<div class="col2" align="left">
								<input id="todatepicker" class="texboxitemcode texboxcal"
									placeholder="To Date" name="to_datepicker" type="text">
							</div>
						</div>
					</div>




					<div class="colOuter">
						<div class="col1">
							<div class="col1title"></div>
						</div>
						<div class="col2">
							<input name="search_stock" class="buttonsaveorder" value="Search"
								type="button" onclick="searchStock()">
						</div>
					</div>



					<div class="row">
						<div class="col-md-12">
							<!--table-->
							<form action="monthEndProcess" method="POST">
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="stockTable">
														<tr class="bgpink">
															<th width="60" align="left">Item Id</th>
															<th width="100" align="left">Item Name</th>
															<th width="80" align="left">Regular Opening Stock</th>
															<th width="80" align="left">Special Opening Stock</th>
															<th width="80" align="left">Total Purchase Amt</th>
															<th width="80" align="left">GRN / GVN Qty</th>
															<th width="80" align="left">Total Sell</th>
															<th width="80" align="left">Regular Current Stock</th>
															<th width="80" align="left">Special Current Stock</th>
															
															<%-- <c:if test="${isMonthCloseApplicable eq true}">
																<th width="105" align="left">Physical Stock</th>
																<th width="105" align="left">Stock Difference</th>
															</c:if> --%>
															
														</tr>



													</table>
												</td>
											</tr>
										</table>

									</div>

									

										<div class="colOuter" id ="monthEnd" style="display: none">
											<div class="col2full">
												<input name="" class="buttonsaveorder" value="Month End"
													type="submit">
											</div>
										</div>
								
								</div>
							</form>
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
				
				
				var isMonthClose= ${isMonthCloseApplicable};
			
				
				var selectedCat = $("#selectCategory").val();
				
				var selectedStockOption=$("#selectStock").val();

				$.getJSON('${getStock}', {
					cat_id : selectedCat,
					show_option : selectedStockOption,
					ajax : 'true'
				}, function(data) {

					var len = data.length;
					$('#stockTable td').remove();

				
					
					
					
					
					if(isMonthClose && selectedStockOption == 1){
					
						
						document.getElementById('monthEnd').style.display = "block";

						$('#stockTable th').remove();
						var tr = $('<tr class=bgpink></tr>');
						
						tr.append($('<th width=100 align=left>Item Id</th>'));
						
						tr.append($('<th width=100 align=left>Item Name</th>'));
						
						tr.append($('<th width=80 align=left>Regular Opening Stock</th>'));
						tr.append($('<th width=80 align=left>Special Opening Stock</th>'));

						
						tr.append($('<th width=80 align=left>Total Purchase Amt</th>'));
						tr.append($('<th width=80 align=left>GRN / GVN Qty</th>'));
						tr.append($('<th width=80 align=left>Total Sell</th>'));
						tr.append($('<th width=80 align=left>Regular Current Stock</th>'));
						tr.append($('<th width=80 align=left>Special Current Stock</th>'));

						tr.append($('<th width=80 align=left>Physical Stock</th>'));
						
						tr.append($('<th width=80 align=left>Stock Difference</th>'));
					
						$('#stockTable').append(tr);
					}
					
					
					$.each(data, function(key, item) {

						var tr = $('<tr></tr>');
						tr.append($('<td></td>').html(item.itemId));
						tr.append($('<td></td>').html(item.itemName));
						tr.append($('<td></td>').html(item.regOpeningStock));
						tr.append($('<td></td>').html(item.spOpeningStock));
						tr.append($('<td></td>').html(item.regTotalPurchase));
						tr.append($('<td></td>').html(item.regTotalGrnGvn));
						tr.append($('<td></td>').html(item.regTotalSell));
						
					//	var regOpeningBalance = parseFloat(item.regOpeningStock);
					//	var regTotalPurchase = parseFloat(item.regTotalPurchase);
					//	var regTotalGrnGvn = parseFloat(item.regTotalGrnGvn);
					//	var regTotalSell = parseFloat(item.regTotalSell);

					//	var totalStock = openingBalance + totalPurchase;
					//	var totalConsumption = totalGrnGvn + totalSell;

						var regCurrentStock = item.currentRegStock;

						tr.append($('<td></td>').html(regCurrentStock));
						
						tr.append($('<td></td>').html(item.currentSpStock));

						if(isMonthClose && selectedStockOption == 1){
							tr.append($('<td><input type=number min=0   onkeyup= updateStockDiff('
									+ item.itemId +','+regCurrentStock+') onchange= updateStockDiff('+ item.itemId + ','+regCurrentStock+')  id= physicalStockQty'+ item.itemId+ ' name=physicalStockQty'+item.itemId+' value = '+ regCurrentStock+ '></td>'));
							tr.append($('<td  name=stockDiff'+ item.itemId + ' id=stockDiff'+ item.itemId + ' value =' + 0 + '  > 0</td>'));
							
						}
						
						
						$('#stockTable tbody').append(tr);

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
		
		
		
</body>

</html>
