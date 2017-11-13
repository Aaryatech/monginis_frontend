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

<c:url var="getDatewiseTaxSellReport" value="/getDatewiseTaxSellReport" />
	
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
	    <div class="col-md-12"><h2 class="pageTitle">View Sell Tax Date wise Report</h2></div>
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
		    <button class="btn search_btn" onclick="searchSellBill()" >HTML View </button>
		    <button class="btn search_btn" onclick="showChart()" >Graph</button>
		    	    <button class="btn search_btn" onclick="showPdf()" >PDF </button>
		</div>
		<br>
    </div>
	
	<div class="row" id="table">
		<div class="col-md-12">
		<!--table-->
			<div class="table-responsive">
				<div class="shInnerwidth">
					
								<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid" class="table table-bordered">
								<thead >
									<tr class="bgpink">
									<th align="right" style="width:100px">Sr no.</th>
									<!-- <th align="center">Bill No</th> -->
									<th align="center">Date</th>
									<th align="center">Tax Rate</th>
									<th align="center">Taxable Amount</th>
									<th align="center">IGST</th>
								 	<th align="center">CGST</th>
									<th align="center">SGST</th> 
									<th align="center">CESS</th> 
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

	<div id="chart"  ">
	<hr>
        
    <br><br>
    <div id="chart_div" style="width: 100%; height: 500px;"></div>
			 
				 
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
	function searchSellBill()
	{ 
		document.getElementById('table').style.display = "block";
		   document.getElementById('chart').style="display:none";
		  // document.getElementById('showchart').style.display = "block";
		$('#table_grid td').remove();
		
		
		var isValid = validate();
		
		if (isValid) {
			
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			   
			
			$.getJSON('${getDatewiseTaxSellReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {

								 
								
								

								if (data == "") {
									alert("No records found !!");

								}
								 

							 	var taxTotal=0;
								var igstTotal=0;
								var cgstTotal=0;
								var sgstTotal=0;
								var cessTotal=0;
							
								$.each(data,function(key, sellTaxData) {

									
									
									
									var tr = $('<tr></tr>');

								  	tr.append($('<td></td>').html(key+1));
								  	

								  	tr.append($('<td></td>').html(sellTaxData.billDate));
								  	

									tr.append($('<td></td>').html(sellTaxData.tax_per));
									
								   	tr.append($('<td></td>').html(sellTaxData.tax_amount));
								  	taxTotal=taxTotal + sellTaxData.tax_amount;
								  	
								  	
									tr.append($('<td></td>').html(sellTaxData.igst));
									igstTotal=igstTotal + sellTaxData.igst;
									
								  	tr.append($('<td></td>').html(sellTaxData.cgst));
								  	cgstTotal=cgstTotal + sellTaxData.cgst;

								  	tr.append($('<td></td>').html(sellTaxData.sgst));
								  	sgstTotal=sgstTotal + sellTaxData.sgst;
								  	
								  	tr.append($('<td></td>').html(sellTaxData.sess));
								  	cessTotal=cessTotal + sellTaxData.sess;

								  	

									$('#table_grid tbody').append(tr);

									
									
													

												})
												
							var tr = "<tr>";
								 var total = "<td colspan='3'>&nbsp;&nbsp;&nbsp;<b> Total</b></td>";
								 
								 
								
								var totalTax = "<td>&nbsp;&nbsp;&nbsp;<b>"
									+ taxTotal
									+ "</b></td>";
								
								var igst = "<td><b>&nbsp;&nbsp;&nbsp;"
										+  igstTotal
										+ "</b></td>";
								 var cgst = "<td><b>&nbsp;&nbsp;&nbsp;"
									+  cgstTotal
									+ "</b></td>";
								var sgst = "<td><b>&nbsp;&nbsp;&nbsp;"
									+ sgstTotal
									+ "</b></td>";
								var cess = "<td><b>&nbsp;&nbsp;&nbsp;"
									+ cessTotal
									+ "</b></td>"; 
									
								
								var trclosed = "</tr>";
								
								
								$('#table_grid tbody')
								.append(tr);
								$('#table_grid tbody')
								.append(total);
								
							
								$('#table_grid tbody')
								.append(totalTax)
								
								 $('#table_grid tbody')
									.append(igst);
								 $('#table_grid tbody')
								.append(cgst);
								$('#table_grid tbody')
								.append(sgst); 
								$('#table_grid tbody')
								.append(cess); 
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
	<script type="text/javascript">
	 
function showChart(){
		
	//$("#PieChart_div").empty();
	$("#chart_div").empty();
		document.getElementById('chart').style.display = "block";
		   document.getElementById("table").style="display:none";
		   
		   var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			   
			var isValid = validate();
			
			if (isValid) {
			$.getJSON('${getDatewiseTaxSellReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {
								 //alert(data);
							 if (data == "") {
									alert("No records found !!");

								}
							 var i=0;

							 google.charts.load('current', {'packages':['corechart', 'bar']});
							 google.charts.setOnLoadCallback(drawStuff);

							 function drawStuff() {
 
							   var chartDiv = document.getElementById('chart_div');
							   document.getElementById("chart_div").style.border = "thin dotted red";
						       var dataTable = new google.visualization.DataTable();
						       
						       dataTable.addColumn('string', 'Date & Tax %'); // Implicit domain column.
						       dataTable.addColumn('number', 'Total Tax'); // Implicit data column.
						       dataTable.addColumn({type:'string', role:'interval'});
						       dataTable.addColumn({type:'string', role:'interval'});
						       dataTable.addColumn('number', 'Taxable Amount');
						       $.each(data,function(key, item) {

									var tax=item.cgst + item.sgst;
									var date= item.billDate+'\nTax : ' + item.tax_per + '%';
									
								   dataTable.addRows([
									 
								             [date, tax, "cgst : "+item.cgst,  "sgst : "+item.sgst ,   item.tax_amount, ]
								           
								           ]);
								     }) 
						    
 var materialOptions = {
          width: 700,
          chart: {
            title: 'Date wise Tax Graph',
            subtitle: 'Total tax & Taxable Amount per day'
          },
          series: {
            0: { axis: 'distance' }, // Bind series 0 to an axis named 'distance'.
            1: { axis: 'brightness' } // Bind series 1 to an axis named 'brightness'.
          },
          axes: {
            y: {
              distance: {label: 'Total Tax'}, // Left y-axis.
              brightness: {side: 'right', label: 'Taxable Amount'} // Right y-axis.
            }
          }
        };
						       
						       function drawMaterialChart() {
						           var materialChart = new google.charts.Bar(chartDiv);
						           materialChart.draw(dataTable, google.charts.Bar.convertOptions(materialOptions));
						          // button.innerText = 'Change to Classic';
						          // button.onclick = drawClassicChart;
						         }
						       
						      /*  var chart = new google.visualization.ColumnChart(
						                document.getElementById('chart_div'));
						       chart.draw(dataTable,
						          {width: 800, height: 600, title: 'Tax Summary Chart'}); */
						       drawMaterialChart();
							 };
							 
										
							  	});
			}
}
</script>
</body>
</html>
