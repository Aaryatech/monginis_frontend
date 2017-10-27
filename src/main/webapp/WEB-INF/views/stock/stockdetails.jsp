<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


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
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
	
	<link href="${pageContext.request.contextPath}/resources/css/monginis.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/resources/css/custom.css" rel="stylesheet" type="text/css"/>

<!--rightNav-->

<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#fromdatepicker").datepicker({ dateFormat: 'dd-mm-yy' });
	});
	$(function() {
		$("#todatepicker").datepicker({ dateFormat: 'dd-mm-yy' });
	});
</script>
<!--datepicker-->


</head>
<body>

	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<c:url var="findAddOnRate" value="/getAddOnRate" />
<c:url var="findItemsByCatId" value="/getFlavourBySpfId" />
<c:url var="findAllMenus" value="/getAllTypes" />
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


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
						<h2 class="pageTitle">Stok Details</h2>
						<!--<h3 class="pageTitle2">Order Date : 22-02-2017 </h3>-->
					</div>
						 <div class="colOuter">
				<div class="col1">
				<b>Select For Stock</b><select name="selectStock" class="form-control chosen" tabindex="6" id="selectStock" onchange="showDiv(this)" required>
             

							
								<option value="-1">Select Option</option>
								<option value="1" id="currentStock">Get Current Stock</option>
 								<option value="2" id="monthStock">Get Stock between Month</option>
  								<option value="3" id="dateStock">Get Stock between Dates</option>

							</select>
						</div>
						<div class="col2">
				<b>Select Category</b><select name="select_category" class="form-control chosen" tabindex="6" id="select_category" required>
             

							
								<option value="-1">Select Category</option>
								<c:forEach items="${category}" var="category"
									varStatus="count">
									<option value="${category.catId}"><c:out value="${category.catName}"/></option>
								</c:forEach>
						

							</select>
						</div>
					</div>
					
					<div class="colOuter" style="display:none" id=select_month_year>
			
					<b>Select Month From :  </b><input type='text' placeholder="Select From Month" id='txtDate' name="from_stockdate" required />
			<b>To  :  </b><input type='text' placeholder="Select To Month" id=txtDateto name="to_stockdate" required />
				
				
				<input name="search_stock" class="buttonsaveorder" value="Search..."
									type="button" onclick="searchStock()">
			
				</div>
		
								<div class="colOuter" style="display:none" id=select_date>
				
							<div class="col1">
									<input id="fromdatepicker" class="texboxitemcode texboxcal"
										placeholder="From Date" name="from_datepicker" type="text">
										
										<input id="todatepicker" class="texboxitemcode texboxcal"
										placeholder="To Date" name="to_datepicker" type="text">
										
						<div class="colOuter">
							<div class="col2full">
								<input name="" class="buttonsaveorder" value="Search..."
									type="button" onclick="searchOrderByDate()">
							</div>
						</div>
</div>
				<!-- 	</form>
 -->
					</div>					
	<div class="row">
		<div class="col-md-12">
		<!--table-->
		<form action="end_StockMonth" method="POST">
			<div class="table-responsive">
				<div class="shInnerwidth">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
						<tr>
							<td align="center" valign="middle" style="padding:0px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr class="bgpink">
												<th width="100" align="left">Item Id</th>
												<th width="100" align="left">Item Name</th>
												<th width="120" align="left">Opening Stock</th>
												
												<th width="159" align="left"> Total Purchase Amt</th>
												<th width="150" align="left">GRN Qty</th>
												<th width="105" align="left">GVN Qty</th>

												<th width="105" align="left">Total Sells</th>
												<th width="105" align="left">Current Stock</th>
																						
											</tr>
													
											<c:forEach items="${billHeader}" var="billHeader" varStatus="count">
												<tr>
													<td><c:out value="${count.index+1}" /></td>
													<td><c:out value="${billHeader.billNo}" /></td>
													<td><c:out value="${billHeader.billDate}" /></td>
													<td><c:out value="${billHeader.taxableAmt}" /></td>
													<td><c:out value="${billHeader.totalTax}" /></td>
													<td><c:out value="${billHeader.grandTotal}" /></td>
													<td><c:out value="${billHeader.status}" /></td>
													<td><c:out value="${billHeader.remark}" /></td>
													
													
												</tr>
												</c:forEach>
											
										</table>
										</td>
										</tr>
										</table>

									</div>
								<div class="colOuter">
									<div class="col2full">
									<input name="" class="buttonsaveorder" value="Month End"
									type="submit">
									</div>
							</div>
							
								</div>
								</form>
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
	<!--easyTabs-->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<!--easyTabs-->

<!-- Select Only Month and Year -->
<script>

$(document).ready(function() {
   $('#txtDate').datepicker({
     changeMonth: true,
     changeYear: true,
     dateFormat: 'MM yy',
       
     onClose: function() {
        var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
     },
       
     beforeShow: function() {
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
     dateFormat: 'MM yy',
       
     onClose: function() {
        var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
     },
       
     beforeShow: function() {
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
function showDiv(elem){
   if(elem.value == 1)
	   {
	  
      document.getElementById('select_month_year').style="display:none";
   document.getElementById('select_date').style="display:none";
	   }
   else if(elem.value == 2)
   {
	   document.getElementById('select_month_year').style.display = "block";
	   document.getElementById('select_date').style="display:none";
   }
   else if(elem.value == 3)
   {
	   document.getElementById('select_date').style.display = "block";
	   document.getElementById('select_month_year').style="display:none";
   }
}
</script>
<!-- <script>
function submitMonthEnd(){
	 document.getElementById('nextMonth').style.display = "block";
} 
</script>-->
</body>
</html>
