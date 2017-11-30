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
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="icon"
	href="${pageContext.request.contextPath}/images/feviconicon.png"
	type="image/x-icon" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>

<!--autocomplete-->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/autocomplete.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/autocomplete.css">
<script
	src="${pageContext.request.contextPath}/resources/css/easy-responsive-tabs.css"></script>

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
</script>
<!--rightNav-->


</head>
<body>
	<c:url var="getCustomerBillList1" value="/generateSellBill1"></c:url>
	<c:url var="getCustomerBillList2" value="/generateSellBill2"></c:url>
	<c:url var="getCustomerBillList3" value="/generateSellBill3"></c:url>
	<c:url var="getCustomerBillList4" value="/generateSellBill4"></c:url>
	<c:url var="getCustomerBillList5" value="/generateSellBill5"></c:url>
	<c:url var="getCustomerBillList6" value="/generateSellBill6"></c:url>
	<c:url var="getCustomerBillList7" value="/generateSellBill7"></c:url>



	<!-- onload="removeOption()" -->
	<c:url var="findItemById" value="/getItemById" />

	<c:url var="deleteItem1" value="/deleteCustBillItemTokenItem1"></c:url>
	<c:url var="deleteItem2" value="/deleteCustBillItemTokenItem2"></c:url>
	<c:url var="deleteItem3" value="/deleteCustBillItemTokenItem3"></c:url>
	<c:url var="deleteItem4" value="/deleteCustBillItemTokenItem4"></c:url>
	<c:url var="deleteItem5" value="/deleteCustBillItemTokenItem5"></c:url>
	<c:url var="deleteItem6" value="/deleteCustBillItemTokenItem6"></c:url>
	<c:url var="deleteItem7" value="/deleteCustBillItemTokenItem7"></c:url>

	<c:url var="updateItem1" value="/updateCustBillItemTokenItem1"></c:url>
	<c:url var="updateItem2" value="/updateCustBillItemTokenItem2"></c:url>
	<c:url var="updateItem3" value="/updateCustBillItemTokenItem3"></c:url>
	<c:url var="updateItem4" value="/updateCustBillItemTokenItem4"></c:url>
	<c:url var="updateItem5" value="/updateCustBillItemTokenItem5"></c:url>
	<c:url var="updateItem6" value="/updateCustBillItemTokenItem6"></c:url>
	<c:url var="updateItem7" value="/updateCustBillItemTokenItem7"></c:url>

	<c:url var="getAllAddedItems1" value="/addNewCustBillItemToken1"></c:url>
	<c:url var="getAllAddedItems2" value="/addNewCustBillItemToken2"></c:url>
	<c:url var="getAllAddedItems3" value="/addNewCustBillItemToken3"></c:url>
	<c:url var="getAllAddedItems4" value="/addNewCustBillItemToken4"></c:url>
	<c:url var="getAllAddedItems5" value="/addNewCustBillItemToken5"></c:url>
	<c:url var="getAllAddedItems6" value="/addNewCustBillItemToken6"></c:url>
	<c:url var="getAllAddedItems7" value="/addNewCustBillItemToken7"></c:url>


	<c:url var="useFromStock2fun1" value="/useFromStock2Fun1"></c:url>
	<c:url var="useFromStock2fun2" value="/useFromStock2Fun2"></c:url>
	<c:url var="useFromStock1fun1" value="/useFromStock1Fun1"></c:url>
	<c:url var="useFromStock1fun2" value="/useFromStock1Fun2"></c:url>
     <c:url var="regOpStockQtyLess" value="/regOpStockQtyLess"></c:url>
     
    <c:url var="useFromCurrentSpStockFun1" value="/useFromSpecialOpStockFun1"></c:url>
     <c:url var="useFromCurrentSpStockFun2" value="/useFromSpecialOpStockFun2"></c:url>
    <c:url var="useFromCurrentRegStockFun3" value="/useFromRegOpeningStockFun3"></c:url>
         <c:url var="useFromCurrentRegStockFun4" value="/useFromRegOpeningStockFun4"></c:url>
         
          <c:url var="useFromCurrentSpStockFun11" value="/useFromSpecialOpStockFun11"></c:url>
     <c:url var="useFromCurrentSpStockFun21" value="/useFromSpecialOpStockFun21"></c:url>
    <c:url var="useFromCurrentRegStockFun31" value="/useFromRegOpeningStockFun31"></c:url>
         <c:url var="useFromCurrentRegStockFun41" value="/useFromRegOpeningStockFun41"></c:url>
     
	<div class="sidebarOuter"></div>

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

				<!------------ Place Actual content of page inside this div ----------->
				<div class="sidebarright">

					<div class="order-left">
						<h2 class="pageTitle">Customer Bill</h2>

					</div>

					<div class="order-right">
						<a href="${pageContext.request.contextPath}/viewBill"><button
								class="pull-right btn view_bill_btn">View Bill</button></a>
					</div>

					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->
						<nav>
							<ul class="cd-tabs-navigation">
								<li><a data-content="tab1" class="selected" href="#0">Token
										1</a></li>
								<li><a data-content="tab2" href="#0">Token 2</a></li>
								<li><a data-content="tab3" href="#0">Token 3</a></li>
								<li><a data-content="tab4" href="#0">Token 4</a></li>
								<li><a data-content="tab5" href="#0">Token 5</a></li>
								<li><a data-content="tab6" href="#0">Token 6</a></li>
								<li><a data-content="tab7" href="#0">Token 7</a></li>
							</ul>
						</nav>
						<!--tabMenu-->
						<ul class="cd-tabs-content">
							<!--tab1-->
							<li data-content="tab1" class="selected">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName1" id="custName1"
											value="Cash">
									</div>

									<div class="col-md-2">
										<h4 class="pull-right" style="margin-top: 5px;">GST No:-</h4>
									</div>
									<div class="col-md-2 ">
										<input type="text" class="form-control"
											placeholder="Enter GST No." name="gstNo1" id="gstNo1">
									</div>
									<div class="col-md-2 ">
										<h4 class="pull-right" style="margin-top: 5px;">Phone
											No:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter phone No." name="phoneNo1" id="phoneNo1">
									</div>
								</div> <br /> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Barcode</td>
															<td>Item Name</td>
															<td>Qty</td>
															<td>Rate</td>
														</tr>
														<tr>
															<td><input type="text" class="form-control"
																id="barcode1" name="barcode1"
																placeholder="Enter Barcode"></td>
															<td>
																<!-- input type="text" class="form-control"
																id="item_name" name="item_name"
																placeholder="Enter Item Name" list="items">
																<datalist id="items">
																
																
																</datalist> --> <select
																data-placeholder="Enter Item Name" name="itemName1"
																class="form-control" tabindex="-1" id="itemName1"
																data-rule-required="true"<%-- onchange="setRate(1,${itemListResponse.itemId},${itemListResponse.itemRate1})" --%>>
																	<option value="">Item Name</option>
																	<c:forEach items="${itemListResponse}"
																		var="itemListResponse">
																		<option value="${itemListResponse.id}">${itemListResponse.itemName}</option>
																	</c:forEach>
															</select> <input name="item_name1" id="item_name1" type="hidden"
																value="" />

															</td>
															<td><input type="number" min="0" max="500"
																class="form-control" placeholder="1" name="qty1"
																id="qty1" value="1"></td>
															<td id="rateTdVal1">00</td>


														</tr>
													</table>
												</td>
											</tr>

										</table>
									</div>
								</div> <input name="rate1" id="rate1" type="hidden" value="00" />
								<div class="row">
									<div class="col-md-12">
										<center>
											<button class="btn additem_btn" onclick="addNewRow1(1)"
												id="b1">Add Item</button>
										</center>
									</div>
								</div> <br /> <!-- Form End -->
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table class="table table-bordered" width="100%" border="0"
											cellspacing="0" cellpadding="0 " id="table_grid1">
											<tr class="bgpink">
												<th style="width: 130px;">Sr no.</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th style="width: 130px;">Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<tr>
												<!--<td>1</td>
															<td>#ppp</td>
															<td>cake</td>
															<td>5</td>
															<td>900</td>
															<td>10</td>
															<td><a href="#" class="action_btn"><abbr
																	title="edit"><i class="fa fa-edit"></i></abbr></a> <a
																href="#" class="action_btn"><abbr title="Delete"><i
																		class="fa fa-trash"></i></abbr></a></td>-->

											</tr>
										</table>

									</div>
								</div>


								<hr />
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total1" style="text-align: center;">00</h4>
												<input type="hidden" class="form-control" id="tot1">

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="discount1"
														onkeyup="disMinusTotal1()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="grandtotal1"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot1">
											</div>
										</div>

									</div>
								</div> </br>

								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">

												<h4 class="col-md-2">
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
													<select data-placeholder="Enter Payment Mode"
														name="paymentMode1" class="form-control" tabindex="-1"
														id="paymentMode1" data-rule-required="true">


														<option value="1">Cash</option>
														<option value="2">Card</option>
														<option value="3">Other</option>

													</select>

												</div>
												<h4 class="col-md-2">
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="paidAmount1"
														onkeyup="amtMinusGrandTotal1()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="remAmt1"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount1">
											</div>
										</div>
									</div>
								</div> <br />
								<center>
									<button class="btn additem_btn" onclick="generateSellBill1()">Generate
										Bill</button>
								</center> <input type="hidden" class="form-control" id=orderResponse1
								value="${orderResponse}" />

							</li>
							<!--tab1-->

							<!--tab2-->
							<li data-content="tab2">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName2" id="custName2"
											value="Cash">
									</div>

									<div class="col-md-2">
										<h4 class="pull-right" style="margin-top: 5px;">GST No:-</h4>
									</div>
									<div class="col-md-2 ">
										<input type="text" class="form-control"
											placeholder="Enter GST No." name="gstNo2" id="gstNo2">
									</div>
									<div class="col-md-2 ">
										<h4 class="pull-right" style="margin-top: 5px;">Phone
											No:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter phone No." name="phoneNo2" id="phoneNo2">
									</div>
								</div> <br /> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Barcode</td>
															<td>Item Name</td>
															<td>Qty</td>
															<td>Rate</td>
														</tr>
														<tr>
															<td><input type="text" class="form-control"
																id="barcode2" name="barcode2"
																placeholder="Enter Barcode"></td>
															<td><select data-placeholder="Enter Item Name"
																name="itemName2" class="form-control" tabindex="-1"
																id="itemName2" data-rule-required="true"<%-- onchange="setRate(1,${itemListResponse.itemId},${itemListResponse.itemRate1})" --%>>
																	<option value="">Item Name</option>
																	<c:forEach items="${itemListResponse}"
																		var="itemListResponse">
																		<option value="${itemListResponse.id}">${itemListResponse.itemName}</option>
																	</c:forEach>
															</select></td>
															<td><input type="number" min="0" max="500"
																class="form-control" placeholder="1" name="qty2"
																id="qty2" value="1"></td>
															<td id="rateTdVal2">00</td>
														</tr>
													</table>
												</td>
											</tr>

										</table>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<center>
											<button class="btn additem_btn" onclick="addNewRow1(2)">Add
												Item</button>
										</center>
									</div>
								</div> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											id="table_grid2" class="table table-bordered">
											<tr class="bgpink">
												<th style="width: 130px;">Sr no.</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th>Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<tr>
												<!-- <td>1</td>
															<td>#ppp</td>
															<td>cake</td>
															<td>5</td>
															<td>900</td>
															<td>10</td>
															<td><a href="#" class="action_btn"><abbr
																	title="edit"><i class="fa fa-edit"></i></abbr></a> <a
																href="#" class="action_btn"><abbr title="Delete"><i
																		class="fa fa-trash"></i></abbr></a></td> -->

											</tr>
										</table>

									</div>
								</div>
								<hr />
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total2" style="text-align: center;">00</h4>
												<input type="hidden" class="form-control" id="tot2">

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="discount2"
														onkeyup="disMinusTotal2()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="grandtotal2"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot2">
											</div>
										</div>

									</div>
								</div> </br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">

												<h4 class="col-md-2">
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
													<select data-placeholder="Enter Payment Mode"
														name="paymentMode2" class="form-control" tabindex="-1"
														id="paymentMode2" data-rule-required="true">


														<option value="1">Cash</option>
														<option value="2">Card</option>
														<option value="3">Other</option>

													</select>

												</div>
												<h4 class="col-md-2">
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="paidAmount2"
														onkeyup="amtMinusGrandTotal2()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="remAmt2"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount2">
											</div>
										</div>
									</div>
								</div> <br />
								<center>
									<button class="btn additem_btn" onclick="generateSellBill2()">Generate
										Bill</button>
								</center> <input type="hidden" class="form-control" id=orderResponse2
								value="${orderResponse}" />

							</li>
							<!--tab2-->

							<!--tab3-->
							<li data-content="tab3">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName3" id="custName3"
											value="Cash">
									</div>

									<div class="col-md-2">
										<h4 class="pull-right" style="margin-top: 5px;">GST No:-</h4>
									</div>
									<div class="col-md-2 ">
										<input type="text" class="form-control"
											placeholder="Enter GST No." name="gstNo3" id="gstNo3">
									</div>
									<div class="col-md-2 ">
										<h4 class="pull-right" style="margin-top: 5px;">Phone
											No:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter phone No." name="phoneNo3" id="phoneNo3">
									</div>
								</div> <br /> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Barcode</td>
															<td>Item Name</td>
															<td>Qty</td>
															<td>Rate</td>
														</tr>
														<tr>
															<td><input type="text" class="form-control"
																id="barcode3" name="barcode3"
																placeholder="Enter Barcode"></td>
															<td><select data-placeholder="Enter Item Name"
																name="itemName3" class="form-control" tabindex="-1"
																id="itemName3" data-rule-required="true"<%-- onchange="setRate(1,${itemListResponse.itemId},${itemListResponse.itemRate1})" --%>>
																	<option value="">Item Name</option>
																	<c:forEach items="${itemListResponse}"
																		var="itemListResponse">
																		<option value="${itemListResponse.id}">${itemListResponse.itemName}</option>
																	</c:forEach>
															</select></td>
															<td><input type="number" min="0" max="500"
																class="form-control" placeholder="1" name="qty3"
																id="qty3" value="1"></td>
															<td id="rateTdVal3">00</td>
														</tr>
													</table>
												</td>
											</tr>

										</table>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<center>
											<button class="btn additem_btn" onclick="addNewRow3()">Add
												Item</button>
										</center>
									</div>
								</div> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											id="table_grid3" class="table table-bordered">
											<tr class="bgpink">
												<th style="width: 130px;">Sr no.</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th>Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<tr>
												<!-- <td>1</td>
															<td>#ppp</td>
															<td>cake</td>
															<td>5</td>
															<td>900</td>
															<td>10</td>
															<td><a href="#" class="action_btn"><abbr
																	title="edit"><i class="fa fa-edit"></i></abbr></a> <a
																href="#" class="action_btn"><abbr title="Delete"><i
																		class="fa fa-trash"></i></abbr></a></td> -->

											</tr>
										</table>

									</div>
								</div>
								<hr />
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total3" style="text-align: center;">00</h4>
												<input type="hidden" class="form-control" id="tot3">

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="discount3"
														onkeyup="disMinusTotal3()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="grandtotal3"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot3">
											</div>
										</div>

									</div>
								</div> </br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">

												<h4 class="col-md-2">
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
													<select data-placeholder="Enter Payment Mode"
														name="paymentMode3" class="form-control" tabindex="-1"
														id="paymentMode3" data-rule-required="true">


														<option value="1">Cash</option>
														<option value="2">Card</option>
														<option value="3">Other</option>

													</select>

												</div>
												<h4 class="col-md-2">
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="paidAmount3"
														onkeyup="amtMinusGrandTotal3()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="remAmt3"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount3">
											</div>
										</div>
									</div>
								</div> <br />
								<center>
									<button class="btn additem_btn" onclick="generateSellBill3()">Generate
										Bill</button>
								</center> <input type="hidden" class="form-control" id=orderResponse3
								value="${orderResponse}" />

							</li>
							<!--tab4-->
							<li data-content="tab4">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName4" id="custName4"
											value="Cash">
									</div>

									<div class="col-md-2">
										<h4 class="pull-right" style="margin-top: 5px;">GST No:-</h4>
									</div>
									<div class="col-md-2 ">
										<input type="text" class="form-control"
											placeholder="Enter GST No." name="gstNo4" id="gstNo4">
									</div>
									<div class="col-md-2 ">
										<h4 class="pull-right" style="margin-top: 5px;">Phone
											No:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter phone No." name="phoneNo4" id="phoneNo4">
									</div>
								</div> <br /> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Barcode</td>
															<td>Item Name</td>
															<td>Qty</td>
															<td>Rate</td>
														</tr>
														<tr>
															<td><input type="text" class="form-control"
																id="barcode4" name="barcode4"
																placeholder="Enter Barcode"></td>
															<td><select data-placeholder="Enter Item Name"
																name="itemName4" class="form-control" tabindex="-1"
																id="itemName4" data-rule-required="true"<%-- onchange="setRate(1,${itemListResponse.itemId},${itemListResponse.itemRate1})" --%>>
																	<option value="">Item Name</option>
																	<c:forEach items="${itemListResponse}"
																		var="itemListResponse">
																		<option value="${itemListResponse.id}">${itemListResponse.itemName}</option>
																	</c:forEach>
															</select></td>
															<td><input type="number" min="0" max="500"
																class="form-control" placeholder="1" name="qty4"
																id="qty4" value="1"></td>
															<td id="rateTdVal4">00</td>
														</tr>
													</table>
												</td>
											</tr>

										</table>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<center>
											<button class="btn additem_btn" onclick="addNewRow4()">Add
												Item</button>
										</center>
									</div>
								</div> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											id="table_grid4" class="table table-bordered">
											<tr class="bgpink">
												<th style="width: 130px;">Sr no.</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th>Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<tr>
												<!-- 
															<td>1</td>
															<td>#ppp</td>
															<td>cake</td>
															<td>5</td>
															<td>900</td>
															<td>10</td>
															<td><a href="#" class="action_btn"><abbr
																	title="edit"><i class="fa fa-edit"></i></abbr></a> <a
																href="#" class="action_btn"><abbr title="Delete"><i
																		class="fa fa-trash"></i></abbr></a></td>
 -->
											</tr>
										</table>

									</div>
								</div>
								<hr />
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total4" style="text-align: center;">00</h4>
												<input type="hidden" class="form-control" id="tot4">

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="discount4"
														onkeyup="disMinusTotal4()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="grandtotal4"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot4">

											</div>

										</div>
									</div>
								</div> </br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">

												<h4 class="col-md-2">
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
													<select data-placeholder="Enter Payment Mode"
														name="paymentMode4" class="form-control" tabindex="-1"
														id="paymentMode4" data-rule-required="true">


														<option value="1">Cash</option>
														<option value="2">Card</option>
														<option value="3">Other</option>

													</select>

												</div>
												<h4 class="col-md-2">
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="paidAmount4"
														onkeyup="amtMinusGrandTotal4()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="remAmt4"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount4">
											</div>
										</div>
									</div>
								</div> <br />
								<center>
									<button class="btn additem_btn" onclick="generateSellBill4()">Generate
										Bill</button>
								</center> <input type="hidden" class="form-control" id=orderResponse4
								value="${orderResponse}" />

							</li>
							<!--tab5-->
							<li data-content="tab5">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName5" id="custName5"
											value="Cash">
									</div>

									<div class="col-md-2">
										<h4 class="pull-right" style="margin-top: 5px;">GST No:-</h4>
									</div>
									<div class="col-md-2 ">
										<input type="text" class="form-control"
											placeholder="Enter GST No." name="gstNo5" id="gstNo5">
									</div>
									<div class="col-md-2 ">
										<h4 class="pull-right" style="margin-top: 5px;">Phone
											No:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter phone No." name="phoneNo5" id="phoneNo5">
									</div>
								</div> <br /> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Barcode</td>
															<td>Item Name</td>
															<td>Qty</td>
															<td>Rate</td>
														</tr>
														<tr>
															<td><input type="text" class="form-control"
																id="barcode5" name="barcode5"
																placeholder="Enter Barcode"></td>
															<td><select data-placeholder="Enter Item Name"
																name="itemName5" class="form-control" tabindex="-1"
																id="itemName5" data-rule-required="true"<%-- onchange="setRate(1,${itemListResponse.itemId},${itemListResponse.itemRate1})" --%>>
																	<option value="">Item Name</option>
																	<c:forEach items="${itemListResponse}"
																		var="itemListResponse">
																		<option value="${itemListResponse.id}">${itemListResponse.itemName}</option>
																	</c:forEach>
															</select></td>
															<td><input type="number" min="0" max="500"
																class="form-control" placeholder="1" name="qty5"
																id="qty5" value="1"></td>
															<td id="rateTdVal5">00</td>
														</tr>
													</table>
												</td>
											</tr>

										</table>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<center>
											<button class="btn additem_btn" onclick="addNewRow5()">Add
												Item</button>
										</center>
									</div>
								</div> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											id="table_grid5" class="table table-bordered">
											<tr class="bgpink">
												<th style="width: 130px;">Sr no.</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th>Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<tr>
												<!-- <td>1</td>
															<td>#ppp</td>
															<td>cake</td>
															<td>5</td>
															<td>900</td>
															<td>10</td>
															<td><a href="#" class="action_btn"><abbr
																	title="edit"><i class="fa fa-edit"></i></abbr></a> <a
																href="#" class="action_btn"><abbr title="Delete"><i
																		class="fa fa-trash"></i></abbr></a></td>
 -->
											</tr>
										</table>

									</div>
								</div>
								<hr />
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total5" style="text-align: center;">00</h4>
												<input type="hidden" class="form-control" id="tot5">

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="discount5"
														onkeyup="disMinusTotal5()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="grandtotal5"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot5">
											</div>
										</div>

									</div>
								</div> </br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">

												<h4 class="col-md-2">
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
													<select data-placeholder="Enter Payment Mode"
														name="paymentMode5" class="form-control" tabindex="-1"
														id="paymentMode5" data-rule-required="true">


														<option value="1">Cash</option>
														<option value="2">Card</option>
														<option value="3">Other</option>

													</select>

												</div>
												<h4 class="col-md-2">
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="paidAmount5"
														onkeyup="amtMinusGrandTotal5()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="remAmt5"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount5">
											</div>
										</div>
									</div>
								</div> <br />
								<center>
									<button class="btn additem_btn" onclick="generateSellBill5()">Generate
										Bill</button>
								</center> <input type="hidden" class="form-control" id=orderResponse5
								value="${orderResponse}" />

							</li>
							<!--tab6-->
							<li data-content="tab6">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName6" id="custName6"
											value="Cash">
									</div>

									<div class="col-md-2">
										<h4 class="pull-right" style="margin-top: 5px;">GST No:-</h4>
									</div>
									<div class="col-md-2 ">
										<input type="text" class="form-control"
											placeholder="Enter GST No." name="gstNo6" id="gstNo6">
									</div>
									<div class="col-md-2 ">
										<h4 class="pull-right" style="margin-top: 5px;">Phone
											No:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter phone No." name="phoneNo6" id="phoneNo6">
									</div>
								</div> <br /> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Barcode</td>
															<td>Item Name</td>
															<td>Qty</td>
															<td>Rate</td>
														</tr>
														<tr>
															<td><input type="text" class="form-control"
																id="barcode6" name="barcode6"
																placeholder="Enter Barcode"></td>
															<td><select data-placeholder="Enter Item Name"
																name="itemName6" class="form-control" tabindex="-1"
																id="itemName6" data-rule-required="true"<%-- onchange="setRate(1,${itemListResponse.itemId},${itemListResponse.itemRate1})" --%>>
																	<option value="">Item Name</option>
																	<c:forEach items="${itemListResponse}"
																		var="itemListResponse">
																		<option value="${itemListResponse.id}">${itemListResponse.itemName}</option>
																	</c:forEach>
															</select></td>
															<td><input type="number" min="0" max="500"
																class="form-control" placeholder="1" name="qty6"
																id="qty6" value="1"></td>
															<td id="rateTdVal6">00</td>
														</tr>
													</table>
												</td>
											</tr>

										</table>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<center>
											<button class="btn additem_btn" onclick="addNewRow6()">Add
												Item</button>
										</center>
									</div>
								</div> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											id="table_grid6" class="table table-bordered">
											<tr class="bgpink">
												<th style="width: 130px;">Sr no.</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th>Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<tr>
												<!-- <td>1</td>
															<td>#ppp</td>
															<td>cake</td>
															<td>5</td>
															<td>900</td>
															<td>10</td>
															<td><a href="#" class="action_btn"><abbr
																	title="edit"><i class="fa fa-edit"></i></abbr></a> <a
																href="#" class="action_btn"><abbr title="Delete"><i
																		class="fa fa-trash"></i></abbr></a></td>
 -->
											</tr>
										</table>

									</div>
								</div>
								<hr />
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total6" style="text-align: center;">00</h4>
												<input type="hidden" class="form-control" id="tot6">

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="discount6"
														onkeyup="disMinusTotal6()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="grandtotal6"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot6">
											</div>
										</div>

									</div>
								</div> </br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">

												<h4 class="col-md-2">
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
													<select data-placeholder="Enter Payment Mode"
														name="paymentMode6" class="form-control" tabindex="-1"
														id="paymentMode6" data-rule-required="true">


														<option value="1">Cash</option>
														<option value="2">Card</option>
														<option value="3">Other</option>

													</select>

												</div>
												<h4 class="col-md-2">
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="paidAmount6"
														onkeyup="amtMinusGrandTotal6()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="remAmt6"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount6">
											</div>
										</div>
									</div>
								</div> <br />
								<center>
									<button class="btn additem_btn" onclick="generateSellBill6()">Generate
										Bill</button>
								</center> <input type="hidden" class="form-control" id=orderResponse6
								value="${orderResponse}" />

							</li>
							<!--tab7-->
							<li data-content="tab7">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName7" id="custName7"
											value="Cash">
									</div>

									<div class="col-md-2">
										<h4 class="pull-right" style="margin-top: 5px;">GST No:-</h4>
									</div>
									<div class="col-md-2 ">
										<input type="text" class="form-control"
											placeholder="Enter GST No." name="gstNo7" id="gstNo7">
									</div>
									<div class="col-md-2 ">
										<h4 class="pull-right" style="margin-top: 5px;">Phone
											No:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter phone No." name="phoneNo7" id="phoneNo7">
									</div>
								</div> <br /> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Barcode</td>
															<td>Item Name</td>
															<td>Qty</td>
															<td>Rate</td>
														</tr>
														<tr>
															<td><input type="text" class="form-control"
																id="barcode7" name="barcode7"
																placeholder="Enter Barcode"></td>
															<td><select data-placeholder="Enter Item Name"
																name="itemName7" class="form-control" tabindex="-1"
																id="itemName7" data-rule-required="true"<%-- onchange="setRate(1,${itemListResponse.itemId},${itemListResponse.itemRate1})" --%>>
																	<option value="">Item Name</option>
																	<c:forEach items="${itemListResponse}"
																		var="itemListResponse">
																		<option value="${itemListResponse.id}">${itemListResponse.itemName}</option>
																	</c:forEach>
															</select></td>
															<td><input type="number" min="0" max="500"
																class="form-control" placeholder="1" name="qty7"
																id="qty7" value="1"></td>
															<td id="rateTdVal7">00</td>
														</tr>
													</table>
												</td>
											</tr>

										</table>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<center>
											<button class="btn additem_btn" onclick="addNewRow7()">Add
												Item</button>
										</center>
									</div>
								</div> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											id="table_grid7" class="table table-bordered">
											<tr class="bgpink">
												<th style="width: 130px;">Sr no.</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th>Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<tr>
												<!-- <td>1</td>
															<td>#ppp</td>
															<td>cake</td>
															<td>5</td>
															<td>900</td>
															<td>10</td>
															<td><a href="#" class="action_btn"><abbr
																	title="edit"><i class="fa fa-edit"></i></abbr></a> <a
																href="#" class="action_btn"><abbr title="Delete"><i
																		class="fa fa-trash"></i></abbr></a></td>
 -->
											</tr>
										</table>

									</div>
								</div>
								<hr />
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total7" style="text-align: center;">00</h4>
												<input type="hidden" class="form-control" id="tot7">

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="discount7"
														onkeyup="disMinusTotal7()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="grandtotal7"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot7">
											</div>
										</div>

									</div>
								</div> </br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">

												<h4 class="col-md-2">
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
													<select data-placeholder="Enter Payment Mode"
														name="paymentMode7" class="form-control" tabindex="-1"
														id="paymentMode7" data-rule-required="true">


														<option value="1">Cash</option>
														<option value="2">Card</option>
														<option value="3">Other</option>

													</select>

												</div>
												<h4 class="col-md-2">
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left">
													<input type="text" class="form-control" id="paidAmount7"
														onkeyup="amtMinusGrandTotal7()" value="0">
												</div>

												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>

												<h4 class="col-md-2 pull-left" id="remAmt7"
													style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount7">
											</div>
										</div>
									</div>
								</div> <br />
								<center>
									<button class="btn additem_btn" onclick="generateSellBill7()">Generate
										Bill</button>
								</center> <input type="hidden" class="form-control" id=orderResponse7
								value="${orderResponse}" />

							</li>
							<!--tab8-->
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
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<!--easyTabs-->


<script type="text/javascript">
		$(document).ready(
				function() {

					$('#itemName1').change(
							function() {

								$.getJSON('${findItemById}', {
									id : $(this).val(),
									ajax : 'true'
								},
										function(data) {

											document.getElementById("barcode1")
													.setAttribute('value',
															data.itemId);

											$("#rateTdVal1").html(data.mrp);
										});
							});
				});
		
		$(document).ready(
				function() {

					$('#itemName2').change(
							function() {

								$.getJSON('${findItemById}', {
									id : $(this).val(),
									ajax : 'true'
								},
										function(data) {

											document.getElementById("barcode2")
													.setAttribute('value',
															data.itemId);

											$("#rateTdVal2").html(data.mrp);
										});
							});
				});
		$(document).ready(
				function() {

					$('#itemName3').change(
							function() {

								$.getJSON('${findItemById}', {
									id : $(this).val(),
									ajax : 'true'
								},
										function(data) {

											document.getElementById("barcode3")
													.setAttribute('value',
															data.itemId);

											$("#rateTdVal3").html(data.mrp);
										});
							});
				});
		$(document).ready(
				function() {

					$('#itemName4').change(
							function() {

								$.getJSON('${findItemById}', {
									id : $(this).val(),
									ajax : 'true'
								},
										function(data) {

											document.getElementById("barcode4")
													.setAttribute('value',
															data.itemId);

											$("#rateTdVal4").html(data.mrp);
										});
							});
				});
		$(document).ready(
				function() {

					$('#itemName5').change(
							function() {

								$.getJSON('${findItemById}', {
									id : $(this).val(),
									ajax : 'true'
								},
										function(data) {

											document.getElementById("barcode5")
													.setAttribute('value',
															data.itemId);

											$("#rateTdVal5").html(data.mrp);
										});
							});
				});
		$(document).ready(
				function() {

					$('#itemName6').change(
							function() {

								$.getJSON('${findItemById}', {
									id : $(this).val(),
									ajax : 'true'
								},
										function(data) {

											document.getElementById("barcode6")
													.setAttribute('value',
															data.itemId);

											$("#rateTdVal6").html(data.mrp);
										});
							});
				});
		$(document).ready(
				function() {

					$('#itemName7').change(
							function() {

								$.getJSON('${findItemById}', {
									id : $(this).val(),
									ajax : 'true'
								},
										function(data) {

											document.getElementById("barcode7")
													.setAttribute('value',
															data.itemId);

											$("#rateTdVal7").html(data.mrp);
										});
							});
				});
	</script>
	 
	 <script type="text/javascript">
		function addNewRow1(token) {

		/* 	var isValid = validation1();
			if (isValid) { */

				var id = $("#itemName"+token).val();
				var barcode = $("#barcode"+token).val();
				//alert(barcode);
				var qty = $("#qty"+token).val();
				//alert(qty);
				var custName = $("#custName"+token).val();
				//alert(custName);
				var phoneNo = $("#phoneNo"+token).val();
				//alert(phoneNo);
				var gstNo = $("#gstNo"+token).val();
				alert(token);

				$('#loader').show();
				$
						.getJSON(
								'${getAllAddedItems1}',
								{
									id : id,
									qty : qty,
									token : token,

									ajax : 'true'
								},
								function(data) {
									$('#loader').hide();
									if (data == "") {
										alert("No records found !!");
									}
									$('#table_grid'+token+' td').remove();
									var allTotal = 0;
									//var keyId=0;

									$
											.each(
													data,
													function(key, item) {//**----------Check first Special Opening Stock is gretor Show Prompt!!---------**
														if (item.spStockGretor == true) {
															
															var retVal = confirm("Would you like to use Current Special Stock [Avail.Qty:"+item.totalSpStock+"]?");
															
													//-------------------- Use From Special Opening Stock-----------------------------
															if (retVal == true) {
																
																
														$.getJSON(
															'${useFromCurrentSpStockFun11}',//function, when  User Selected Special Opening Stock
															{
																	index : key,
																	token : token,
																	ajax : 'true'
															},
															function(data) {             
																	$('#loader').hide();
																	if (data == "") {
																			alert("No records found !!");
																	}
																$('#table_grid'+token+' td').remove();
															   var allTotal = 0;
	                                                             $.each(data,function(key, item) {//**Fun2-Start**
	                                                 //-------------------------------------------------------------------------------
	                                     				if (item.spStockGretor == true) {

																var retVal1 = confirm("Current Special  stock is less than Entered quantity, Do you want to use Special Available Current Special Stock [Avail-Qty:"+item.totalSpStock+"]?")
																if (retVal1 == true) {							
																								
																			$.getJSON(
																					'${useFromCurrentSpStockFun21}',//function, when User Want To Use Special Opening Stock //append data and totakl rem
																					{
																							index : key,
																							token : token,
																							ajax : 'true'
																					},
																					function(data) {             
																						$('#loader').hide();
																						if (data == "") {
																								alert("No records found !!");
																						}
																					$('#table_grid'+token+' td').remove();
																				    //var allTotal = 0;
						                                                             $.each(data,function(key, item) {//**Fun3-Start**
						                                                            	 
						                                                            	 
						                                                            	 
						                                                            	//**Fun3-appendData(useFromSpecialOpStockFun2)**
						                                                            	 
						                                                            	 var index = key + 1;

						     															var tr = "<tr>";

						     															var index = "<td align=left>"
						     																	+ index
						     																	+ "</td>";

						     															var barcode = "<td>"
						     																	+ item.itemId
						     																	+ "</td>";

						     															var itemName = "<td>"
						     																	+ item.itemName
						     																	+ "</td>";

						     															var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+key+ " name=billQty1"+token+""+key+" value = "+ item.qty+ " ></div></td>";
						     															
						     															var rate = "<td >"
						     																	+ item.mrp
						     																	+ "</td>";

						     															var total = parseFloat(item.mrp)
						     																	* parseFloat(item.qty);

						     															var Amount = "<td align=center id=billTotal1"+token+""+key+">"
						     																	+ total+ "</td>";

						     															var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"+toktn+""+ key+ " onclick=updateTotal1("+token+","
						     																	+ item.id+ ","+key
						     																	+ ")>  </i> </abbr> "
						     																	+"<abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("+ item.id+ ","+ token
						     																	+ ","+ key+ ");   id=editItem1"+token+""+ key+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
						     																	+ item.id+ ","+token+ ","+key+ ")>"
						     																	+"<abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
						     														
						     															allTotal = allTotal + total;

						     															var trclosed = "</tr>";

						     															$('#table_grid'+token+' tbody')
						     																	.append(tr);
						     															$('#table_grid'+token+' tbody')
						     																	.append(index);
						     															$('#table_grid'+token+' tbody')
						     																	.append(barcode);
						     															$('#table_grid'+token+' tbody')
						     																	.append(
						     																			itemName);
						     															$('#table_grid'+token+' tbody')
						     																	.append(qty);
						     															$('#table_grid'+token+' tbody')
						     																	.append(rate);

						     															$('#table_grid'+token+' tbody')
						     																	.append(Amount);

						     															$('#table_grid'+token+' tbody')
						     																	.append(action);

						     															$('#table_grid'+token+' tbody')
						     																	.append(
						     																			trclosed);
						                                                             })
						                                                         	//**Fun3-totalCal(useFromSpecialOpStockFun2)**

						                         									$("#total"+token).html(allTotal);
						                         									document.getElementById("tot"+token)
						                         											.setAttribute('value', allTotal);

						                         									document.getElementById("paidAmount"+token)
						                         									.setAttribute('value', allTotal);
						                         									
						                         									var discount = $("#discount"+token).val();
						                         									var grandAmt = allTotal - (allTotal * (discount / 100));
						                         									var paidAmount = $("#paidAmount"+token).val();
						                         									
						                         									var grandMinusPaidAmt=grandAmt-paidAmount;
						                         									$('#grandtotal'+token).html(grandAmt);
						                         									document.getElementById("grandtot"+token).setAttribute('value',grandAmt);

						                         									
						                         									$('#remAmt'+token).html(grandMinusPaidAmt);
						                         									document.getElementById("remAmount"+token).setAttribute('value',grandMinusPaidAmt);
						                         									
						                         									document.getElementById("barcode"+token).focus();
						                                                             
																					});
						                                                             
																					
																			return true;		
																}
																else
																	{//When User Selected No ( Use RegOpening Stock )
																	$
																	.getJSON(
																			'${useFromCurrentRegStockFun31}',//function, when Use from Regular Opening Stock 
																			{
																				index : key,
																				token : token,
																				ajax : 'true'
																			},
																			function(data) {             
																				$('#loader').hide();
																				if (data == "") {
																						alert("No records found !!");
																				}
																			$('#table_grid'+token+' td').remove();
																		    var allTotal = 0;
				                                                             $.each(data,function(key, item) {
				                                                            	 if (item.regOpStockLess == true) {

				         															var retVal1 = confirm("Current Regular stock is less than Entered quantity, Do you want to use Current Regular Available Stock[Avail-Qty:"+item.totalRegStock+"]?")
				         															if (retVal1 == true) {	
				         																
				         																$
				        																.getJSON(
				        																		'${useFromCurrentRegStockFun41}',//function, when Use from Regular Opening Stock 
				        																		{
				        																			index : key,
				        																			token :token,
				        																			ajax : 'true'
				        																		},
				        																		function(data) {             
				        																			$('#loader').hide();
				        																			if (data == "") {
				        																					alert("No records found !!");
				        																			}
				        																		$('#table_grid'+token+' td').remove();
				        																	    var allTotal = 0;
				        			                                                             $.each(data,function(key, item) {
				        			                                                            	 var index = key + 1;
				        			                                                            	  
				 					     															var tr = "<tr>";

				 					     															var index = "<td align=left>"
				 					     																	+ index
				 					     																	+ "</td>";

				 					     															var barcode = "<td>"
				 					     																	+ item.itemId
				 					     																	+ "</td>";

				 					     															var itemName = "<td>"
				 					     																	+ item.itemName
				 					     																	+ "</td>";

				 					     															var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+ key+ " name=billQty1"+token+""+key+" value = "+ item.qty+ " ></div></td>";
				 					     															
				 					     															var rate = "<td >"
				 					     																	+ item.mrp
				 					     																	+ "</td>";

				 					     															var total = parseFloat(item.mrp)
				 					     																	* parseFloat(item.qty);

				 					     															var Amount = "<td align=center id=billTotal1"+token+""+key+">"
				 					     																	+ total
				 					     																	+ "</td>";

				 					     															var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
				 					     																	+token+""+key
				 					     																	+ " onclick=updateTotal1("
				 					     																	+ item.id
				 					     																	+ ","
				 					     																	+token+","+key
				 					     																	+ ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("
				 					     																	+ item.id
				 					     																	+ ","
				 					     																	+ token
				 					     																	+ ","
				 					     																	+key
				 					     																	+ ");   id=editItem1"
				 					     																	+ token+""+key
				 					     																	+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
				 					     																	+ item.id
				 					     																	+ ","
				 					     																	+ token
				 					     																	+ ","
				 					     																	+key
				 					     																	+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
				 					     														
				 					     															allTotal = allTotal
				 					     																	+ total;

				 					     															var trclosed = "</tr>";

				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(tr);
				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(index);
				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(barcode);
				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(
				 					     																			itemName);
				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(qty);
				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(rate);

				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(Amount);

				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(action);

				 					     															$('#table_grid'+token+' tbody')
				 					     																	.append(
				 					     																			trclosed);
				        			                                                            	 
				        			                                                             })

				 					                         									$("#total"+token).html(allTotal);
				 					                         									document.getElementById("tot"+token)
				 					                         											.setAttribute('value', allTotal);

				 					                         									document.getElementById("paidAmount"+token)
				 					                         									.setAttribute('value', allTotal);
				 					                         									
				 					                         									var discount = $("#discount"+token).val();
				 					                         									var grandAmt = allTotal - (allTotal * (discount / 100));
				 					                         									var paidAmount = $("#paidAmount"+token).val();
				 					                         									
				 					                         									var grandMinusPaidAmt=grandAmt-paidAmount;
				 					                         									$('#grandtotal'+token).html(grandAmt);
				 					                         									document.getElementById("grandtot"+token).setAttribute('value',grandAmt);

				 					                         									
				 					                         									$('#remAmt1').html(grandMinusPaidAmt);
				 					                         									document.getElementById("remAmount"+token).setAttribute('value',grandMinusPaidAmt);
				 					                         									
				 					                         									document.getElementById("barcode"+token).focus();
				        			                                                             
				        																		})
				         																return true;
				         															}
				         															else
				         																{
				         																//alertPromt3No 
				         																
				         																alert("Current Regular Stock is Less than entered Qty.[Avail-Qty:"+item.totalRegStock+"]");
				         																return false;
				         																}
				         																
				                                                            	 }
				                                                            	 else
				                                                            		 {
				                                                            	   	 var index = key + 1;
				                                                            	   	  
						     															var tr = "<tr>";

						     															var index = "<td align=left>"
						     																	+ index
						     																	+ "</td>";

						     															var barcode = "<td>"
						     																	+ item.itemId
						     																	+ "</td>";

						     															var itemName = "<td>"
						     																	+ item.itemName
						     																	+ "</td>";

						     															var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+key+ " name=billQty1"+token+""+key+" value = "+ item.qty+ " ></div></td>";
						     															
						     															var rate = "<td >"
						     																	+ item.mrp
						     																	+ "</td>";

						     															var total = parseFloat(item.mrp)
						     																	* parseFloat(item.qty);

						     															var Amount = "<td align=center id=billTotal1"+token+""+key+">"
						     																	+ total
						     																	+ "</td>";

						     															var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
						     																	+token+""+key
						     																	+ " onclick=updateTotal1("
						     																	+ item.id
						     																	+ ","+token+","
						     																	+key
						     																	+ ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("
						     																	+ item.id
						     																	+ ","
						     																	+ token
						     																	+ ","
						     																	+ key
						     																	+ ");   id=editItem1"
						     																	+ key
						     																	+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
						     																	+ item.id
						     																	+ ","
						     																	+ token
						     																	+ ","
						     																	+key
						     																	+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
						     														
						     															allTotal = allTotal
						     																	+ total;

						     															var trclosed = "</tr>";

						     															$('#table_grid'+token+' tbody')
						     																	.append(tr);
						     															$('#table_grid'+token+' tbody')
						     																	.append(index);
						     															$('#table_grid'+token+' tbody')
						     																	.append(barcode);
						     															$('#table_grid'+token+' tbody')
						     																	.append(
						     																			itemName);
						     															$('#table_grid'+token+' tbody')
						     																	.append(qty);
						     															$('#table_grid'+token+' tbody')
						     																	.append(rate);

						     															$('#table_grid'+token+' tbody')
						     																	.append(Amount);

						     															$('#table_grid'+token+' tbody')
						     																	.append(action);

						     															$('#table_grid'+token+' tbody')
						     																	.append(
						     																			trclosed);
				                                                            		 
				                                                            		 }
				                                                            	 
				                                                             })

					                         									$("#total"+token).html(allTotal);
					                         									document.getElementById("tot"+token)
					                         											.setAttribute('value', allTotal);

					                         									document.getElementById("paidAmount"+token)
					                         									.setAttribute('value', allTotal);
					                         									
					                         									var discount = $("#discount"+token).val();
					                         									var grandAmt = allTotal - (allTotal * (discount / 100));
					                         									var paidAmount = $("#paidAmount"+token).val();
					                         									
					                         									var grandMinusPaidAmt=grandAmt-paidAmount;
					                         									$('#grandtotal'+token).html(grandAmt);
					                         									document.getElementById("grandtot"+token).setAttribute('value',grandAmt);

					                         									
					                         									$('#remAmt'+token).html(grandMinusPaidAmt);
					                         									document.getElementById("remAmount"+token).setAttribute('value',grandMinusPaidAmt);
					                         									
					                         									document.getElementById("barcode"+token).focus();
																			})
																	  
																	  return false;
																	}
	                                     				}
															//**Fun2-appendData();	
														else {//Adding Added item to List
															
														   	 var index = key + 1;
														 
																var tr = "<tr>";

																var index = "<td align=left>"
																		+ index
																		+ "</td>";

																var barcode = "<td>"
																		+ item.itemId
																		+ "</td>";

																var itemName = "<td>"
																		+ item.itemName
																		+ "</td>";

																var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+key+ " name=billQty1"+token+""+key+ " value = "+ item.qty+ " ></div></td>";
																
																var rate = "<td >"
																		+ item.mrp
																		+ "</td>";

																var total = parseFloat(item.mrp)
																		* parseFloat(item.qty);

																var Amount = "<td align=center id=billTotal1"+token+""+key+ ">"
																		+ total
																		+ "</td>";

																var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
																	    +token+""+key 
																		+ " onclick=updateTotal1("
																		+ item.id
																		+ ","+token+","
																		+ key
																		+ ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("
																		+ item.id
																		+ ","
																		+ token
																		+ ","
																		+ key
																		+ ");   id=editItem1"
																		+ token+""+key
																		+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
																		+ item.id
																		+ ","
																		+ token
																		+ ","
																		+key
																		+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
															
																allTotal = allTotal
																		+ total;

																var trclosed = "</tr>";

																$('#table_grid'+token+' tbody')
																		.append(tr);
																$('#table_grid'+token+' tbody')
																		.append(index);
																$('#table_grid'+token+' tbody')
																		.append(barcode);
																$('#table_grid'+token+' tbody')
																		.append(
																				itemName);
																$('#table_grid'+token+' tbody')
																		.append(qty);
																$('#table_grid'+token+' tbody')
																		.append(rate);

																$('#table_grid'+token+' tbody')
																		.append(Amount);

																$('#table_grid'+token+' tbody')
																		.append(action);

																$('#table_grid'+token+' tbody')
																		.append(
																				trclosed);
															
														}
	                                                })//**Fun2-End**
	                                                 //**Fun2-totalCalculation();	
	                                    			$("#total"+token).html(allTotal);
		                         									document.getElementById("tot"+token)
		                         											.setAttribute('value', allTotal);

		                         									document.getElementById("paidAmount"+token)
		                         									.setAttribute('value', allTotal);
		                         									
		                         									var discount = $("#discount"+token).val();
		                         									var grandAmt = allTotal - (allTotal * (discount / 100));
		                         									var paidAmount = $("#paidAmount"+token).val();
		                         									
		                         									var grandMinusPaidAmt=grandAmt-paidAmount;
		                         									$('#grandtotal'+token).html(grandAmt);
		                         									document.getElementById("grandtot"+token).setAttribute('value',grandAmt);

		                         									
		                         									$('#remAmt'+token).html(grandMinusPaidAmt);
		                         									document.getElementById("remAmount"+token).setAttribute('value',grandMinusPaidAmt);
		                         									
		                         									document.getElementById("barcode"+token).focus();          
	                                                             
	                                                             
												})		
															
															
														
																	return true;
																}
																else
																	{
																	$
																	.getJSON(
																			'${useFromCurrentRegStockFun31}',//function, when Use from Regular Opening Stock 
																			{
																				index : key,
																				ajax : 'true'
																			},
																			function(data) {             
																				$('#loader').hide();
																				if (data == "") {
																						alert("No records found !!");
																				}
																			$('#table_grid'+token+' td').remove();
																		  var allTotal = 0;
				                                                             $.each(data,function(key, item) {
				                                                            	 if (item.regOpStockLess == true) {

				         															var retVal1 = confirm("Current Regular stock is less than Entered quantity, Do you want to use Current Regular Available Stock[Avail-Qty:"+item.totalRegStock+"]?")
				         															if (retVal1 == true) {	
				         																
				         																$
				        																.getJSON(
				        																		'${useFromCurrentRegStockFun4}',//function, when Use from Regular Opening Stock 
				        																		{
				        																			index : key,
				        																			token : token,
				        																			ajax : 'true'
				        																		},
				        																		function(data) {             
				        																			$('#loader').hide();
				        																			if (data == "") {
				        																					alert("No records found !!");
				        																			}
				        																		$('#table_grid'+token+' td').remove();
				        																	    var allTotal = 0;
				        			                                                             $.each(data,function(key, item) {
				        			                                                            		var index = key + 1;
				        			                                                            		 
				        			            														var tr = "<tr>";

				        			            														var index = "<td align=left>"
				        			            																+ index
				        			            																+ "</td>";

				        			            														var barcode = "<td>"
				        			            																+ item.itemId
				        			            																+ "</td>";

				        			            														var itemName = "<td>"
				        			            																+ item.itemName
				        			            																+ "</td>";

				        			            														var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+key+ " name=billQty1"+token+""+key+" value = "+ item.qty+ " ></div></td>";
				        			            														
				        			            														var rate = "<td >"
				        			            																+ item.mrp
				        			            																+ "</td>";

				        			            														var total = parseFloat(item.mrp)
				        			            																* parseFloat(item.qty);

				        			            														var Amount = "<td align=center id=billTotal1"+token+""+key+">"
				        			            																+ total
				        			            																+ "</td>";

				        			            														var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
				        			            																+ token+""+key
				        			            																+ " onclick=updateTotal1("
				        			            																+ item.id
				        			            																+ ","+token+","
				        			            																+ key
				        			            																+ ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("
				        			            																+ item.id
				        			            																+ ","
				        			            																+ token
				        			            																+ ","
				        			            																+ key
				        			            																+ ");   id=editItem1"
				        			            																+ token+""+key
				        			            																+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
				        			            																+ item.id
				        			            																+ ","
				        			            																+ token
				        			            																+ ","
				        			            																+key
				        			            																+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
				        			            													
				        			            														allTotal = allTotal
				        			            																+ total;

				        			            														var trclosed = "</tr>";

				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(tr);
				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(index);
				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(barcode);
				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(
				        			            																		itemName);
				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(qty);
				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(rate);

				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(Amount);

				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(action);

				        			            														$('#table_grid'+token+' tbody')
				        			            																.append(
				        			            																		trclosed);
				        			                                                            	 
				        			                                                             })
				        			                                                             $("#total"+token).html(allTotal);
				        			                         									document.getElementById("tot"+token)
				        			                         											.setAttribute('value', allTotal);

				        			                         									document.getElementById("paidAmount"+token)
				        			                         											.setAttribute('value', allTotal);

				        			                         									var discount = $("#discount"+token).val();
				        			                         									var grandAmt = allTotal
				        			                         											- (allTotal * (discount / 100));
				        			                         									var paidAmount = $("#paidAmount"+token).val();

				        			                         									var grandMinusPaidAmt = grandAmt
				        			                         											- paidAmount;
				        			                         									$('#grandtotal'+token).html(grandAmt);
				        			                         									document.getElementById("grandtot"+token)
				        			                         											.setAttribute('value', grandAmt);

				        			                         									$('#remAmt'+token).html(grandMinusPaidAmt);
				        			                         									document.getElementById("remAmount"+token)
				        			                         											.setAttribute('value',
				        			                         													grandMinusPaidAmt);

				        			                         									document.getElementById("barcode"+token).focus(); 
				        			                                                             
				        																		});
				         																return true;
				         															}
				         															else
				         																{
				         																//alertPromt3No 
				         																
				         																alert("Current Regular Stock is Less than entered Qty.[Avail-Qty:"+item.totalRegStock+"]");
				         																return false;
				         																}
				         																
				                                                            	 }
				                                                            	 else
				                                                            		 {//4:56
				                                                             		var index = key + 1;

				            														var tr = "<tr>";

				            														var index = "<td align=left>"
				            																+ index
				            																+ "</td>";

				            														var barcode = "<td>"
				            																+ item.itemId
				            																+ "</td>";

				            														var itemName = "<td>"
				            																+ item.itemName
				            																+ "</td>";

				            														var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+key+ " name=billQty1"+token+""+key+" value = "+ item.qty+ " ></div></td>";
				            														
				            														var rate = "<td >"
				            																+ item.mrp
				            																+ "</td>";

				            														var total = parseFloat(item.mrp)
				            																* parseFloat(item.qty);

				            														var Amount = "<td align=center id=billTotal1"+token+""+key+">"
				            																+ total
				            																+ "</td>";

				            														var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
				            																+ token+""+key
				            																+ " onclick=updateTotal1("
				            																+ item.id
				            																+ ","+token+","
				            																+ key
				            																+ ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("
				            																+ item.id
				            																+ ","
				            																+ token
				            																+ ","
				            																+ key
				            																+ ");   id=editItem1"
				            																+ token+""+key
				            																+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
				            																+ item.id
				            																+ ","
				            																+ token
				            																+ ","
				            																+key
				            																+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
				            													
				            														allTotal = allTotal
				            																+ total;

				            														var trclosed = "</tr>";

				            														$('#table_grid'+token+' tbody')
				            																.append(tr);
				            														$('#table_grid'+token+' tbody')
				            																.append(index);
				            														$('#table_grid'+token+' tbody')
				            																.append(barcode);
				            														$('#table_grid'+token+' tbody')
				            																.append(
				            																		itemName);
				            														$('#table_grid'+token+' tbody')
				            																.append(qty);
				            														$('#table_grid'+token+' tbody')
				            																.append(rate);

				            														$('#table_grid'+token+' tbody')
				            																.append(Amount);

				            														$('#table_grid'+token+' tbody')
				            																.append(action);

				            														$('#table_grid'+token+' tbody')
				            																.append(
				            																		trclosed);
				                                                            		 
				                                                            		 
				                                                            		 
				                                                            		 }
				                                                            	 
				                                                             })
				                                                             $("#total"+token).html(allTotal);
	 			                         									document.getElementById("tot"+token)
	 			                         											.setAttribute('value', allTotal);

	 			                         									document.getElementById("paidAmount"+token)
	 			                         											.setAttribute('value', allTotal);

	 			                         									var discount = $("#discount"+token).val();
	 			                         									var grandAmt = allTotal
	 			                         											- (allTotal * (discount / 100));
	 			                         									var paidAmount = $("#paidAmount"+token).val();

	 			                         									var grandMinusPaidAmt = grandAmt
	 			                         											- paidAmount;
	 			                         									$('#grandtotal'+token).html(grandAmt);
	 			                         									document.getElementById("grandtot"+token)
	 			                         											.setAttribute('value', grandAmt);

	 			                         									$('#remAmt'+token).html(grandMinusPaidAmt);
	 			                         									document.getElementById("remAmount"+token)
	 			                         											.setAttribute('value',
	 			                         													grandMinusPaidAmt);

	 			                         									document.getElementById("barcode"+token).focus(); 
																			})
																	
																	return false;
																	}
														}
														else if(item.regOpStockLess==true)//new4:24
															{

																var retVal1 = confirm("Current Regular stock is less than Entered quantity, Do you want to use Current Regular Available Stock[Avail-Qty:"+item.totalRegStock+"]?")
																if (retVal1 == true) {	
																	
																	$
																.getJSON(
																		'${useFromCurrentRegStockFun41}',//function, when Use from Regular Opening Stock 
																		{
																			index : key,
																			ajax : 'true'
																		},
																		function(data) {             
																			$('#loader').hide();
																			if (data == "") {
																					alert("No records found !!");
																			}
																		$('#table_grid'+token+' td').remove();
																	    var allTotal = 0;
			                                                             $.each(data,function(key, item) {
			                                                            		var index = key + 1;

			            														var tr = "<tr>";

			            														var index = "<td align=left>"
			            																+ index
			            																+ "</td>";

			            														var barcode = "<td>"
			            																+ item.itemId
			            																+ "</td>";

			            														var itemName = "<td>"
			            																+ item.itemName
			            																+ "</td>";

			            														var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+key+ " name=billQty1"+token+""+key+" value = "+ item.qty+ " ></div></td>";
			            														
			            														var rate = "<td >"
			            																+ item.mrp
			            																+ "</td>";

			            														var total = parseFloat(item.mrp)
			            																* parseFloat(item.qty);

			            														var Amount = "<td align=center id=billTotal1"+token+""+key+">"
			            																+ total
			            																+ "</td>";

			            														var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
			            																+ token+""+key
			            																+ " onclick=updateTotal1("
			            																+ item.id
			            																+ ","
			            																+ token+","+key
			            																+ ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("
			            																+ item.id
			            																+ ","
			            																+ token
			            																+ ","
			            																+ key
			            																+ ");   id=editItem1"
			            																+ token+""+key
			            																+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
			            																+ item.id
			            																+ ","
			            																+ token
			            																+ ","
			            																+key
			            																+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
			            													
			            														allTotal = allTotal
			            																+ total;

			            														var trclosed = "</tr>";

			            														$('#table_grid'+token+' tbody')
			            																.append(tr);
			            														$('#table_grid'+token+' tbody')
			            																.append(index);
			            														$('#table_grid'+token+' tbody')
			            																.append(barcode);
			            														$('#table_grid'+token+' tbody')
			            																.append(
			            																		itemName);
			            														$('#table_grid'+token+' tbody')
			            																.append(qty);
			            														$('#table_grid'+token+' tbody')
			            																.append(rate);

			            														$('#table_grid'+token+' tbody')
			            																.append(Amount);

			            														$('#table_grid'+token+' tbody')
			            																.append(action);

			            														$('#table_grid'+token+' tbody')
			            																.append(
			            																		trclosed);
			                                                            	 
			                                                             })
			                                                             //append total calc
			                                                             $("#total"+token).html(allTotal);
			                         									document.getElementById("tot"+token)
			                         											.setAttribute('value', allTotal);

			                         									document.getElementById("paidAmount"+token)
			                         											.setAttribute('value', allTotal);

			                         									var discount = $("#discount"+token).val();
			                         									var grandAmt = allTotal
			                         											- (allTotal * (discount / 100));
			                         									var paidAmount = $("#paidAmount"+token).val();

			                         									var grandMinusPaidAmt = grandAmt
			                         											- paidAmount;
			                         									$('#grandtotal'+token).html(grandAmt);
			                         									document.getElementById("grandtot"+token)
			                         											.setAttribute('value', grandAmt);

			                         									$('#remAmt'+token).html(grandMinusPaidAmt);
			                         									document.getElementById("remAmount"+token)
			                         											.setAttribute('value',
			                         													grandMinusPaidAmt);

			                         									document.getElementById("barcode"+token).focus(); 
																		});
																	return true;
																}
																else
																	{
																	//alertPromt3No 
																	
																	alert("Current Regular Stock is Less than entered Qty[Avail-Qty:"+item.totalRegStock+"]");
																	
																	
																	return false;
																	}
															//Special Stock is not gretor (Else Condition)
																var index = key + 1;

	    														var tr = "<tr>";

	    														var index = "<td align=left>"
	    																+ index
	    																+ "</td>";

	    														var barcode = "<td>"
	    																+ item.itemId
	    																+ "</td>";

	    														var itemName = "<td>"
	    																+ item.itemName
	    																+ "</td>";

	    														var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+key+ " name=billQty1"+token+""+key+" value = "+ item.qty+ " ></div></td>";
	    														
	    														var rate = "<td >"
	    																+ item.mrp
	    																+ "</td>";

	    														var total = parseFloat(item.mrp)
	    																* parseFloat(item.qty);

	    														var Amount = "<td align=center id=billTotal1"+token+""+key+">"
	    																+ total
	    																+ "</td>";

	    														var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
	    																+ token+""+key
	    																+ " onclick=updateTotal1("
	    																+ item.id
	    																+ ","
	    																+ token+","+key
	    																+ ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("
	    																+ item.id
	    																+ ","
	    																+ token
	    																+ ","
	    																+ key
	    																+ ");   id=editItem1"
	    																+ token+""+key
	    																+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
	    																+ item.id
	    																+ ","
	    																+ token
	    																+ ","
	    																+key
	    																+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
	    													
	    														allTotal = allTotal
	    																+ total;

	    														var trclosed = "</tr>";

	    														$('#table_grid'+token+' tbody')
	    																.append(tr);
	    														$('#table_grid'+token+' tbody')
	    																.append(index);
	    														$('#table_grid'+token+' tbody')
	    																.append(barcode);
	    														$('#table_grid'+token+' tbody')
	    																.append(
	    																		itemName);
	    														$('#table_grid'+token+' tbody')
	    																.append(qty);
	    														$('#table_grid tbody')
	    																.append(rate);

	    														$('#table_grid'+token+' tbody')
	    																.append(Amount);

	    														$('#table_grid'+token+' tbody')
	    																.append(action);

	    														$('#table_grid'+token+' tbody')
	    																.append(
	    																		trclosed);
															}
														
													
												    //----------------------------------------------------------------------------------------
														//**Fun1-appendData();
														var index = key + 1;

														var tr = "<tr>";

														var index = "<td align=left>"
																+ index
																+ "</td>";

														var barcode = "<td>"
																+ item.itemId
																+ "</td>";

														var itemName = "<td>"
																+ item.itemName
																+ "</td>";

														var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+token+""+key+ " name=billQty1"+token+""+key+" value = "+ item.qty+ " ></div></td>";
														
														var rate = "<td >"
																+ item.mrp
																+ "</td>";

														var total = parseFloat(item.mrp)
																* parseFloat(item.qty);

														var Amount = "<td align=center id=billTotal1"+token+""+key+">"
																+ total
																+ "</td>";

														var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
																+ token+""+key
																+ " onclick=updateTotal1("
																+ item.id
																+ ","
																+ token+","+key
																+ ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable1("
																+ item.id
																+ ","
																+ token
																+ ","
																+ key
																+ ");   id=editItem1"
																+ token+""+key
																+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
																+ item.id
																+ ","
																+ token
																+ ","
																+key
																+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
													
														allTotal = allTotal
																+ total;

														var trclosed = "</tr>";

														$('#table_grid'+token+' tbody')
																.append(tr);
														$('#table_grid'+token+' tbody')
																.append(index);
														$('#table_grid'+token+' tbody')
																.append(barcode);
														$('#table_grid'+token+' tbody')
																.append(
																		itemName);
														$('#table_grid'+token+' tbody')
																.append(qty);
														$('#table_grid'+token+' tbody')
																.append(rate);

														$('#table_grid'+token+' tbody')
																.append(Amount);

														$('#table_grid'+token+' tbody')
																.append(action);

														$('#table_grid'+token+' tbody')
																.append(
																		trclosed);
												
													})

									$("#total"+token).html(allTotal);
									document.getElementById("tot"+token)
											.setAttribute('value', allTotal);

									var discount = $("#discount"+token).val();
									var grandAmt = allTotal
											- (allTotal * (discount / 100));

									document.getElementById("paidAmount"+token)
											.setAttribute('value', grandAmt);

									var paidAmount = $("#paidAmount"+token).val();

									var grandMinusPaidAmt = grandAmt
											- paidAmount;

									$('#grandtotal'+token).html(grandAmt);
									document.getElementById("grandtot"+token)
											.setAttribute('value', grandAmt);

									$('#remAmt'+token).html(grandMinusPaidAmt);
									document.getElementById("remAmount"+token)
											.setAttribute('value',
													grandMinusPaidAmt);

									document.getElementById("barcode"+token).focus();
								});
			}
			
		 
			</script>


	<script type="text/javascript">
		function editDisable1(id,qty,index) {
			//	alert(id+""+qty)

			$("#billQty1" + index).prop('disabled', false);

			$("#saveItem1" + index).show();
			document.getElementById("saveItem1" + index).style.visibility = "visible";

			document.getElementById("editItem1" + index).style.visibility = "hidden";
			$("#editItem1" + index).prop('disabled', true);

		}
	</script>
	
	<script type="text/javascript">
		function deleteFunction1(id, qty,index) {
			$
					.getJSON(
							'${deleteItem1}',
							{
								id : id,
								qty : qty,
                                index:index,
								ajax : 'true'
							},
							function(data) {
								$('#loader').hide();
								if (data == "") {
									alert("No records found !!");
								}
								$('#table_grid td').remove();
								var allTotal = 0;

								$
										.each(
												data,
												function(key, item) {

													var index = key + 1;

													var tr = "<tr>";

													var index = "<td align=left>"
															+ index + "</td>";

													var barcode = "<td>"
															+ item.itemId
															+ "</td>";

													var itemName = "<td>"
															+ item.itemName
															+ "</td>";

													var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+ (key+1)+ " name=billQty1"+(key+1)+" value = "+ item.qty+ " ></div></td>";

													var rate = "<td >"
															+ item.mrp
															+ "</td>";

													var total = parseFloat(item.mrp)
															* parseFloat(item.qty);

													var Amount = "<td align=center id=billTotal1"+(key+1)+">"
															+ total + "</td>";

													var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
															+ (key+1)
															+ " onclick=updateTotal1("
															+ item.id
															+ ","
															+ (key+1)
															+ ")>  </i>  <i class='fa fa-edit'onclick=editDisable1("
															+ item.id
															+ ","
															+ item.qty
															+ ","
															+(key+1)
															+ ");   id=editItem1"
															+ (key+1)
															+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
															+ item.id
															+ ","
															+ item.qty
															+ ","
															+ (key)
															+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";

													allTotal = allTotal + total;

													var trclosed = "</tr>";

													$('#table_grid tbody')
															.append(tr);
													$('#table_grid tbody')
															.append(index);
													$('#table_grid tbody')
															.append(barcode);
													$('#table_grid tbody')
															.append(itemName);
													$('#table_grid tbody')
															.append(qty);
													$('#table_grid tbody')
															.append(rate);

													$('#table_grid tbody')
															.append(Amount);

													$('#table_grid tbody')
															.append(action);

													$('#table_grid tbody')
															.append(trclosed);

												})

								$("#total1").html(allTotal);
								document.getElementById("tot1").setAttribute(
										'value', allTotal);

								var discount = $("#discount1").val();
								var grandAmt = allTotal
										- (allTotal * (discount / 100));

								document.getElementById("paidAmount1")
										.setAttribute('value', grandAmt);

								var paidAmount = $("#paidAmount1").val();

								var grandMinusPaidAmt = grandAmt - paidAmount;
								$('#grandtotal1').html(grandAmt);
								document.getElementById("grandtot1")
										.setAttribute('value', grandAmt);

								$('#remAmt1').html(grandMinusPaidAmt);
								document.getElementById("remAmount1")
										.setAttribute('value',
												grandMinusPaidAmt);

								document.getElementById("barcode1").focus();
							});
		}
	</script>
	<script type="text/javascript">
		function updateTotal1(id,token,index) {

			//	alert(id);
			//	alert(mrp);
			var key=index;
			var newQty = $("#billQty1"+token+""+ index).val();
			//	alert(newQty)

			$
					.getJSON(
							'${updateItem1}',
							{
								id : id,
								qty : newQty,
                                index : key,
                                token : token,
								ajax : 'true'
							},
							function(data) {
								$('#loader').hide();
								if (data == "") {
									alert("No records found !!");
								}
								$('#table_grid td').remove();
								var allTotal = 0;

								$
										.each(
												data,
												function(key, item) {

													var index = key + 1;

													var tr = "<tr>";

													var index = "<td align=left>"
															+ index + "</td>";

													var barcode = "<td>"
															+ item.itemId
															+ "</td>";

													var itemName = "<td>"
															+ item.itemName
															+ "</td>";

													var qty = "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control  disabled id= billQty1"+(key+1)+ " name=billQty1"+(key+1)+" value = "+ item.qty+ " ></div></td>";

													var rate = "<td >"
															+ item.mrp
															+ "</td>";

													var total = parseFloat(item.mrp)
															* parseFloat(item.qty);

													var Amount = "<td align=center id=billTotal1"+(key+1)+">"
															+ total + "</td>";

													var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"
															+ (key+1)
															+ " onclick=updateTotal1("
															+ item.id
															+ ","
															+ (key+1)
															+ ")>  </i>  <i class='fa fa-edit'onclick=editDisable1("
															+ item.id
															+ ","
															+ item.qty
															+ ","
															+ (key+1)
															+ ");   id=editItem1"
															+(key+1)
															+ "></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("
															+ item.id
															+ ","
															+ item.qty
															+ ","
															+ (key)
															+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
													/* <a href='#' class='action_btn'> *//* </a> */
													allTotal = allTotal + total;

													var trclosed = "</tr>";

													$('#table_grid tbody')
															.append(tr);
													$('#table_grid tbody')
															.append(index);
													$('#table_grid tbody')
															.append(barcode);
													$('#table_grid tbody')
															.append(itemName);
													$('#table_grid tbody')
															.append(qty);
													$('#table_grid tbody')
															.append(rate);

													$('#table_grid tbody')
															.append(Amount);

													$('#table_grid tbody')
															.append(action);

													$('#table_grid tbody')
															.append(trclosed);

												})

								$("#total1").html(allTotal);
								document.getElementById("tot1").setAttribute(
										'value', allTotal);

								var discount = $("#discount1").val();
								var grandAmt = allTotal
										- (allTotal * (discount / 100));

								document.getElementById("paidAmount1")
										.setAttribute('value', grandAmt);

								var paidAmount = $("#paidAmount1").val();

								var grandMinusPaidAmt = grandAmt - paidAmount;
								$('#grandtotal1').html(grandAmt);
								document.getElementById("grandtot1")
										.setAttribute('value', grandAmt);

								$('#remAmt1').html(grandMinusPaidAmt);
								document.getElementById("remAmount1")
										.setAttribute('value',
												grandMinusPaidAmt);

								document.getElementById("barcode1").focus();
							});
		}
	</script>
	 <script type="text/javascript">
		function generateSellBill1() {

			//var isValid = validation1();

			//if (isValid) {
				var custName = $("#custName1").val();
				var gstNo = $("#gstNo1").val();
				var phoneNo = $("#phoneNo1").val();
				var discount = $("#discount1").val();
				var paymentMode = $("#paymentMode1").val();
				var paidAmount = $("#paidAmount1").val();

				$('#loader').show();

				$.getJSON('${getCustomerBillList1}',

				{
					custName : custName,
					gstNo : gstNo,
					phoneNo : phoneNo,
					discount : discount,
					paymentMode : paymentMode,
					paidAmount : paidAmount,
					ajax : 'true'

				}, function(data) {

					$('#loader').hide();
					if (data == "") {
						alert("Order Placed Successfully !!");
					}
					$('#table_grid td').remove();

					document.getElementById("barcode1")
							.setAttribute('value', 0);

					$("#rateTdVal1").html(0);

					$("#total1").html(0.0);
					document.getElementById("tot1").setAttribute('value', 0.0);

					document.getElementById("paidAmount1").setAttribute(
							'value', 0.0);

					$('#grandtotal1').html(0.0);
					document.getElementById("grandtot1").setAttribute('value',
							0.0);

					$('#remAmt1').html(grandMinusPaidAmt);
					document.getElementById("remAmount1").setAttribute('value',
							0.0);

					document.getElementById("barcode1").focus();

				});

			//}

		}
	</script>
</body>
</html>
