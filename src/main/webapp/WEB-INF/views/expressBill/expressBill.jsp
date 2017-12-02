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
<c:url var="getItemDetails" value="/findItemDetails" />
<c:url var="insertItemOrder" value="/insertItem" />
<c:url var="insertHeader" value="/insertHeader" />
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
						<h2 class="pageTitle">Express Bill</h2>

					</div>
					
					
				<!-------------------------------------------------------------->
				
   <c:choose>
         
         <c:when test = "${count == 0}">
                      <div class="colOuter">
		 			  <div class="col3full">
        				<input name="" class="buttonsaveorder" value="Start Day" type="button" id="start" onclick="start()">
					  </div>
					  </div>
         </c:when>
         
         <c:when test = "${count ==2}">
           
              <div class="colOuter">
		            <div class="col1">Bill NO:</div>
		            <div class="col2">${sellBillHeader.sellBillNo}</div>
	                </div>
	                
	                <div class="colOuter">
		            <div class="col1">Bill Date:</div>
		            <div class="col2">${sellBillHeader.billDate}</div>
	                </div>
					  
				<!--tab1-->
							<li  class="selected">
								<div class="row">
									
								</div> <br /> <br />
								<div class="table-responsive" ">
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
																<input type='text' oninput='onInput()' class="form-control"placeholder="Enter Barcode" id='input' list='dlist' />

                                                                 <datalist id='dlist'>
                                                                    <c:forEach items="${itemsList}" var="itemsList"> 
                                                                       <option value="${itemsList.itemId}"><c:out value="${itemsList.itemId}"/></option>
                                                                     </c:forEach>
                                                                  </datalist>
																</td>
															<td>
															<input type="text" class="form-control"
																id="itemName" name="itemName"
																placeholder="Item Name" disabled>
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
											<button class="btn additem_btn" onclick="insertItem1()"
												id="b2" >SUBMIT</button>
										</center>
									</div>
								</div> <br /> <!-- Form End -->
								<div class="table-responsive" >
									<div class="shInnerwidth">
										
													<table class="table table-bordered" width="100%" border="0" cellspacing="0"
														cellpadding="0 " id="table_grid1">
														<tr class="bgpink">
															<th>Barcode</th>
															<th>Item Name</th>
															<th style="width: 130px;">Qty</th>
															<th>Rate</th>
															<th>Amount</th>
														</tr>
														  <c:forEach items="${sellBillDetails}" var="sellBillDetails"> 
                                                              <tr>      
                                                                  <td><c:out value="${sellBillDetails.itemId}"/></td>
                                                                  <td><c:out value="${sellBillDetails.itemName}"/></td>
                                                                  <td><c:out value="${sellBillDetails.qty}"/></td>
                                                                  <td><c:out value="${sellBillDetails.mrp}"/></td>
                                                                  <td><c:out value="${sellBillDetails.grandTotal}"/></td>
                                                               </tr>
                                                            </c:forEach>

													</table>
									</div>
								</div>
								<hr/>
								<br/>
								<center >
									<button class="btn additem_btn" onclick="todaysDayClose()" id="dayClose1">DAY CLOSE</button>
								</center>
								
							</li>
                  
                  </c:when>
         <c:when test = "${count ==3}">
         
               
         
         <li>            
                <div class="row">
									
								</div> <br /> <br />
                     <div class="table-responsive" >
									<div class="shInnerwidth">
										
													<table class="table table-bordered" width="100%" border="0" cellspacing="0"
														cellpadding="0 " id="table_grid">
														<tr class="bgpink">
															<th>Bill No.</th>
															<th>Bill Date</th>
															<th style="width: 130px;">Taxable Amount</th>
															<th>Payable amount</th>
															<th>Amount</th>
															<th>Action</th>
														</tr>
														<tr>
															 <td><c:out value="${sellBillHeader.sellBillNo}"/></td>
                                                                  <td><c:out value="${sellBillHeader.billDate}"/></td>
                                                                  <td><c:out value="${sellBillHeader.taxableAmt}"/></td>
                                                                  <td><c:out value="${sellBillHeader.payableAmt}"/></td>
                                                                  <td><c:out value="${sellBillHeader.grandTotal}"/></td>
                                                   <td>
                                                   <a href="${pageContext.request.contextPath}/dayClose/${sellBillHeader.sellBillNo}">
                                                   <input name="Start" class="buttonsaveorder" value="Day Close" type="button"></a></td>
														</tr>
													</table>
									</div>
						</div>
						</li>
					
						<li>
                     
                             
                                  
								<div class="table-responsive" >
									<div class="shInnerwidth">
										
													<table class="table table-bordered" width="100%" border="0" cellspacing="0"
														cellpadding="0 " id="table_grid">
														<tr class="bgpink">
															<th>Barcode</th>
															<th>Item Name</th>
															<th style="width: 130px;">Qty</th>
															<th>Rate</th>
															<th>Amount</th>
														</tr>
													
														
                                                         <c:forEach items="${sellBillDetails}" var="sellBillDetails"> 
                                                              <tr>      
                                                                  <td><c:out value="${sellBillDetails.itemId}"/></td>
                                                                  <td><c:out value="${sellBillDetails.itemName}"/></td>
                                                                  <td><c:out value="${sellBillDetails.qty}"/></td>
                                                                  <td><c:out value="${sellBillDetails.mrp}"/></td>
                                                                  <td><c:out value="${sellBillDetails.grandTotal}"/></td>
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
							<li  class="selected">
								<div class="row">
									
								</div> <br /> <br />
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
																<input type='text' onchange='onInput()' class="form-control"placeholder="Enter Barcode" id='input1' list='dlist' />

                                                                 <datalist id='dlist'>
                                                                    <c:forEach items="${itemsList}" var="itemsList"> 
                                                                       <option value="${itemsList.itemId}"><c:out value="${itemsList.itemId}"/></option>
                                                                     </c:forEach>
                                                                  </datalist>
																</td>
															<td>
															<input type="text" class="form-control"
																id="itemName" name="itemName"
																placeholder="Item Name" disabled>
															</td>
															<td><input type="number" min="0" max="500"
																class="form-control" placeholder="1" name="qty2"
																id="qty2" value="1"></td>
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
											<button class="btn additem_btn" onclick="insertItems()"
												id="b1"style="display: none;" >SUBMIT</button>
										</center>
									</div>
								</div> <br /> <!-- Form End -->
								<div class="table-responsive" style="display: none;" id="div2">
									<div class="shInnerwidth">
										
													<table class="table table-bordered" width="100%" border="0" cellspacing="0"
														cellpadding="0 " id="table_grid">
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
								<hr/>
								<br/>
								<center >
									<button class="btn additem_btn" onclick="generateSellBill1()"style="display: none;" id="dayClose1">DAY CLOSE</button>
								</center>
								
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
    $("#b1").show();
    $("#dayClose1").show();
    
    $.getJSON('${insertHeader}',{
		
		ajax : 'true',

    }, function(data) {
		alert("insertItem2")


	});
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
			document.getElementById("itemName").setAttribute('value',data.itemName);
			$("#rateTdVal1").html(data.mrp);

		});
	    
	    
	  }
	</script>
	<script type="text/javascript">
	function insertItem1() {
		//alert("insertItem")

		
	    var val = document.getElementById("input").value;
	    var qty = document.getElementById("qty1").value;

	    
	    
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

				
				$('#table_grid1 tbody').append(tr);

			});
		
	         });
		
	 }
	</script> 
	<script type="text/javascript">
	function todaysDayClose()
	{
	
	}
	</script>
	
</body>
</html>
