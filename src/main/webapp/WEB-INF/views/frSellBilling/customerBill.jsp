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

<!--new css added by kalpesh -->
	<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" type="text/css" />
	
	<!--new css added by kalpesh -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.mCustomScrollbar.css">

  <script src="${pageContext.request.contextPath}/resources/css/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-select.min.css" />
	  <script src="${pageContext.request.contextPath}/resources/css/bootstrap-select.min.js"></script><!-- 1 css and 2 js for search item   -->
	
</head>
<body>
<c:url var="getCustomerBillList1" value="/generateSellBill1"></c:url>d
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
	<div class="sidebarOuter"></div>

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

				<!------------ Place Actual content of page inside this div ----------->
				<div class="sidebarright">

					<div class="order-left">
						<h2 class="pageTitle">Customer Bill</h2>

					</div>

					<div class="order-right">
						<a href="${pageContext.request.contextPath}/viewBill"><button class="pull-right btn view_bill_btn">
							View Bill
						</button></a>
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
							<div class="col-md-9">
								<div class="control-label">
								
								<div>
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
																
																
																</datalist> --> 
																
																
	
																<select class="selectpicker"  data-show-subtext="true" data-live-search="true"
																data-placeholder="Enter Item Name" name="itemName1"
																class="form-control" tabindex="-1" id="itemName1"
																data-rule-required="true"<%-- onchange="setRate(1,${itemListResponse.itemId},${itemListResponse.itemRate1})" --%>>
																	<option value="">Item Name</option>
																	<c:forEach items="${itemListResponse}"
																		var="itemListResponse">
																		<option value="${itemListResponse.id}">${itemListResponse.itemName}</option>
																	</c:forEach>
															</select> 
															
															<input name="item_name1" id="item_name1" type="hidden"
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
								</div> 
								</div>
								</div>
								
								
								
								
									<div class="col-md-2">
									<input name="rate1" id="rate1" type="hidden" value="00" />
									
										<center>
											<button class="btn additem_btn" onclick="addNewRow1()"
												id="b1">Add Item</button>
										</center>
									</div>
									</div>
								
								
								<div class="clearfix"></div>
								 <br /> <!-- Form End -->
								 
								 
								 
								 			<div id="table-scroll" class="table-scroll">
					<div id="faux-table" class="faux-table" aria="hidden"></div>
					<div class="table-wrap table-wrap-custbill">
						<table id="table_grid" class="main-table small-td">
							<thead>
								<tr class="bgpink">
															<th  class="sr-no">Sr no.</th>
															<th class="col-md-1">Barcode</th>
															<th class="col-md-2">Item Name</th>
															<th class="col-md-1">Qty</th>
															<th class="col-md-1">Rate</th>
															<th class="col-md-1">Amount</th>
															<th class="col-md-1">Action</th>
														</tr>
							</thead>
							<tbody>



							



							</tbody>

						</table>
					</div>
				</div>
						
						
						
					
								
								
								
								
                               <div class="row">
											<div class="col-md-4">
												<h4 class="col-md-7">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-5" id="total1">00</h4>
												<input type="hidden" class="form-control" id="tot1">
												</div>
												
												<div class="col-md-4">
												<h4 class="col-md-7" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-5"><input type="text" class="form-control" id="discount1"
														onkeyup="disMinusTotal1()" value="0"></div>
										     </div>
										     
										     <div class="col-md-4">
										     	<h4 class="col-md-7"style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>
										
												<h4 class="col-md-5" id="grandtotal1">00</h4>
												<input type="hidden" class="form-control" id="grandtot1">
										     </div>	
										     
										       <div class="clearfix"></div>
										        
										   		<div class="col-md-4">
												
												<h4 class="col-md-7" >
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-5">
												<select
																data-placeholder="Enter Payment Mode" name="paymentMode1"
																class="form-control" tabindex="-1" id="paymentMode1"
																data-rule-required="true">
																
																
																<option value="1">Cash</option>
																<option value="2">Card</option>
																<option value="3">Other</option>
																
																</select>
												
												</div>
												</div>
												
												<div class="col-md-4">
												<h4 class="col-md-7" >
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-5"><input type="text" class="form-control" id="paidAmount1"
														onkeyup="amtMinusGrandTotal1()" value="0"></div>
										     
										     </div>
										     
										     <div class="col-md-4">
										     	<h4 class="col-md-7" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>
												
												
										
												<h4 class="col-md-5" id="remAmt1">00</h4>
												<input type="hidden" class="form-control" id="remAmount1">
										     </div>	
										     
										  <div class="clearfix"></div>     
										     
										     
										     <hr/>
										<div class="col-md-12 control-label">
										
										<div class="col-md-4">
										<h4>Customer name:-</h4>
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName1" id="custName1" value="Cash">
											</div>
									<div class="col-md-4">
										<h4>GST No:-</h4>
										<input type="text" class="form-control"
											placeholder="Enter GST No." name="gstNo1" id="gstNo1">
									</div>
									
									
									<div class="col-md-4">
										<h4>Phone
											No:-</h4>
										<input type="text" class="form-control"
											placeholder="Enter phone No." name="phoneNo1" id="phoneNo1">
											</div>
									</div>
								
								</div>
								
								
								<center>
									<button class="btn additem_btn" onclick="generateSellBill1()">Generate Bill</button>
								</center>
							<input type="hidden" class="form-control" id=orderResponse1 value="${orderResponse}"/>
								
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
											placeholder="Enter Name" name="custName2" id="custName2"value="Cash">
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
								<div >
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
															<td>
															
															<select class="selectpicker"  data-show-subtext="true" data-live-search="true" data-placeholder="Enter Item Name"
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
											<button class="btn additem_btn" onclick="addNewRow2()">Add
												Item</button>
										</center>
									</div>
								</div> <br />
								<div class="table-responsive">
									<div class="shInnerwidth">
										
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid2" class="table table-bordered">
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
                                <hr/>
								 <div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total2" style="text-align:center;">00</h4>
												<input type="hidden" class="form-control" id="tot2">
												
												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="discount2"
														onkeyup="disMinusTotal2()" value="0"></div>
										     
										     	<h4 class="col-md-2"style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="grandtotal2"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot2">
										     </div>	
										</div>
								
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												
												<h4 class="col-md-2" >
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
												<select
																data-placeholder="Enter Payment Mode" name="paymentMode2"
																class="form-control" tabindex="-1" id="paymentMode2"
																data-rule-required="true">
																
																
																<option value="1">Cash</option>
																<option value="2">Card</option>
																<option value="3">Other</option>
																
																</select>
												
												</div>
												<h4 class="col-md-2" >
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="paidAmount2"
														onkeyup="amtMinusGrandTotal2()" value="0"></div>
										     
										     	<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="remAmt2"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount2">
										     </div>	
								</div>
									</div>
								</div>
								<br/>
								<center>
									<button class="btn additem_btn" onclick="generateSellBill2()">Generate Bill</button>
								</center>
							<input type="hidden" class="form-control" id=orderResponse2 value="${orderResponse}"/>
								
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
											placeholder="Enter Name" name="custName3" id="custName3"value="Cash">
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
								<div>
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
															<td><select class="selectpicker"  data-show-subtext="true" data-live-search="true" data-placeholder="Enter Item Name"
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
										
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid3" class="table table-bordered">
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
								</div><hr/>
								 <div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total3" style="text-align:center;">00</h4>
												<input type="hidden" class="form-control" id="tot3">
												
												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="discount3"
														onkeyup="disMinusTotal3()" value="0"></div>
										     
										     	<h4 class="col-md-2"style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="grandtotal3"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot3">
										     </div>	
										</div>
								
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												
												<h4 class="col-md-2" >
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
												<select
																data-placeholder="Enter Payment Mode" name="paymentMode3"
																class="form-control" tabindex="-1" id="paymentMode3"
																data-rule-required="true">
																
																
																<option value="1">Cash</option>
																<option value="2">Card</option>
																<option value="3">Other</option>
																
																</select>
												
												</div>
												<h4 class="col-md-2" >
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="paidAmount3"
														onkeyup="amtMinusGrandTotal3()" value="0"></div>
										     
										     	<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="remAmt3"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount3">
										     </div>	
								</div>
									</div>
								</div>
								<br/>
								<center>
									<button class="btn additem_btn" onclick="generateSellBill3()">Generate Bill</button>
								</center>
							<input type="hidden" class="form-control" id=orderResponse3 value="${orderResponse}"/>
								
							</li>
							<!--tab4-->
							<li data-content="tab4">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName4" id="custName4" value="Cash">
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
									
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid4" class="table table-bordered">
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
								</div><hr/>
								 <div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total4" style="text-align:center;">00</h4>
												<input type="hidden" class="form-control" id="tot4">
												
												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="discount4"
														onkeyup="disMinusTotal4()" value="0"></div>
														
												<h4 class="col-md-2"style="margin-top: 5px">		
													<b>Grand Total:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="grandtotal4"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot4">
										    
										</div>
								
									</div>
								</div>
								</div>
								</br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												
												<h4 class="col-md-2" >
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
												<select
																data-placeholder="Enter Payment Mode" name="paymentMode4"
																class="form-control" tabindex="-1" id="paymentMode4"
																data-rule-required="true">
																
																
																<option value="1">Cash</option>
																<option value="2">Card</option>
																<option value="3">Other</option>
																
																</select>
												
												</div>
												<h4 class="col-md-2" >
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="paidAmount4"
														onkeyup="amtMinusGrandTotal4()" value="0"></div>
										     
										     	<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="remAmt4"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount4">
										     </div>	
								</div>
									</div>
								</div>
								<br/>
								<center>
									<button class="btn additem_btn" onclick="generateSellBill4()">Generate Bill</button>
								</center>
							<input type="hidden" class="form-control" id=orderResponse4 value="${orderResponse}"/>
								
							</li>
							<!--tab5-->
							<li data-content="tab5">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName5" id="custName5"value="Cash">
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
									
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid5" class="table table-bordered">
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
								</div><hr/>
								 <div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total5" style="text-align:center;">00</h4>
												<input type="hidden" class="form-control" id="tot5">
												
												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="discount5"
														onkeyup="disMinusTotal5()" value="0"></div>
										     
										     	<h4 class="col-md-2"style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="grandtotal5"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot5">
										     </div>	
										</div>
								
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												
												<h4 class="col-md-2" >
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
												<select
																data-placeholder="Enter Payment Mode" name="paymentMode5"
																class="form-control" tabindex="-1" id="paymentMode5"
																data-rule-required="true">
																
																
																<option value="1">Cash</option>
																<option value="2">Card</option>
																<option value="3">Other</option>
																
																</select>
												
												</div>
												<h4 class="col-md-2" >
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="paidAmount5"
														onkeyup="amtMinusGrandTotal5()" value="0"></div>
										     
										     	<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="remAmt5"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount5">
										     </div>	
								</div>
									</div>
								</div>
								<br/>
								<center>
									<button class="btn additem_btn" onclick="generateSellBill5()">Generate Bill</button>
								</center>
							<input type="hidden" class="form-control" id=orderResponse5 value="${orderResponse}"/>
								
							</li>
							<!--tab6-->
							<li data-content="tab6">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName6" id="custName6"value="Cash">
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
										
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid6" class="table table-bordered">
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
								</div><hr/>
								 <div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total6" style="text-align:center;">00</h4>
												<input type="hidden" class="form-control" id="tot6">
												
												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="discount6"
														onkeyup="disMinusTotal6()" value="0"></div>
										     
										     	<h4 class="col-md-2"style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="grandtotal6"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot6">
										     </div>	
										</div>
								
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												
												<h4 class="col-md-2" >
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
												<select
																data-placeholder="Enter Payment Mode" name="paymentMode6"
																class="form-control" tabindex="-1" id="paymentMode6"
																data-rule-required="true">
																
																
																<option value="1">Cash</option>
																<option value="2">Card</option>
																<option value="3">Other</option>
																
																</select>
												
												</div>
												<h4 class="col-md-2" >
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="paidAmount6"
														onkeyup="amtMinusGrandTotal6()" value="0"></div>
										     
										     	<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="remAmt6"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount6">
										     </div>	
								</div>
									</div>
								</div>
								<br/>
								<center>
									<button class="btn additem_btn" onclick="generateSellBill6()">Generate Bill</button>
								</center>
							<input type="hidden" class="form-control" id=orderResponse6 value="${orderResponse}"/>
								
							</li>
							<!--tab7-->
							<li data-content="tab7">
								<div class="row">
									<div class="col-md-2 control-label">
										<h4 style="margin-top: 5px;">Customer name:-</h4>
									</div>
									<div class="col-md-2">
										<input type="text" class="form-control"
											placeholder="Enter Name" name="custName7" id="custName7"value="Cash">
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
										
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid7" class="table table-bordered">
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
								</div><hr/>
								 <div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<h4 class="col-md-2">
													<b>Total:-</b>
												</h4>
												<h4 class="col-md-2" id="total7" style="text-align:center;">00</h4>
												<input type="hidden" class="form-control" id="tot7">
												
												<h4 class="col-md-2" style="margin-top: 5px">
													<b>Discount(%):-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="discount7"
														onkeyup="disMinusTotal7()" value="0"></div>
										     
										     	<h4 class="col-md-2"style="margin-top: 5px">
													<b>Grand Total:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="grandtotal7"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="grandtot7">
										     </div>	
										</div>
								
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												
												<h4 class="col-md-2" >
													<b>Payment Mode:-</b>
												</h4>
												<div class="col-md-2">
												<select
																data-placeholder="Enter Payment Mode" name="paymentMode7"
																class="form-control" tabindex="-1" id="paymentMode7"
																data-rule-required="true">
																
																
																<option value="1">Cash</option>
																<option value="2">Card</option>
																<option value="3">Other</option>
																
																</select>
												
												</div>
												<h4 class="col-md-2" >
													<b>Paid Amount:-</b>
												</h4>
												<div class="col-md-1 pull-left"><input type="text" class="form-control" id="paidAmount7"
														onkeyup="amtMinusGrandTotal7()" value="0"></div>
										     
										     	<h4 class="col-md-2" style="margin-top: 5px">
													<b>Remaining Amt:-</b>
												</h4>
										
												<h4 class="col-md-2 pull-left" id="remAmt7"style="margin-top: 5px">00</h4>
												<input type="hidden" class="form-control" id="remAmount7">
										     </div>	
								</div>
									</div>
								</div>
								<br/>
								<center>
									<button class="btn additem_btn" onclick="generateSellBill7()">Generate Bill</button>
								</center>
							    <input type="hidden" class="form-control" id=orderResponse7 value="${orderResponse}"/>
								
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
	
	
<script type="text/javascript">
		function generateSellBill1() {

			var isValid = validation1();

			if (isValid) {
				var custName = $("#custName1").val();
				var gstNo = $("#gstNo1").val();
				var phoneNo = $("#phoneNo1").val();
                var discount=$("#discount1").val();
                var paymentMode=$("#paymentMode1").val();
                var paidAmount=$("#paidAmount1").val();

               
				$('#loader').show();

				$.getJSON('${getCustomerBillList1}',

								{
									custName :custName,
									gstNo :gstNo ,
									phoneNo :phoneNo,
									discount:discount,
									paymentMode:paymentMode,
									paidAmount:paidAmount,
									ajax : 'true'

								},
								function(data) {
							
									
									$('#loader').hide();
									if (data == "") {
										alert("Order Placed Successfully !!");
									}
									$('#table_grid td').remove();
									
									document.getElementById("barcode1")
									.setAttribute('value',
											0);
									

							        $("#rateTdVal1").html(0);
									
									$("#total1").html(0.0);
									document.getElementById("tot1")
											.setAttribute('value', 0.0);
									
									document.getElementById("paidAmount1")
									.setAttribute('value', 0.0);
								
									
									$('#grandtotal1').html(0.0);
									document.getElementById("grandtot1").setAttribute('value',0.0);

									
									$('#remAmt1').html(grandMinusPaidAmt);
									document.getElementById("remAmount1").setAttribute('value',0.0);
									
									document.getElementById("barcode1").focus();
										
									
								});
			
			
			}
			
		}
	</script>
	<script type="text/javascript">
		function generateSellBill2() {

			
			var isValid = validation1();

			if (isValid) {
				var custName = $("#custName2").val();
				var gstNo = $("#gstNo2").val();
				var phoneNo = $("#phoneNo2").val();
                var discount=$("#discount2").val();
                var paymentMode=$("#paymentMode2").val();
                var paidAmount=$("#paidAmount2").val();


				$('#loader').show();

				$.getJSON(
								'${getCustomerBillList2}',

								{
									custName :custName,
									gstNo :gstNo ,
									phoneNo :phoneNo,
									discount:discount,
									paymentMode:paymentMode,
									paidAmount:paidAmount,
									ajax : 'true'

								},
								function(data) {
							
									
									$('#loader').hide();
									if (data == "") {
										alert("Order Placed Successfully !!");
									}
									$('#table_grid2 td').remove();

									document.getElementById("barcode2")
									.setAttribute('value',
											0);
									

							        $("#rateTdVal2").html(0);
									
									$("#total2").html(0.0);
									document.getElementById("tot2")
											.setAttribute('value', 0.0);
									
									document.getElementById("paidAmount2")
									.setAttribute('value', 0.0);
								
									
									$('#grandtotal2').html(0.0);
									document.getElementById("grandtot2").setAttribute('value',0.0);

									
									$('#remAmt2').html(grandMinusPaidAmt);
									document.getElementById("remAmount2").setAttribute('value',0.0);
									
									document.getElementById("barcode2").focus();
										
									
								});
			}
			
		}
	</script>
	
	<script type="text/javascript">
		function generateSellBill3() {

		
			
			var isValid = validation3();

			if (isValid) {
				var custName = $("#custName3").val();
				var gstNo = $("#gstNo3").val();
				var phoneNo = $("#phoneNo3").val();
                var discount=$("#discount3").val();
                var paymentMode=$("#paymentMode3").val();
                var paidAmount=$("#paidAmount3").val();

				$('#loader').show();

				$.getJSON(
								'${getCustomerBillList3}',

								{
									custName :custName,
									gstNo :gstNo ,
									phoneNo :phoneNo,
									discount:discount,
									paymentMode:paymentMode,
									paidAmount:paidAmount,
									ajax : 'true'

								},
								function(data) {
								
									
									$('#loader').hide();
									if (data == "") {
										alert("Order Placed Successfully !!");
									}
									$('#table_grid3 td').remove();

									
									document.getElementById("barcode3")
									.setAttribute('value',
											0);
									

							        $("#rateTdVal3").html(0);
									
									$("#total3").html(0.0);
									document.getElementById("tot3")
											.setAttribute('value', 0.0);
									
									document.getElementById("paidAmount3")
									.setAttribute('value', 0.0);
								
									
									$('#grandtotal3').html(0.0);
									document.getElementById("grandtot3").setAttribute('value',0.0);

									
									$('#remAmt3').html(grandMinusPaidAmt);
									document.getElementById("remAmount3").setAttribute('value',0.0);
									
									document.getElementById("barcode3").focus();	
									
								});
			}
			
		}
	</script>
	<script type="text/javascript">
		function generateSellBill4() {

			
			var isValid = validation4();

			if (isValid) {
				var custName = $("#custName4").val();
				var gstNo = $("#gstNo4").val();
				var phoneNo = $("#phoneNo4").val();
                var discount=$("#discount4").val();
                var paymentMode=$("#paymentMode4").val();
                var paidAmount=$("#paidAmount4").val();

         
				$('#loader').show();

				$.getJSON(
								'${getCustomerBillList4}',

								{
									custName :custName,
									gstNo :gstNo ,
									phoneNo :phoneNo,
									discount:discount,
									paymentMode:paymentMode,
									paidAmount:paidAmount,
									ajax : 'true'

								},
								function(data) {
							
									
									$('#loader').hide();
									if (data == "") {
										alert("Order Placed Successfully !!");
									}
									$('#table_grid4 td').remove();

									document.getElementById("barcode4")
									.setAttribute('value',
											0);
									

							        $("#rateTdVal4").html(0);
									
									$("#total4").html(0.0);
									document.getElementById("tot4")
											.setAttribute('value', 0.0);
									
									document.getElementById("paidAmount4")
									.setAttribute('value', 0.0);
								
									
									$('#grandtotal4').html(0.0);
									document.getElementById("grandtot4").setAttribute('value',0.0);

									
									$('#remAmt4').html(grandMinusPaidAmt);
									document.getElementById("remAmount4").setAttribute('value',0.0);
									
									document.getElementById("barcode4").focus();
										
									
								});
			}
			
		}
	</script>
	<script type="text/javascript">
		function generateSellBill5() {

	
			
			var isValid = validation5();

			if (isValid) {
				var custName = $("#custName5").val();
				var gstNo = $("#gstNo5").val();
				var phoneNo = $("#phoneNo5").val();
                var discount=$("#discount5").val();
                var paymentMode=$("#paymentMode5").val();
                var paidAmount=$("#paidAmount5").val();

        
				$('#loader').show();

				$.getJSON(
								'${getCustomerBillList5}',

								{
									custName :custName,
									gstNo :gstNo ,
									phoneNo :phoneNo,
									discount:discount,
									paymentMode:paymentMode,
									paidAmount:paidAmount,
									ajax : 'true'

								},
								function(data) {
								
									
									$('#loader').hide();
									if (data == "") {
										alert("Order Placed Successfully !!");
									}
									$('#table_grid5 td').remove();

									document.getElementById("barcode5")
									.setAttribute('value',
											0);
									

							        $("#rateTdVal5").html(0);
									
									$("#total5").html(0.0);
									document.getElementById("tot5")
											.setAttribute('value', 0.0);
									
									document.getElementById("paidAmount5")
									.setAttribute('value', 0.0);
								
									
									$('#grandtotal5').html(0.0);
									document.getElementById("grandtot5").setAttribute('value',0.0);

									
									$('#remAmt5').html(grandMinusPaidAmt);
									document.getElementById("remAmount5").setAttribute('value',0.0);
									
									document.getElementById("barcode5").focus();
										
									
								});
			}
			
		}
	</script>
	<script type="text/javascript">
		function generateSellBill6() {


			
			var isValid = validation6();

			if (isValid) {
				var custName = $("#custName6").val();
				var gstNo = $("#gstNo6").val();
				var phoneNo = $("#phoneNo6").val();
                var discount=$("#discount6").val();
                var paymentMode=$("#paymentMode6").val();
                var paidAmount=$("#paidAmount6").val();

				$('#loader').show();

				$.getJSON(
								'${getCustomerBillList6}',

								{
									custName :custName,
									gstNo :gstNo ,
									phoneNo :phoneNo,
									discount:discount,
									paymentMode:paymentMode,
									paidAmount:paidAmount,
									ajax : 'true'

								},
								function(data) {
								
									
									$('#loader').hide();
									if (data == "") {
										alert("Order Placed Successfully !!");
									}
									$('#table_grid6 td').remove();

									document.getElementById("barcode6")
									.setAttribute('value',
											0);
									

							        $("#rateTdVal6").html(0);
									
									$("#total6").html(0.0);
									document.getElementById("tot6")
											.setAttribute('value', 0.0);
									
									document.getElementById("paidAmount6")
									.setAttribute('value', 0.0);
								
									
									$('#grandtotal6').html(0.0);
									document.getElementById("grandtot6").setAttribute('value',0.0);

									
									$('#remAmt6').html(grandMinusPaidAmt);
									document.getElementById("remAmount6").setAttribute('value',0.0);
									
									document.getElementById("barcode6").focus();
										
									
								});
			}
			
		}
	</script>
	<script type="text/javascript">
		function generateSellBill7() {

	
			
			var isValid = validation7();

			if (isValid) {
				var custName = $("#custName7").val();
				var gstNo = $("#gstNo7").val();
				var phoneNo = $("#phoneNo7").val();
                var discount=$("#discount7").val();
                var paymentMode=$("#paymentMode7").val();
                var paidAmount=$("#paidAmount7").val();

				$('#loader').show();

				$.getJSON(
								'${getCustomerBillList7}',

								{
									custName :custName,
									gstNo :gstNo ,
									phoneNo :phoneNo,
									discount:discount,
									paymentMode:paymentMode,
									paidAmount:paidAmount,
									ajax : 'true'

								},
								function(data) {
								
									$('#loader').hide();
									if (data == "") {
										alert("Order Placed Successfully !!");
									}
									$('#table_grid7 td').remove();

									document.getElementById("barcode7")
									.setAttribute('value',
											0);
									

							        $("#rateTdVal7").html(0);
									
									$("#total7").html(0.0);
									document.getElementById("tot7")
											.setAttribute('value', 0.0);
									
									document.getElementById("paidAmount7")
									.setAttribute('value', 0.0);
								
									
									$('#grandtotal7').html(0.0);
									document.getElementById("grandtot7").setAttribute('value',0.0);

									
									$('#remAmt7').html(grandMinusPaidAmt);
									document.getElementById("remAmount7").setAttribute('value',0.0);
									
									document.getElementById("barcode7").focus();
										
									
								});
			}
			
		}
	</script>
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
	</script>

	<script type="text/javascript">
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
	</script>
	<script type="text/javascript">
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
	</script>
	<script type="text/javascript">
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
	</script>
	<script type="text/javascript">
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
	</script>
	<script type="text/javascript">
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
	</script>
	<script type="text/javascript">
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
		function addNewRow1() {

			var isValid = validation1();
			if (isValid) {

				var id = $("#itemName1").val();
				var barcode = $("#barcode1").val();
				//alert(barcode);
				var qty = $("#qty1").val();
				//alert(qty);
				var custName = $("#custName1").val();
				//alert(custName);
				var phoneNo = $("#phoneNo1").val();
				//alert(phoneNo);
				var gstNo = $("#gstNo1").val();
				//alert(gstNo);

				$('#loader').show();
				$
						.getJSON(
								'${getAllAddedItems1}',
								{
									id : id,
									qty : qty,

									ajax : 'true'
								},
								function(data) {
									$('#loader').hide();
									if (data == "") {
										alert("No records found !!");
									}
									$('#table_grid td').remove();
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

														var qty =  "<td><div class='col-md-10 row'><input type=text min=0 max=30 class=form-control   disabled id= billQty1"+ item.id+ " name=billQty1"+item.id+" value = "+ item.qty+ " ></div></td>";
/*onkeyup= updateTotal("
															+ bill.id + ","
															+ bill.mrp + ") onchange= updateTotal("+ bill.id+ ","+ bill.mrp+ ")*/
														var rate = "<td >"
																+ item.mrp
																+ "</td>";

														var total = parseFloat(item.mrp)
																* parseFloat(item.qty);

														var Amount = "<td align=center id=billTotal1"+item.id+">"
																+ total
																+ "</td>";

														var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"+item.id+" onclick=updateTotal1("
														+ item.id + ","
														+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable1("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem1"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
														/* <a href='#' class='action_btn'> *//* </a> */
														allTotal = allTotal
																+ total;

														var trclosed = "</tr>";

														$('#table_grid tbody')
																.append(tr);
														$('#table_grid tbody')
																.append(index);
														$('#table_grid tbody')
																.append(barcode);
														$('#table_grid tbody')
																.append(
																		itemName);
														$('#table_grid tbody')
																.append(qty);
														$('#table_grid tbody')
																.append(rate);

														$('#table_grid tbody')
																.append(Amount);

														$('#table_grid tbody')
																.append(action);

														$('#table_grid tbody')
																.append(
																		trclosed);

													})


									$("#total1").html(allTotal);
									document.getElementById("tot1")
											.setAttribute('value', allTotal);

									
									
									
									var discount = $("#discount1").val();
									var grandAmt = allTotal - (allTotal * (discount / 100));
									
									document.getElementById("paidAmount1")
									.setAttribute('value', grandAmt);
									
									var paidAmount = $("#paidAmount1").val();
									
									var grandMinusPaidAmt=grandAmt-paidAmount;
									
									$('#grandtotal1').html(grandAmt);
									document.getElementById("grandtot1").setAttribute('value',grandAmt);

									
									$('#remAmt1').html(grandMinusPaidAmt);
									document.getElementById("remAmount1").setAttribute('value',grandMinusPaidAmt);
									
									document.getElementById("barcode1").focus();
								});
			}
		}
	</script>
	
	
	<script type="text/javascript">
	function editDisable1(id,qty){
	//	alert(id+""+qty)
		
		$("#billQty1"+id).prop('disabled', false);
		
		$("#saveItem1"+id).show();
		document.getElementById("saveItem1"+id).style.visibility = "visible"; 
		
		document.getElementById("editItem1"+id).style.visibility= "hidden"; 
		$("#editItem1"+id).prop('disabled', true);
		
	}
	</script>
	<script type="text/javascript">
	function editEnable1(id){
		//alert(id)
		$("#saveItem1"+id).hide();
		document.getElementById("saveItem1"+id).style.visibility = "hidden"; 

		$("#editItem1"+id).prop('disabled', false);
		document.getElementById("editItem1"+id).style.visibility= "visible"; 
	}
	</script>
	<script type="text/javascript">
	function deleteFunction1(id,qty){
		 $.getJSON(
					'${deleteItem1}',
					{
						id : id,
						qty : qty,

						ajax : 'true'
					},
					function(data) {
						$('#loader').hide();
						if (data == "") {
							alert("No records found !!");
						}
						$('#table_grid td').remove();
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

											var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty1"+ item.id+ " name=billQty1"+item.id+" value = "+ item.qty+ " ></div></td>";

											var rate = "<td >"
													+ item.mrp
													+ "</td>";

											var total = parseFloat(item.mrp)
													* parseFloat(item.qty);

											var Amount = "<td align=center id=billTotal1"+item.id+">"
													+ total
													+ "</td>";

											var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"+item.id+" onclick=updateTotal1("
											+ item.id + ","
											+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable1("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem1"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";

											allTotal = allTotal
													+ total;

											var trclosed = "</tr>";

											$('#table_grid tbody')
													.append(tr);
											$('#table_grid tbody')
													.append(index);
											$('#table_grid tbody')
													.append(barcode);
											$('#table_grid tbody')
													.append(
															itemName);
											$('#table_grid tbody')
													.append(qty);
											$('#table_grid tbody')
													.append(rate);

											$('#table_grid tbody')
													.append(Amount);

											$('#table_grid tbody')
													.append(action);

											$('#table_grid tbody')
													.append(
															trclosed);
											

										})

						$("#total1").html(allTotal);
						document.getElementById("tot1")
								.setAttribute('value', allTotal);

						
						
						var discount = $("#discount1").val();
						var grandAmt = allTotal - (allTotal * (discount / 100));
						
						document.getElementById("paidAmount1")
						.setAttribute('value', grandAmt);
						
						var paidAmount = $("#paidAmount1").val();
						
						var grandMinusPaidAmt=grandAmt-paidAmount;
						$('#grandtotal1').html(grandAmt);
						document.getElementById("grandtot1").setAttribute('value',grandAmt);

						
						$('#remAmt1').html(grandMinusPaidAmt);
						document.getElementById("remAmount1").setAttribute('value',grandMinusPaidAmt);
						
						document.getElementById("barcode1").focus();
					});
}</script>
	<script type="text/javascript">
		function updateTotal1(id,mrp) {
			
		//	alert(id);
		//	alert(mrp);
			var newQty = $("#billQty1" + id).val();
		//	alert(newQty)
			
			
				
			 $.getJSON(
						'${updateItem1}',
						{
							id : id,
							qty : newQty,

							ajax : 'true'
						},
						function(data) {
							$('#loader').hide();
							if (data == "") {
								alert("No records found !!");
							}
							$('#table_grid td').remove();
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

												var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control  disabled id= billQty1"+ item.id+ " name=billQty1"+item.id+" value = "+ item.qty+ " ></div></td>";

												var rate = "<td >"
														+ item.mrp
														+ "</td>";

												var total = parseFloat(item.mrp)
														* parseFloat(item.qty);

												var Amount = "<td align=center id=billTotal1"+item.id+">"
														+ total
														+ "</td>";

												var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem1"+item.id+" onclick=updateTotal1("
												+ item.id + ","
												+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable1("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem1"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction1("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
												/* <a href='#' class='action_btn'> *//* </a> */
												allTotal = allTotal
														+ total;

												var trclosed = "</tr>";

												$('#table_grid tbody')
														.append(tr);
												$('#table_grid tbody')
														.append(index);
												$('#table_grid tbody')
														.append(barcode);
												$('#table_grid tbody')
														.append(
																itemName);
												$('#table_grid tbody')
														.append(qty);
												$('#table_grid tbody')
														.append(rate);

												$('#table_grid tbody')
														.append(Amount);

												$('#table_grid tbody')
														.append(action);

												$('#table_grid tbody')
														.append(
																trclosed);

											})

							$("#total1").html(allTotal);
							document.getElementById("tot1")
									.setAttribute('value', allTotal);

							
							
							var discount = $("#discount1").val();
							var grandAmt = allTotal - (allTotal * (discount / 100));
							
							document.getElementById("paidAmount1")
							.setAttribute('value', grandAmt);
							
							var paidAmount = $("#paidAmount1").val();
							
							var grandMinusPaidAmt=grandAmt-paidAmount;
							$('#grandtotal1').html(grandAmt);
							document.getElementById("grandtot1").setAttribute('value',grandAmt);

							
							$('#remAmt1').html(grandMinusPaidAmt);
							document.getElementById("remAmount1").setAttribute('value',grandMinusPaidAmt);
							
							document.getElementById("barcode1").focus();
						});
		}
	</script>
	
	<script type="text/javascript">
		function addNewRow2() {

			var isValid = validation2();
			if (isValid) {

				var id = $("#itemName2").val();
				var barcode = $("#barcode2").val();
				//alert(barcode);
				var qty = $("#qty2").val();
				//alert(qty);
				var custName = $("#custName2").val();
				//alert(custName);
				var phoneNo = $("#phoneNo2").val();
				//alert(phoneNo);
				var gstNo = $("#gstNo2").val();
				//alert(gstNo);

				$('#loader').show();
				$
						.getJSON(
								'${getAllAddedItems2}',
								{
									id : id,
									qty : qty,

									ajax : 'true'
								},
								function(data) {
									$('#loader').hide();
									if (data == "") {
										alert("No records found !!");
									}
									$('#table_grid2 td').remove();
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

														var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty2"+ item.id+ " name=billQty2"+item.id+" value = "+ item.qty+ " ></div></td>";
/*onkeyup= updateTotal("
															+ bill.id + ","
															+ bill.mrp + ") onchange= updateTotal("+ bill.id+ ","+ bill.mrp+ ")*/
														var rate = "<td >"
																+ item.mrp
																+ "</td>";

														var total = parseFloat(item.mrp)
																* parseFloat(item.qty);

														var Amount = "<td align=center id=billTotal2"+item.id+">"
																+ total
																+ "</td>";

														var action = "<td><abbr title='Save'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem2"+item.id+" onclick=updateTotal2("
														+ item.id + ","
														+ item.mrp + ")>  </i> </abbr> <abbr title='Edit'><i class='fa fa-edit'onclick=editDisable2("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem2"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction2("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
														/* <a href='#' class='action_btn'> *//* </a> */
														allTotal = allTotal
																+ total;

														var trclosed = "</tr>";

														$('#table_grid2 tbody')
																.append(tr);
														$('#table_grid2 tbody')
																.append(index);
														$('#table_grid2 tbody')
																.append(barcode);
														$('#table_grid2 tbody')
																.append(
																		itemName);
														$('#table_grid2 tbody')
																.append(qty);
														$('#table_grid2 tbody')
																.append(rate);

														$('#table_grid2 tbody')
																.append(Amount);

														$('#table_grid2 tbody')
																.append(action);

														$('#table_grid2 tbody')
																.append(
																		trclosed);

													})


									$("#total2").html(allTotal);
									document.getElementById("tot2")
											.setAttribute('value', allTotal);

									document.getElementById("paidAmount2")
									.setAttribute('value', allTotal);
									
									var discount = $("#discount2").val();
									var grandAmt = allTotal - (allTotal * (discount / 100));
									var paidAmount = $("#paidAmount2").val();
									
									var grandMinusPaidAmt=grandAmt-paidAmount;
									$('#grandtotal2').html(grandAmt);
									document.getElementById("grandtot2").setAttribute('value',grandAmt);

									
									$('#remAmt2').html(grandMinusPaidAmt);
									document.getElementById("remAmount2").setAttribute('value',grandMinusPaidAmt);
									
									document.getElementById("barcode2").focus();
								});
			}
		}
	</script>
	<script type="text/javascript">
	function editDisable2(id,qty){
	//	alert(id+""+qty)
		
		$("#billQty2"+id).prop('disabled', false);
		
		$("#saveItem2"+id).show();
		document.getElementById("saveItem2"+id).style.visibility = "visible"; 
		
		document.getElementById("editItem2"+id).style.visibility= "hidden"; 
		$("#editItem2"+id).prop('disabled', true);
		
	}
	</script>
	<script type="text/javascript">
	function deleteFunction2(id,qty){
		 $.getJSON(
					'${deleteItem2}',
					{
						id : id,
						qty : qty,

						ajax : 'true'
					},
					function(data) {
						$('#loader').hide();
						if (data == "") {
							alert("No records found !!");
						}
						$('#table_grid2 td').remove();
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

											var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty2"+ item.id+ " name=billQty2"+item.id+" value = "+ item.qty+ " ></div></td>";

											var rate = "<td >"
													+ item.mrp
													+ "</td>";

											var total = parseFloat(item.mrp)
													* parseFloat(item.qty);

											var Amount = "<td align=center id=billTotal2"+item.id+">"
													+ total
													+ "</td>";

											var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem2"+item.id+" onclick=updateTotal2("
											+ item.id + ","
											+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable2("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem2"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction2("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";

											allTotal = allTotal
													+ total;

											var trclosed = "</tr>";

											$('#table_grid2 tbody')
													.append(tr);
											$('#table_grid2 tbody')
													.append(index);
											$('#table_grid2 tbody')
													.append(barcode);
											$('#table_grid2 tbody')
													.append(
															itemName);
											$('#table_grid2 tbody')
													.append(qty);
											$('#table_grid2 tbody')
													.append(rate);

											$('#table_grid2 tbody')
													.append(Amount);

											$('#table_grid2 tbody')
													.append(action);

											$('#table_grid2 tbody')
													.append(
															trclosed);
											

										})

						$("#total2").html(allTotal);
						document.getElementById("tot2")
								.setAttribute('value', allTotal);

						document.getElementById("paidAmount2")
						.setAttribute('value', allTotal);
						
						var discount = $("#discount2").val();
						var grandAmt = allTotal - (allTotal * (discount / 100));
						var paidAmount = $("#paidAmount2").val();
						
						var grandMinusPaidAmt=grandAmt-paidAmount;
						$('#grandtotal2').html(grandAmt);
						document.getElementById("grandtot2").setAttribute('value',grandAmt);

						
						$('#remAmt2').html(grandMinusPaidAmt);
						document.getElementById("remAmount2").setAttribute('value',grandMinusPaidAmt);
						
						document.getElementById("barcode2").focus();
					});
}</script>
	<script type="text/javascript">
		function updateTotal2(id,mrp) {
			
			//alert(id);
		//	alert(mrp);
			var newQty = $("#billQty2" + id).val();
			//alert(newQty)
			
			
				
			 $.getJSON(
						'${updateItem2}',
						{
							id : id,
							qty : newQty,

							ajax : 'true'
						},
						function(data) {
							$('#loader').hide();
							if (data == "") {
								alert("No records found !!");
							}
							$('#table_grid2 td').remove();
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

												var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control  disabled id= billQty2"+ item.id+ " name=billQty2"+item.id+" value = "+ item.qty+ " ></div></td>";

												var rate = "<td >"
														+ item.mrp
														+ "</td>";

												var total = parseFloat(item.mrp)
														* parseFloat(item.qty);

												var Amount = "<td align=center id=billTotal2"+item.id+">"
														+ total
														+ "</td>";

												var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem2"+item.id+" onclick=updateTotal2("
												+ item.id + ","
												+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable2("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem2"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction2("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
												/* <a href='#' class='action_btn'> *//* </a> */
												allTotal = allTotal
														+ total;

												var trclosed = "</tr>";

												$('#table_grid2 tbody')
														.append(tr);
												$('#table_grid2 tbody')
														.append(index);
												$('#table_grid2 tbody')
														.append(barcode);
												$('#table_grid2 tbody')
														.append(
																itemName);
												$('#table_grid2 tbody')
														.append(qty);
												$('#table_grid2 tbody')
														.append(rate);

												$('#table_grid2 tbody')
														.append(Amount);

												$('#table_grid2 tbody')
														.append(action);

												$('#table_grid2 tbody')
														.append(
																trclosed);

											})

							$("#total2").html(allTotal);
							document.getElementById("tot2")
									.setAttribute('value', allTotal);

							document.getElementById("paidAmount2")
							.setAttribute('value', allTotal);
							
							var discount = $("#discount2").val();
							var grandAmt = allTotal - (allTotal * (discount / 100));
							var paidAmount = $("#paidAmount2").val();
							
							var grandMinusPaidAmt=grandAmt-paidAmount;
							$('#grandtotal2').html(grandAmt);
							document.getElementById("grandtot2").setAttribute('value',grandAmt);

							
							$('#remAmt2').html(grandMinusPaidAmt);
							document.getElementById("remAmount2").setAttribute('value',grandMinusPaidAmt);
							
							document.getElementById("barcode2").focus();
						});
		}
	</script>
	<script type="text/javascript">
		function addNewRow3() {

			var isValid = validation3();
			if (isValid) {

				var id = $("#itemName3").val();
				var barcode = $("#barcode3").val();
				//alert(barcode);
				var qty = $("#qty3").val();
				//alert(qty);
				var custName = $("#custName3").val();
				//alert(custName);
				var phoneNo = $("#phoneNo3").val();
				//alert(phoneNo);
				var gstNo = $("#gstNo3").val();
				//alert(gstNo);

				$('#loader').show();
				$
						.getJSON(
								'${getAllAddedItems3}',
								{
									id : id,
									qty : qty,

									ajax : 'true'
								},
								function(data) {
									$('#loader').hide();
									if (data == "") {
										alert("No records found !!");
									}
									$('#table_grid3 td').remove();
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

														var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty3"+ item.id+ " name=billQty3"+item.id+" value = "+ item.qty+ " ></div></td>";
/*onkeyup= updateTotal("
															+ bill.id + ","
															+ bill.mrp + ") onchange= updateTotal("+ bill.id+ ","+ bill.mrp+ ")*/
														var rate = "<td >"
																+ item.mrp
																+ "</td>";

														var total = parseFloat(item.mrp)
																* parseFloat(item.qty);

														var Amount = "<td align=center id=billTotal3"+item.id+">"
																+ total
																+ "</td>";

														var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem3"+item.id+" onclick=updateTotal3("
														+ item.id + ","
														+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable3("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem3"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction3("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
														/* <a href='#' class='action_btn'> *//* </a> */
														allTotal = allTotal
																+ total;

														var trclosed = "</tr>";

														$('#table_grid3 tbody')
																.append(tr);
														$('#table_grid3 tbody')
																.append(index);
														$('#table_grid3 tbody')
																.append(barcode);
														$('#table_grid3 tbody')
																.append(
																		itemName);
														$('#table_grid3 tbody')
																.append(qty);
														$('#table_grid3 tbody')
																.append(rate);

														$('#table_grid3 tbody')
																.append(Amount);

														$('#table_grid3 tbody')
																.append(action);

														$('#table_grid3 tbody')
																.append(
																		trclosed);

													})


									$("#total3").html(allTotal);
									document.getElementById("tot3")
											.setAttribute('value', allTotal);

									document.getElementById("paidAmount3")
									.setAttribute('value', allTotal);
									
									var discount = $("#discount3").val();
									var grandAmt = allTotal - (allTotal * (discount / 100));
									var paidAmount = $("#paidAmount3").val();
									
									var grandMinusPaidAmt=grandAmt-paidAmount;
									$('#grandtotal3').html(grandAmt);
									document.getElementById("grandtot3").setAttribute('value',grandAmt);

									
									$('#remAmt3').html(grandMinusPaidAmt);
									document.getElementById("remAmount3").setAttribute('value',grandMinusPaidAmt);
									
									document.getElementById("barcode3").focus();
								});
			}
		}
	</script>
	<script type="text/javascript">
	function editDisable3(id,qty){
	//	alert(id+""+qty)
		
		$("#billQty3"+id).prop('disabled', false);
		
		$("#saveItem3"+id).show();
		document.getElementById("saveItem3"+id).style.visibility = "visible"; 
		
		document.getElementById("editItem3"+id).style.visibility= "hidden"; 
		$("#editItem3"+id).prop('disabled', true);
		
	}
	</script>
	
	<script type="text/javascript">
	function deleteFunction3(id,qty){
		 $.getJSON(
					'${deleteItem3}',
					{
						id : id,
						qty : qty,

						ajax : 'true'
					},
					function(data) {
						$('#loader').hide();
						if (data == "") {
							alert("No records found !!");
						}
						$('#table_grid3 td').remove();
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

											var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty3"+ item.id+ " name=billQty3"+item.id+" value = "+ item.qty+ " ></div></td>";

											var rate = "<td >"
													+ item.mrp
													+ "</td>";

											var total = parseFloat(item.mrp)
													* parseFloat(item.qty);

											var Amount = "<td align=center id=billTotal3"+item.id+">"
													+ total
													+ "</td>";

											var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem3"+item.id+" onclick=updateTotal3("
											+ item.id + ","
											+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable3("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem3"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction3("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";

											allTotal = allTotal
													+ total;

											var trclosed = "</tr>";

											$('#table_grid3 tbody')
													.append(tr);
											$('#table_grid3 tbody')
													.append(index);
											$('#table_grid3 tbody')
													.append(barcode);
											$('#table_grid3 tbody')
													.append(
															itemName);
											$('#table_grid3 tbody')
													.append(qty);
											$('#table_grid3 tbody')
													.append(rate);

											$('#table_grid3 tbody')
													.append(Amount);

											$('#table_grid3 tbody')
													.append(action);

											$('#table_grid3 tbody')
													.append(
															trclosed);
											

										})

						$("#total3").html(allTotal);
						document.getElementById("tot3")
								.setAttribute('value', allTotal);

						document.getElementById("paidAmount3")
						.setAttribute('value', allTotal);
						
						var discount = $("#discount3").val();
						var grandAmt = allTotal - (allTotal * (discount / 100));
						var paidAmount = $("#paidAmount3").val();
						
						var grandMinusPaidAmt=grandAmt-paidAmount;
						$('#grandtotal3').html(grandAmt);
						document.getElementById("grandtot3").setAttribute('value',grandAmt);

						
						$('#remAmt3').html(grandMinusPaidAmt);
						document.getElementById("remAmount3").setAttribute('value',grandMinusPaidAmt);
						
						document.getElementById("barcode3").focus();
					});
}</script>

<script type="text/javascript">
		function updateTotal3(id,mrp) {
			
		//	alert(id);
		//	alert(mrp);
			var newQty = $("#billQty3" + id).val();
		//	alert(newQty)
			
			
				
			 $.getJSON(
						'${updateItem3}',
						{
							id : id,
							qty : newQty,

							ajax : 'true'
						},
						function(data) {
							$('#loader').hide();
							if (data == "") {
								alert("No records found !!");
							}
							$('#table_grid3 td').remove();
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

												var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control  disabled id= billQty3"+ item.id+ " name=billQty3"+item.id+" value = "+ item.qty+ " ></div></td>";

												var rate = "<td >"
														+ item.mrp
														+ "</td>";

												var total = parseFloat(item.mrp)
														* parseFloat(item.qty);

												var Amount = "<td align=center id=billTotal3"+item.id+">"
														+ total
														+ "</td>";

												var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem3"+item.id+" onclick=updateTotal3("
												+ item.id + ","
												+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable3("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem3"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction3("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
												/* <a href='#' class='action_btn'> *//* </a> */
												allTotal = allTotal
														+ total;

												var trclosed = "</tr>";

												$('#table_grid3 tbody')
														.append(tr);
												$('#table_grid3 tbody')
														.append(index);
												$('#table_grid3 tbody')
														.append(barcode);
												$('#table_grid3 tbody')
														.append(
																itemName);
												$('#table_grid3 tbody')
														.append(qty);
												$('#table_grid3 tbody')
														.append(rate);

												$('#table_grid3 tbody')
														.append(Amount);

												$('#table_grid3 tbody')
														.append(action);

												$('#table_grid3 tbody')
														.append(
																trclosed);

											})

							$("#total3").html(allTotal);
							document.getElementById("tot3")
									.setAttribute('value', allTotal);

							document.getElementById("paidAmount3")
							.setAttribute('value', allTotal);
							
							var discount = $("#discount3").val();
							var grandAmt = allTotal - (allTotal * (discount / 100));
							var paidAmount = $("#paidAmount3").val();
							
							var grandMinusPaidAmt=grandAmt-paidAmount;
							$('#grandtotal3').html(grandAmt);
							document.getElementById("grandtot3").setAttribute('value',grandAmt);

							
							$('#remAmt3').html(grandMinusPaidAmt);
							document.getElementById("remAmount3").setAttribute('value',grandMinusPaidAmt);
							
							document.getElementById("barcode3").focus();
						});
		}
	</script>
	
	<script type="text/javascript">
		function addNewRow4() {

			var isValid = validation4();
			if (isValid) {

				var id = $("#itemName4").val();
				var barcode = $("#barcode4").val();
				//alert(barcode);
				var qty = $("#qty4").val();
				//alert(qty);
				var custName = $("#custName4").val();
				//alert(custName);
				var phoneNo = $("#phoneNo4").val();
				//alert(phoneNo);
				var gstNo = $("#gstNo4").val();
				//alert(gstNo);

				$('#loader').show();
				$
						.getJSON(
								'${getAllAddedItems4}',
								{
									id : id,
									qty : qty,

									ajax : 'true'
								},
								function(data) {
									$('#loader').hide();
									if (data == "") {
										alert("No records found !!");
									}
									$('#table_grid4 td').remove();
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

														var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty4"+ item.id+ " name=billQty4"+item.id+" value = "+ item.qty+ " ></div></td>";
/*onkeyup= updateTotal("
															+ bill.id + ","
															+ bill.mrp + ") onchange= updateTotal("+ bill.id+ ","+ bill.mrp+ ")*/
														var rate = "<td >"
																+ item.mrp
																+ "</td>";

														var total = parseFloat(item.mrp)
																* parseFloat(item.qty);

														var Amount = "<td align=center id=billTotal4"+item.id+">"
																+ total
																+ "</td>";

														var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem4"+item.id+" onclick=updateTotal4("
														+ item.id + ","
														+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable4("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem4"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction4("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
														/* <a href='#' class='action_btn'> *//* </a> */
														allTotal = allTotal
																+ total;

														var trclosed = "</tr>";

														$('#table_grid4 tbody')
																.append(tr);
														$('#table_grid4 tbody')
																.append(index);
														$('#table_grid4 tbody')
																.append(barcode);
														$('#table_grid4 tbody')
																.append(
																		itemName);
														$('#table_grid4 tbody')
																.append(qty);
														$('#table_grid4 tbody')
																.append(rate);

														$('#table_grid4 tbody')
																.append(Amount);

														$('#table_grid4 tbody')
																.append(action);

														$('#table_grid4 tbody')
																.append(
																		trclosed);

													})


									$("#total4").html(allTotal);
									document.getElementById("tot4")
											.setAttribute('value', allTotal);

									
									
									var discount = $("#discount4").val();
									var grandAmt = allTotal - (allTotal * (discount / 100));
									
									document.getElementById("paidAmount4")
									.setAttribute('value', grandAmt);
									
									var paidAmount = $("#paidAmount4").val();
									
									var grandMinusPaidAmt=grandAmt-paidAmount;
									$('#grandtotal4').html(grandAmt);
									document.getElementById("grandtot4").setAttribute('value',grandAmt);

									
									$('#remAmt4').html(grandMinusPaidAmt);
									document.getElementById("remAmount4").setAttribute('value',grandMinusPaidAmt);
									
									document.getElementById("barcode4").focus();
								});
			}
		}
	</script>
	<script type="text/javascript">
	function editDisable4(id,qty){
	//	alert(id+""+qty)
		
		$("#billQty4"+id).prop('disabled', false);
		
		$("#saveItem4"+id).show();
		document.getElementById("saveItem4"+id).style.visibility = "visible"; 
		
		document.getElementById("editItem4"+id).style.visibility= "hidden"; 
		$("#editItem4"+id).prop('disabled', true);
		
	}
	</script>
	<script type="text/javascript">
	function deleteFunction4(id,qty){
		 $.getJSON(
					'${deleteItem4}',
					{
						id : id,
						qty : qty,

						ajax : 'true'
					},
					function(data) {
						$('#loader').hide();
						if (data == "") {
							alert("No records found !!");
						}
						$('#table_grid4 td').remove();
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

											var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty4"+ item.id+ " name=billQty4"+item.id+" value = "+ item.qty+ " ></div></td>";

											var rate = "<td >"
													+ item.mrp
													+ "</td>";

											var total = parseFloat(item.mrp)
													* parseFloat(item.qty);

											var Amount = "<td align=center id=billTotal4"+item.id+">"
													+ total
													+ "</td>";

											var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem4"+item.id+" onclick=updateTotal4("
											+ item.id + ","
											+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable4("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem4"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction4("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";

											allTotal = allTotal
													+ total;

											var trclosed = "</tr>";

											$('#table_grid4 tbody')
													.append(tr);
											$('#table_grid4 tbody')
													.append(index);
											$('#table_grid4 tbody')
													.append(barcode);
											$('#table_grid4 tbody')
													.append(
															itemName);
											$('#table_grid4 tbody')
													.append(qty);
											$('#table_grid4 tbody')
													.append(rate);

											$('#table_grid4 tbody')
													.append(Amount);

											$('#table_grid4 tbody')
													.append(action);

											$('#table_grid4 tbody')
													.append(
															trclosed);
											

										})

						$("#total4").html(allTotal);
						document.getElementById("tot4")
								.setAttribute('value', allTotal);

						
						
						var discount = $("#discount4").val();
						var grandAmt = allTotal - (allTotal * (discount / 100));
						
						document.getElementById("paidAmount4")
						.setAttribute('value', grandAmt);
						
						var paidAmount = $("#paidAmount4").val();
						
						var grandMinusPaidAmt=grandAmt-paidAmount;
						$('#grandtotal4').html(grandAmt);
						document.getElementById("grandtot4").setAttribute('value',grandAmt);

						
						$('#remAmt4').html(grandMinusPaidAmt);
						document.getElementById("remAmount4").setAttribute('value',grandMinusPaidAmt);
						
						document.getElementById("barcode4").focus();
					});
}</script>
	<script type="text/javascript">
		function updateTotal4(id,mrp) {
			
		//	alert(id);
		//	alert(mrp);
			var newQty = $("#billQty4" + id).val();
		//	alert(newQty)
			
			
				
			 $.getJSON(
						'${updateItem4}',
						{
							id : id,
							qty : newQty,

							ajax : 'true'
						},
						function(data) {
							$('#loader').hide();
							if (data == "") {
								alert("No records found !!");
							}
							$('#table_grid4 td').remove();
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

												var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control  disabled id= billQty4"+ item.id+ " name=billQty4"+item.id+" value = "+ item.qty+ " ></div></td>";

												var rate = "<td >"
														+ item.mrp
														+ "</td>";

												var total = parseFloat(item.mrp)
														* parseFloat(item.qty);

												var Amount = "<td align=center id=billTotal4"+item.id+">"
														+ total
														+ "</td>";

												var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem4"+item.id+" onclick=updateTotal4("
												+ item.id + ","
												+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable4("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem4"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction4("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
												/* <a href='#' class='action_btn'> *//* </a> */
												allTotal = allTotal
														+ total;

												var trclosed = "</tr>";

												$('#table_grid4 tbody')
														.append(tr);
												$('#table_grid4 tbody')
														.append(index);
												$('#table_grid4 tbody')
														.append(barcode);
												$('#table_grid4 tbody')
														.append(
																itemName);
												$('#table_grid4 tbody')
														.append(qty);
												$('#table_grid4 tbody')
														.append(rate);

												$('#table_grid4 tbody')
														.append(Amount);

												$('#table_grid4 tbody')
														.append(action);

												$('#table_grid4 tbody')
														.append(
																trclosed);

											})

							$("#total4").html(allTotal);
							document.getElementById("tot4")
									.setAttribute('value', allTotal);

						
							
							var discount = $("#discount4").val();
							var grandAmt = allTotal - (allTotal * (discount / 100));
							
							document.getElementById("paidAmount4")
							.setAttribute('value', grandAmt);
							
							var paidAmount = $("#paidAmount4").val();
							
							var grandMinusPaidAmt=grandAmt-paidAmount;
							$('#grandtotal4').html(grandAmt);
							document.getElementById("grandtot4").setAttribute('value',grandAmt);

							
							$('#remAmt4').html(grandMinusPaidAmt);
							document.getElementById("remAmount4").setAttribute('value',grandMinusPaidAmt);
							
							document.getElementById("barcode4").focus();
						});
		}
	</script>
	
	<script type="text/javascript">
		function addNewRow5() {

			var isValid = validation5();
			if (isValid) {

				var id = $("#itemName5").val();
				var barcode = $("#barcode5").val();
			//	alert(barcode);
				var qty = $("#qty5").val();
			//	alert(qty);
				var custName = $("#custName5").val();
			//	alert(custName);
				var phoneNo = $("#phoneNo5").val();
			//	alert(phoneNo);
				var gstNo = $("#gstNo5").val();
			//	alert(gstNo);

				$('#loader').show();
				$
						.getJSON(
								'${getAllAddedItems5}',
								{
									id : id,
									qty : qty,

									ajax : 'true'
								},
								function(data) {
									$('#loader').hide();
									if (data == "") {
										alert("No records found !!");
									}
									$('#table_grid5 td').remove();
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

														var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty5"+ item.id+ " name=billQty5"+item.id+" value = "+ item.qty+ " ></div></td>";
/*onkeyup= updateTotal("
															+ bill.id + ","
															+ bill.mrp + ") onchange= updateTotal("+ bill.id+ ","+ bill.mrp+ ")*/
														var rate = "<td >"
																+ item.mrp
																+ "</td>";

														var total = parseFloat(item.mrp)
																* parseFloat(item.qty);

														var Amount = "<td align=center id=billTotal5"+item.id+">"
																+ total
																+ "</td>";

														var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem5"+item.id+" onclick=updateTotal5("
														+ item.id + ","
														+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable5("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem5"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction5("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
														/* <a href='#' class='action_btn'> *//* </a> */
														allTotal = allTotal
																+ total;

														var trclosed = "</tr>";

														$('#table_grid5 tbody')
																.append(tr);
														$('#table_grid5 tbody')
																.append(index);
														$('#table_grid5 tbody')
																.append(barcode);
														$('#table_grid5 tbody')
																.append(
																		itemName);
														$('#table_grid5 tbody')
																.append(qty);
														$('#table_grid5 tbody')
																.append(rate);

														$('#table_grid5 tbody')
																.append(Amount);

														$('#table_grid5 tbody')
																.append(action);

														$('#table_grid5 tbody')
																.append(
																		trclosed);

													})


									$("#total5").html(allTotal);
									document.getElementById("tot5")
											.setAttribute('value', allTotal);

									
									
									var discount = $("#discount5").val();
									var grandAmt = allTotal - (allTotal * (discount / 100));
									
									document.getElementById("paidAmount5")
									.setAttribute('value', grandAmt);
									
									var paidAmount = $("#paidAmount5").val();
									
									var grandMinusPaidAmt=grandAmt-paidAmount;
									$('#grandtotal5').html(grandAmt);
									document.getElementById("grandtot5").setAttribute('value',grandAmt);

									
									$('#remAmt5').html(grandMinusPaidAmt);
									document.getElementById("remAmount5").setAttribute('value',grandMinusPaidAmt);
									
									document.getElementById("barcode5").focus();
								});
			}
		}
	</script>
	<script type="text/javascript">
	function editDisable5(id,qty){
	//	alert(id+""+qty)
		
		$("#billQty5"+id).prop('disabled', false);
		
		$("#saveItem5"+id).show();
		document.getElementById("saveItem5"+id).style.visibility = "visible"; 
		
		document.getElementById("editItem5"+id).style.visibility= "hidden"; 
		$("#editItem5"+id).prop('disabled', true);
		
	}
	</script>
	<script type="text/javascript">
	function deleteFunction5(id,qty){
		 $.getJSON(
					'${deleteItem5}',
					{
						id : id,
						qty : qty,

						ajax : 'true'
					},
					function(data) {
						$('#loader').hide();
						if (data == "") {
							alert("No records found !!");
						}
						$('#table_grid5 td').remove();
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

											var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty5"+ item.id+ " name=billQty5"+item.id+" value = "+ item.qty+ " ></div></td>";

											var rate = "<td >"
													+ item.mrp
													+ "</td>";

											var total = parseFloat(item.mrp)
													* parseFloat(item.qty);

											var Amount = "<td align=center id=billTotal5"+item.id+">"
													+ total
													+ "</td>";

											var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem5"+item.id+" onclick=updateTotal5("
											+ item.id + ","
											+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable5("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem5"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction5("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";

											allTotal = allTotal
													+ total;

											var trclosed = "</tr>";

											$('#table_grid5 tbody')
													.append(tr);
											$('#table_grid5 tbody')
													.append(index);
											$('#table_grid5 tbody')
													.append(barcode);
											$('#table_grid5 tbody')
													.append(
															itemName);
											$('#table_grid5 tbody')
													.append(qty);
											$('#table_grid5 tbody')
													.append(rate);

											$('#table_grid5 tbody')
													.append(Amount);

											$('#table_grid5 tbody')
													.append(action);

											$('#table_grid5 tbody')
													.append(
															trclosed);
											

										})

						$("#total5").html(allTotal);
						document.getElementById("tot5")
								.setAttribute('value', allTotal);

						
						var discount = $("#discount5").val();
						var grandAmt = allTotal - (allTotal * (discount / 100));
						
						document.getElementById("paidAmount5")
						.setAttribute('value', grandAmt);
						
						var paidAmount = $("#paidAmount5").val();
						
						var grandMinusPaidAmt=grandAmt-paidAmount;
						$('#grandtotal5').html(grandAmt);
						document.getElementById("grandtot5").setAttribute('value',grandAmt);

						
						$('#remAmt5').html(grandMinusPaidAmt);
						document.getElementById("remAmount5").setAttribute('value',grandMinusPaidAmt);
						
						document.getElementById("barcode5").focus();
					});
}</script>
	<script type="text/javascript">
		function updateTotal5(id,mrp) {
			
		//	alert(id);
		//	alert(mrp);
			var newQty = $("#billQty5" + id).val();
		//	alert(newQty)
			
			
				
			 $.getJSON(
						'${updateItem5}',
						{
							id : id,
							qty : newQty,

							ajax : 'true'
						},
						function(data) {
							$('#loader').hide();
							if (data == "") {
								alert("No records found !!");
							}
							$('#table_grid5 td').remove();
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

												var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control  disabled id= billQty5"+ item.id+ " name=billQty5"+item.id+" value = "+ item.qty+ " ></div></td>";

												var rate = "<td >"
														+ item.mrp
														+ "</td>";

												var total = parseFloat(item.mrp)
														* parseFloat(item.qty);

												var Amount = "<td align=center id=billTotal5"+item.id+">"
														+ total
														+ "</td>";

												var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem5"+item.id+" onclick=updateTotal5("
												+ item.id + ","
												+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable5("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem5"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction5("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
												/* <a href='#' class='action_btn'> *//* </a> */
												allTotal = allTotal
														+ total;

												var trclosed = "</tr>";

												$('#table_grid5 tbody')
														.append(tr);
												$('#table_grid5 tbody')
														.append(index);
												$('#table_grid5 tbody')
														.append(barcode);
												$('#table_grid5 tbody')
														.append(
																itemName);
												$('#table_grid5 tbody')
														.append(qty);
												$('#table_grid5 tbody')
														.append(rate);

												$('#table_grid5 tbody')
														.append(Amount);

												$('#table_grid5 tbody')
														.append(action);

												$('#table_grid5 tbody')
														.append(
																trclosed);

											})

							$("#total5").html(allTotal);
							document.getElementById("tot5")
									.setAttribute('value', allTotal);

							
							document.getElementById("paidAmount5")
							.setAttribute('value', allTotal);
							
							var discount = $("#discount5").val();
							var grandAmt = allTotal - (allTotal * (discount / 100));
							
							document.getElementById("paidAmount5")
							.setAttribute('value', grandAmt);
							
							var paidAmount = $("#paidAmount5").val();
							
							var grandMinusPaidAmt=grandAmt-paidAmount;
							$('#grandtotal5').html(grandAmt);
							document.getElementById("grandtot5").setAttribute('value',grandAmt);

							
							$('#remAmt5').html(grandMinusPaidAmt);
							document.getElementById("remAmount5").setAttribute('value',grandMinusPaidAmt);
							
							document.getElementById("barcode5").focus();
						});
		}
	</script>
	<script type="text/javascript">
		function addNewRow6() {

			var isValid = validation6();
			if (isValid) {

				var id = $("#itemName6").val();
				var barcode = $("#barcode6").val();
			//	alert(barcode);
				var qty = $("#qty6").val();
			//	alert(qty);
				var custName = $("#custName6").val();
			//	alert(custName);
				var phoneNo = $("#phoneNo6").val();
			//	alert(phoneNo);
				var gstNo = $("#gstNo6").val();
			//	alert(gstNo);

				$('#loader').show();
				$
						.getJSON(
								'${getAllAddedItems6}',
								{
									id : id,
									qty : qty,

									ajax : 'true'
								},
								function(data) {
									$('#loader').hide();
									if (data == "") {
										alert("No records found !!");
									}
									$('#table_grid6 td').remove();
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

														var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty6"+ item.id+ " name=billQty6"+item.id+" value = "+ item.qty+ " ></div></td>";
/*onkeyup= updateTotal("
															+ bill.id + ","
															+ bill.mrp + ") onchange= updateTotal("+ bill.id+ ","+ bill.mrp+ ")*/
														var rate = "<td >"
																+ item.mrp
																+ "</td>";

														var total = parseFloat(item.mrp)
																* parseFloat(item.qty);

														var Amount = "<td align=center id=billTotal6"+item.id+">"
																+ total
																+ "</td>";

														var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem6"+item.id+" onclick=updateTotal6("
														+ item.id + ","
														+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable6("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem6"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction6("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
														/* <a href='#' class='action_btn'> *//* </a> */
														allTotal = allTotal
																+ total;

														var trclosed = "</tr>";

														$('#table_grid6 tbody')
																.append(tr);
														$('#table_grid6 tbody')
																.append(index);
														$('#table_grid6 tbody')
																.append(barcode);
														$('#table_grid6 tbody')
																.append(
																		itemName);
														$('#table_grid6 tbody')
																.append(qty);
														$('#table_grid6 tbody')
																.append(rate);

														$('#table_grid6 tbody')
																.append(Amount);

														$('#table_grid6 tbody')
																.append(action);

														$('#table_grid6 tbody')
																.append(
																		trclosed);

													})


									$("#total6").html(allTotal);
									document.getElementById("tot6")
											.setAttribute('value', allTotal);

								
									
									var discount = $("#discount6").val();
									var grandAmt = allTotal - (allTotal * (discount / 100));
									
									document.getElementById("paidAmount6")
									.setAttribute('value', grandAmt);
									
									var paidAmount = $("#paidAmount6").val();
									
									var grandMinusPaidAmt=grandAmt-paidAmount;
									$('#grandtotal6').html(grandAmt);
									document.getElementById("grandtot6").setAttribute('value',grandAmt);

									
									$('#remAmt6').html(grandMinusPaidAmt);
									document.getElementById("remAmount6").setAttribute('value',grandMinusPaidAmt);
									
									document.getElementById("barcode6").focus();
								});

			}
		}
	</script>
	<script type="text/javascript">
	function editDisable6(id,qty){
		//alert(id+""+qty)
		
		$("#billQty6"+id).prop('disabled', false);
		
		$("#saveItem6"+id).show();
		document.getElementById("saveItem6"+id).style.visibility = "visible"; 
		
		document.getElementById("editItem6"+id).style.visibility= "hidden"; 
		$("#editItem6"+id).prop('disabled', true);
		
	}
	</script>
	<script type="text/javascript">
	function deleteFunction6(id,qty){
		 $.getJSON(
					'${deleteItem6}',
					{
						id : id,
						qty : qty,

						ajax : 'true'
					},
					function(data) {
						$('#loader').hide();
						if (data == "") {
							alert("No records found !!");
						}
						$('#table_grid6 td').remove();
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

											var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty6"+ item.id+ " name=billQty6"+item.id+" value = "+ item.qty+ " ></div></td>";

											var rate = "<td >"
													+ item.mrp
													+ "</td>";

											var total = parseFloat(item.mrp)
													* parseFloat(item.qty);

											var Amount = "<td align=center id=billTotal1"+item.id+">"
													+ total
													+ "</td>";

											var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem6"+item.id+" onclick=updateTotal6("
											+ item.id + ","
											+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable6("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem6"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction6("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";

											allTotal = allTotal
													+ total;

											var trclosed = "</tr>";

											$('#table_grid6 tbody')
													.append(tr);
											$('#table_grid6 tbody')
													.append(index);
											$('#table_grid6 tbody')
													.append(barcode);
											$('#table_grid6 tbody')
													.append(
															itemName);
											$('#table_grid6 tbody')
													.append(qty);
											$('#table_grid6 tbody')
													.append(rate);

											$('#table_grid6 tbody')
													.append(Amount);

											$('#table_grid6 tbody')
													.append(action);

											$('#table_grid6 tbody')
													.append(
															trclosed);
											

										})

						$("#total6").html(allTotal);
						document.getElementById("tot6")
								.setAttribute('value', allTotal);

						
						var discount = $("#discount6").val();
						var grandAmt = allTotal - (allTotal * (discount / 100));
						
						document.getElementById("paidAmount6")
						.setAttribute('value', grandAmt);
						
						
						var paidAmount = $("#paidAmount6").val();
						
						var grandMinusPaidAmt=grandAmt-paidAmount;
						$('#grandtotal6').html(grandAmt);
						document.getElementById("grandtot6").setAttribute('value',grandAmt);

						
						$('#remAmt6').html(grandMinusPaidAmt);
						document.getElementById("remAmount6").setAttribute('value',grandMinusPaidAmt);
						
						document.getElementById("barcode6").focus();
					});
}</script>
	<script type="text/javascript">
		function updateTotal6(id,mrp) {
			
			//alert(id);
			//alert(mrp);
			var newQty = $("#billQty6" + id).val();
			//alert(newQty)
			
			
				
			 $.getJSON(
						'${updateItem6}',
						{
							id : id,
							qty : newQty,

							ajax : 'true'
						},
						function(data) {
							$('#loader').hide();
							if (data == "") {
								alert("No records found !!");
							}
							$('#table_grid6 td').remove();
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

												var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control  disabled id= billQty6"+ item.id+ " name=billQty6"+item.id+" value = "+ item.qty+ " ></div></td>";

												var rate = "<td >"
														+ item.mrp
														+ "</td>";

												var total = parseFloat(item.mrp)
														* parseFloat(item.qty);

												var Amount = "<td align=center id=billTotal6"+item.id+">"
														+ total
														+ "</td>";

												var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem6"+item.id+" onclick=updateTotal6("
												+ item.id + ","
												+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable6("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem6"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction6("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
												/* <a href='#' class='action_btn'> *//* </a> */
												allTotal = allTotal
														+ total;

												var trclosed = "</tr>";

												$('#table_grid6 tbody')
														.append(tr);
												$('#table_grid6 tbody')
														.append(index);
												$('#table_grid6 tbody')
														.append(barcode);
												$('#table_grid6 tbody')
														.append(
																itemName);
												$('#table_grid6 tbody')
														.append(qty);
												$('#table_grid6 tbody')
														.append(rate);

												$('#table_grid6 tbody')
														.append(Amount);

												$('#table_grid6 tbody')
														.append(action);

												$('#table_grid6 tbody')
														.append(
																trclosed);

											})

							$("#total6").html(allTotal);
							document.getElementById("tot6")
									.setAttribute('value', allTotal);

							
							var discount = $("#discount6").val();
							var grandAmt = allTotal - (allTotal * (discount / 100));
							
							document.getElementById("paidAmount6")
							.setAttribute('value', grandAmt);
							
							var paidAmount = $("#paidAmount6").val();
							
							var grandMinusPaidAmt=grandAmt-paidAmount;
							$('#grandtotal6').html(grandAmt);
							document.getElementById("grandtot6").setAttribute('value',grandAmt);

							
							$('#remAmt6').html(grandMinusPaidAmt);
							document.getElementById("remAmount6").setAttribute('value',grandMinusPaidAmt);
							
							document.getElementById("barcode6").focus();
						});
		}
	</script>
	<script type="text/javascript">
		function addNewRow7() {

			var isValid = validation7();
			if (isValid) {

				var id = $("#itemName7").val();
				var barcode = $("#barcode7").val();
				//alert(barcode);
				var qty = $("#qty7").val();
				//alert(qty);
				var custName = $("#custName7").val();
				//alert(custName);
				var phoneNo = $("#phoneNo7").val();
				//alert(phoneNo);
				var gstNo = $("#gstNo7").val();
				//alert(gstNo);

				$('#loader').show();
				$
						.getJSON(
								'${getAllAddedItems7}',
								{
									id : id,
									qty : qty,

									ajax : 'true'
								},
								function(data) {
									$('#loader').hide();
									if (data == "") {
										alert("No records found !!");
									}
									$('#table_grid7 td').remove();
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

														var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty7"+ item.id+ " name=billQty7"+item.id+" value = "+ item.qty+ " ></div></td>";
/*onkeyup= updateTotal("
															+ bill.id + ","
															+ bill.mrp + ") onchange= updateTotal("+ bill.id+ ","+ bill.mrp+ ")*/
														var rate = "<td >"
																+ item.mrp
																+ "</td>";

														var total = parseFloat(item.mrp)
																* parseFloat(item.qty);

														var Amount = "<td align=center id=billTotal7"+item.id+">"
																+ total
																+ "</td>";

														var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem7"+item.id+" onclick=updateTotal7("
														+ item.id + ","
														+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable7("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem1"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction7("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
														/* <a href='#' class='action_btn'> *//* </a> */
														allTotal = allTotal
																+ total;

														var trclosed = "</tr>";

														$('#table_grid7 tbody')
																.append(tr);
														$('#table_grid7 tbody')
																.append(index);
														$('#table_grid7 tbody')
																.append(barcode);
														$('#table_grid7 tbody')
																.append(
																		itemName);
														$('#table_grid7 tbody')
																.append(qty);
														$('#table_grid7 tbody')
																.append(rate);

														$('#table_grid7 tbody')
																.append(Amount);

														$('#table_grid7 tbody')
																.append(action);

														$('#table_grid7 tbody')
																.append(
																		trclosed);

													})


									$("#total7").html(allTotal);
									document.getElementById("tot7")
											.setAttribute('value', allTotal);
								
									var discount = $("#discount7").val();
									var grandAmt = allTotal - (allTotal * (discount / 100));
									
									document.getElementById("paidAmount7")
									.setAttribute('value', grandAmt);
									
									var paidAmount = $("#paidAmount7").val();
									
									var grandMinusPaidAmt=grandAmt-paidAmount;
									$('#grandtotal7').html(grandAmt);
									document.getElementById("grandtot7").setAttribute('value',grandAmt);

									
									$('#remAmt7').html(grandMinusPaidAmt);
									document.getElementById("remAmount7").setAttribute('value',grandMinusPaidAmt);
									
									document.getElementById("barcode7").focus();
								});
			}
		}
		
	</script>
	
	<script type="text/javascript">
	function editDisable7(id,qty){
		//alert(id+""+qty)
		
		$("#billQty7"+id).prop('disabled', false);
		
		$("#saveItem7"+id).show();
		document.getElementById("saveItem7"+id).style.visibility = "visible"; 
		
		document.getElementById("editItem7"+id).style.visibility= "hidden"; 
		$("#editItem7"+id).prop('disabled', true);
		
	}
	</script>
	
<script type="text/javascript">
	function deleteFunction7(id,qty){
		 $.getJSON(
					'${deleteItem7}',
					{
						id : id,
						qty : qty,

						ajax : 'true'
					},
					function(data) {
						$('#loader').hide();
						if (data == "") {
							alert("No records found !!");
						}
						$('#table_grid7 td').remove();
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

											var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control    disabled id= billQty7"+ item.id+ " name=billQty7"+item.id+" value = "+ item.qty+ " ></div></td>";

											var rate = "<td >"
													+ item.mrp
													+ "</td>";

											var total = parseFloat(item.mrp)
													* parseFloat(item.qty);

											var Amount = "<td align=center id=billTotal7"+item.id+">"
													+ total
													+ "</td>";

											var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem7"+item.id+" onclick=updateTotal7("
											+ item.id + ","
											+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable7("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem7"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction7("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";

											allTotal = allTotal
													+ total;

											var trclosed = "</tr>";

											$('#table_grid7 tbody')
													.append(tr);
											$('#table_grid7 tbody')
													.append(index);
											$('#table_grid7 tbody')
													.append(barcode);
											$('#table_grid7 tbody')
													.append(
															itemName);
											$('#table_grid7 tbody')
													.append(qty);
											$('#table_grid7 tbody')
													.append(rate);

											$('#table_grid7 tbody')
													.append(Amount);

											$('#table_grid7 tbody')
													.append(action);

											$('#table_grid7 tbody')
													.append(
															trclosed);
											

										})

						$("#total7").html(allTotal);
						document.getElementById("tot7")
								.setAttribute('value', allTotal);

						
						var discount = $("#discount7").val();
						var grandAmt = allTotal - (allTotal * (discount / 100));
						
						document.getElementById("paidAmount7")
						.setAttribute('value', grandAmt);
						
						
						var paidAmount = $("#paidAmount7").val();
						
						var grandMinusPaidAmt=grandAmt-paidAmount;
						$('#grandtotal7').html(grandAmt);
						document.getElementById("grandtot7").setAttribute('value',grandAmt);

						
						$('#remAmt7').html(grandMinusPaidAmt);
						document.getElementById("remAmount7").setAttribute('value',grandMinusPaidAmt);
						
						document.getElementById("barcode7").focus();
					});
}</script>
	<script type="text/javascript">
		function updateTotal7(id,mrp) {
			
		////	alert(id);
	//	alert(mrp);
			var newQty = $("#billQty7" + id).val();
		//	alert(newQty)
			
			
				
			 $.getJSON(
						'${updateItem7}',
						{
							id : id,
							qty : newQty,

							ajax : 'true'
						},
						function(data) {
							$('#loader').hide();
							if (data == "") {
								alert("No records found !!");
							}
							$('#table_grid7 td').remove();
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

												var qty =  "<td><div class=class=col-md-1 pull-left><input type=number min=0 max=30 class=form-control  disabled id= billQty7"+ item.id+ " name=billQty7"+item.id+" value = "+ item.qty+ " ></div></td>";

												var rate = "<td >"
														+ item.mrp
														+ "</td>";

												var total = parseFloat(item.mrp)
														* parseFloat(item.qty);

												var Amount = "<td align=center id=billTotal7"+item.id+">"
														+ total
														+ "</td>";

												var action = "<td><abbr title='edit'><i class='fa fa-check-circle' style='visibility: hidden;' id=saveItem7"+item.id+" onclick=updateTotal7("
												+ item.id + ","
												+ item.mrp + ")>  </i>  <i class='fa fa-edit'onclick=editDisable7("+item.id+","+ item.qty+ ","+ item.mrp+ ");   id=editItem7"+item.id+"></i></abbr> <a href='#' class='action_btn'onclick=deleteFunction7("+item.id+ ","+ item.qty+ ")><abbr title='Delete'><i class='fa fa-trash'></i></abbr></a></td>";
												/* <a href='#' class='action_btn'> *//* </a> */
												allTotal = allTotal
														+ total;

												var trclosed = "</tr>";

												$('#table_grid7 tbody')
														.append(tr);
												$('#table_grid7 tbody')
														.append(index);
												$('#table_grid7 tbody')
														.append(barcode);
												$('#table_grid7 tbody')
														.append(
																itemName);
												$('#table_grid7 tbody')
														.append(qty);
												$('#table_grid7 tbody')
														.append(rate);

												$('#table_grid7 tbody')
														.append(Amount);

												$('#table_grid7 tbody')
														.append(action);

												$('#table_grid7 tbody')
														.append(
																trclosed);

											})

							$("#total7").html(allTotal);
							document.getElementById("tot7")
									.setAttribute('value', allTotal);

							
							var discount = $("#discount7").val();
							var grandAmt = allTotal - (allTotal * (discount / 100));
							
							document.getElementById("paidAmount7")
							.setAttribute('value', grandAmt);
							
							var paidAmount = $("#paidAmount7").val();
							
							var grandMinusPaidAmt=grandAmt-paidAmount;
							$('#grandtotal7').html(grandAmt);
							document.getElementById("grandtot7").setAttribute('value',grandAmt);

							
							$('#remAmt7').html(grandMinusPaidAmt);
							document.getElementById("remAmount7").setAttribute('value',grandMinusPaidAmt);
							
							document.getElementById("barcode7").focus();
						});
		}
	</script>
	<script type="text/javascript">
		function validation1() {
			var custName1 = $("#custName1").val();
			var phoneNo1 = $("#phoneNo1").val();
			var itemName1 = $("#itemName1").val();
			var isValid = true;
			if (custName1 == "" || custName1 == null) {
				isValid = false;
				alert("Please Enter Customer Name");
			} else if (phoneNo1 != "" && phoneNo1.length!=10) {
				isValid = false;
				alert("Please Enter Valid Phone No");
			} else if (itemName1 == "" || itemName1 == null) {
				isValid = false;
				alert("Please Enter Select Item");
			}
			return isValid;
		}
	</script>
	<script type="text/javascript">
		function validation2() {
			var custName2 = $("#custName2").val();
			var phoneNo2 = $("#phoneNo2").val();
			var itemName2 = $("#itemName2").val();
			var isValid = true;
			if (custName2 == "" || custName1 == null) {
				isValid = false;
				alert("Please Enter Customer Name");
			} else if (phoneNo2!= "" && phoneNo2.length!=10) {
				isValid = false;
				alert("Please Enter Valid Phone No");
			} else if (itemName2 == "" || itemName2 == null) {
				isValid = false;
				alert("Please Enter Select Item");
			}
			return isValid;
		}
	</script>
	<script type="text/javascript">
		function validation3() {
			var custName3 = $("#custName3").val();
			var phoneNo3 = $("#phoneNo3").val();
			var itemName3 = $("#itemName3").val();
			var isValid = true;
			if (custName3 == "" || custName3 == null) {
				isValid = false;
				alert("Please Enter Customer Name");
			} else if (phoneNo3!= "" && phoneNo3.length!=10) {
				isValid = false;
				alert("Please Enter Valid Phone No");
			} else if (itemName3 == "" || itemName3 == null) {
				isValid = false;
				alert("Please Enter Select Item");
			}
			return isValid;
		}
	</script>
	<script type="text/javascript">
		function validation4() {
			var custName4 = $("#custName4").val();
			var phoneNo4 = $("#phoneNo4").val();
			var itemName4 = $("#itemName4").val();
			var isValid = true;
			if (custName4 == "" || custName4 == null) {
				isValid = false;
				alert("Please Enter Customer Name");
			} else if (phoneNo4 != "" &&  phoneNo4.length!=10) {
				isValid = false;
				alert("Please Enter Valid Phone No");
			} else if (itemName4 == "" || itemName4 == null) {
				isValid = false;
				alert("Please Enter Select Item");
			}
			return isValid;
		}
	</script>
	<script type="text/javascript">
		function validation5() {
			var custName5 = $("#custName5").val();
			var phoneNo5 = $("#phoneNo5").val();
			var itemName5 = $("#itemName5").val();
			var isValid = true;
			if (custName5 == "" || custName5 == null) {
				isValid = false;
				alert("Please Enter Customer Name");
			} else if (phoneNo5 != "" && phoneNo5.length!=10) {
				isValid = false;
				alert("Please Enter Valid Phone No");
			} else if (itemName5 == "" || itemName5 == null) {
				isValid = false;
				alert("Please Enter Select Item");
			}
			return isValid;
		}
	</script>
	<script type="text/javascript">
		function validation6() {
			var custName6 = $("#custName6").val();
			var phoneNo6 = $("#phoneNo6").val();
			var itemName6 = $("#itemName6").val();
			var isValid = true;
			if (custName6 == "" || custName6 == null) {
				isValid = false;
				alert("Please Enter Customer Name");
			} else if (phoneNo6 != "" && phoneNo6.length!=10) {
				isValid = false;
				alert("Please Enter Valid Phone No");
			} else if (itemName6 == "" || itemName6 == null) {
				isValid = false;
				alert("Please Enter Select Item");
			}
			return isValid;
		}
	</script>
	<script type="text/javascript">
		function validation7() {
			var custName7 = $("#custName7").val();
			var phoneNo7 = $("#phoneNo7").val();
			var itemName7 = $("#itemName7").val();
			var isValid = true;
			if (custName7 == "" || custName7 == null) {
				isValid = false;
				alert("Please Enter Customer Name");
			} else if (phoneNo7 != "" && phoneNo7.length!=10) {
				isValid = false;
				alert("Please Enter Valid Phone No");
			} else if (itemName7 == "" || itemName7 == null) {
				isValid = false;
				alert("Please Enter Select Item");
			}
			
		
			return isValid;
		}
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
	<script type="text/javascript">
		function removeOption() {
			var itemName1 = $("#itemName1").val();
			document.getElementById("itemName1").options.length = 0;

		}
	</script>
	<script type="text/javascript">
		function disMinusTotal1() {
			var discount = $("#discount1").val();

			var total = $("#tot1").val();

			var grandAmt = total - (total * (discount / 100));

			$('#grandtotal1').html(grandAmt);
			document.getElementById("grandtot1").setAttribute('value',grandAmt);
			
			
			document.getElementById("paidAmount1").setAttribute('value',grandAmt);
			
		}
	</script>
	<script type="text/javascript">
		function disMinusTotal2() {
			var discount = $("#discount2").val();

			var total = $("#tot2").val();

			var grandAmt = total - (total * (discount / 100));

			$('#grandtotal2').html(grandAmt);
			document.getElementById("grandtot2").setAttribute('value',grandAmt);

			
			document.getElementById("paidAmount2").setAttribute('value',grandAmt);
		}
	</script>
	<script type="text/javascript">
		function disMinusTotal3() {
			var discount = $("#discount3").val();

			var total = $("#tot3").val();

			var grandAmt = total - (total * (discount / 100));

			$('#grandtotal3').html(grandAmt);
			document.getElementById("grandtot3").setAttribute('value',grandAmt);

			document.getElementById("paidAmount3").setAttribute('value',grandAmt);

		}
	</script>
	<script type="text/javascript">
		function disMinusTotal4() {
			var discount = $("#discount4").val();

			var total = $("#tot4").val();

			var grandAmt = total - (total * (discount / 100));

			$('#grandtotal4').html(grandAmt);
			document.getElementById("grandtot4").setAttribute('value',grandAmt);
			
			document.getElementById("paidAmount4").setAttribute('value',grandAmt);

		}
	</script>
	<script type="text/javascript">
		function disMinusTotal5() {
			var discount = $("#discount5").val();

			var total = $("#tot5").val();

			var grandAmt = total - (total * (discount / 100));

			$('#grandtotal5').html(grandAmt);
			document.getElementById("grandtot5").setAttribute('value',grandAmt);

			document.getElementById("paidAmount5").setAttribute('value',grandAmt);
		}
	</script>
	<script type="text/javascript">
		function disMinusTotal6() {
			var discount = $("#discount6").val();

			var total = $("#tot6").val();

			var grandAmt = total - (total * (discount / 100));

			$('#grandtotal6').html(grandAmt);
			
			document.getElementById("grandtot6").setAttribute('value',grandAmt);
			
			document.getElementById("paidAmount6").setAttribute('value',grandAmt);
		}
	</script>
	<script type="text/javascript">
		function disMinusTotal7() {
			var discount = $("#discount7").val();

			var total = $("#tot7").val();

			var grandAmt = total - (total * (discount / 100));

			$('#grandtotal7').html(grandAmt);
			
			document.getElementById("grandtot7").setAttribute('value',grandAmt);
			
			document.getElementById("paidAmount7").setAttribute('value',grandAmt);
		}
	</script>
	<script type="text/javascript">
		function amtMinusGrandTotal1()
		{
			var paidAmount = $("#paidAmount1").val();
            
			
			var grandAmount = $("#grandtot1").val();
			//alert(paidAmount);
			//alert(grandAmount);
			
			var remainingAmount = (grandAmount - paidAmount);

			$('#remAmt1').html(remainingAmount);
			document.getElementById("remAmount1").setAttribute('value',remainingAmount);

		}
	</script>
	<script type="text/javascript">
		function amtMinusGrandTotal2()
		{
			var paidAmount = $("#paidAmount2").val();
            
			
			var grandAmount = $("#grandtot2").val();
			//alert(paidAmount);
			//alert(grandAmount);
			
			var remainingAmount = (grandAmount - paidAmount);

			$('#remAmt2').html(remainingAmount);
			document.getElementById("remAmount2").setAttribute('value',remainingAmount);

		}
	</script>
	<script type="text/javascript">
		function amtMinusGrandTotal3()
		{
			var paidAmount = $("#paidAmount3").val();
            
			
			var grandAmount = $("#grandtot3").val();
			//alert(paidAmount);
			//alert(grandAmount);
			
			var remainingAmount = (grandAmount - paidAmount);

			$('#remAmt3').html(remainingAmount);
			document.getElementById("remAmount3").setAttribute('value',remainingAmount);

		}
	</script>
	<script type="text/javascript">
		function amtMinusGrandTotal4()
		{
			var paidAmount = $("#paidAmount4").val();
            
			
			var grandAmount = $("#grandtot4").val();
			//alert(paidAmount);
			//alert(grandAmount);
			
			var remainingAmount = (grandAmount - paidAmount);

			$('#remAmt4').html(remainingAmount);
			document.getElementById("remAmount4").setAttribute('value',remainingAmount);

		}
	</script>
	<script type="text/javascript">
		function amtMinusGrandTotal5()
		{
			var paidAmount = $("#paidAmount5").val();
            
			
			var grandAmount = $("#grandtot5").val();
			//alert(paidAmount);
			//alert(grandAmount);
			
			var remainingAmount = (grandAmount - paidAmount);

			$('#remAmt5').html(remainingAmount);
			document.getElementById("remAmount5").setAttribute('value',remainingAmount);

		}
	</script>
	<script type="text/javascript">
		function amtMinusGrandTotal6()
		{
			var paidAmount = $("#paidAmount6").val();
            
			
			var grandAmount = $("#grandtot6").val();
			//alert(paidAmount);
			//alert(grandAmount);
			
			var remainingAmount = (grandAmount - paidAmount);

			$('#remAmt6').html(remainingAmount);
			document.getElementById("remAmount6").setAttribute('value',remainingAmount);

		}
	</script>
	<script type="text/javascript">
		function amtMinusGrandTotal7()
		{
			var paidAmount = $("#paidAmount7").val();
            
			
			var grandAmount = $("#grandtot7").val();
			//alert(paidAmount);
			//alert(grandAmount);
			
			var remainingAmount = (grandAmount - paidAmount);

			$('#remAmt7').html(remainingAmount);
			document.getElementById("remAmount7").setAttribute('value',remainingAmount);

		}
	</script>
</body>
</html>