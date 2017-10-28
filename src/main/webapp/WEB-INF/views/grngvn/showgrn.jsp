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

<link
	href="${pageContext.request.contextPath}/resources/css/monginis.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />



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
						<div class="col-md-12">
							<h2 class="pageTitle">GRN Bill</h2>
						</div>
					</div>





					<br />

					<div class="row">
						<div class="col-md-12">
							<!--table-->
							<form
								action="${pageContext.request.contextPath}/insertGrnProcess"
								name="grn" id="grn" method="post">
								<div class="table-responsive">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Sr No.</td>
															<td>Bill No.</td>
															<td>Item Name</td>
															<td>GRN TYPE</td>
															<td>GRN QTY</td>
															<td>Item Rate</td>
															<td>iS Edit</td>
															<td>Edit GRN Qty</td>

															<td>GRN Amount</td>
															<td>GRN Remark</td>

														</tr>


														<c:forEach items="${grnConfList}" var="grnConfList"
															varStatus="count">
															<tr>

																<td>${count.index+1}</td>
																<td><c:out value="${grnConfList.billNo}"></c:out></td>
																<td><c:out value="${grnConfList.itemName}"></c:out></td>
																<c:choose>
																	<c:when test="${grnConfList.grnType==0}">
																		<td><c:out value="GRN 1" ></c:out></td>
																	</c:when>
																	<c:when test="${grnConfList.grnType==1}">
																		<td><c:out value="GRN 2" ></c:out></td>
																	</c:when>
																	<c:when test="${grnConfList.grnType== 2}">
																		<td><c:out value="GRN 3" ></c:out></td>
																	</c:when>
																	
																</c:choose>
		

																<%--  																		<td><c:out value="GRN 3"></c:out></td>
 --%>
																<td><input type="text"
																	name="grn_qty${grnConfList.itemId}"
																	id="grnqty${grnConfList.itemId}" size="5" value="0"
																	onkeyup="calcGrn(${grnConfList.grnType},${grnConfList.rate},${grnConfList.itemId})" /></td>
																<td id="grn_rate${grnConfList.itemId}"><c:out
																		value="${grnConfList.rate}"></c:out></td>
																<!-- <td><label><input type="radio"
																	name="is-edit" id=is_edit value="0" checked="checked">No</label>
																<label><input type="radio" name="is-edit"
																	id=is_edit value="1">Yes</label></td> -->

																<td><select name="is_edit${grnConfList.itemId}"
																	id="is_edit${grnConfList.itemId}"
																	onchange="showEdit(this.id,${grnConfList.itemId})">
																		<option selected value="0">No</option>
																		<option value="1">Yes</option>
																</select></td>


																<td><input type="number"
																	name="grn_qty${grnConfList.itemId}" disabled="disabled"
																	id="grnqtyauto${grnConfList.itemId}" size="5" value="0"
																	onkeyup="calcGrn(${grnConfList.grnType},${grnConfList.rate},${grnConfList.itemId})" /></td>


																<td id="grn_amt${grnConfList.itemId}"><c:out
																		value="0"></c:out></td>

																<td><input type="text"
																	name="grn_remark${grnConfList.itemId}" id=grn_remark /></td>

																<!-- <td>
									    <a href="#" class="action_btn"><abbr title="edit"><i class="fa fa-edit"></i></abbr></a>
										<a href="#" class="action_btn"><abbr title="Delete"><i class="fa fa-trash"></i></abbr></a>
										<a href="#" class="action_btn"><abbr title="Upload Photo"><i class="fa fa-file-image-o"></i></abbr></a>
									</td>
									 -->

																</tr>
														</c:forEach>

													</table>
												</td>
											</tr>
										</table>
									</div>
								</div>


								<div class="form-group">
									<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-5">
										<button type="submit" class="btn btn-primary">
											<i class="fa fa-check"></i> Save
										</button>
										<!--<button type="button" class="btn">Cancel</button>-->
									</div>
								</div>

								<!-- <a href="#" class="action_btn" onclick="submitForm()"><abbr title="Save"><i class="fa fa-trash"></i></abbr></a> -->

							</form>
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

	<script type="text/javascript">
	
	function showEdit(id,itemId) {
		
		 var x=$("#is_edit"+itemId).val();
		 
		 
		 
		if(x == 1){
		 
			 $("#grnqtyauto"+itemId).removeAttr("disabled"); 
	           
			// document.getElementById("is_edit"+itemId).style.visibility = "hidden"; 
			 
			 document.getElementById("isEditYes"+itemId).show();
			 
			// $("#grnqtyauto"+itemId).removeAttr("disabled"); 
			
			
			
		}
		if(x== 0)
			{
			
			
            $("#grnqtyauto"+itemId).attr("disabled", "disabled"); 
			
			}
		
	}
	
	
	</script>



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
	
	function calcGrn(grnType,rate,itemId){
		
		if(grnType==0){
			
			
			var grnQty=$("#grnqty"+itemId).val();
			
			
			var grnRate=$("#grn_rate"+itemId).text();
			
			
			var grnAmt=parseFloat(grnQty)*parseFloat(grnRate);
			grnAmt=grnAmt*75/100;	
			$("#grn_amt"+itemId).html(grnAmt.toFixed(2));
		
		}
		else{ 
			
			if(grnType==1){
			
		
			var grnQty=$("#grnqty"+itemId).val();
			
			
			var grnRate=$("#grn_rate"+itemId).text();
			
			var grnAmt=parseFloat(grnQty)*parseFloat(grnRate);
			grnAmt=grnAmt*90/100;	
			$("#grn_amt"+itemId).html(grnAmt.toFixed(2));
		
		}
			else{ 
				
			if(grnType==2){
			
			
			var grnQty=$("#grnqty"+itemId).val();
			
			
			var grnRate=$("#grn_rate"+itemId).text();
			
			
			var grnAmt=parseFloat(grnQty)*parseFloat(grnRate);
			
			$("#grn_amt"+itemId).html(grnAmt.toFixed(2));
		
			}
		}
		
		}
	
	}

	
	
	</script>

</body>
</html>
