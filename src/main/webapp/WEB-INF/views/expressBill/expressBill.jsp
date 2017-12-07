<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

  <script src="${pageContext.request.contextPath}/resources/css/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-select.min.css" />
	  <script src="${pageContext.request.contextPath}/resources/css/bootstrap-select.min.js"></script><!-- 1 css and 2 js for search item   -->
	


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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/loader.css">

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
<body> --%>


	<c:url var="getItemDetails" value="/findItemDetails" />
	<c:url var="insertItemOrder" value="/insertItem" />
	<c:url var="insertHeader" value="/insertHeader" />
	<div class="sidebarOuter"></div>
	<c:url var="calcStock" value="/calcStock" />

	<c:url var="deleteItem" value="/deleteItem" />


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

				<!------------ Place Actual content of page inside this div ----------->
				<div class="sidebarright">

					<div class="order-left">
						<h2 class="pageTitle">Express Bill</h2>

					</div>


					<!-------------------------------------------------------------->

					<c:choose>

						<c:when test="${count == 0}">
							<div class="colOuter">
								<div class="col3full">
									<input name="" class="buttonsaveorder" value="Start Day"
										type="button" id="start" onclick="start(); hideMe(this.id);">
								</div>
							</div>
						</c:when>

						<c:when test="${count ==2}">
						
						
						<div class="col3" align="justify" >
						
				<h4 style="align-items: center;" >
					<i class="fa fa-bars"> Bill No :</i>${sellBillHeader.sellBillNo} &nbsp; &nbsp; &nbsp;
					<i class="fa fa-bars"> Bill Date :</i>${sellBillHeader.billDate}
				</h4>
				<%-- <h4 style="align-items: center;" >
					<i class="fa fa-bars">Bill Date :</i>${sellBillHeader.billDate}
				</h4> --%>
				

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
							<li class="selected">
								<div class="row"></div> <br /> <br />
								<div class="table-responsive"">
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
																 
																 <input type='text' onchange='onInput()'
																class="form-control" placeholder="Enter Barcode"
																id='input' list='dlist' /> <datalist id='dlist'>
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
																class="form-control" tabindex="6" id="itemName" onchange="onSelectItem()"
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
										</center>
									</div>
								</div> <br /> <!-- Form End -->
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table class="table table-bordered" width="100%" border="0"
											cellspacing="0" cellpadding="0 " id="table_grid1">
											<tr class="bgpink">
												<th>Barcode</th>
												<th>Item Name</th>
												<th style="width: 130px;">Qty</th>
												<th>Rate</th>
												<th>Amount</th>
												<th>Action</th>
											</tr>
											<c:forEach items="${sellBillDetails}" var="sellBillDetails">
												<tr>
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

							</li>

						</c:when>
						<c:when test="${count ==3}">
							<li>
								<div class="row"></div> <br /> <br />
								<div class="table-responsive">
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
													onclick="todaysDayClose(${sellBillHeader.sellBillNo})"
													value="DAY CLOSE" id="callSubmit"/>
													
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
												<th>Barcode</th>
												<th>Item Name</th>
												<th style="width: 130px;">Qty</th>
												<th>Rate</th>
												<th>Amount</th>
											</tr>

											<c:forEach items="${sellBillDetails}" var="sellBillDetails">
												<tr>
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
					<!--tab1-->
					
					<li class="selected">
						<div class="row"></div> <br /> <br />
						<div class="table-responsive" id="div1" style="display: none;">
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
														class="form-control" onchange='onInput()' min='0' max='500'
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
																class="form-control" tabindex="6" id="itemName" onchange="onSelectItem()"
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
											<button class="btn btn-primary" onclick="insertItem1()"
												id="insertItemButton">Submit Item</button>
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
						<hr /> <br /> <%-- <center>
									<button class="btn additem_btn"  onclick="todaysDayClose()"style="display: none;" id="dayClose1">DAY CLOSE</button>
								</center> --%> <input type="submit" class="btn btn-primary"
						onclick="todaysDayClose()" style="display: none;" id="dayClose1"
						value="DAY CLOSE">

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
    alert("started");
    
    $.getJSON('${insertHeader}',{

    	ajax : 'true',

    }, function(data) {
		alert("inserting Header ")

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
	    
	     var opts = document.getElementById('dlist').childNodes;
	    for (var i = 0; i < opts.length; i++) {
	      if (opts[i].value === val) {
	        // An item was selected from the list!
	        // yourCallbackHere()
	       // alert(opts[i].value);
	        break;
	      }
	    } 

	    $.getJSON('${getItemDetails}',{
			
            itemId : JSON.stringify(val),
			
			ajax : 'true',

		}, function(data) {
			
		$('#itemName').val(data.itemId).prop('selected', true);
			
			$("#rateTdVal1").html(data.mrp);
			
			$('#insertItemButton').focus();
			
		});

	  }
	
	function onSelectItem() {
 
		var iId=document.getElementById("itemName").value;
	  
	    	val=iId;
		  
	    $.getJSON('${getItemDetails}',{
	  
            itemId : JSON.stringify(val),
			ajax : 'true',

		}, function(data) {

		$('#itemName').val(data.itemId).prop('selected', true);
		document.getElementById("input").value=val;
			
			$("#rateTdVal1").html(data.mrp);
			$('#insertItemButton').focus();
			
		});
		
	}
	</script>
	<script type="text/javascript">
	function insertItem1() {
		
		$('#loader').show();

	    var val = document.getElementById("input").value;
	    var qty = document.getElementById("qty1").value;

	    $('#input').focus();
	    
	    $.getJSON('${calcStock}',{

	    	itemId : val,
          //  qty:qty,
			ajax : 'true',

	}, function(data) {
		if(data<qty)
			{
			$('#loader').hide();

			alert("Stock Not Available. Can not place Item ");
			
			}
		else
	{
		 $.getJSON('${insertItemOrder}',{
				

	            itemId : val,
	            qty:qty,
				ajax : 'true',

			}, function(data) {

				$('#loader').hide();
				var len = data.length;


				$('#table_grid1 td').remove();

				$.each(data,function(key, item) {

				var tr = $('<tr></tr>');
			  
			  	tr.append($('<td></td>').html(item.itemId));

			  	tr.append($('<td></td>').html(item.itemName));

				tr.append($('<td></td>').html(item.qty));

				tr.append($('<td></td>').html(item.mrp));

				tr.append($('<td></td>').html(item.grandTotal));
				
				//tr.append($('<td ><input type="button" id="deleteButton" onclick="deleteItem('+item.sellBillDetailNo+')" /><i class='fa fa-trash'></i></td>'));

				//tr.append($('<td ><a href="#" >< i class="fa fa-trash" id="deleteButton" onclick="deleteItem('+item.sellBillDetailNo+')" ></i></a></td>'));

				
				tr.append($('<td ><a href="#" class="action_btn" onclick="deleteItem('+item.sellBillDetailNo+')"><abbr title="Delete"><i class="fa fa-trash"></i></abbr></a></td>'));
				$('#table_grid1 tbody').append(tr);

			});
		
	         });
	}
	});
	    document.getElementById("input").value="";
	    document.getElementById("itemName").value="";
	    
	}
		
	</script>
	<script type="text/javascript">
	function todaysDayClose(){
			//alert("Hello");
							$('#loader').show();

			$.ajax({

				type : "get",
				url : "dayClose", 
			
				 complete: function() {
					
					 window.location.reload();
				 }
			});
			$('#loader').hide();
		
	}
	
	</script>

	<script type="text/javascript">
	function deleteItem(sellBillDetailNo){
		
		$('#loader').show();

		//alert("Hello");
			var billNo=sellBillDetailNo;
			
			 $.getJSON('${deleteItem}',{

				sellBillDetailNo:billNo,
				type : "get",
			

			 },
			 function(data) {
					//$('#loader').hide();


					$('#loader').hide();
					var len = data.length;

					$('#table_grid1 td').remove();

					$.each(data,function(key, item) {

					var tr = $('<tr></tr>');

				  	tr.append($('<td></td>').html(item.itemId));

				  	tr.append($('<td></td>').html(item.itemName));

					tr.append($('<td></td>').html(item.qty));

					tr.append($('<td></td>').html(item.mrp));

					tr.append($('<td></td>').html(item.grandTotal));
					
				//	tr.append($('<td ><input type="button" id="deleteButton" onclick="deleteItem('+item.sellBillDetailNo+')" value="Delete" /></td>'));
								tr.append($('<td ><a href="#" class="action_btn" onclick="deleteItem('+item.sellBillDetailNo+')"><abbr title="Delete"><i class="fa fa-trash"></i></abbr></a></td>'));


					$('#table_grid1 tbody').append(tr);

				});
			
		         });
		}
	
	</script>

</body>
</html>
