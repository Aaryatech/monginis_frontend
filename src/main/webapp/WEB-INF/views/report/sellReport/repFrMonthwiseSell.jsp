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
<script>
  $( function() {
    $( "#todatepicker" ).datepicker({ dateFormat: 'mm/yy' });
  } );
  $( function() {
    $( "#fromdatepicker" ).datepicker({ dateFormat: 'mm/yy' });
  } );
 
  </script>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>


</head>
<body>



<c:url var="getMonthwiselReport" value="/getMonthwiselReport" />
	
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
	    <div class="col-md-12"><h2 class="pageTitle">View Month wise Report</h2></div>
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
									<th align="center">Month</th>
									<th align="center">Amount</th>
									<th align="center">Cash</th>
								 	<th align="center">Card</th>
									<th align="center">Other</th> 
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

	<div id="chart" style="display: none">
	<hr><div  >
	 
			<div  id="chart_div" style="width:60%; height:300; float:left;" ></div> 
		 
			<div   id="Piechart" style="width:40%%; height:300; float: right;" ></div> 
			</div>
			 
			<div class="colOuter" align="center" >
			 <br>
				<div   id="PieChart_div" style="width:50%; height:400;" align="center" ></div>
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
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<!--easyTabs-->

	
	<script type="text/javascript">
	function searchSellBill()
	{ 
		document.getElementById('table').style.display = "block";
		   document.getElementById('chart').style="display:none";
		 //  document.getElementById('showchart').style.display = "block";
		$('#table_grid td').remove();
		
		
		var isValid = validate();
		
		if (isValid) {
			
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			   
			
			$.getJSON('${getMonthwiselReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {

								 
								
								

								if (data == "") {
									alert("No records found !!");

								}
								 

							 	var cashTotal=0;
								var cardTotal=0;
								var amtTotal=0;
								var otherTotal=0;
								$.each(data,function(key, sellBillData) {

									
									
									
									var tr = $('<tr></tr>');

								  	tr.append($('<td></td>').html(key+1));

								  	var monthNumber = sellBillData.month;
								    
								    var monthNames = ['0','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

							 tr.append($('<td></td>').html(monthNames[monthNumber]));
								  	
								  	var amt=sellBillData.cash + sellBillData.card + sellBillData.other;
								  	tr.append($('<td></td>').html(amt));
								  	
								  	amtTotal=amtTotal + sellBillData.cash + sellBillData.card + sellBillData.other;
									
								  	tr.append($('<td></td>').html(sellBillData.cash));
								  	cashTotal=cashTotal + sellBillData.cash;

								  	tr.append($('<td></td>').html(sellBillData.card));
								  	cardTotal=cardTotal + sellBillData.card;
								  	
								  	tr.append($('<td></td>').html(sellBillData.other));
								  	otherTotal=otherTotal + sellBillData.other;

								  	

									$('#table_grid tbody').append(tr);

									
									
													

												})
												
							var tr = "<tr>";
								 var total = "<td colspan='2'>&nbsp;&nbsp;&nbsp;<b> Total</b></td>";
								 
								var totalAmt = "<td>&nbsp;&nbsp;&nbsp;<b>"
									+ amtTotal
									+ "</b></td>";
								 var cash = "<td><b>&nbsp;&nbsp;&nbsp;"
									+  cashTotal
									+ "</b></td>";
								var card = "<td><b>&nbsp;&nbsp;&nbsp;"
									+ cardTotal
									+ "</b></td>";
								var other = "<td><b>&nbsp;&nbsp;&nbsp;"
									+ otherTotal
									+ "</b></td>"; 
									
								
								var trclosed = "</tr>";
								
								
								$('#table_grid tbody')
								.append(tr);
								$('#table_grid tbody')
								.append(total);
								$('#table_grid tbody')
								.append(totalAmt);
								 $('#table_grid tbody')
									.append(cash);
								 $('#table_grid tbody')
								.append(card);
								$('#table_grid tbody')
								.append(other); 
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
	$("#PieChart_div").empty();
	$("#chart_div").empty();
	$("#Piechart").empty();
	
		document.getElementById('chart').style.display = "block";
		   document.getElementById("table").style="display:none";
		   
		   var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			   
			var isValid = validate();
			
			if (isValid) {
			$.getJSON('${getMonthwiselReport}',{
				
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true',

							},
							function(data) {
								  
							 if (data == "") {
									alert("No records found !!");

								}
							 var i=0;
							 
							 //google.charts.load('current', {'packages':['corechart']});
							  google.charts.load('current', {'packages':['corechart', 'bar']});
							  google.charts.setOnLoadCallback(drawStuff);
							 google.charts.setOnLoadCallback(drawPie1Chart);
							 
							 
							  
							 function drawStuff() {
								 
								   var chartDiv = document.getElementById('chart_div');
								   document.getElementById("chart_div").style.border = "thin dotted red";
							       var dataTable = new google.visualization.DataTable();
							       
							       dataTable.addColumn('string', 'Month'); // Implicit domain column.
							       dataTable.addColumn('number', 'Amount'); // Implicit data column.
							      // dataTable.addColumn({type:'string', role:'interval'});
							     //  dataTable.addColumn({type:'string', role:'interval'});
							      // dataTable.addColumn('number', 'Total Tax');
								 $.each(data,function(key, item) {
									   
									   var monthNumber = item.month;
									    
									    var monthNames = ['0','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

								 
										var amt=item.cash + item.card + item.other;

									   dataTable.addRows([

									             [monthNames[monthNumber], amt]

									           ]);
									   

									   }) 
							    
	 var materialOptions = {
	          width: 600,
	          height:450,
	          chart: {
	            title: 'Sell Amount per Month ',
	            subtitle: ' '
	          },
	          series: {
	            0: { axis: 'distance' }, // Bind series 0 to an axis named 'distance'.
	            1: { axis: 'brightness' } // Bind series 1 to an axis named 'brightness'.
	          },
	          axes: {
	            y: {
	              distance: {label: 'Paid Amount'}, // Left y-axis.
	              brightness: {side: 'right', label: 'Total Tax'} // Right y-axis.
	            }
	          }
	        };
							       var materialChart = new google.charts.Bar(chartDiv);
							       
							        function selectHandler() {
						          var selectedItem = materialChart.getSelection()[0];
						          if (selectedItem) {
						            var topping = dataTable.getValue(selectedItem.row, 0);
						            //alert('The user selected ' + selectedItem.row,0);
						            i=selectedItem.row,0;
						            google.charts.setOnLoadCallback(drawBarChart);
						          }
						        }
							       
							       function drawMaterialChart() {
							          // var materialChart = new google.charts.Bar(chartDiv);
							           google.visualization.events.addListener(materialChart, 'select', selectHandler);    
							           materialChart.draw(dataTable, google.charts.Bar.convertOptions(materialOptions));
							          // button.innerText = 'Change to Classic';
							          // button.onclick = drawClassicChart;
							         }
							         
							       drawMaterialChart();
							 
								 };
							 function drawPie1Chart() {
								 var dataTable = new google.visualization.DataTable();
								 dataTable.addColumn('string', 'Topping');
								 dataTable.addColumn('number', 'Slices');
							        
						 
								   $.each(data,function(key, item) {
									   
									   var monthNumber = item.month;
									    
									    var monthNames = ['0','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

								 
										var amt=item.cash + item.card + item.other;

									   dataTable.addRows([

									             [monthNames[monthNumber], amt]

									           ]);
									   

									   }) 
							 var options = {'title':'Sell Amount per Month',
				                       'width':400,
				                       'height':250};
							 var chart = new google.visualization.PieChart(document.getElementById('Piechart'));
							 document.getElementById("Piechart").style.border = "thin dotted red";
							      function selectHandler() {
						          var selectedItem = chart.getSelection()[0];
						          if (selectedItem) {
						            var topping = dataTable.getValue(selectedItem.row, 0);
						            //alert('The user selected ' + selectedItem.row,0);
						            i=selectedItem.row,0;
						            google.charts.setOnLoadCallback(drawBarChart);
						          }
						        }

						        google.visualization.events.addListener(chart, 'select', selectHandler);    
						        chart.draw(dataTable, options);
						         
						      }
							 
							 function drawBarChart() {
								 var dataTable = new google.visualization.DataTable();
								 dataTable.addColumn('string', 'Topping');
								 dataTable.addColumn('number', 'Slices');
							        
							       
						 
							 
									   dataTable.addRows([

									             ['Cash', data[i].cash],
									             ['Card', data[i].card],
									             ['Other', data[i].other],

									           ]);

									//   }) 
							 var options = {'title':'Total Amount: Cash, Card and Other',
				                       'width':500,
				                       'height':350};
							 var chart = new google.visualization.PieChart(document.getElementById('PieChart_div'));
							 document.getElementById("PieChart_div").style.border = "thin dotted red";
						        function selectHandler() {
						          var selectedItem = chart.getSelection()[0];
						          if (selectedItem) {
						            var topping = dataTable.getValue(selectedItem.row, 0);
						          //  alert('The user selected ' + selectedItem.row,0);
						           
						          }
						        }

						        google.visualization.events.addListener(chart, 'select', selectHandler);    
						        chart.draw(dataTable, options);
				
							 }
										
							  	});
			}
			}
</script>
 

</body>
</html>
