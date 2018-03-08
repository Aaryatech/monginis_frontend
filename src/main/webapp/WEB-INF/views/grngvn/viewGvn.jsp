<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

	<!--topHeader-->
	<c:url var="getGrnList" value="/getGvnHeaderList" />
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
					<h2 class="pageTitle">GVN Headers</h2>

				</div>
				<form id="validation-form">

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



						<div class="col-sm-2">
							<label>OR Gvn Sr No</label>
							<!-- <input type="checkbox" class="form-control" id="headerCheckBox"
						 name="headerCheckBox" id="headerCheckBox"
							/> -->
						</div>
						<div class="col-md-1">
							<input type="text" class="form-control" id="headeIdText"
								name="headeIdText" value="0" style="width: 120px;" />
						</div>
						<div class="col-md-1"></div>
						<div class="col-md-1">

							<button type="button" class="btn  buttonsaveorder"
								onclick="searchGRN()">Search</button>
						</div>

					</div>


					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->


						<div id="table-scroll" class="table-scroll">
							<div id="faux-table" class="faux-table" aria="hidden"></div>
							<div class="table-wrap">
								<table id="table_grid" class="main-table">
									<thead>
										<tr class="bgpink">
											<th class="col-md-2">GvnSr No</th>
											<th class="col-md-1">Date</th>
											<th class="col-md-2">Taxable Amt</th>
											<th class="col-md-2">Tax Amt</th>

											<th class="col-md-2">Total Refund Requested</th>
											<th class="col-md-2">Approved Refund</th>
											<th class="col-md-2">Status</th>
											<th class="col-md-2">Action</th>
											<th class="col-md-1">PDF</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${gvnList}" var="grnList" varStatus="count">
											<tr>
												<td class="col-md-1"><c:out
														value="${grnList.grngvnSrno}" /> <input type="hidden"
													name="headerId" id="headerId"
													value="${grnList.grnGvnHeaderId}"></td>
												<td class="col-md-1"><c:out
														value="${grnList.grngvnDate}" /></td>


												<td class="col-md-1"><c:out
														value="${grnList.taxableAmt}" /></td>
												<td class="col-md-1"><c:out value="${grnList.taxAmt}" /></td>

												<td class="col-md-1"><c:out value="${grnList.totalAmt}" /></td>

												<td class="col-md-1"><fmt:formatNumber type="number"
														minFractionDigits="2" maxFractionDigits="2"
														value="${grnList.aprGrandTotal}" /></td>

												<c:set var="status" value="a"></c:set>
												<c:choose>
													<c:when test="${grnList.grngvnStatus==1}">
														<c:set var="status" value="Pending"></c:set>

													</c:when>
													<c:when test="${grnList.grngvnStatus==2}">
														<c:set var="status" value="Approved From Dispatch"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==3}">
														<c:set var="status" value="Reject From Dispatch"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==4}">
														<c:set var="status" value="Approved From Sell"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==5}">
														<c:set var="status" value="Reject From Sell"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==6}">
														<c:set var="status" value="Approved From Account"></c:set>
													</c:when>

													<c:when test="${grnList.grngvnStatus==7}">
														<c:set var="status" value="Reject From Account"></c:set>
													</c:when>

													<c:otherwise>
														<c:set var="status" value="Partially Approved"></c:set>
													</c:otherwise>

												</c:choose>

												<td class="col-md-1"><c:out value="${status}"></c:out></td>
												<td class="col-md-1"><a href='#' class='action_btn'
													onclick="getGvnDetail(${grnList.grnGvnHeaderId})"><abbr
														title='Detail'><i class='fa fa-list'></i></abbr></a> <%-- <input type="button" onclick="getGvnDetail(${grnList.grnGvnHeaderId})" id="grnDetailButton" value="Detail"> --%></td>

												<td class="col-md-1"><a href='#' class='action_btn'
													onclick="genPdf(${grnList.grnGvnHeaderId})"><abbr
														title='Pdf'><i class='fa fa-list'></i></abbr></a> <%-- <input type="button" onclick="getGvnDetail(${grnList.grnGvnHeaderId})" id="grnDetailButton" value="Detail"> --%></td>

											</tr>
										</c:forEach>



									</tbody>

								</table>
							</div>
						</div>



					</div>
					<!--tabNavigation-->


				</form>
			</div>

			<!--rightSidebar-->

		</div>
		<!--fullGrid-->
	</div>
	<!--rightContainer-->

</div>
<!--wrapper-end-->





<script type="text/javascript">
		function searchGRN() {

			$('#table_grid td').remove();
			var headeIdText=$("#headeIdText").val();
			
			//if(!headeIdText==null || headeIdText=="")
			//var isValid = validate();

			//if (isValid) {

				var fromDate = document.getElementById("datepicker").value;
				var toDate = document.getElementById("datepicker2").value;
				//var headeIdText=$("#headeIdText").val();
				
				
				//var headerCheckBox = document.getElementById("headerCheckBox").value;
				//alert("CHK "+headerCheckBox);

				$.getJSON('${getGrnList}', {

					fromDate : fromDate,
					toDate : toDate,
					headerId : headeIdText,
					ajax : 'true'

				}, function(data) {

					//$('#table_grid td').remove();
document.getElementById("headeIdText").value=0;
					if (data == "") {
						alert("No records found !!");

					}

					$.each(data, function(key, grndata) {

						
						var tr = $('<tr></tr>');
						
						var grnStatus;
								
								if(grndata.grngvnStatus==1)
									grnStatus="Pending";
							 if(grndata.grngvnStatus==2)
									grnStatus="Approved From Dispatch";
							 else if(grndata.grngvnStatus==3)
									grnStatus="Reject From Dispatch";
							 else if(grndata.grngvnStatus==4)
									grnStatus="Approved From Sell";
							 else	if(grndata.grngvnStatus==5)
									grnStatus="Reject From Sell";
							 else if(grndata.grngvnStatus==6)
									grnStatus="Approved From Account";
							 else if(grndata.grngvnStatus==7)
									grnStatus="Reject From Account";
							 else if(grndata.grngvnStatus==8)
									grnStatus="Partially Approved";

						tr.append($('<td class="col-md-2"></td>').html(grndata.grngvnSrno));
						tr.append($('<td class="col-md-1"></td>').html(grndata.grngvnDate));
				tr.append($('<td class="col-md-1"></td>').html(grndata.taxableAmt));
				tr.append($('<td class="col-md-1"></td>').html(grndata.taxAmt));
						tr.append($('<td class="col-md-2"></td>').html(grndata.totalAmt));
						tr.append($('<td class="col-md-2"></td>').html(grndata.aprGrandTotal));
						tr.append($('<td class="col-md-2"></td>').html(grnStatus));

						//tr.append($('<td class="col-md-2"></td>').html("<input type='button' onclick='getGrnDetail("+grndata.grnGvnHeaderId+")' id='grnDetailButton' value='Detail'>"));
						
							tr.append($('<td ><a href="#" class="action_btn" onclick="getGvnDetail('+grndata.grnGvnHeaderId+')"><abbr title="Detail"><i class="fa fa-list"></i></abbr></a></td>'));
							tr.append($('<td ><a href="#" class="action_btn" onclick="genPdf('+grndata.grnGvnHeaderId+')"><abbr title="Pdf"><i class="fa fa-list"></i></abbr></a></td>'));

						//tr.append($('<td class="col-md-2"><a href=''#' class='action_btn' onclick='getGrnDetail("+grndata.grnGvnHeaderId+")'> <abbr title='Detail'><i class="fa fa-trash"></i></abbr></a></td>'));
$('#table_grid tbody')
	.append(
			tr);
			
})

});
				

			
//}//if block
}
		
	
	</script>


<script type="text/javascript">

function getGvnDetail(headerId){
	
	//alert("PPP");
			//alert("HIII");
			//alert("header ID "+headerId)
		    var form = document.getElementById("validation-form");
		    form.action ="getGvnDetailList/"+headerId;
		    form.submit();
		}
</script>

<script type="text/javascript">
		function validate() {
		
			var fromDate =$("#datepicker").val();
			var toDate =$("#datepicker2").val();
			
			var headeIdText=$("#headeIdText").val();
			alert(headeIdText);
			
			var isValid = true;
			if(headeIdText =="" || headeIdText == null){
				 isValid = false;
			}
			else if (fromDate == "" || fromDate == null) {

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


<script>
	/*
//  jquery equivalent
jQuery(document).ready(function() {
   jQuery(".main-table").clone(true).appendTo('#table-scroll .faux-table').addClass('clone');
   jQuery(".main-table.clone").clone(true).appendTo('#table-scroll .faux-table').addClass('clone2'); 
 });
*/
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


<script>

function genPdf(headerId) {
		//alert("Inside Gen Pdf ");

		var fromDate =$("#datepicker").val();
		var toDate =$("#datepicker2").val();
		
		    window.open('${pageContext.request.contextPath}/pdf?reportURL=/getGrnPdf/'+fromDate+'/'+'/'+toDate+'/'+headerId+'/'+0);
		    
		    // window.open('${pageContext.request.contextPath}/getGrnPdf/'+fromDate+'/'+'/'+toDate+'/'+headerId+'/'+0);
			
	}
	</script>

</body>
</html>