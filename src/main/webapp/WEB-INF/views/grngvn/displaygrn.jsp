<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	
	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<c:url var="getGrnList" value="/getGrnList" />
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
				<div class="sidebarright">
					<div class="order-left">
						<h2 class="pageTitle">GRN Details</h2>

					</div>
					
					
					<div class="colOuter"><!-- copy div kalpesh -->
					
							<div class="calender-title"></div>
						<div class="col-md-2">GRN Date -<b> ${grnDate}</b>
							
						</div>
					
							<%-- <div class="calender-title">TO</div>
						<div class="col-md-2">
							<input id="datepicker2" class="texboxitemcode texboxcal"
								value="${cDate}" name="to_Date" type="text">
						</div>
						 --%>
						<!-- <div class="col-md-1">
						<button type="button" class="btn  buttonsaveorder"  onclick="searchGRN()">Search</button>
						</div>
									 -->					
						</div>


					

					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->


				<div id="table-scroll" class="table-scroll">
					<div id="faux-table" class="faux-table" aria="hidden"></div>
					<div class="table-wrap">
						<table id="table_grid" class="main-table">
							<thead>
								<tr class="bgpink">

																<th class="col-md-1">Invoice No</th>
																<th class="col-md-2">Item Name</th>
																<th class="col-md-1">Rate</th>
																<th class="col-md-1">Quantity</th>
																<th class="col-md-1"> Type</th>
																<th class="col-md-1"> Amt</th>

																<th class="col-md-1">Tax %</th>

																<th class="col-md-1">Tax Amt</th>


																<th class="col-md-1">Amount</th>
																<th class="col-md-1">Status</th>

															</tr>
														</thead>
							<tbody>

															<c:forEach items="${grnList}" var="grnList"
																varStatus="count">
																<tr>
																	<td class="col-md-1"><c:out value="${grnList.invoiceNo}" /></td>
																	<td class="col-md-1"><c:out value="${grnList.itemName}" /></td>
																	<td class="col-md-1"><c:out value="${grnList.baseRate}" /></td>
																	<td class="col-md-1"><c:out value="${grnList.grnGvnQty}" /></td>
																	<c:choose>
																		<c:when test="${grnList.grnType==0}">
																			<td class="col-md-1"><c:out value="GRN 1"></c:out></td>
																		</c:when>
																		<c:when test="${grnList.grnType==1}">
																			<td class="col-md-1"><c:out value="GRN 2"></c:out></td>
																		</c:when>
																		<c:when test="${grnList.grnType==2}">
																			<td class="col-md-1"><c:out value="GRN 3"></c:out></td>
																		</c:when>
																		<c:when test="${grnList.grnType==3}">
																			<td class="col-md-1"><c:out value="No GRN"></c:out></td>
																		</c:when>
																		<c:when test="${grnList.grnType==4}">
																			<td class="col-md-1"><c:out value="GRN 3"></c:out></td>
																		</c:when>
																	</c:choose>
																	
																	
																	<td class="col-md-1">
																	<fmt:formatNumber type="number"
												minFractionDigits="2" maxFractionDigits="2"
												value="${grnList.taxableAmt}" />
																	
																	<%-- <c:out value="${grnList.taxableAmt}" /> --%></td>
																	<td class="col-md-1"><c:out
																			value="${grnList.sgstPer + grnList.cgstPer}" /></td>
																	<td class="col-md-1">
																	<fmt:formatNumber type="number"
												minFractionDigits="2" maxFractionDigits="2"
												value="${grnList.totalTax}" />
																	
																	<%-- <c:out value="${grnList.totalTax}" /> --%></td>
																	
																	
																	<td class="col-md-1">	<fmt:formatNumber  type="number"
												minFractionDigits="2" maxFractionDigits="2"
												value="${grnList.grnGvnAmt}" />
																	<%-- <c:out value="${grnList.grnGvnAmt}" /> --%></td>
																	
																	<c:choose>
																		<c:when test="${grnList.grnGvnStatus==1}">
																			<td class="col-md-1"><c:out value="Pending"></c:out></td>
																		</c:when>
																		<c:when test="${grnList.grnGvnStatus==2}">
																			<td class="col-md-1"><c:out value="Pending"></c:out></td>
																		</c:when>
																		<c:when test="${grnList.grnGvnStatus==3}">
																			<td class="col-md-1"><c:out value="Reject By Dispatch"></c:out></td>
																		</c:when>
																		
																		<c:when test="${grnList.grnGvnStatus==4}">
																			<td class="col-md-1"><c:out value="Pending"></c:out></td>
																		</c:when>
																		
																		<c:when test="${grnList.grnGvnStatus==5}">
																			<td class="col-md-1"><c:out value="Reject By Store"></c:out></td>
																		</c:when>
																		<c:when test="${grnList.grnGvnStatus==6}">
																			<td class="col-md-1"><c:out value="Approved"></c:out></td>
																		</c:when>
																		<c:when test="${grnList.grnGvnStatus==7}">
																			<td class="col-md-1"><c:out value="Reject By Acc"></c:out></td>
																		</c:when>
																		
																	</c:choose>
																																													
																</tr>
															</c:forEach>

														

							</tbody>

						</table>
					</div>
				</div>



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


	


	<script type="text/javascript">
		function searchGRN() {

			$('#table_grid td').remove();

			var isValid = validate();

			if (isValid) {

				var fromDate = document.getElementById("datepicker").value;
				var toDate = document.getElementById("datepicker2").value;

				$.getJSON('${getGrnList}', {

					fromDate : fromDate,
					toDate : toDate,
					ajax : 'true'

				}, function(data) {

					//$('#table_grid td').remove();

					if (data == "") {
						alert("No records found !!");

					}

					$.each(data, function(key, grndata) {
						
						var tr = $('<tr></tr>');
						var calcTaxPer=parseFloat(grndata.sgstPer)+parseFloat(grndata.cgstPer);
						
						var grnType;
						var grnStatus;
						if(grndata.grnType==0)
							grnType="GRN 1";
						if(grndata.grnType==1)
							grnType="GRN 2";
								if(grndata.grnType==2)
									grnType="GRN 3";
								if(grndata.grnType==3)
									grnType="No GRN";
								if(grndata.grnType==4)
									grnType="GRN 4";
								
								if(grndata.grnGvnStatus==1)
									grnStatus="Pending";
								if(grndata.grnGvnStatus==2)
									grnStatus="Pending";
								if(grndata.grnGvnStatus==3)
									grnStatus="Reject By Dispatch";
								if(grndata.grnGvnStatus==4)
									grnStatus="Pending";
								if(grndata.grnGvnStatus==5)
									grnStatus="Reject By Store";
								if(grndata.grnGvnStatus==6)
									grnStatus="Approved";
								if(grndata.grnGvnStatus==7)
									grnStatus="Reject By Acc";
								

						tr.append($('<td class="col-md-1"></td>').html(grndata.billNo));
						tr.append($('<td class="col-md-2"></td>').html(grndata.itemName));
						tr.append($('<td class="col-md-1"></td>').html(grndata.baseRate));
						tr.append($('<td class="col-md-1"></td>').html(grndata.grnGvnQty));
						tr.append($('<td class="col-md-1"></td>').html(grnType));
						tr.append($('<td class="col-md-1"></td>').html(grndata.taxableAmt.toFixed(2)));
						tr.append($('<td class="col-md-1"></td>').html(calcTaxPer));
						tr.append($('<td class="col-md-1"></td>').html(grndata.totalTax.toFixed(2)));
						tr.append($('<td class="col-md-1"></td>').html(grndata.grnGvnAmt.toFixed(2)));
						tr.append($('<td class="col-md-1"></td>').html(grnStatus));


/* 
						var index = key + 1;

						var tr = "<tr>";

						var srNo = "<td>&nbsp;&nbsp;&nbsp;" + index + "</td>";

						var billNo = "<td>&nbsp;&nbsp;&nbsp;" + grndata.billNo
								+ "</td>";
						var grnGvnDate = "<td>&nbsp;&nbsp;&nbsp;"
								+ grndata.grnGvnDate + "</td>";
						var itemName = "<td>&nbsp;&nbsp;&nbsp;"
								+ grndata.itemName + "</td>";

						var itemRate = "<td>&nbsp;&nbsp;&nbsp;"
								+ grndata.baseRate + "</td>";

						var grnGvnQty = "<td>&nbsp;&nbsp;&nbsp;"
								+ grndata.grnGvnQty + "</td>";

						if (grndata.grnType == 0) {
							var grnType = "<td>&nbsp;&nbsp;&nbsp;" + "Grn 1"
									+ "</td>";
						}
						if (grndata.grnType == 1) {
							var grnType = "<td>&nbsp;&nbsp;&nbsp;" + "Grn 2"
									+ "</td>";
						}
						if (grndata.grnType == 2) {
							var grnType = "<td>&nbsp;&nbsp;&nbsp;" + "Grn 3"
									+ "</td>";
						}
						
						var grnAmt = "<td>&nbsp;&nbsp;&nbsp;"
							+ grndata.taxableAmt + "</td>";
							
				var calcTaxPer=parseFloat(grndata.sgstPer)+parseFloat(grndata.cgstPer);
				
				var grnTaxPer = "<td>&nbsp;&nbsp;&nbsp;"
					+calcTaxPer + "</td>";

					
					var taxAmt = "<td>&nbsp;&nbsp;&nbsp;"
						+ grndata.totalTax + "</td>";
						
						var amount = "<td>&nbsp;&nbsp;&nbsp;"
								+ grndata.grnGvnAmt + "</td>";
								
								
								
								
								if (grndata.grnGvnStatus == 1) {
									var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;" + "Pending"
											+ "</td>";
								}
								
								if (grndata.grnGvnStatus == 2) {
									var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;" + "Approved By Gate "
											+ "</td>";
								}
								
								if (grndata.grnGvnStatus == 3) {
									var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;" + "Reject By Gate"
											+ "</td>";
								}
								
								if (grndata.grnGvnStatus == 4) {
									var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;" + "Approved By Store"
											+ "</td>";
								}
								
								if (grndata.grnGvnStatus == 5) {
									var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;" + "Reject By Store"
											+ "</td>";
								}
								
								if (grndata.grnGvnStatus == 6) {
									var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;" + "Approved By Account"
											+ "</td>";
								}
								
								if (grndata.grnGvnStatus == 7) {
									var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;" + "Reject By Account"
											+ "</td>";
								}
								
							
						var trclosed = "</tr>";

						$('#table_grid tbody').append(tr);
						$('#table_grid tbody').append(srNo);

						$('#table_grid tbody').append(billNo);
						$('#table_grid tbody').append(grnGvnDate);
						$('#table_grid tbody').append(itemName);
						$('#table_grid tbody').append(itemRate);
						$('#table_grid tbody').append(grnGvnQty);
						$('#table_grid tbody').append(grnType);
						
						$('#table_grid tbody').append(grnAmt);

						$('#table_grid tbody').append(grnTaxPer);

						$('#table_grid tbody').append(taxAmt);

						$('#table_grid tbody').append(amount);

						$('#table_grid tbody').append(grnGvnStatus);

						$('#table_grid tbody').append(trclosed);
 */$('#table_grid tbody')
	.append(
			tr);

})

});

}
}
	</script>



	<script type="text/javascript">
		function validate() {
		
		
			var fromDate =$("#datepicker").val();
			var toDate =$("#datepicker2").val();
			

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




</body>
</html>