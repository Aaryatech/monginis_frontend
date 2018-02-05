<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>


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



</head> --%>

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


<c:url var="getSellBillHeader" value="/getSellBillHeader" />
	
	<div class="sidebarOuter"></div>
	
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
				
				<!-- Place Actual content of page inside this div -->
				<div class="sidebarright">
				

<div class="row">
	    <div class="col-md-12"><h2 class="pageTitle">View Bills</h2></div>
	</div>
	 <%String frmDate = session.getAttribute("fromSellBillDate").toString();
	 String tDate = session.getAttribute("toSellBillDate").toString();%>
	<div class="row">
	
		<div class="col-md-2 from_date">
		    <h4 class="pull-left">From Date:-</h4>
		</div>
		<div class="col-md-2 ">
			<input id="fromdatepicker" class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" name="fromDate" type="text" value="<%=frmDate%>">
		</div>
		<div class="col-md-1">
		    <h4 class="pull-left">To Date:-</h4>
		</div>
		<div class="col-md-2 ">
			<input id="todatepicker" class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" name="toDate" type="text" value="<%=tDate%>">
		</div>
		<div class="col-md-2">
		    <button class="btn search_btn pull-left" onclick="searchSellBill()">Search </button>
		</div>
		
    </div>
	
	<div class="row">
		<div class="col-md-12">
		<!--table-->
			<div class="table-responsive">
				<div class="shInnerwidth">
					
								<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid" class="table table-bordered">
									<tr class="bgpink">
									<th >Bill No</th>
										<th >Invoice No</th>
									<th>Bill Date</th>
										<th >Grand Total</th>
									<th>Payable Amount</th>
									<th>Paid Amount</th>
									<th>Paymode</th>
									<th>Action</th>
								  </tr>
								
								 
								  
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
			   
			
			$.getJSON('${getSellBillHeader}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {

								//$('#table_grid td').remove();
								
								

								if (data == "") {
									alert("No records found !!");

								}
								//alert(data);

								
								$.each(data,function(key, sellBillData) {

													var index = key + 1;

													var tr = "<tr>";

													

													var sellBillNo = "<td>&nbsp;&nbsp;&nbsp;"
															+ sellBillData.sellBillNo
															+ "</td>";
															var invoiceNo = "<td>&nbsp;&nbsp;&nbsp;"
																+ sellBillData.invoiceNo
																+ "</td>";
																var billDate = "<td>&nbsp;&nbsp;&nbsp;"
																	+ sellBillData.billDate
																	+ "</td>";

																	var grandTotal = "<td>&nbsp;&nbsp;&nbsp;"
																		+ sellBillData.grandTotal
																		+ "</td>";

																		var PayableAmt = "<td>&nbsp;&nbsp;&nbsp;"
						 													+ sellBillData.payableAmt
						 													+ "</td>";
																			
						  													var paidAmt = "<td>&nbsp;&nbsp;&nbsp;"
																				+ sellBillData.paidAmt
																				+ "</td>";

																			var paymentMode = "<td>&nbsp;&nbsp;&nbsp;"
																				+ sellBillData.paymentMode
																				+ "</td>";
																				
																				var viewBill = '<td>&nbsp;&nbsp;&nbsp;'
																				+'<a href="${pageContext.request.contextPath}/viewBillDetails?sellBillNo='+ sellBillData.sellBillNo+'&billDate='+sellBillData.billDate+'" class="action_btn" name='+'><abbr title="Details"><i class="fa fa-list"></i></abbr></a>'
																				+ "</td>";



													

													var trclosed = "</tr>";

													$('#table_grid tbody')
															.append(tr);
													$('#table_grid tbody')
															.append(sellBillNo);
													$('#table_grid tbody')
													.append(invoiceNo);
													$('#table_grid tbody')
													.append(billDate);
													$('#table_grid tbody')
													.append(grandTotal);
													$('#table_grid tbody')
													.append(PayableAmt);
													$('#table_grid tbody')
													.append(paidAmt);
													
													$('#table_grid tbody')
													.append(paymentMode);
													
													$('#table_grid tbody')
													.append(viewBill);
													
													$('#table_grid tbody')
													.append(trclosed);
													
													

												})
													

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
