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
<style type="text/css">
.hide-calendar .ui-datepicker-calendar {
    display: none;
}
</style>

</head>
<body>

<c:url var="monthWisePurchaseReport" value="/getMonthWisePurchaseReport" />
	
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
	    <div class="col-md-12"><h2 class="pageTitle">MonthWise Purchase Report</h2></div>
	</div>
	
	<div class="row">
	
		<div class="col-md-2">
		    <h4 class="pull-left">Month From :-</h4>
		</div>
		<div class="col-md-2 ">
                  <input type='text' placeholder="Select From Month" id='txtDate' name="from_stockdate" required />		</div>
		<div class="col-md-2">
		    <h4 class="pull-left">To Month:-</h4>
		</div>
		<div class="col-md-2 ">
			<input type='text' placeholder="Select To Month" id=txtDateto name="to_stockdate" required />
		</div>
		<!-- <div class="col-md-2">
		    <button class="btn search_btn pull-left" onclick="monthWisePurchase()">Search </button>
		</div> -->
			<div align="center">
		    <button class="btn search_btn" onclick="monthWisePurchase()" >HTML View </button>
		    <button class="btn search_btn" onclick="showChart()" >Graph</button>
		    	    <button class="btn search_btn" onclick="showPdf()" >PDF </button>
		</div>
		
    </div>
	
	<div class="row" id="table">
		<div class="col-md-12">
		<!--table-->
			<div class="table-responsive">
				<div class="shInnerwidth">
					
								<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid" class="table table-bordered">
									<tr class="bgpink">
									
									<th>Sr.No.</th>
									<th>MONTH</th>
									<th>Taxable Amt</th>
									<th>IGST</th>
									<th>CGST</th>
									<th>SGST</th>
									<th>CESS</th>
									<th>ROFF</th>
									<th>TOTAL</th>
								
								  </tr>
								
								 
								  
								</table>
						
				</div>
			</div>
		<!--table end-->
		 
		</div>	
    </div>

<div id="chart"  >
	<hr><div  >
	 
			 
   
    <div  id="chart_div" style="width:60%; height:300; float:left;" style="overflow-y: scroll;"></div> 
		 
			<div   id="pieChart_div" style="width:40%%; height:300; float: right;" ></div> 
			<div   id="Piechart" style="width:40%%; height:300; float: right;" ></div> 
			<!-- <div   id="PieChart_div" style="width:40%%; height:300; float: right;" ></div>  -->
			</div>
			<!-- <hr style="height:1px; width:50%%;" color="black">
			<div class="colOuter" >
			 
				<div   id="PieChart_div" style="width:100%; height:300;" align="center" ></div>
				</div> -->
				 
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
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<!--easyTabs-->

	
	<script type="text/javascript">
	function monthWisePurchase()
	{ 
		$('#table_grid td').remove();
		
		
		document.getElementById('table').style.display = "block";
		   document.getElementById('chart').style="display:none";
			
			var fromDate = document.getElementById("txtDate").value;
			var toDate = document.getElementById("txtDateto").value;
			   
			
			$.getJSON('${monthWisePurchaseReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {

								$('#loader').hide();
								var len = data.length;


								$('#table_grid td').remove();

								$.each(data,function(key, monthWisePurchaseData) {
									
									var index = key + 1;
									
								    var monthNumber = monthWisePurchaseData.month;
									    
								    var monthNames = ['0','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

								var tr = $('<tr></tr>');

								tr.append($('<td></td>').html(index));


							  	tr.append($('<td></td>').html(monthNames[monthNumber]));


							  	tr.append($('<td></td>').html(monthWisePurchaseData.taxableAmt));

							  	tr.append($('<td></td>').html(monthWisePurchaseData.igstRs));

								tr.append($('<td></td>').html(parseFloat(Math.round(monthWisePurchaseData.cgstRs * 100) / 100).toFixed(2)));

								tr.append($('<td></td>').html(parseFloat(Math.round(monthWisePurchaseData.sgstRs * 100) / 100).toFixed(2)));

								tr.append($('<td></td>').html(monthWisePurchaseData.sess));


								tr.append($('<td></td>').html(monthWisePurchaseData.roundOff));

								tr.append($('<td></td>').html(monthWisePurchaseData.grandTotal));

								
								$('#table_grid tbody').append(tr);

							});
							}
								


		);	
	}
	
							/* function(data) {

								//$('#table_grid td').remove();
								
								

								if (data == "") {
									alert("No records found !!");

								}
								alert(data);

								
								$.each(data,function(key, monthWisePurchaseData) {

													var index = key + 1;

													var tr = "<tr>";

												    var monthNumber = monthWisePurchaseData.month;
												    
												    var monthNames = ['0','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
												
 
												  
													var month = "<td>&nbsp;&nbsp;&nbsp;"
															+ monthNames[monthNumber]
															+ "</td>";
															var taxableAmt = "<td>&nbsp;&nbsp;&nbsp;"
																+ monthWisePurchaseData.taxableAmt
																+ "</td>";
																var igstRs = "<td>&nbsp;&nbsp;&nbsp;"
																	+ monthWisePurchaseData.igstRs
																	+ "</td>";

																	var cgstRs = "<td>&nbsp;&nbsp;&nbsp;"
																		+parseFloat(Math.round(monthWisePurchaseData.cgstRs * 100) / 100).toFixed(2);
																		+ "</td>";

																		var sgstRs = "<td>&nbsp;&nbsp;&nbsp;"
						 													+   parseFloat(Math.round(monthWisePurchaseData.sgstRs * 100) / 100).toFixed(2);
						 													+ "</td>";
																			
						  													var SESS = "<td>&nbsp;&nbsp;&nbsp;"
																				+ monthWisePurchaseData.sess
																				+ "</td>";

																			var roff = "<td>&nbsp;&nbsp;&nbsp;"
																				+ monthWisePurchaseData.roundOff
																				+ "</td>";
																				
																				var total = "<td>&nbsp;&nbsp;&nbsp;"
																					+ monthWisePurchaseData.grandTotal
																					+ "</td>";	


													

													var trclosed = "</tr>";

													$('#table_grid tbody')
															.append(tr);
													$('#table_grid tbody')
															.append(month);
													$('#table_grid tbody')
													.append(taxableAmt);
													$('#table_grid tbody')
													.append(igstRs);
													$('#table_grid tbody')
													.append(cgstRs);
													$('#table_grid tbody')
													.append(sgstRs);
													$('#table_grid tbody')
													.append(SESS);
													$('#table_grid tbody')
													.append(roff);
													
													$('#table_grid tbody')
													.append(total);
													
													$('#table_grid tbody')
													.append(trclosed);
													
													

												})
													

							});

		
	} */
	</script>
<!-- <script type="text/javascript">
	function validate() {
	
	
		var fromDate =$("#txtDate").val();
		var toDate =$("#txtDateto").val();
		

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
</script> -->
<!-- 	Select Only Month and Year 
 --><script>

$(document).ready(function() {
   $('#txtDate').datepicker({
     changeMonth: true,
     changeYear: true,
     dateFormat: 'mm/yy',
       
     
     onClose: function() {
        var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
     },
       
     beforeShow: function() {
         $('#ui-datepicker-div').addClass('hide-calendar');

    	 
       if ((selDate = $(this).val()).length > 0) 
       {
          iYear = selDate.substring(selDate.length - 4, selDate.length);
          iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
          $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
           $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
       }
    }
  });
});
</script>

<script>

$(document).ready(function() {
   $('#txtDateto').datepicker({
     changeMonth: true,
     changeYear: true,
     dateFormat: 'mm/yy',
       
     onClose: function() {
        var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
     },
       
     beforeShow: function() {
    	 
      //   $('#ui-datepicker-div').addClass('hide-calendar');

       if ((selDate = $(this).val()).length > 0) 
       {
          iYear = selDate.substring(selDate.length - 4, selDate.length);
          iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
          $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
           $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
       }
    }
  });
});
</script>

<script type="text/javascript">
	 
function showChart(){
		
	//$("#PieChart_div").empty();
	$("#chart_div").empty();
		document.getElementById('chart').style.display = "block";
		   document.getElementById("table").style="display:none";
		   
		   var fromDate = document.getElementById("txtDate").value;
			var toDate = document.getElementById("txtDateto").value;
			   
			
			$.getJSON('${monthWisePurchaseReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {

								$('#loader').hide();
								 //alert(data);
							 if (data == "") {
									alert("No records found !!");

								}
							 var i=0;

							 google.charts.load('current', {'packages':['corechart', 'bar']});
							 google.charts.setOnLoadCallback(drawStuff);
							 google.charts.setOnLoadCallback(drawAmtPieChart);
							 google.charts.setOnLoadCallback(drawTaxPieChart);
							  
							 function drawStuff() {
								 
								   var chartDiv = document.getElementById('chart_div');
								   document.getElementById("chart_div").style.border = "thin dotted red";
							       var dataTable = new google.visualization.DataTable();
							       
							       dataTable.addColumn('string', 'Month'); // Implicit domain column.
							       dataTable.addColumn('number', 'Amount'); // Implicit data column.
							      // dataTable.addColumn({type:'string', role:'interval'});
							     //  dataTable.addColumn({type:'string', role:'interval'});
							       dataTable.addColumn('number', 'Total Tax');
							       $.each(data,function(key, item) {
							    	   
							    	   var monthNumber = item.month;
									    
							    	   var monthNames = ['0','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];


										var totalTax = item.cgstRs + item.sgstRs;
									   dataTable.addRows([
										 
									             [monthNames[monthNumber], item.taxableAmt, totalTax, ]
									           
									           ]);
									     }) 
							    
	 var materialOptions = {
	          width: 600,
	          height:450,
	          chart: {
	            title: ' Taxable Amount & Total Tax',
	            subtitle: 'Tax percent wise Total Tax & Amount '
	          },
	          series: {
	            0: { axis: 'distance' }, // Bind series 0 to an axis named 'distance'.
	            1: { axis: 'brightness' } // Bind series 1 to an axis named 'brightness'.
	          },
	          axes: {
	            y: {
	              distance: {label: 'Taxable Amount'}, // Left y-axis.
	              brightness: {side: 'right', label: 'Total Tax'} // Right y-axis.
	            }
	          }
	        };
							     //  var materialChart = new google.charts.Bar(chartDiv);
							       
							        
							       
							       function drawMaterialChart() {
							           var materialChart = new google.charts.Bar(chartDiv);
							         //  google.visualization.events.addListener(materialChart, 'select', selectHandler);    
							           materialChart.draw(dataTable, google.charts.Bar.convertOptions(materialOptions));
							          // button.innerText = 'Change to Classic';
							          // button.onclick = drawClassicChart;
							         }
							         
							       drawMaterialChart();
							 
								 };
									
							 function drawAmtPieChart() {
								 
								   var chartDiv = document.getElementById('pieChart_div');
								   document.getElementById("pieChart_div").style.border = "thin dotted red";
							       var dataTable = new google.visualization.DataTable();
							       
							       dataTable.addColumn('string', 'Month'); // Implicit domain column.
							       dataTable.addColumn('number', 'Taxable Amount'); // Implicit data column.
							     //  dataTable.addColumn({type:'string', role:'interval'});
							     //  dataTable.addColumn({type:'string', role:'interval'});
							       //dataTable.addColumn('number', 'TaxableAmt');
							        $.each(data,function(key, item) {
							    	   
							    	   var monthNumber = item.month;
									    
							    	   var monthNames = ['0','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];


										var totalTax = item.cgstRs + item.sgstRs;
									   dataTable.addRows([
										 
									             [monthNames[monthNumber], item.taxableAmt, ]
									           
									           ]);
									     }) 
							    
							     

							       var chart = new google.visualization.PieChart(
							                document.getElementById('pieChart_div'));
							       chart.draw(dataTable,
							          {width: 400, height: 300, title: 'Taxable Amount'});
								   
								 };
								 function drawTaxPieChart() {
									 
									   var chartDiv = document.getElementById('Piechart');
									   document.getElementById("Piechart").style.border = "thin dotted red";
								       var dataTable = new google.visualization.DataTable();
								       
								       dataTable.addColumn('string', 'Month'); // Implicit domain column.
								       dataTable.addColumn('number', 'Total Tax'); // Implicit data column.
								     //  dataTable.addColumn({type:'string', role:'interval'});
								     //  dataTable.addColumn({type:'string', role:'interval'});
								       //dataTable.addColumn('number', 'TaxableAmt');
								        $.each(data,function(key, item) {
							    	   
							    	   var monthNumber = item.month;
									    
							    	   var monthNames = ['0','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];


										var totalTax = item.cgstRs + item.sgstRs;
									   dataTable.addRows([
										 
									             [monthNames[monthNumber],totalTax, ]
									           
									           ]);
									     }) 
							    
								     

								       var chart = new google.visualization.PieChart(
								                document.getElementById('Piechart'));
								       chart.draw(dataTable,
								          {width: 400, height: 300, title: 'Total tax'});
									   
									 };
										
							  	});
			}

</script>
</body>
</html>
