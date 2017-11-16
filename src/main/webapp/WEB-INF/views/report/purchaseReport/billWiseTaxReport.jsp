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

<c:url var="getBillWiseTaxReport" value="/findBillWiseTaxReport" />
	
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
	    <div class="col-md-12"><h2 class="pageTitle">BillWise Tax Report</h2></div>
	</div>
	
	<div class="row">
	
		<div class="col-md-2 from_date">
		    <h4 class="pull-left">From Date:-</h4>
		</div>
		<div class="col-md-2 ">
			<input id="fromdatepicker" class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" name="fromDate" type="text">
		</div>
		<div class="col-md-1">
		    <h4 class="pull-left">To Date:-</h4>
		</div>
		<div class="col-md-2 ">
			<input id="todatepicker" class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" name="toDate" type="text">
		</div>
		<div class="col-md-2">
		    <button class="btn search_btn pull-left" onclick="billWiseTaxReport()">Search </button>
		  &nbsp;&nbsp;&nbsp;  <a href='${pageContext.request.contextPath}/pdf?reportURL=showPurchaseTaxBillwiseReportPdf' id="btn_pdf" class="btn search_btn" style="display: none">PDF</a>
		 
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
									<th>Sr. NO.</th>
									<th>Party Name</th>
									<th>GSTIN</th>
									<th>Bill No</th>
									<th>Bill Date</th>
									
									<th>Taxable Amt</th>
									<th>Tax Rate</th>
									<th>IGST</th>
									<th>CGST</th>
									<th>SGST</th>
									<th>Bill Amount</th>
									<th>CESS</th>
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
	function billWiseTaxReport()
	{ 
		$('#table_grid td').remove();
		
		
		var isValid = validate();
		
		if (isValid) {

			document.getElementById('btn_pdf').style.display = "block";
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			   
			
			$.getJSON('${getBillWiseTaxReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},function(data) {

								$('#loader').hide();
								var len = data.length;


								$('#table_grid td').remove();

								$.each(data,function(key, billWiseTaxData) {
									
									 var partyname="GFPL";
                                     var gstNo="#012";

								var tr = $('<tr></tr>');

								tr.append($('<td></td>').html(key+1));

							  	tr.append($('<td></td>').html(partyname));

							  	tr.append($('<td></td>').html(gstNo));

							  	tr.append($('<td></td>').html(billWiseTaxData.billNo));

							  	tr.append($('<td></td>').html(billWiseTaxData.billDate));

								tr.append($('<td></td>').html(billWiseTaxData.taxableAmt));

								tr.append($('<td></td>').html(billWiseTaxData.taxRate));
								
								tr.append($('<td></td>').html(billWiseTaxData.igstRs));

								tr.append($('<td></td>').html(billWiseTaxData.cgstRs));

								tr.append($('<td></td>').html(billWiseTaxData.sgstRs));

								tr.append($('<td></td>').html(billWiseTaxData.grandTotal));

								tr.append($('<td></td>').html(billWiseTaxData.cess));

								
								$('#table_grid tbody').append(tr);

							});
							}
								


		);	
	}
	}
							/* function(data) {

								//$('#table_grid td').remove();
								
								

								if (data == "") {
									alert("No records found !!");

								}
								alert(data);

								
								$.each(data,function(key, billWiseTaxData) {

													var index = key + 1;

													var tr = "<tr>";

													var partyname="GFPL";

													var gstno="#00";
													
													
													
													var partyName = "<td>&nbsp;&nbsp;&nbsp;"
															+ partyname
															+ "</td>";
															
															var gstNo = "<td>&nbsp;&nbsp;&nbsp;"
																+ gstno
																+ "</td>";
																
																var billNo = "<td>&nbsp;&nbsp;&nbsp;"
																	+ billWiseTaxData.billNo
																	+ "</td>";
																	
																var billDate = "<td>&nbsp;&nbsp;&nbsp;"
																	+ billWiseTaxData.billDate
																	+ "</td>";

																

																		var taxableAmt = "<td>&nbsp;&nbsp;&nbsp;"
						 													+ billWiseTaxData.taxableAmt
						 													+ "</td>";
																			
						  													var taxRate = "<td>&nbsp;&nbsp;&nbsp;"
																				+ billWiseTaxData.taxRate
																				+ "</td>";

																				var igstAmt = "<td>&nbsp;&nbsp;&nbsp;"
								 													+ billWiseTaxData.igstRs
								 													+ "</td>";
																					
								  													var cgstAmt = "<td>&nbsp;&nbsp;&nbsp;"
																						+ billWiseTaxData.cgstRs
																						+ "</td>";

																					var sgstAmt = "<td>&nbsp;&nbsp;&nbsp;"
																						+ billWiseTaxData.sgstRs
																						+ "</td>";
																						

																				     var grandTotal = "<td>&nbsp;&nbsp;&nbsp;"
																					   + billWiseTaxData.grandTotal
																					  + "</td>";
                                                                                
																					  var CESS = "<td>&nbsp;&nbsp;&nbsp;"
																							+ billWiseTaxData.cess
																							+ "</td>";

													var trclosed = "</tr>";

													$('#table_grid tbody')
															.append(tr);
													$('#table_grid tbody')
															.append(partyName);
													
													$('#table_grid tbody')
													.append(gstNo);
													$('#table_grid tbody')
													.append(billNo);
													$('#table_grid tbody')
													.append(billDate);
													$('#table_grid tbody')
													.append(taxableAmt);
													$('#table_grid tbody')
													.append(taxRate);
													$('#table_grid tbody')
													.append(igstAmt);
													
													$('#table_grid tbody')
													.append(cgstAmt);
													
													$('#table_grid tbody')
													.append(sgstAmt);
													
													$('#table_grid tbody')
													.append(grandTotal);
													
													$('#table_grid tbody')
													.append(CESS);
													
													$('#table_grid tbody')
													.append(trclosed);
													
													

												})
													

							});

		}
	} */
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
