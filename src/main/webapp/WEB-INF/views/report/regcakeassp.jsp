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
	<c:url var="getRegCakeAsSpOrder" value="/getRegCakeAsSpOrder" />
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
					<h2 class="pageTitle">Regular Cake As Special Order</h2>

				</div>
				<form id="validation-form">
					<input type="hidden" value="${gstType}" name="type" id="type" />

					<div class="colOuter">
						<!-- copy div kalpesh -->

						<div class="calender-title">From</div>
						<div class="col-md-2">
							<input id="datepicker" class="texboxitemcode texboxcal"
								value="${cDate}" autocomplete="off" name="from_Date" type="text">
						</div>

						<div class="calender-title">TO</div>
						<div class="col-md-2">
							<input id="datepicker2" class="texboxitemcode texboxcal"
								value="${cDate}" autocomplete="off" name="to_Date" type="text">
						</div>

						<div class="col-md-1"></div>
						<div class="col-md-1">
							<button type="button" class="btn  buttonsaveorder"
								onclick="getReport()">Search</button>
						</div>

						<div class="col-md-1">
							<button type="button" class="btn  buttonsaveorder" id='pdf'
								onclick="genPdf()" disabled>Generate Pdf</button>
						</div>
					</div>

					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->

						<div id="table-scroll" class="table-scroll">
							<div id="faux-table" class="faux-table" aria="hidden">
								<table id="table_grid" class="main-table" border="1">
									<thead>
										<tr class="bgpink">
											<th class="col-md-1">Sr No</th>
											<th class="col-md-2">Item Name</th>
											<th class="col-md-1">Sub Category</th>
											<th class="col-md-1">MRP</th>
											<th class="col-md-1">Quantity</th>
											<th class="col-md-1">Sub Total</th>
											<th class="col-md-1">Customer Name</th>
											
										</tr>
									</thead>
								</table>
							</div>
							<div class="table-wrap">
								<table id="table_grid" class="main-table" border="1">
									<thead>
										<tr class="bgpink">
											<th class="col-md-1">Sr No</th>
											<th class="col-md-2">Item Name</th>
											<th class="col-md-1">Sub Category</th>
											<th class="col-md-1">MRP</th>
											<th class="col-md-1">Quantity</th>
											<th class="col-md-1">Sub Total</th>
											<th class="col-md-1">Customer Name</th>
										</tr>
									</thead>
									<tbody>
								</table>
							</div>
						</div>
					</div>
					<!--tabNavigation-->
				</form>
			</div>
			<!--rightSidebar-->
		</div>
		<!--fullGrid-->
	</div>
	<!--rightContainer-->
</div>
<!--wrapper-end-->

<script type="text/javascript">
		function getReport() {
			
			$('#table_grid td').remove();
				var fromDate = document.getElementById("datepicker").value;
				var toDate = document.getElementById("datepicker2").value;
				
				$.getJSON('${getRegCakeAsSpOrder}', {

					fromDate : fromDate,
					toDate : toDate,
					ajax : 'true'

				}, function(data) {
					$.each(data, function(key, report) {
						
						
						if(data!=null){
							 document.getElementById("pdf").disabled = false; 

						}
						var tr = $('<tr></tr>');
						
						tr.append($('<td class="col-md-1"></td>').html(key+1));
						tr.append($('<td class="col-md-2"></td>').html(report.itemName));
						tr.append($('<td class="col-md-1"></td>').html(report.subCatName));
						tr.append($('<td class="col-md-1" style="text-align:right;"></td>').html(report.mrp));
 						tr.append($('<td class="col-md-1"  style="text-align:right;"></td>').html(report.qty));
 						tr.append($('<td class="col-md-1"  style="text-align:right;"></td>').html(report.rspSubTotal.toFixed(2)));
						tr.append($('<td class="col-md-1"></td>').html(report.rspCustName));
						
					
$('#table_grid tbody')
	.append(
			tr);
			
})

});
				

			
//}//if block
}
		
document.getElementById("pdf").disabled = true;

	</script>




<script type="text/javascript">
		function validate() {
		
			var fromDate =$("#datepicker").val();
			var toDate =$("#datepicker2").val();
			
			var headeIdText=$("#headeIdText").val();
			alert(headeIdText);
			
			var isValid = true;
			if(headeIdText =="" || headeIdText == null){
				 isValid = false;
			}
			else if (fromDate == "" || fromDate == null) {

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

<script>

function genPdf() {
		    window.open('${pageContext.request.contextPath}/getRegCakeAsSpOrderPdf');
	}
	</script>

</body>
</html>