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
	    <div class="col-md-12"><h2 class="pageTitle">View Bills</h2></div>
	</div>
	
	<div class="row">
	
		<div class="col-md-2 from_date">
		    <h4 class="pull-left">From Date:-</h4>
		</div>
		<div class="col-md-2 ">
			<input id="todatepicker" class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" name="" type="text">
		</div>
		<div class="col-md-1">
		    <h4 class="pull-left">To Date:-</h4>
		</div>
		<div class="col-md-2 ">
			<input id="fromdatepicker" class="texboxitemcode texboxcal" placeholder="DD-MM-YYYY" name="" type="text">
		</div>
		<div class="col-md-2">
		    <button class="btn search_btn pull-left">Search </button>
		</div>
		
    </div>
	<br/>
	
	<div class="row">
		<div class="col-md-12">
		<!--table-->
			<div class="table-responsive">
				<div class="shInnerwidth">
					
								<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid6" class="table table-bordered">
									<tr class="bgpink">
									<th >Bill.No</th>
									<th>Date</th>
							
									<th>Payable Amount</th>
									<th>Paid Amount</th>
									<th>Remaining Amount</th>
									<th>Paymode</th>
									<th>Action</th>
								  </tr>
								  <tr>
									<td>1</td>
									<td>9/28/2017</td>
								
									<td>40</td>
									<td><div class=class=col-md-1 pull-left><input type=number class=form-control  value="20" disabled id="paidAmt" name="paidAmt"></div></td>
									<td>20</td>
									<td>Card</td>
									<td>
										<a href="${pageContext.request.contextPath}/viewBillDetails" class="action_btn"><abbr title="Details"><i class="fa fa-list"></i></abbr></a>
									
									   <abbr title='save'><i class='fa fa-check-circle' style='visibility: hidden;' id="save" onclick="editEnable()"></i></abbr>
									
									   <abbr title="edit"><i class="fa fa-edit" id="edit" onclick="editDisable()"></i></abbr>
										
							           <abbr title="Delete"><i class="fa fa-trash"></i></abbr>
							           
							            <a href="#" class="action_btn"><abbr title="Print"><i class="fa fa-print"></i></abbr></a>
									</td>
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

	<script>
		function openNav() {
			document.getElementById("mySidenav").style.width = "100%";
		}

		function closeNav() {
			document.getElementById("mySidenav").style.width = "0";
		}
		function openNav1() {
			document.getElementById("mySidenav1").style.width = "100%";
		}

		function closeNav1() {
			document.getElementById("mySidenav1").style.width = "0";
		}
		function openNav3() {
			document.getElementById("mySidenav3").style.width = "100%";
		}

		function closeNav3() {
			document.getElementById("mySidenav3").style.width = "0";
		}
	</script>
	<script type="text/javascript">
	function editDisable(){
			
		$("#paidAmt").prop('disabled', false);
		
		$("#save").show();
		document.getElementById("save").style.visibility = "visible"; 
		
		document.getElementById("edit").style.visibility= "hidden"; 
		$("#edit").prop('disabled', true);
		
	}
	</script>
	<script type="text/javascript">
	function editEnable(){
			
		$("#paidAmt").prop('enabled', false);
		
 		$("#save").show();
		document.getElementById("save").style.visibility = "hidden"; 
		
		document.getElementById("edit").style.visibility= "visible"; 
		$("#edit").prop('disabled', true);
		
	}
	</script>
</body>
</html>
