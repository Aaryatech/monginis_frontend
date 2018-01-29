<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>



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



<c:url var="getItemWiseReport" value="/findItemWiseReport" />
	
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
	    <div class="col-md-12"><h2 class="pageTitle">Item Wise Report</h2></div>
	</div>
	
	
	
<div class="row">
	
	<div class="col-md-2"><div class="pull-left">Group</div></div>
		<div class="col-md-5"><select name="catId" id="catId" class="form-control chosen"required>
              <option value=""selected>Select Group</option>
        
			 <c:forEach items="${catList}" var="catList">
                <option value="${catList.catId}"selected>${catList.catName}</option>
           </c:forEach>  
            </select>
			</div>
	</div>	
	
	</br>
	
	
	
	<div class="row">
	
		<div class="col-md-2 from_date">
		    <h4 class="pull-left">From Date:-</h4>
		</div>
		<div class="col-md-3 ">
			<input id="fromdatepicker" class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" name="fromDate" type="text">
		</div>
		<div class="col-md-2">
		    <h4 class="pull-left">To Date:-</h4>
		</div>
		<div class="col-md-3 ">
			<input id="todatepicker" class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" name="toDate" type="text">
		</div>
		<div class="col-md-2">
		    <button class="btn search_btn pull-left" onclick="itemWiseReport()">Search </button>
		   &nbsp;&nbsp;&nbsp; <a href='${pageContext.request.contextPath}/pdf?reportURL=showPurchaseItemwiseReportpPdf' id="btn_pdf" class="btn search_btn" style="display: none">PDF</a>
		 
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
									<th class="col-md-1">Party Name</th>
									<th class="col-md-1">Item Name</th>
									<th class="col-md-1">Qty</th>
									<th class="col-md-1">Rate</th>
									<th class="col-md-1">Amount</th>
								
								  </tr>
								</thead>
								<tbody>
								 
								  
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
	function itemWiseReport()
	{ 
		$('#table_grid td').remove();
		
		
		var isValid = validate();
		
		if (isValid) {

			document.getElementById('btn_pdf').style.display = "block";
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			var catId = document.getElementById("catId").value;   
			
		
			$.getJSON('${getItemWiseReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								catId: catId,
								ajax : 'true',

							},function(data) {

								$('#loader').hide();
								var len = data.length;
								if (data == "") {
									alert("No records found !!");
									  document.getElementById("expExcel").disabled=true;
								}

								$('#table_grid td').remove();

								$.each(data,function(key, itemWiseTaxData) {
									
									
									  document.getElementById("expExcel").disabled=false;
										document.getElementById('range').style.display = 'block';
									
										
								var partyname="GFPL";
									
								var tr = $('<tr></tr>');

								tr.append($('<td class="col-md-1"></td>').html(key+1));
								
								tr.append($('<td class="col-md-1"></td>').html(partyname));

							  	tr.append($('<td class="col-md-1"></td>').html(itemWiseTaxData.itemName));

								tr.append($('<td class="col-md-1"></td>').html(itemWiseTaxData.qty));

								tr.append($('<td class="col-md-1"></td>').html(itemWiseTaxData.rate));

								tr.append($('<td class="col-md-1"></td>').html(itemWiseTaxData.total));


								
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

								
								$.each(data,function(key, itemWiseTaxData) {

													var index = key + 1;
													
                                                    var partyname="GFPL";
                                                    
													var tr = "<tr>";

													var itemName = "<td>&nbsp;&nbsp;&nbsp;"
														+ itemWiseTaxData.itemName
														+ "</td>";

														var partyName = "<td>&nbsp;&nbsp;&nbsp;"
															+ partyname
															+ "</td>";
															
													   var billNo = "<td>&nbsp;&nbsp;&nbsp;"
															+ itemWiseTaxData.billNo
															+ "</td>";
															
																var billDate = "<td>&nbsp;&nbsp;&nbsp;"
																	+ itemWiseTaxData.billDate
																	+ "</td>";

																	var qty = "<td>&nbsp;&nbsp;&nbsp;"
																		+ itemWiseTaxData.qty
																		+ "</td>";
																		
																		var rate = "<td>&nbsp;&nbsp;&nbsp;"
																			+ itemWiseTaxData.rate
																			+ "</td>";

																		
																	var grandTotal = "<td>&nbsp;&nbsp;&nbsp;"
																		+ itemWiseTaxData.total
																		+ "</td>";

																		var grnType = "<td>&nbsp;&nbsp;&nbsp;"
						 													+ itemWiseTaxData.grnType
						 													+ "</td>";
																			
						  													

													var trclosed = "</tr>";

													$('#table_grid tbody')
															.append(tr);
													$('#table_grid tbody')
															.append(itemName);
													$('#table_grid tbody')
													.append(partyName);
													$('#table_grid tbody')
													.append(billNo);
													$('#table_grid tbody')
													.append(billDate);
													$('#table_grid tbody')
													.append(qty);
													$('#table_grid tbody')
													.append(rate);
													
													$('#table_grid tbody')
													.append(grandTotal);
													
													$('#table_grid tbody')
													.append(grnType);
													
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
	
	
</body>
</html>
