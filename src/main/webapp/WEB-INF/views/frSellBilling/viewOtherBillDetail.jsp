

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

 

</head>
<body>
 --%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<c:url var="editFrSupplier" value="/editFrSupplier"></c:url>

<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
		$(function() {
			$("#fromdatepicker").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
		$(function() {
			$("#todatepicker").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
	</script>
<!--datepicker-->

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

	<!--topHeader-->
	<c:url var="findAddOnRate" value="/getAddOnRate" />
	<c:url var="findItemsByCatId" value="/getFlavourBySpfId" />
	<c:url var="findAllMenus" value="/getAllTypes" />
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


		 
			<div class="sidebarright">
				 
				<form name="frm_search" id="frm_search" method="post"
					action="${pageContext.request.contextPath}/insertSupplier">
					<input type="hidden" name="mod_ser" id="mod_ser"
						value="search_result">

					
						<div class="col-md -3">
							
								<div class="col1title" align="left"><h3>Other Bill Detail</h3></div>
						</div>
						
					<div class="colOuter">
						<div class="col-md-2">
							<div class="col1title">Invoice No. </div>
						</div>
						<div class="col-md-1">
							${otherBillHeader.invoiceNo}

						</div>
						<div class="col-md-1">
							 
						</div>

						<div class="col-md-2">
							<div class="col1title">Bill Date </div>
						</div>
						<div class="col-md-1">
							${otherBillHeader.billDate}

						</div>
					 
					</div>
					
					<div class="colOuter">
						<div class="col-md-2">
							<div class="col1title">Supplier Name </div>
						</div>
						<div class="col-md-1">
							${supplier.suppName}

						</div>
						<div class="col-md-1">
							 
						</div>

						<div class="col-md-2">
							<div class="col1title">Discount AMT </div>
						</div>
						<div class="col-md-1">
							${otherBillHeader.discAmt}
					 

						</div>
				 
					</div>
					
					<div class="colOuter">
						<div class="col-md-2">
							<div class="col1title">Taxable AMT* </div>
						</div>
						<div class="col-md-1">
							${otherBillHeader.taxableAmt}

						</div>
						<div class="col-md-1">
							 
						</div>

						<div class="col-md-2">
							<div class="col1title">CGST AMT </div>
						</div>
						<div class="col-md-1">
							${otherBillHeader.cgstSum}
						</div>
				 
					</div>
					
					<div class="colOuter">
						<div class="col-md-2">
							<div class="col1title">SGST AMT </div>
						</div>
						<div class="col-md-1">
							${otherBillHeader.sgstSum}

						</div>
						<div class="col-md-1">
							 
						</div>

						<div class="col-md-2">
							<div class="col1title">IGST AMT </div>
						</div>
						<div class="col-md-1">
							${otherBillHeader.igstSum}

						</div>
				 
					</div>
					
					<div class="colOuter">
						<div class="col-md-2">
							<div class="col1title">Total </div>
						</div>
						<div class="col-md-1">
							${otherBillHeader.grandTotal}

						</div>
						 
				 
					</div>
					
					  
					
					<div id="table-scroll" class="table-scroll">
					<div id="faux-table" class="faux-table" aria="hidden"></div>
					<div class="table-wrap">
						<table id="table_grid" class="main-table">

							<thead>
								<tr class="bgpink">
								
									<th class="col-sm-1">Sr No</th>
									<th class="col-md-1">Item Name</th> 
									<th class="col-md-1">Qty</th>
									<th class="col-md-1">Base Rate</th> 
									<th class="col-md-1">Discount Amt</th>
									<th class="col-md-1">Taxable Amt</th>
									<th class="col-md-1">Tax Amt</th>
									<th class="col-md-1">Total Amt</th>
								</tr>
							</thead>
							<tbody>

								<c:forEach items="${otherBillHeader.otherBillDetailList}" var="otherBillDetailList"
									varStatus="count">
									<tr>
										 <td class="col-sm-1"><c:out value="${count.index+1}" /></td>
										  <c:forEach items="${itemsList}" var="itemsList" >
												 <c:choose> 
												 <c:when test="${otherBillDetailList.itemId==itemsList.itemId}">
												 <td class="col-md-1"><c:out
												value="${itemsList.itemName}" /></td>
												 </c:when>
												 </c:choose>
										 </c:forEach>
										
										<td class="col-md-1"><c:out
												value="${otherBillDetailList.billQty}" /></td>
										<td class="col-md-1"><c:out
												value="${otherBillDetailList.baseRate}" /></td>
										<td class="col-md-1"><c:out
												value="${otherBillDetailList.discRs}" /></td>
										<td class="col-md-1"><c:out
												value="${otherBillDetailList.taxableAmt}" /></td>
										<td class="col-md-1"><c:out
												value="${otherBillDetailList.totalTax}" /></td>
										<td class="col-md-1"><c:out
												value="${otherBillDetailList.grandTotal}" /></td>
										 
									</tr>
								</c:forEach>
						</table>

					</div>
				</div>

				</form>

				 
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


<script>
function edit(suppId) {
 
	  
	$('#loader').show();

	$
			.getJSON(
					'${editFrSupplier}',

					{
						 
						suppId : suppId, 
						ajax : 'true'

					},
					function(data) { 
						
						document.getElementById("suppId").value=data.suppId;
						document.getElementById("suppName").value=data.suppName;  
						document.getElementById("suppAdd").value=data.suppAddr;
						document.getElementById("city").value=data.suppCity;
						document.getElementById("mob").value=data.mobileNo;
						document.getElementById("email").value=data.email;
						document.getElementById("gstnNo").value=data.gstnNo;
						document.getElementById("panNo").value=data.panNo;
						document.getElementById("liceNo").value=data.suppFdaLic;
						document.getElementById("creditDays").value=data.suppCreditDays;
						document.getElementById("isSameState").value=data.isSameState; 
						document.getElementById("cancel").disabled=false;
					});

 
	   

}

function cancel1() {

    //alert("cancel");
	document.getElementById("suppId").value="";
	document.getElementById("suppName").value="";  
	document.getElementById("suppAdd").value="";
	document.getElementById("city").value="";
	document.getElementById("mob").value="";
	document.getElementById("email").value="";
	document.getElementById("gstnNo").value="";
	document.getElementById("panNo").value="";
	document.getElementById("liceNo").value="";
	document.getElementById("creditDays").value="";
	document.getElementById("isSameState").value=""; 
	document.getElementById("cancel").disabled=false;

}
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

</body>
</html>
