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
	<c:url var="getOtherBillBetweenDate" value="/getOtherBillBetweenDate" />
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
					<h2 class="pageTitle">Other Bills</h2>

				</div>
				<form id="validation-form">

					<div class="colOuter">
						<!-- copy div kalpesh -->

						<div class="calender-title">From</div>
						<div class="col-md-2">
							<input id="datepicker" class="texboxitemcode texboxcal"
								value="${cDate}" name="from_Date" type="text">
						</div>

						<div class="calender-title">TO</div>
						<div class="col-md-2">
							<input id="datepicker2" class="texboxitemcode texboxcal"
								value="${cDate}" name="to_Date" type="text">
						</div>

 

						<div class="col-md-1">
							<button type="button" class="btn  buttonsaveorder"
								onclick="serchOtherBill()">Search</button>
						</div>

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
										<th class="col-md-2">Sr No</th>
											<th class="col-md-2">Invoice No</th>
											<th class="col-md-1">Date</th>
											<th class="col-md-2">Discount</th>
											<th class="col-md-2">Taxable Amt</th>
											<th class="col-md-2">Tax Amt</th>
											<th class="col-md-2">Grand Total</th> 
											<th class="col-md-2">Action</th>

										</tr>
									</thead>
									<tbody>
 
									</tbody>

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
		function searchGRN() {

			$('#table_grid td').remove();
			var headeIdText=$("#headeIdText").val();
			
			//if(!headeIdText==null || headeIdText=="")
			//var isValid = validate();

			//if (isValid) {

				var fromDate = document.getElementById("datepicker").value;
				var toDate = document.getElementById("datepicker2").value;
				//var headeIdText=$("#headeIdText").val();
				
				
				//var headerCheckBox = document.getElementById("headerCheckBox").value;
				//alert("CHK "+headerCheckBox);

				$.getJSON('${getGrnList}', {

					fromDate : fromDate,
					toDate : toDate,
					headerId : headeIdText,
					ajax : 'true'

				}, function(data) {

					//$('#table_grid td').remove();
document.getElementById("headeIdText").value=0;
					if (data == "") {
						alert("No records found !!");

					}

					$.each(data, function(key, grndata) {

						
						var tr = $('<tr></tr>');
						
						var grnStatus;
								
								if(grndata.grngvnStatus==1)
									grnStatus="Pending";
								else if(grndata.grngvnStatus==2)
									grnStatus="Pending";
								else if(grndata.grngvnStatus==3)
									grnStatus="Reject By Dispatch";
								else if(grndata.grngvnStatus==4)
									grnStatus="Pending";
								else if(grndata.grngvnStatus==5)
									grnStatus="Reject By Store";
								else if(grndata.grngvnStatus==6)
									grnStatus="Approved";
								else if(grndata.grngvnStatus==7)
									grnStatus="Reject By Acc";
								
								else(grndata.grngvnStatus==8)
									grnStatus="Partially Approved";
								
								var isCredit;
								if(grndata.isCreditNote==1)
									isCredit="Yes";
								if(grndata.isCreditNote==0)
									isCredit="Pending";
								

						tr.append($('<td class="col-md-2"></td>').html(grndata.grngvnSrno));
						tr.append($('<td class="col-md-1"></td>').html(grndata.grngvnDate));
						tr.append($('<td class="col-md-2"></td>').html(grndata.taxableAmt));
						tr.append($('<td class="col-md-2"></td>').html(grndata.taxAmt));
						tr.append($('<td class="col-md-2"></td>').html(grndata.totalAmt));
						tr.append($('<td class="col-md-2"></td>').html(grndata.aprGrandTotal));
						tr.append($('<td class="col-md-2"></td>').html(grnStatus));
						
						tr.append($('<td class="col-md-2"></td>').html(isCredit));

						tr.append($('<td class="col-md-2"></td>').html(grndata.creditNoteId));	

						

						//tr.append($('<td class="col-md-2"></td>').html("<input type='button' onclick='getGrnDetail("+grndata.grnGvnHeaderId+")' id='grnDetailButton' value='Detail'>"));
						
							tr.append($('<td ><a href="#" class="action_btn" onclick="getGrnDetail('+grndata.grnGvnHeaderId+')"><abbr title="Detail"><i class="fa fa-list"></i></abbr></a></td>'));

						//tr.append($('<td class="col-md-2"><a href=''#' class='action_btn' onclick='getGrnDetail("+grndata.grnGvnHeaderId+")'> <abbr title='Detail'><i class="fa fa-trash"></i></abbr></a></td>'));
$('#table_grid tbody')
	.append(
			tr);
			
})

});
				

			
//}//if block
}
		
	
	</script>


<script type="text/javascript">

function getGrnDetail(headerId){
			//alert("HIII");
			//alert("header ID "+headerId)
		    var form = document.getElementById("validation-form");
		    form.action ="getGrnDetailList/"+headerId;
		    form.submit();
		}
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

function serchOtherBill()
{
	var fromDate=document.getElementById("datepicker").value;
	var toDate=document.getElementById("datepicker2").value; 
	$
	.getJSON(
			'${getOtherBillBetweenDate}',

			{
				 
				fromDate : fromDate,
				toDate : toDate, 
			
				ajax : 'true'

			},
			function(data) {
				
				$('#table_grid td').remove(); 
				  
			  $.each(
							data,
							function(key, itemList) {
							

								var tr = $('<tr></tr>');
								 
							  	tr.append($('<td></td>').html(key+1));
							  	tr.append($('<td></td>').html(itemList.invoiceNo));
							  	tr.append($('<td></td>').html(itemList.billDate));  
							  	tr.append($('<td></td>').html(itemList.discAmt)); 
							  	tr.append($('<td></td>').html(itemList.taxableAmt)); 
							  	tr.append($('<td></td>').html(itemList.totalTax));
							  	tr.append($('<td></td>').html(itemList.grandTotal));
							    $('#table_grid tbody').append(tr);

								 

							})  
						 
				
			});
	
	
}

	</script>




</body>
</html>