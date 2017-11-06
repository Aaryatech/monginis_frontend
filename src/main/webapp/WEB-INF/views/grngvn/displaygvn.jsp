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

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap/css/lightbox.css">
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/lightbox.js"></script>

<!--rightNav-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/menuzord.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#menuzord").menuzord({
			align : "left"
		});
	});
</script>
<!--rightNav-->

<!--selectlistbox-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.selectlistbox.js"></script>

<!--selectlistbox-->

<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#datepicker").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#datepicker2").datepicker({
			dateFormat : 'dd-mm-yy'
		});
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
		<c:url var="getGvnList" value="/getGvnList" />

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
						<h2 class="pageTitle">GVN Details</h2>
						<!--<h3 class="pageTitle2">Order Date : 22-02-2017 </h3>-->
					</div>


					<input type="hidden" name="mod_ser" id="mod_ser"
						value="search_result">

					<div class="colOuter">
						<div class="col1">
							<div class="col1title">From</div>
						</div>
						<div class="col2">
							<input id="datepicker" class="texboxitemcode texboxcal"
								value="${cDate}" name="from_Date" type="text">
						</div>
					</div>

					<div class="colOuter">
						<div class="col1">
							<div class="col1title">TO</div>
						</div>
						<div class="col2">
							<input id="datepicker2" class="texboxitemcode texboxcal"
								value="${cDate}" name="to_Date" type="text">
						</div>
					</div>

					<div class="colOuter">
						<div class="col2full">
							<input name="" class="buttonsaveorder" value="Search..."
								type="button" onclick="searchGVN()">
						</div>
					</div>



					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->
						<ul class="cd-tabs-content">
							<!--tab1-->
							<li data-content="tab1" class="selected">
								<div class="table-responsive">
									<div class="shInnerwidth">


										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">




													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid">
														<thead>
															<tr class="bgpink">

																<th>Bill No</th>
																<th>GVN Date</th>
																<th>Item Name</th>
																<th>RATE</th>
																<th>Quantity</th>
																<th>Amount</th>
																<th>Status</th>
																<th>Photo 1</th>
																<th>Photo 2</th>
																<th>Remark</th>

															</tr>
														</thead>
														<tbody>

														</tbody>
														<c:forEach items="${gvnList}" var="gvnList">
															<tr>
																<td><c:out value="${gvnList.billNo}" /></td>
																<td><c:out value="${gvnList.grnGvnDate}" /></td>
																<td><c:out value="${gvnList.itemName}" /></td>
																<td><c:out value="${gvnList.itemRate}" /></td>
																<td><c:out value="${gvnList.grnGvnQty}" /></td>

																<td><c:out value="${gvnList.grnGvnAmt}" /></td>
																<td><c:out value="${gvnList.grnGvnStatus}" /></td>
																<td><a href="${url}${gvnList.gvnPhotoUpload1}"
																data-lightbox="image-1">Image 1</a></td>
																<td><a href="${url}${gvnList.gvnPhotoUpload2}"
																	data-lightbox="image-2" >Image 2</a></td>
																<td><c:out value="${gvnList.frGrnGvnRemark}" /></td>
															</tr>
														</c:forEach>




													</table>

												</td>
											</tr>
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

	<script type="text/javascript">
		function searchGVN() {

			$('#table_grid td').remove();

			var isValid = validate();

			if (isValid) {

				var fromDate = document.getElementById("datepicker").value;
				var toDate = document.getElementById("datepicker2").value;

				$
						.getJSON(
								'${getGvnList}',
								{

									fromDate : fromDate,
									toDate : toDate,
									ajax : 'true'

								},
								function(data) {

									//$('#table_grid td').remove();

									if (data == "") {
										alert("No records found !!");

									}

									$
											.each(
													data,
													function(key, gvndata) {

														var index = key + 1;

														var tr = "<tr>";

														var billNo = "<td>&nbsp;&nbsp;&nbsp;"
																+ gvndata.billNo
																+ "</td>";
														var grnGvnDate = "<td>&nbsp;&nbsp;&nbsp;"
																+ gvndata.grnGvnDate
																+ "</td>";
														var itemName = "<td>&nbsp;&nbsp;&nbsp;"
																+ gvndata.itemName
																+ "</td>";

														var itemRate = "<td>&nbsp;&nbsp;&nbsp;"
																+ gvndata.itemRate
																+ "</td>";

														var grnGvnQty = "<td>&nbsp;&nbsp;&nbsp;"
																+ gvndata.grnGvnQty
																+ "</td>";

														var grnGvnAmt = "<td>&nbsp;&nbsp;&nbsp;"
																+ gvndata.grnGvnAmt
																+ "</td>";

														var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;"
																+ gvndata.grnGvnStatus
																+ "</td>";

														var gvnPhotoUpload1 = '<td> &nbsp;&nbsp;<a href="'
																							+gvndata.gvnPhotoUpload1+'" data-lightbox="image-1" data-title="My caption">Image 1</a>'
																+ '</td>';

														var gvnPhotoUpload2 = '<td> &nbsp;&nbsp;<a href="'
																							+gvndata.gvnPhotoUpload2+'" data-lightbox="image-1" data-title="My caption">Image 2</a>'
																+ '</td>';

														var frGrnGvnRemark = "<td>&nbsp;&nbsp;&nbsp;"
																+ gvndata.frGrnGvnRemark
																+ "</td>";

														var trclosed = "</tr>";

														$('#table_grid tbody')
																.append(tr);
														$('#table_grid tbody')
																.append(billNo);
														$('#table_grid tbody')
																.append(
																		grnGvnDate);
														$('#table_grid tbody')
																.append(
																		itemName);
														$('#table_grid tbody')
																.append(
																		itemRate);
														$('#table_grid tbody')
																.append(
																		grnGvnQty);

														$('#table_grid tbody')
																.append(
																		grnGvnAmt);

														$('#table_grid tbody')
																.append(
																		grnGvnStatus);
														$('#table_grid tbody')
																.append(
																		gvnPhotoUpload1);
														$('#table_grid tbody')
																.append(
																		gvnPhotoUpload2);
														$('#table_grid tbody')
																.append(
																		frGrnGvnRemark);

														$('#table_grid tbody')
																.append(
																		trclosed);

													})

								});

			}
		}
	</script>



	<script type="text/javascript">
		function validate() {

			var fromDate = $("#datepicker").val();
			var toDate = $("#datepicker2").val();

			var isValid = true;

			if (fromDate == "" || fromDate == null) {

				isValid = false;
				alert("Please select From Date");
			} else if (toDate == "" || toDate == null) {

				isValid = false;
				alert("Please select To Date");
			}
			return isValid;

		}
	</script>



	<script type="text/javascript">
function show_image(data) {
	alert(data);
    var image = new Image();
    image.src = data;

    var w = window.open("");
    w.document.write(image.outerHTML);
}
</script>
</body>
</html>
