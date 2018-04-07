<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<%-- <!DOCTYPE html>
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
</script> --%>
<!--rightNav-->
<!--datepicker-->

	<c:url var="getSelectedIdForPrint" value="/billDetailPrint" />


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


<!-- </head>
<body>
 -->
	
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
	    <div class="col-md-12"><h2 class="pageTitle">View Bill Details</h2></div>
	</div>
	
	<div class="row">
	
		<div class="col-md-2 from_date">
		    <h4 class="pull-left">Bill No:-  <b>${sellBillNo}</b></h4>
		</div>
		<div class="col-md-2 ">
			
		</div>
		<div class="col-md-3">
		    <h4 class="pull-left">Bill Date:- <b> ${billDate}</b></h4>
		</div>
		<div class="col-md-2 ">
			
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
									<th>Index</th>
									<th>Print</th>
									<th>Item Name</td>
									<th>Qty</td>
									<th>MRP Base Rate</td>
									<th>Taxable Amount</td>
									<th>Tax %</td>
									<th>Total Tax</td>
									<th>MRP</td>
								
									
								  </tr>
								  <tbody>
													<c:forEach items="${getSellBillDetailList}" var="sellBill" varStatus="count">

														<tr>
															<td><c:out value="${count.index+1}"/></td>
 <td><input type="checkbox" name="select_to_print" onchange="selectToPrint()"
																id="select_to_print"
																value="${sellBill.sellBillDetailNo}" ></td>
																
															<td align="left"><c:out value="${sellBill.itemName}" /></td>
															<td align="left"><c:out	value="${sellBill.qty}" /></td>
															<td align="left"><c:out value="${sellBill.mrpBaseRate}" /></td>
															<td align="left"><c:out value="${sellBill.taxableAmt}" /></td>
															<td align="left"><c:out value="${sellBill.sgstPer+sellBill.cgstPer}" /></td>
															<td align="left"><c:out value="${sellBill.totalTax}" /></td>
															<td align="left"><c:out value="${sellBill.mrp}" /></td>
															
														
														</tr>
													</c:forEach>

												</tbody>
								  
								</table>
							
				</div>
				<button style="float: right;margin-top: 13px;" type="button" class="btn btn-primary"
						onclick="printExBill()"  id="printExBill">Print</button>
			</div>
		<!--table end-->
		 
		</div>	
    </div>
	<div align="center">
								<a href="${pageContext.request.contextPath}/viewBill"><input name="" class="buttonsaveorder" value="Go Back"
									  align="center" type="button"></a><!-- onclick="goBack()" -->
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


function printExBill()
{
	//alert("in print");
	
	var checkedId=[];
	var checkboxes=document.getElementsByName("select_to_print");
	
	 
		for (var i = 0, n = checkboxes.length; i < n; i++) {
			if(checkboxes[i].checked) {
				
				checkedId.push(checkboxes[i].value );
				
			}
		}
		//alert(checkboxes);
		 $.getJSON('${getSelectedIdForPrint}',{

				id :  JSON.stringify(checkedId),
				ajax : 'true',
			

			 });
			  
	window.open("${pageContext.request.contextPath}/printSelectedBillDetail");
}

function selectToPrint()
{
	//alert("hh");
 
	var checkboxes=document.getElementsByName("select_to_print");
	//alert(checkboxes[0].value);
	var flag=0;
		for (var i = 0, n = checkboxes.length; i < n; i++) {
			if(checkboxes[i].checked) {
				 
				flag=1;
			}
		}
	if(flag==1)
		{
	 //alert("KK");
		document.getElementById("printExBill").disabled=false;
		}
	else{
	document.getElementById("printExBill").disabled=true;
	}
	
	 
}

</script>
</body>
</html>
