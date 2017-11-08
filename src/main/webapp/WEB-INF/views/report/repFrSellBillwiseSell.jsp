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
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/resources/css/custom.css" rel="stylesheet" type="text/css"/>	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">	
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />
	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>	
	
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
<!--datepicker-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
  $( function() {
    $( "#todatepicker" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
  $( function() {
    $( "#fromdatepicker" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
 
  </script>
<!--datepicker--> 


</head>
<body>

<c:url var="getBilwiselReport" value="/getBilwiselReport" />
	
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
				
				<!-- Place Actual content of page inside this div -->
				<div class="sidebarright">
				

<div class="row">
	    <div class="col-md-12"><h2 class="pageTitle">View Billwise Report</h2></div>
	</div>
	
	<div class="row">
	
		<div class="colOuter">
		<div class="col1"><div class="col1title">From</div></div>
		<div class="col2"><input id="fromdatepicker" class="texboxitemcode texboxcal" placeholder="Delivery Date"  name="from_Date" type="text"  >
		</div>
	</div>

	<div class="colOuter">
		<div class="col1"><div class="col1title">TO</div></div>
		<div class="col2"><input id="todatepicker" class="texboxitemcode texboxcal" placeholder="Delivery Date"  name="to_Date" type="text"  >
		</div>
	</div>
	
		<div align="center">
		    <button class="btn search_btn" onclick="searchSellBill()" >Search </button>
		</div>
		<br>
    </div>
	
	<div class="row">
		<div class="col-md-12">
		<!--table-->
			<div class="table-responsive">
				<div class="shInnerwidth">
					
								<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid" class="table table-bordered">
								<thead >
									<tr class="bgpink">
									<th align="right" style="width:100px">Sr no.</th>
									<th align="center">Bill No</th>
									<th align="center">Date</th>
									<th align="center">Amount</th>
									<th align="center">Payment Mode</th>
								<!-- 	<th align="center">Card</th>
									<th align="center">Other</th> -->
									
								  </tr>
								</thead>
								
								 <tbody >
								
								 </tbody>
								  
								</table>
						
				</div>
			</div>
		<!--table end-->
		 
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
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<!--easyTabs-->

	
	<script type="text/javascript">
	function searchSellBill()
	{ 
		$('#table_grid td').remove();
		
		
		var isValid = validate();
		
		if (isValid) {
			
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			   
			
			$.getJSON('${getBilwiselReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {

								//$('#table_grid td').remove();
								
								

								if (data == "") {
									alert("No records found !!");

								}
								 

							 //	var cashTotal=0;
							//	var cardTotal=0;
								var amtTotal=0;
								//var otherTotal=0;
								$.each(data,function(key, sellBillData) {

									
									
									

									var tr = $('<tr></tr>');

								  	tr.append($('<td></td>').html(key+1));
								  	
								  	tr.append($('<td></td>').html(sellBillData.sellBillNo));
								  	
								  	tr.append($('<td></td>').html(sellBillData.billDate));
								  	
								  	//var amt=sellBillData.cash + sellBillData.card + sellBillData.other;
								  	tr.append($('<td></td>').html(sellBillData.payableAmt));
								  	
									amtTotal=amtTotal + sellBillData.payableAmt;
									
								  //	amtTotal=amtTotal + sellBillData.cash + sellBillData.card + sellBillData.other;
									
								  	var paymentMode = sellBillData.paymentMode;
								  	var mode;
									
									if(paymentMode==1)
										{
										mode="Cash";
										//cashTotal==cashTotal + sellBillData.paidAmt;
										}
									else if(paymentMode==2)
									{
										mode="Card";
									//	cardTotal==cardTotal + sellBillData.paidAmt;
									}
									else if(paymentMode==3)
									{
										mode="Other";
										//otherTotal==otherTotal + sellBillData.paidAmt;
									}
									
								  	tr.append($('<td></td>').html(mode));
								  	

								  	

									$('#table_grid tbody').append(tr);

									
									
									
									/* 
													var index = key + 1;

													var tr = "<tr>";

													var srNo = "<td>&nbsp;&nbsp;&nbsp;"
														+ index
														+ "</td>";

													var sellBillNo = "<td>&nbsp;&nbsp;&nbsp;"
															+ sellBillData.sellBillNo
															+ "</td>";
														
																var billDate = "<td>&nbsp;&nbsp;&nbsp;"
																	+ sellBillData.billDate
																	+ "</td>";
																	
																	var grandTotal = "<td>&nbsp;&nbsp;&nbsp;"
																		+ sellBillData.grandTotal
																		+ "</td>";
																		amtTotal=amtTotal + sellBillData.grandTotal;
																			
																		var paymentMode = sellBillData.paymentMode;
																			var mode;
																			
																			if(paymentMode==1)
																				{
																				mode="Cash";
																				//cashTotal==cashTotal + sellBillData.paidAmt;
																				}
																			else if(paymentMode==2)
																			{
																				mode="Card";
																			//	cardTotal==cardTotal + sellBillData.paidAmt;
																			}
																			else if(paymentMode==3)
																			{
																				mode="Other";
																				//otherTotal==otherTotal + sellBillData.paidAmt;
																			}

																			var paidMode = "<td>&nbsp;&nbsp;&nbsp;"
																				+ mode
																				+ "</td>";
																		



													

													var trclosed = "</tr>";

													$('#table_grid tbody')
															.append(tr);
													$('#table_grid tbody')
													.append(srNo);
													$('#table_grid tbody')
															.append(sellBillNo);
												
													$('#table_grid tbody')
													.append(billDate);
													
													$('#table_grid tbody')
													.append(grandTotal);
													$('#table_grid tbody')
													.append(paidMode);
													
													
													$('#table_grid tbody')
													.append(trclosed); */
													
													

												})
												
							var tr = "<tr>";
								 var total = "<td colspan='3'>&nbsp;&nbsp;&nbsp;<b> Total</b></td>";
								 
								var totalAmt = "<td>&nbsp;&nbsp;&nbsp;<b>"
									+ amtTotal
									+ "</b></td>";
								/* var cash = "<td>&nbsp;&nbsp;&nbsp;"
									+  cashTotal
									+ "</td>";
								var card = "<td>&nbsp;&nbsp;&nbsp;"
									+ cardTotal
									+ "</td>";
								var other = "<td>&nbsp;&nbsp;&nbsp;"
									+ otherTotal
									+ "</td>"; */
									
								
								var trclosed = "</tr>";
								
								$('#table_grid tbody')
								.append(tr);
								$('#table_grid tbody')
								.append(tr);
								$('#table_grid tbody')
								.append(total);
								$('#table_grid tbody')
								.append(totalAmt);
								
								 /*$('#table_grid tbody')
								.append(card);
								$('#table_grid tbody')
								.append(other); */
								$('#table_grid tbody')
								.append(trclosed); 
								$('#table_grid tbody')
								.append(trclosed); 
							});

		}
	}
	</script>
	<script type="text/javascript">
	function validate() {
	
	
		var fromDate =$("#fromdatepicker").val();
		var toDate =$("#todatepicker").val();
		

		var isValid = true;

	 if (fromDate == "" || fromDate == null) {

			isValid = false;
			alert("Please select From Date");
		}
	 else if (toDate == "" || toDate == null) {

			isValid = false;
			alert("Please select To Date");
		}
		return isValid;

	}
</script>
	
</body>
</html>
