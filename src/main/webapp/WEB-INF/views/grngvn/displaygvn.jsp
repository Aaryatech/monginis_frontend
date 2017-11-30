<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

	<!--topHeader-->
	<c:url var="getGvnList" value="/getGvnList" />

	<jsp:include page="/WEB-INF/views/include/logo.jsp"></jsp:include>


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
					<!-- copy div kalpesh -->

					<div class="calender-title">From</div>
					<div class="col-md-2">
						<input id="datepicker" class="texboxitemcode texboxcal"
							value="${cDate}" name="from_Date" type="text">
					</div>

					<div class="calender-title">TO</div>
					<div class="col-md-2">
						<input id="datepicker2" class="texboxitemcode texboxcal"
							value="${cDate}" name="to_Date" type="text">
					</div>

					<div class="col-md-1">
						<button type="button" class="btn  buttonsaveorder"
							onclick="searchGVN()">Search</button>
					</div>

				</div>

				<div class="clearfix"></div>


				<div id="table-scroll" class="table-scroll">
					<div id="faux-table" class="faux-table" aria="hidden"></div>
					<div class="table-wrap">
						<table id="table_grid" class="main-table">
							<thead>
								<tr class="bgpink">
<th class="col-md-1">Bill No</th>
<th class="col-md-1">Date</th>
<th class="col-md-2">Name</th>
<th class="col-md-1">Rate</th>
<th class="col-md-1">Quantity</th>
<th class="col-md-1">Tax %</th>
<th class="col-md-1">Tax Amt</th>
<th class="col-md-1">Amount</th>
<th class="col-md-1">Status</th>
<th class="col-md-1">Photo 1</th>
<th class="col-md-1">Photo 2</th>
<th class="col-md-1">Remark</th>
  </tr>
							</thead>
							<tbody>



								<c:forEach items="${gvnList}" var="gvnList" varStatus="count">
									<tr>


										<td class="col-md-1"><c:out value="${gvnList.billNo}" /></td>
										<td class="col-md-1"><c:out value="${gvnList.grnGvnDate}" /></td>
										<td class="col-md-2"><c:out value="${gvnList.itemName}" /></td>
										<td class="col-md-1"><c:out value="${gvnList.baseRate}" /></td>
										<td class="col-md-1"><c:out value="${gvnList.grnGvnQty}" /></td>
										<td class="col-md-1"><c:out value="${gvnList.sgstPer+gvnList.cgstPer}" /></td>

										<td class="col-md-1"><c:out value="${gvnList.totalTax}" /></td>


										<td class="col-md-1"><c:out value="${gvnList.grnGvnAmt}" /></td>
										<td class="col-md-1"><c:out value="${gvnList.grnGvnStatus}" /></td>
										<td class="col-md-1"><a href="${url}${gvnList.gvnPhotoUpload1}"
											data-lightbox="image-1">Image 1</a></td>
										<td class="col-md-1"><a href="${url}${gvnList.gvnPhotoUpload2}"
											data-lightbox="image-2">Image 2</a></td>
										<td class="col-md-1"><c:out value="${gvnList.frGrnGvnRemark}" /></td>
								</c:forEach>




							</tbody>

						</table>
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

<script>

(function() {
  var fauxTable = document.getElementById("faux-table");
  var mainTable = document.getElementById("table_grid");
  var clonedElement = table_grid.cloneNode(true);
  var clonedElement2 = table_grid.cloneNode(true);
  clonedElement.id = "";
  clonedElement2.id = "";
  fauxTable.appendChild(clonedElement);
  fauxTable.appendChild(clonedElement2);
})();


	</script>

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
														
														var tr = $('<tr></tr>');

														tr.append($('<td class="col-md-1"></td>').html(gvndata.billNo));
													 	tr.append($('<td class="col-md-1"></td>').html(gvndata.grnGvnDate));
													 	tr.append($('<td class="col-md-2"></td>').html(gvndata.itemName));
													 	tr.append($('<td class="col-md-1"></td>').html(gvndata.baseRate));
													 	tr.append($('<td class="col-md-1"></td>').html(gvndata.grnGvnQty));
														var calcTaxPer=parseFloat(gvndata.sgstPer)+parseFloat(gvndata.cgstPer);

													 	tr.append($('<td class="col-md-1"></td>').html(calcTaxPer));
													 	tr.append($('<td class="col-md-1"></td>').html(gvndata.totalTax));
													 	tr.append($('<td class="col-md-1"></td>').html(gvndata.grnGvnAmt));
													 	tr.append($('<td class="col-md-1"></td>').html(gvndata.grnGvnStatus));
													 	tr.append($('<td class="col-md-1"></td>').html('<a href="'
																							+gvndata.gvnPhotoUpload1+'" data-lightbox="image-1" data-title="My caption"><i class="fa fa-image icon2"></i></a>'));
													 	tr.append($('<td class="col-md-1"></td>').html('<a href="'
																							+gvndata.gvnPhotoUpload2+'" data-lightbox="image-1" data-title="My caption"><i class="fa fa-image icon2"></i></a>'));
													 	
													 	tr.append($('<td class="col-md-1"></td>').html(gvndata.frGrnGvnRemark));
													  	

/* 
														var index = key + 1;

														var tr = "<tr>";
														

														var billNo = "<td>"
																+ gvndata.billNo
																+ "</td>";
														var grnGvnDate = "<td>"
																+ gvndata.grnGvnDate
																+ "</td>";
														var itemName = "<td>"
																+ gvndata.itemName
																+ "</td>";

														var itemRate = "<td>"
																+ gvndata.baseRate
																+ "</td>";

														var grnGvnQty = "<td>"
																+ gvndata.grnGvnQty
																+ "</td>";
																
																
																var gvnTaxPer = "<td>"
																	+ calcTaxPer
																	+ "</td>";
																	
																	var totalTax = "<td>"
																		+ gvndata.totalTax
																		+ "</td>";
																
																
																

														var grnGvnAmt = "<td>"
																+ gvndata.grnGvnAmt
																+ "</td>";

																
																
																
														var grnGvnStatus = "<td>"
																+ gvndata.grnGvnStatus
																+ "</td>";

														var gvnPhotoUpload1 = '<td> <a href="'
																							+gvndata.gvnPhotoUpload1+'" data-lightbox="image-1" data-title="My caption">Image 1</a>'
																+ '</td>';

														var gvnPhotoUpload2 = '<td> <a href="'
																							+gvndata.gvnPhotoUpload2+'" data-lightbox="image-1" data-title="My caption">Image 2</a>'
																+ '</td>';

														var frGrnGvnRemark = "<td>"
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
																gvnTaxPer);

														
														$('#table_grid tbody')
														.append(
																totalTax);

														
														
														
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
 */
														$('#table_grid tbody')
																.append(
																		tr);

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
