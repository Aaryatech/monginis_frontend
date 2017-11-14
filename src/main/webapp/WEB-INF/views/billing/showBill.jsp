<%-- 

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>Monginis</title>
<link href="${pageContext.request.contextPath}/resources/css/monginis.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/resources/css/custom.css" rel="stylesheet" type="text/css"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="icon" href="images/feviconicon.png" type="image/x-icon"/> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--selectlistbox-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.selectlistbox.js"></script>
<script>

<!--datepicker-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>

!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
  $( function() {
    $( "#datepicker" ).datepicker();
  } );
  $( function() {
    $( "#datepicker2" ).datepicker();
  } );
  $( function() {
    $( "#datepicker3" ).datepicker();
  } );
  $( function() {
    $( "#datepicker4" ).datepicker();
  } );
  $( function() {
    $( "#datepicker5" ).datepicker();
  } );
  </script>
<!--datepicker--> 
        
</head>
<body>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>





			<!--fullGrid-->
			
	<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />
				</jsp:include>






<!--rightSidebar-->
<div class="sidebarright">
	<div class="row">
	    <div class="col-md-12"><h2 class="pageTitle">Purchase Bill</h2></div>
	</div>
	
	<div class="row">
	
		<div class="col-md-2 from_date">
		    <h4 class="pull-left">From Date:-</h4>
		</div>
		<div class="col-md-2 ">
			<input id="datepicker" class="texboxitemcode texboxcal" placeholder="MM-DD-YYYY" name="from_date" type="text">
		</div>
		<div class="col-md-1">
		    <h4 class="pull-left">To Date:-</h4>
		</div>
		<div class="col-md-2 ">
			<input id="datepicker2" class="texboxitemcode texboxcal" placeholder="MM-DD-YYYY" name="to_date" type="text">
		</div>
		<div class="col-md-2">
		    <button class="btn search_btn pull-left">Search <span class="glyphicon glyphicon-search"></span></button>
		</div>
		
    </div>
	<br/>
	
	<div class="row">
		<div class="col-md-12">
		<!--table-->
			<div class="table-responsive">
				<div class="shInnerwidth">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
						<tr>
							<td align="center" valign="middle" style="padding:0px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr class="bgpink">
									<td >Sr.No</td>
									<td>Bill No</td>
									<td>Delivery Date</td>
									<td>Taxable Amount</td>
										<td>Tax Amount</td>
											<td>Grand Total</td>
												
									<td>Status</td>
									<td>Remark</td>
								  </tr>
								 <c:forEach items="${billHeader}" var="billHeader" varStatus="count">
												<tr>
													<td><c:out value="${count.index+1}" /></td>
													<td><c:out value="${billHeader.billNo}" /></td>
													<td><c:out value="${billHeader.billDate}" /></td>
													<td><c:out value="${billHeader.frName}" /></td>
													<td><c:out value="${billHeader.taxableAmt}" /></td>
													<td><c:out value="${billHeader.totalTax}" /></td>
													<td><c:out value="${billHeader.grandTotal}" /></td>
													<td><c:out value="${billHeader.status}" /></td>
													<td><c:out value="${billHeader.remark}" /></td>
												
													<c:set var="billNo" value="${billHeader.billNo}"/>
												</tr>
												</c:forEach>
											
								  
								</table>
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



</body>




</html>
 --%>





















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
						<h2 class="pageTitle">Bills</h2>
						<!--<h3 class="pageTitle2">Order Date : 22-02-2017 </h3>-->
					</div>

					<form name="frm_search" id="frm_search" method="post"
						action="showBillProcess">
						<input type="hidden" name="mod_ser" id="mod_ser"
							value="search_result">

						<div class="colOuter">
							<div class="col1">
								<div class="col1title">View Bills For</div>
							</div>
							<div class="colOuter">
								<div class="col1">
									<div class="col1title">From Date</div>
								</div>
								<div class="col2">
									<input id="fromdatepicker" class="texboxitemcode texboxcal"
										placeholder="From Date" name="from_datepicker" type="text">
										
								</div>
							</div>

							<div class="colOuter">
								<div class="col1">
									<div class="col1title">To Date</div>
								</div>
								<div class="col2">
									<input id="todatepicker" class="texboxitemcode texboxcal"
										placeholder="To Date" name="to_datepicker" type="text">
										
								</div>
							</div>




						</div>

	
						<div class="colOuter">
							<div align="center">
								<input name="" class="buttonsaveorder" value="Search..."
									type="submit" align="center">
							</div>
						</div>

					</form>

					<!--tabNavigation-->
					<!-- <div class="cd-tabs">
						tabMenu

						tabMenu
						<ul class="cd-tabs-content">
							tab1
							<li data-content="tab1" class="selected">
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table width="100%" id="table1"> my table  commment  -->
										
										
										<div class="row">
		<div class="col-md-12">
		<!--table-->
			<div class="table-responsive">
				<div class="shInnerwidth">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
						<tr>
							<td align="center" valign="middle" style="padding:0px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr class="bgpink">
												<th width="100" align="left">Sr No</th>
												<th width="100" align="left">Bill No</th>
												<th width="120" align="left">Date</th>
												
												<th width="159" align="left"> Taxable Amt</th>
												<th width="150" align="left">Tax Amount</th>
												<th width="105" align="left">Grand Total</th>

												<th width="105" align="left">Status</th>
												<th width="105" align="left">Remark</th>
												<th width="105" align="left">Action</th>
												
											</tr>
													
											<c:forEach items="${billHeader}" var="billHeader" varStatus="count">
												<tr>
													<td><c:out value="${count.index+1}" /></td>
													<td><c:out value="${billHeader.billNo}" /></td>
													<td><c:out value="${billHeader.billDate}" /></td>
													<td><c:out value="${billHeader.taxableAmt}" /></td>
													<td><c:out value="${billHeader.totalTax}" /></td>
													<td><c:out value="${billHeader.grandTotal}" /></td>
												<%-- 	<td><c:out value="${billHeader.status}" /></td> --%>
														<c:choose>
																	<c:when test="${billHeader.status==1}">
																		<td><c:out value="Pending"></c:out></td>
																	</c:when>
																	<c:when test="${billHeader.status==2}">
																		<td><c:out value="Receive"></c:out></td>
																	</c:when>
																	<c:when test="${billHeader.status== 3}">
																		<td><c:out value="GVN Apply"></c:out></td>
																	</c:when>
																	<c:when test="${billHeader.status== 4}">
																		<td><c:out value="GVN Approve"></c:out></td>
																	</c:when>
																	<c:when test="${billHeader.status== 5}">
																		<td><c:out value="GRN Apply"></c:out></td>
																	</c:when>
																		<c:when test="${billHeader.status== 6}">
																		<td><c:out value="GRN Approve"></c:out></td>
																	</c:when>
																		<c:when test="${billHeader.status== 7}">
																		<td><c:out value="Closed"></c:out></td>
																	</c:when>

																</c:choose>
													<td><c:out value="${billHeader.remark}" /></td>
													<td><div class="order-btn textcenter">
						<a	href="${pageContext.request.contextPath}/showBillDetailProcess/?billNo=${billHeader.billNo}&billDate=${billHeader.billDate}&billStatus=${billHeader.status}&grandTotal=${billHeader.grandTotal}"
						 class="buttonsaveorder">VIEW</a>
						<!--<input name="" class="buttonsaveorder" value="EXPORT TO EXCEL" type="button">-->
					</div> </td>
													<c:set var="billNo" value="${billHeader.billNo}"/>
												</tr>
												</c:forEach>
											
										</table>

									</div>
								</div>
							</li>

						</ul>
					</div>
					<!--tabNavigation-->

					<!--<div class="order-btn"><a href="#" class="saveOrder">SAVE ORDER</a></div>-->
					<%-- <div class="order-btn textcenter">
						<a
							href="${pageContext.request.contextPath}/showBillDetailProcess/${billNo}"
							class="buttonsaveorder">VIEW DETAILS</a>
						<!--<input name="" class="buttonsaveorder" value="EXPORT TO EXCEL" type="button">-->
					</div> --%>


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




</body>
</html>
