<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- <jsp:include page="/WEB-INF/views/include/header.jsp"/> --%>

  


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
	
	<!-- For Toggle Button  Print on off -->
	<style>
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 25px;
  margin-top: 14px;
  
    
}

.switch input {display:none;}

.slider {
  position: absolute;
  cursor: pointer;
 top: -2px;
left: -6px;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 15px;
  width: 26px;
  left: 4px;
  bottom: 5px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>
</head>
<body>


	<c:url var="getItemDetails" value="/findItemDetails" />
	<c:url var="insertItemOrder" value="/insertItem" />
	<c:url var="insertHeader" value="/insertHeader" />
	<div class="sidebarOuter"></div>
	<c:url var="calcStock" value="/calcStock" />
	<c:url var="printExBill" value="/printExBill" />
	<c:url var="deleteItem" value="/deleteItem" />
	<c:url var="getSelectedIdForPrint" value="/getSelectedIdForPrint" />
	
		<c:url var="dayClose" value="/dayClose" />
	

	<div class="wrapper">

		
<jsp:include page="/WEB-INF/views/include/logo.jsp"></jsp:include>

		<!--rightContainer-->
		<div class="fullGrid">
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

					<div class="col-md-2">
						<h2 class="pageTitle">Express Bill</h2>

					</div>
					
					
					<div class="col-md-12 text-left bill-date">
						<c:choose>

						<c:when test="${count == 0}">
							<div class="colOuter">
								<div><center>
									<input name="" class="buttonsaveorder" value="Start Day"
										type="button" id="start" onclick="start(); hideMe(this.id);"></center>
								</div>
							</div>
						</c:when>

						<c:when test="${count ==2}">
						
						
						<div>
					 
				<h4>
					<B> Bill No :${sellBillHeader.sellBillNo} &nbsp; &nbsp; &nbsp;
					 Bill Date :${sellBillHeader.billDate}</B>
				</h4>
				<%-- <h4 style="align-items: center;" >
					<i class="fa fa-bars">Bill Date :</i>${sellBillHeader.billDate}
				</h4> --%>
				
						

					</div>


					<!-------------------------------------------------------------->

					
			</div>
			
			<div class="col-md-2"> 
								<span style="padding-top: 0px;float: left;margin-top: 13px;font-size: 16px; ">Single Print</span><label class="switch"> 
  									<input type="checkbox" id="id" checked>
 											 <span class="slider round"></span>
 								</div>			 
 										
			 

							<%-- <div class="colOuter">
								<div class="col1">Bill NO:</div>
								<div class="col1">${sellBillHeader.sellBillNo}</div>
							</div>

							<div class="colOuter">
								<div class="col1">Bill Date:</div>
								<div class="col1">${sellBillHeader.billDate}</div>
							</div> --%>

							<!--tab1-->
							<!-- <li class="selected"> -->
							
								<div class="row"></div>
								
									 
								</label>
								<div class="table">
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
															<td>
																<!--  new Input <input type='text' class="form-control"
																oninput='onInput()' id='input1' />
																 --> 
																 
																 <input type="text"  class="form-control"
																data-placeholder="Enter Barcode"
																id='input'  onchange='onInput()' /> <%-- <datalist id='dlist'>
																	<c:forEach items="${itemsList}" var="itemsList">
																		<option value="${itemsList.itemId}"><c:out value="${itemsList.itemId}"/></option>
																	</c:forEach>
																</datalist> --%>
															</td>
															<td>
															
															<!-- <input type="text" class="form-control"
																id="itemName" name="itemName" placeholder="Item Name"
																disabled onchange="changeFocus()"> -->
																
																<select class="selectpicker"  data-show-subtext="true" data-live-search="true"
																data-placeholder="Enter Item Name"  name="itemName"
																class="form-control" tabindex="-1" id="itemName" onchange="onSelectItem()"
																data-rule-required="true">
																	<option value="">Item Name</option>
																	<c:forEach items="${itemsList}"
																		var="itemsList">
																		<option value="${itemsList.itemId}">${itemsList.itemName}</option>
																	</c:forEach>
															</select> 
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
											<button class="btn btn-primary" onclick="insertItem1()"
												id="insertItemButton">Submit Item</button>
												<button style="float: right;margin-top: 13px;" type="button" class="btn btn-primary"
						onclick="printExBill()" disabled id="printExBill">Print</button>
										</center>
										 <div align="center" id="loader11" style="display: none">
										<span>
											<h4>
												<font color="#343690">Loading</font>
											</h4>
										</span> <span class="l-1"></span> <span class="l-2"></span> <span
											class="l-3"></span> <span class="l-4"></span> <span
											class="l-5"></span> <span class="l-6"></span>
									</div>		
									</div>
									
									<hr></hr>
									 
								</div> <br /> <!-- Form End -->
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table class="table table-bordered" width="100%" border="0"
											cellspacing="0" cellpadding="0 " id="table_grid1">
											<tr class="bgpink">
												<th>Print</th> 
												<th>Sr.No</th>
												<th>Detail Id</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th style="width: 130px;">Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<c:forEach items="${sellBillDetails}" var="sellBillDetails" varStatus="count">
												<tr>
											 <td><input type="checkbox" name="select_to_print" onchange="selectToPrint()"
																id="select_to_print"
																value="${sellBillDetails.sellBillDetailNo}" ></td>
																
																
																	<td ><c:out value="${listSize}" /></td>
																	<c:set value="${listSize-1}" var="listSize"></c:set>
													<td><c:out value="${sellBillDetails.sellBillDetailNo}" /></td>
													<td><c:out value="${sellBillDetails.itemId}" /></td>
													<td><c:out value="${sellBillDetails.itemName}" /></td>
													<td><c:out value="${sellBillDetails.qty}" /></td>
													<td><c:out value="${sellBillDetails.mrp}" /></td>
													<td><c:out value="${sellBillDetails.grandTotal}" /></td>

 											<td>
								 				<a href="#" class="action_btn" onclick="deleteItem(${sellBillDetails.sellBillDetailNo},${sellBillDetails.qty},${sellBillDetails.itemId})"><abbr title="Delete"><i class="fa fa-trash"></i></abbr></a>
													</td>
												</tr>
											</c:forEach>

										</table>
									</div>


							<!-- Loader Div -->
									<div align="center" id="loader" style="display: none">
										<span>
											<h4>
												<font color="#343690">Loading</font>
											</h4>
										</span> <span class="l-1"></span> <span class="l-2"></span> <span
											class="l-3"></span> <span class="l-4"></span> <span
											class="l-5"></span> <span class="l-6"></span>
									</div>
									
																<!--End of  Loader Div -->
									
								</div>
								<hr /> <br />
								<center>
									<input type="submit" class="btn btn-primary"
													onclick="todaysDayClose()"              
													value="DAY CLOSE" id="dayClose1"/>
								</center>
<!--here input para was bill No  -->
							<!-- </li> -->

						</c:when>
						<c:when test="${count ==3}">
							<li>
								<div class="row"></div> <br /> <br />
								<div class="table">
									<div class="shInnerwidth">

										<table class="table table-bordered" width="100%" border="0"
											cellspacing="0" cellpadding="0 " id="table_grid">
											<tr class="bgpink">
												<th>Bill No.</th>
												<th>Bill Date</th>
												<th style="width: 130px;">Taxable Amount</th>
												<th>Payable amount</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<tr>
											
																
												<td><c:out value="${sellBillHeader.sellBillNo}" /></td>
												<td><c:out value="${sellBillHeader.billDate}" /></td>
												<td><c:out value="${sellBillHeader.taxableAmt}" /></td>
												<td><c:out value="${sellBillHeader.payableAmt}" /></td>
												<td><c:out value="${sellBillHeader.grandTotal}" /></td>
												<td>
													 <input type="submit" class="btn btn-primary" id="dayClose1"
													onclick="todaysDayClose()"
													value="DAY CLOSE" id="callSubmit"/>
													
													<!--here input para was bill No  -->
													
													
												</td>
											</tr>
										</table>
									</div>
								</div>
							</li>

							<li>

								<div class="table-responsive">
									<div class="shInnerwidth">

										<table class="table table-bordered" width="100%" border="0"
											cellspacing="0" cellpadding="0 " id="table_grid">
											<tr class="bgpink">
										<th>Print</th>
												<th>Sr.No.</th>
												<th>Detail Id</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th style="width: 130px;">Qty</th>
												<th>Rate</th>
												<th>Amount</th>
											</tr>

											<c:forEach items="${sellBillDetails}" var="sellBillDetails"  varStatus="count">
												<tr>
												 <td><input type="checkbox" name="select_to_print" onchange="selectToPrint()"
																id="select_to_print"
																value="${sellBillDetails.sellBillDetailNo}" ></td>
												<td ><c:out value="${listSize}" /></td>
																	<c:set value="${listSize-1}" var="listSize"></c:set>
													<td><c:out value="${sellBillDetails.sellBillNo}" /></td>
															<td><c:out value="${sellBillDetails.itemId}" /></td>
													<td><c:out value="${sellBillDetails.itemName}" /></td>
													<td><c:out value="${sellBillDetails.qty}" /></td>
													<td><c:out value="${sellBillDetails.mrp}" /></td>
													<td><c:out value="${sellBillDetails.grandTotal}" /></td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</div>
							</li>

						</c:when>
						<c:otherwise>

						</c:otherwise>
					</c:choose>
			<%-- 		<!--tab1-->
					<div class="row"></div> <br /> <br />
						<div class="table" id="div1" style="display: none;">
							<div>
					 
				<h4>
					<B> Bill No :${sellBillHeader.sellBillNo} &nbsp; &nbsp; &nbsp;
					 Bill Date :${sellBillHeader.billDate}</B>
				</h4>
				<h4 style="align-items: center;" >
					<i class="fa fa-bars">Bill Date :</i>${sellBillHeader.billDate}
				</h4>
				
						

					</div>


					<!-------------------------------------------------------------->

					
			
			
			<div class="col-md-2"> 
								<span style="padding-top: 0px;float: left;margin-top: 13px;font-size: 16px; ">Single Print</span><label class="switch"> 
  									<input type="checkbox" id="id" checked>
 											 <span class="slider round"></span>
 								</div>			 
 										
			 

							<div class="colOuter">
								<div class="col1">Bill NO:</div>
								<div class="col1">${sellBillHeader.sellBillNo}</div>
							</div>

							<div class="colOuter">
								<div class="col1">Bill Date:</div>
								<div class="col1">${sellBillHeader.billDate}</div>
							</div>

							<!--tab1-->
							<!-- <li class="selected"> -->
							
								<div class="row"></div>
								
									 
								</label>
								<div class="table">
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
															<td>
																<!--  new Input <input type='text' class="form-control"
																oninput='onInput()' id='input1' />
																 --> 
																 
																 <input type="text"  class="form-control"
																data-placeholder="Enter Barcode"
																id='input'  onchange='onInput()' /> <datalist id='dlist'>
																	<c:forEach items="${itemsList}" var="itemsList">
																		<option value="${itemsList.itemId}"><c:out value="${itemsList.itemId}"/></option>
																	</c:forEach>
																</datalist>
															</td>
															<td>
															
															<!-- <input type="text" class="form-control"
																id="itemName" name="itemName" placeholder="Item Name"
																disabled onchange="changeFocus()"> -->
																
																<select class="selectpicker"  data-show-subtext="true" data-live-search="true"
																data-placeholder="Enter Item Name"  name="itemName"
																class="form-control" tabindex="-1" id="itemName" onchange="onSelectItem()"
																data-rule-required="true">
																	<option value="">Item Name</option>
																	<c:forEach items="${itemsList}"
																		var="itemsList">
																		<option value="${itemsList.itemId}">${itemsList.itemName}</option>
																	</c:forEach>
															</select> 
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
											<button class="btn btn-primary" onclick="insertItem1()"
												id="insertItemButton">Submit Item</button>
												<button style="float: right;margin-top: 13px;" type="button" class="btn btn-primary"
						onclick="printExBill()" disabled id="printExBill">Print</button>
										</center>
										 		
									</div>
									 
								</div> <br /> <!-- Form End -->
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table class="table table-bordered" width="100%" border="0"
											cellspacing="0" cellpadding="0 " id="table_grid1">
											<tr class="bgpink">
												<th>Print</th> 
												<th>Sr.No</th>
												<th>Detail Id</th>
												<th>Barcode</th>
												<th>Item Name</th>
												<th style="width: 130px;">Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<c:forEach items="${sellBillDetails}" var="sellBillDetails" varStatus="count">
												<tr>
											 <td><input type="checkbox" name="select_to_print" onchange="selectToPrint()"
																id="select_to_print"
																value="${sellBillDetails.sellBillDetailNo}" ></td>
																	<td ><c:out value="${count.index+1}" /></td>
													<td><c:out value="${sellBillDetails.sellBillDetailNo}" /></td>
													<td><c:out value="${sellBillDetails.itemId}" /></td>
													<td><c:out value="${sellBillDetails.itemName}" /></td>
													<td><c:out value="${sellBillDetails.qty}" /></td>
													<td><c:out value="${sellBillDetails.mrp}" /></td>
													<td><c:out value="${sellBillDetails.grandTotal}" /></td>

 											<td>
								 				<a href="#" class="action_btn" onclick="deleteItem('+item.sellBillDetailNo+')"><abbr title="Delete"><i class="fa fa-trash"></i></abbr></a>
													</td>
												</tr>
											</c:forEach>

										</table>
									</div>


							<!-- Loader Div -->
									<div align="center" id="loader" style="display: none">
										<span>
											<h4>
												<font color="#343690">Loading</font>
											</h4>
										</span> <span class="l-1"></span> <span class="l-2"></span> <span
											class="l-3"></span> <span class="l-4"></span> <span
											class="l-5"></span> <span class="l-6"></span>
									</div>
									
																<!--End of  Loader Div -->
									
								</div>
								<hr /> <br />
								<center>
									<input type="submit" class="btn btn-primary"
													onclick="todaysDayClose(${sellBillHeader.sellBillNo})"
													value="DAY CLOSE" id="dayClose1"/>
								</center>
					</li> --%>
					 <li class="selected">
						<div class="row"></div> <br /> <br />
						<div class="table" id="div1" style="display: none;">
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
													<td>
														
														 <input type='text'
														class="form-control" onkeypress='onInput()' min='0' max='500'
														placeholder="Enter Barcode" id='input' list='dlist' /> <datalist
															id='dlist'>
															<c:forEach items="${itemsList}" var="itemsList">
																<option value="${itemsList.itemId}"><c:out value="${itemsList.itemId}"/></option>
															</c:forEach>
														</datalist>
														
														
													</td>

													<td>
													
													<!-- <input type="text" class="form-control"
														id="itemName" name="itemName" placeholder="Item Name"
														disabled>
														 -->
														 <select class="selectpicker"  data-show-subtext="true" data-live-search="true"
																data-placeholder="Enter Item Name"  name="itemName"
																class="form-control" tabindex="-1" id="itemName" onchange="onSelectItem()"
																data-rule-required="true">
																	<option value="">Item Name</option>
																	<c:forEach items="${itemsList}"
																		var="itemsList">
																		<option value="${itemsList.itemId}">${itemsList.itemName}</option>
																	</c:forEach>
															</select> 
														</td>
													<td><input type="number" min="0" max="500"
														class="form-control" placeholder="1" name="qty1" id="qty1"
														value="1"></td>
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
											  <button class="btn btn-primary" onclick="insertItem1()" style="display: none;"
												id="insertItemButton">Submit Item</button> 
												<!-- <button style="float: right;margin-top: 13px;" type="button" class="btn btn-primary"
						onclick="printExBill()" disabled id="printExBill">Print</button> --> 
										</center>
						 
								

							</div>
							
						</div> <br /> <!-- Form End -->
						<div class="table-responsive" style="display: none;" id="div2">
							<div class="shInnerwidth">

								<table class="table table-bordered" width="100%" border="0"
									cellspacing="0" cellpadding="0 " id="table_grid">
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

									</tr>
								</table>
							</div>
						</div>
						<hr /> <br /> <center>
									<button class="btn additem_btn"  onclick="todaysDayClose()"style="display: none;" id="dayClose1">DAY CLOSE</button>
								</center><center> <input type="submit" class="btn btn-primary"
						onclick="todaysDayClose()" style="display: none;" id="dayClose1"
						value="DAY CLOSE"></center>
						
						

					</li>
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
function start(){
    $("#div1").show();
    $("#div2").show();
    $("#insertItemButton").show();
    $("#dayClose1").show();
    
    $("#insertItemButton").show();
    $("#loader").show();

  //  alert("started");
    
    $.getJSON('${insertHeader}',{

    	ajax : 'true',

    }, function(data) {
		window.location.reload();
	    $("#loader").hide();


	});
}

function  hideMe(startId){
	 $("#"+startId).hide();
	 $("#insertItemButton").show();
	 //window.location.reload();
	
}

</script>
	<script type="text/javascript">
	function onInput() {
		
	    var val = document.getElementById("input").value;
	    
	   // alert("Barcode "+val);
	 
	    $.getJSON('${getItemDetails}',{
			
            //itemId : JSON.stringify(val),
			 itemId : val,
			ajax : 'true',

		}, function(data) {
			//alert("name="+data.itemName);
			
			
			$('#itemName').selectpicker('val',''+data.itemId);

			$("#rateTdVal1").html(data.mrp);
			
			//$('#insertItemButton').focus();
			
			  insertItem1();
			 $('#input').focus();
			
		});
		//$('#insertItemButton').focus();
	    $('#input').focus();
	  }
	
	function onSelectItem() {
 
		var iId=document.getElementById("itemName").value;
	  
	    	val=iId;
	    	
	    //alert("iID " +iId);
		  
	    $.getJSON('${getItemDetails}',{
	  
           // itemId : JSON.stringify(val),
           
           itemId : val,
			ajax : 'true',

		}, function(data) {

		//$('#itemName').val(data.itemId).prop('selected', true);
			$('#itemName').selectpicker('val',''+data.itemId);
		document.getElementById("input").value=val;
			
			$("#rateTdVal1").html(data.mrp);
			//$('#insertItemButton').focus();
			 $('#input').focus();
			 
				insertItem1();
			
		});
		
	}
	</script>
	<script type="text/javascript">
	function insertItem1() {
		
		$('#loader11').show();

	    var val = document.getElementById("input").value;
	    var qty = document.getElementById("qty1").value;

	    $('#input').focus();
	    
	    $.getJSON('${calcStock}',{

	    	itemId : val,
            qty:qty,
			ajax : 'true',

	}, function(data) {
		if(data<qty)
			{
			$('#loader11').hide();

			alert("Stock Not Available. Can not place Item ");
			document.getElementById("input").value="";
			
			 $('#input').focus();
			 
			}
		else
	{
		 $.getJSON('${insertItemOrder}',{
				

	            itemId : val,
	            qty:qty,
				ajax : 'true',

			}, function(data) {

				$('#loader11').hide();
				var len = data.length;

				$('#table_grid1 td').remove();

				$.each(data,function(key, item) {
					key=len;
				var tr = $('<tr></tr>');
				tr.append($('<td></td>').html(' <input type="checkbox" onchange="selectToPrint()" name="select_to_print" id="select_to_print" value="'+item.sellBillDetailNo+'" >'));
			
					//tr.append($('<td></td>').html(key));
					
					tr.append($('<td></td>').html(len));
						
						len=len-1;

				tr.append($('<td></td>').html(item.sellBillDetailNo));
				
			  	tr.append($('<td></td>').html(item.itemId));

			  	tr.append($('<td></td>').html(item.itemName));

				tr.append($('<td></td>').html(item.qty));

				tr.append($('<td></td>').html(item.mrp));

				tr.append($('<td></td>').html(item.grandTotal));
				
				//tr.append($('<td ><input type="button" id="deleteButton" onclick="deleteItem('+item.sellBillDetailNo+')" /><i class='fa fa-trash'></i></td>'));

				//tr.append($('<td ><a href="#" >< i class="fa fa-trash" id="deleteButton" onclick="deleteItem('+item.sellBillDetailNo+')" ></i></a></td>'));

				
				tr.append($('<td ><a href="#" class="action_btn" onclick="deleteItem('+item.sellBillDetailNo+','+item.qty+','+item.itemId+')"><abbr title="Delete"><i class="fa fa-trash"></i></abbr></a></td>'));
				$('#table_grid1 tbody').append(tr);

			});
				 if(document.getElementById("id").checked){
					 
					// alert("print");
					 window.open("${pageContext.request.contextPath}/printExBill");
				 }
	         });
		
	}
	});
	    document.getElementById("input").value="";
	   // document.getElementById("itemName").val("");
		$('#itemName').selectpicker('val',''+"");
		
		 $('#input').focus();
	    
	}
		
	</script>
	
	
	
	
	<script type="text/javascript">
	function todaysDayClose(){
			//alert("Hi ");
							$('#loader11').show();

							$.getJSON('${dayClose}',{

								ajax : 'true',
							 },
							 function(data) {
								 //alert(data);
								 
								 window.location.reload();
								 
			});
			$('#loader11').hide();
		//	alert("Hi End  ");
	}
	
	</script>
	
	
	
	
	<!-- <script type="text/javascript">
	function todaysDayClose(){
			alert("Hi ");
							$('#loader11').show();

			$.ajax({

				type : "get",
				url : "dayClose", 
			
				 complete: function() {
					
					 window.location.reload();
				 }
			});
			$('#loader11').hide();
			alert("Hi End  ");
	}
	
	</script> -->

	<script type="text/javascript">
	function deleteItem(sellBillDetailNo,qty,id){
		
		$('#loader').show();

		//alert("Hello");
			var billNo=sellBillDetailNo;
			
			 $.getJSON('${deleteItem}',{

				sellBillDetailNo:billNo,
				qty:qty,
				id:id,
				type : "get",
			

			 },
			 function(data) {
					//$('#loader').hide();


					$('#loader').hide();
					var len = data.length;

					$('#table_grid1 td').remove();

					$.each(data,function(key, item) {

					var tr = $('<tr></tr>');
					
					 
						
						tr.append($('<td></td>').html(' <input type="checkbox" onchange="selectToPrint()" name="select_to_print" id="select_to_print" value="'+item.sellBillDetailNo+'" >'));
						
						//tr.append($('<td></td>').html(key+1));
						
						tr.append($('<td></td>').html(len));
						
						len=len-1;
						
						tr.append($('<td></td>').html(item.sellBillDetailNo));
						
				  	tr.append($('<td></td>').html(item.itemId));

				  	tr.append($('<td></td>').html(item.itemName));

					tr.append($('<td></td>').html(item.qty));

					tr.append($('<td></td>').html(item.mrp));

					tr.append($('<td></td>').html(item.grandTotal));
					
				//	tr.append($('<td ><input type="button" id="deleteButton" onclick="deleteItem('+item.sellBillDetailNo+')" value="Delete" /></td>'));
								tr.append($('<td ><a href="#" class="action_btn" onclick="deleteItem('+item.sellBillDetailNo+','+item.qty+','+item.itemId+')"><abbr title="Delete"><i class="fa fa-trash"></i></abbr></a></td>'));


					$('#table_grid1 tbody').append(tr);

				});
			
		         });
		}
	
	
	function printExBill()
	{
		//alert("in print");
		
		var checkedId=[];
		var checkboxes=document.getElementsByName("select_to_print");
		
		 
			for (var i = 0, n = checkboxes.length; i < n; i++) {
				if(checkboxes[i].checked) {
					
					checkedId.push(checkboxes[i].value );
					
				}
			}
			//alert(checkboxes);
			 $.getJSON('${getSelectedIdForPrint}',{

					id :  JSON.stringify(checkedId),
					ajax : 'true',
				

				 });
				  
		window.open("${pageContext.request.contextPath}/printSelectedOrder");
	}
	
	function selectToPrint()
	{
		//alert("hh");
	 
		var checkboxes=document.getElementsByName("select_to_print");
		//alert(checkboxes[0].value);
		var flag=0;
			for (var i = 0, n = checkboxes.length; i < n; i++) {
				if(checkboxes[i].checked) {
					 
					flag=1;
				}
			}
		if(flag==1)
			{
		 //alert("KK");
			document.getElementById("printExBill").disabled=false;
			}
		else{
		document.getElementById("printExBill").disabled=true;
		}
		
		 
	}
	</script>

</body>
</html>
