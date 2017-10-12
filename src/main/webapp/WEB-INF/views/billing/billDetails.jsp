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
		<%-- <c:url var="findAddOnRate" value="/getAddOnRate" />
<c:url var="findItemsByCatId" value="/getFlavourBySpfId" />
<c:url var="findAllMenus" value="/getAllTypes" /> --%>
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

						

						<%-- <div class="colOuter">
		<div class="col1"><div class="col1title">Delivery Order / GRN / GVN  Date</div></div>
		<div class="col2"><input id="datepicker" class="texboxitemcode texboxcal" placeholder="Delivery Date"  name="datepicker" type="text" value="${spDeliveryDt}" >
		</div>
	</div>
	 --%>
						<div class="colOuter">
							<div class="col2full">
								<input name="" class="buttonsaveorder" value="Search..."
									type="submit">
							</div>
						</div>

					</form>

					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->
						<ul class="cd-tabs-content">
							<!--tab1-->
							<li data-content="tab1" class="selected">
								<div class="table-responsive">
									<div class="shInnerwidth">

										<table width="100%" id="table1">
											<tr class="bgpink">
												<th width="138" style="width: 18px" align="left">Sr No</th>
													<th width="138" align="left">Item Name</th>
													<th width="159" align="left">Group</th>
													<th width="105" align="left">Order Qty</th>
													<th width="270" align="right">Billed Qty</th>
												
													<th width="159" align="left">MRP</th>
														<th width="91" align="left">Rate</th>
														<th width="105" align="left">Total (excluding tax) now Taxable Amt</th>
													<th width="105" align="left">GST %</th>
													
													<th width="105" align="left">Tax Amount</th>
													<th width="105" align="left">Total ie now  Grand Total</th>
													
													<th width="159" align="left">Remark</th>
											</tr>
													
											<c:forEach items="${billDetailsList}" var="billDetailsList" varStatus="count">
												<tr>
													<td><c:out value="${count.index+1}" /></td>
													<td><c:out value="${billDetailsList.itemName}" /></td>
													<td><c:out value="${billDetailsList.catName}" /></td>
													<td><c:out value="${billDetailsList.orderQty}" /></td>
													<td><c:out value="${billDetailsList.billQty}" /></td>
													<td><c:out value="${billDetailsList.rate}" /></td>
													<td><c:out value="${billDetailsList.mrp}" /></td>
													
													<c:set var="sgstPer" value="${billDetailsList.sgstPer}"/>
															<c:set var="cgstPer" value="${billDetailsList.cgstPer}"/>
													<td><c:out value="${sgstPer+cgstPer}" /></td>
													<td><c:out value="2500" /></td>
													
													<td><c:out value="${billDetailsList.remark}" /></td>
													
												</tr>
												</c:forEach>
											
										</table>

									</div>
								</div>
							</li>

						</ul>
					</div>
					<!--tabNavigation-->

				

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
