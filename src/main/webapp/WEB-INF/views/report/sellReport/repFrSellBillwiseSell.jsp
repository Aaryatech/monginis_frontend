
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

 
<body>

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

<c:url var="getBilwiselReport" value="/getBilwiselReport" />
	
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
	    <div class="col-md-12"><h2 class="pageTitle">View Billwise Report</h2></div>
	</div>
	
	<div class="colOuter">
		<div align="center" >
		<div class="col1"><div class="col1title"><b>From&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
		<input id="fromdatepicker"  placeholder="Delivery Date"  name="from_Date" type="text" size="35" >
		</div></div>
		<div class="col2"><div class="col1title"><b>TO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
		<input id="todatepicker"  placeholder="Delivery Date"  name="to_Date" type="text" size="35" >
		</div></div>
		<input type="hidden" name="frId" id="frId" value="${frId}">
	</div>
 
	
 	<div align="center"> 
		    <button class="btn search_btn" onclick="searchSellBill()" >HTML View </button>
		 
		    	   <%--  <a href='${pageContext.request.contextPath}/pdf?reportURL=showSellBillwiseReportpPdf' id="btn_pdf" class="btn search_btn" style="display: none">PDF</a> --%>
		 												<button class="btn btn-primary" value="PDF" id="PDFButton" onclick="genPdf()">PDF</button>
		 
		 
		<br>
    </div>
	</div>
	
	
	<div class="row">
		<div class="col-md-12">
		<!--table-->
			<div class="clearfix"></div>


				<div id="table-scroll" class="table-scroll">
					<div id="faux-table" class="faux-table" aria="hidden"></div>
					<div class="table-wrap">
						<table id="table_grid" class="main-table">
							<thead>
								<tr class="bgpink">

									<th class="col-md-1">Sr.No.</th>
									<th class="col-md-1">Bill No</th>
									<th class="col-md-1">Date</th>
									<th class="col-md-1">Amount</th>
									<th class="col-md-1">Payment Mode</th>
								<!-- 	<th class="col-md-1">Card</th>
									<th class="col-md-1">Other</th> -->
									
								  </tr>
								</thead>
								
								 <tbody >
								
								 </tbody>
								  
								</table>
						 	
				</div>
				<div class="form-group" style="display: none;" id="range">
								 
											 
											 
											<div class="col-sm-3  controls">
											 <input type="button" id="expExcel" class="btn btn-primary" value="EXPORT TO Excel" onclick="exportToExcel();" disabled="disabled">
											</div>
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
			//document.getElementById('btn_pdf').style.display = "block";
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
									  document.getElementById("expExcel").disabled=true;
								}
								 

							 //	var cashTotal=0;
							//	var cardTotal=0;
								var amtTotal=0;
								//var otherTotal=0;
								$.each(data,function(key, sellBillData) {

									  document.getElementById("expExcel").disabled=false;
										document.getElementById('range').style.display = 'block';
									
									

									var tr = $('<tr></tr>');

								  	tr.append($('<td class="col-md-1"></td>').html(key+1));
								  	
								  	tr.append($('<td class="col-md-1"></td>').html(sellBillData.sellBillNo));
								  	
								  	tr.append($('<td class="col-md-1"></td>').html(sellBillData.billDate));
								  	
								  	//var amt=sellBillData.cash + sellBillData.card + sellBillData.other;
								  	tr.append($('<td class="col-md-1"></td>').html(sellBillData.payableAmt));
								  	
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
									
								  	tr.append($('<td class="col-md-1"></td>').html(mode));
								  	

								  	

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

<script>
	
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

function exportToExcel()
{
	 
	window.open("${pageContext.request.contextPath}/exportToExcel");
			document.getElementById("expExcel").disabled=true;
}
	</script>
<script type="text/javascript">
function genPdf()
{
	var isValid=validate();
	if(isValid==true)
		{
	var fromDate = document.getElementById("fromdatepicker").value;
	var toDate = document.getElementById("todatepicker").value;
	var frId=document.getElementById("frId").value;
	window.open('${pageContext.request.contextPath}/pdf?reportURL=pdf/showSellBillwiseReportPdf/'+fromDate+'/'+toDate+'/'+frId);
	}

}

</script>	
</body>
</html>
