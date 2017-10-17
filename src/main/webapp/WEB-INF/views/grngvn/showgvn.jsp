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
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="icon"
	href="${pageContext.request.contextPath}/images/feviconicon.png"
	type="image/x-icon" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>

<!--autocomplete-->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/autocomplete.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/autocomplete.css">
<script
	src="${pageContext.request.contextPath}/resources/css/easy-responsive-tabs.css"></script>

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
	<c:url var="findItemsByCatId" value="/getItemForCategory" />

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
							<h2 class="pageTitle">GVN</h2>
						</div>
					</div>


					<div class="col-md-2">
						<h4 class="pull-left" style="">Select Group:-</h4>
					</div>




					<br />

					<div class="row">
						<div class="col-md-12">
							<!--table-->
							<form action="${pageContext.request.contextPath}/getGvnBillDetails"
								name="grn" id="grn" method="get">
								<div class="table-responsive">



									<div class="col-md-2">


										<div>
											<select name="bill_no" id="bill_no">
												<option value="0">--Select BILL--</option>

												<c:forEach items="${frBillList}" var="frBillList">


													<option value="${frBillList.billNo}">Bill No- ${frBillList.billNo} Bill Date- ${frBillList.billDate}</option>

												</c:forEach>

											</select>

										</div>
									</div>
									<br>
									<!-- <div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Items</label>
										<div class="col-sm-9 col-lg-3 controls">
											<select data-placeholder="Select Items" name="items[]"
												class="form-control chosen" tabindex="-1" id="items"
												data-rule-required="true">

											</select>

										</div>
									</div> -->

									
								<div class="form-group">
									<div class="col-sm-9 col-sm-offset-3 col-lg-5 col-lg-offset-1">
										<button type="submit" class="btn btn-primary">
											<i class="fa fa-check"></i> Search
										</button>
										<!--<button type="button" class="btn">Cancel</button>-->
									</div>
								</div>
									</form>

	<form action="${pageContext.request.contextPath}/addGvnProcess"
								name="grn_add" id="grn_add" enctype="multipart/form-data" method="post">
									<div class="shInnerwidth">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr class="bgpink">
															<td>Sr No.</td>
															<td>Bill No</td>
															<td>Bill Date</td>

															<td>Item Name</td>


															<td>GVN QTY</td>
															<td>Item Rate</td>


															<td>GVN Amount</td>
															<td>GVN Remark</td>
															<td>PHOTO 1</td>
															<td>PHOTO 2</td>

														</tr>


														<c:forEach items="${gvnConfList}" var="gvnConfList"
															varStatus="count">
															<tr>

																<td>${count.index+1}</td>

																<td>${gvnConfList.billNo}</td>
																<td>${gvnConfList.billDate}</td>
																<td>${gvnConfList.itemName}</td>

																<td><input type="text" name="gvn_qty${gvnConfList.itemId}" id="gvn_qty${gvnConfList.itemId}" value="0" size="5" onkeyup="calcGvn(${gvnConfList.rate},${gvnConfList.itemId})" /></td>
																<td>${gvnConfList.rate}</td>
																<td id="gvn_amt${gvnConfList.itemId}"><c:out value=""></c:out></td>
																<td><input type="text" name="gvn_remark${gvnConfList.itemId}"
																	id=grn_remark value="" placeholder="Gvn Remark"/></td>
																<td>
																	<div class="colOuter">
																		<div class="col1">
																			<div class="col1title">Photo1</div>
																		</div>
																		<div class="col2full">
																			<div class="editimg">
																				<div class="editpics">
																					<div class="fileUpload">
																						<span> <i class="fa fa-pencil"></i></span> <input
																							class="upload" type="file" id="gvn_photo1"
																							name="gvn_photo1" />


																					</div>
																				</div>
																				 <img id="image" />
																				<img id="image" src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" alt="img"> 
																			</div>
																		</div>
																	</div>
																</td>

																<!-- <td><div class="colOuter">
																		<div class="col1">
																			<div class="col1title">Photo 2</div>
																		</div>
																		<div class="col2full">
																			<div class="editimg">
																				<div class="editpics">
																					<div class="fileUpload">
																						<span> <i class="fa fa-pencil"></i></span> <input
																							class="upload" type="file" id="order_photo2"
																							name="order_photo2" />


																					</div>
																				</div>
																				<img id="image" />
																				<img id="image" src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" alt="img">
																			</div>
																		</div>
																	</div>
																	</td> -->
																


															</tr>
														</c:forEach>

													</table>
												</td>
											</tr>
										</table>
									</div>
									
									<div class="form-group">
									<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-5">
										<button type="submit" class="btn btn-primary">
											<i class="fa fa-check"></i> Save
										</button>
										<!--<button type="button" class="btn">Cancel</button>-->
									</div>
								</div>
									
									</form>
								</div>


								
								

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

<script>

 document.getElementById("order_photo1").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
        // get loaded data and render thumbnail.
        document.getElementById("image").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

</script>


<script type="text/javascript">
function calcGvn(rate,itemId){
	
	var gvnQty=$("#gvn_qty"+itemId).val();
	//alert(gvnQty);
	
	
	var gvnAmt=parseFloat(gvnQty)*parseFloat(rate);
	//alert(gvnAmt);
	$("#gvn_amt"+itemId).html(gvnAmt.toFixed(2));


	
	
};


</script >




<script>

 document.getElementById("gvn_photo1").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
        // get loaded data and render thumbnail.
        document.getElementById("image").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

</script>


	<!-- <script type="text/javascript">
$(document).ready(function() {
	
	
    $('#menu').change(
            function() {
            	
                $.getJSON('${findItemsByCatId}', {
                    catId : $(this).val(),
                    ajax : 'true'
                }, function(data) {
                
                    var len = data.length;

					$('#items')
				    .find('option')
				    .remove()
				    .end()
				 $("#items").append($("<option></option>").attr( "value",-1).text("ALL"));
                    for ( var i = 0; i < len; i++) {
                            
                                
                        $("#items").append(
                                $("<option></option>").attr(
                                    "value", data[i].id).text(data[i].itemName)
                            );
                    }

                    $("#items").trigger("chosen:updated");


                });
            });
});
</script> -->

</body>
</html>