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

<c:url var="getItemWiseDetailReport" value="/findItemWiseDetailReport" />
	
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
	    <div class="col-md-12"><h2 class="pageTitle">Item Wise Tax Report</h2></div>
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
		    <button class="btn search_btn pull-left" onclick="itemWiseTaxReport()">Search </button>
		   &nbsp;&nbsp;&nbsp; <a href='${pageContext.request.contextPath}/pdf?reportURL=showPurchaseItemwiseDetailPdf' id="btn_pdf" class="btn search_btn" style="display: none">PDF</a>
		 
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
									<th>Sr.No.</th>
									<th>Item Name</th>
									<th>Party Name</th>
									<th>Bill No</th>
									<th>Bill Date</th>
									<th>Qty</th>
									<th>Rate</th>
									<th>Amount</th>
									<th>GRN TYPE</th>
								
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
	function itemWiseTaxReport()
	{ 
		$('#table_grid td').remove();
		
		
		var isValid = validate();
		
		if (isValid) {

			document.getElementById('btn_pdf').style.display = "block";
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			var catId = document.getElementById("catId").value;   
			
			alert(catId);
			$.getJSON('${getItemWiseDetailReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								catId: catId,
								ajax : 'true',

							},function(data) {

								$('#loader').hide();
								var len = data.length;


								$('#table_grid td').remove();

								$.each(data,function(key, itemWiseTaxData) {
									
								var partyname="GFPL";
									
								var tr = $('<tr></tr>');

								tr.append($('<td></td>').html(key+1));

							  	tr.append($('<td></td>').html(itemWiseTaxData.itemName));

							  	tr.append($('<td></td>').html(partyname));

							  	tr.append($('<td></td>').html(itemWiseTaxData.billNo));

							  	tr.append($('<td></td>').html(itemWiseTaxData.billDate));

								tr.append($('<td></td>').html(itemWiseTaxData.qty));

								tr.append($('<td></td>').html(itemWiseTaxData.rate));

								tr.append($('<td></td>').html(itemWiseTaxData.total));

								tr.append($('<td></td>').html(itemWiseTaxData.grnType));

								

								
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
	
</body>
</html>
