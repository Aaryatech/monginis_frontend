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
							<form
								action="${pageContext.request.contextPath}/getGvnBillDetails"
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
								name="grn_add" id="grn_add" enctype="multipart/form-data"
								method="post">
								<div class="shInnerwidth">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="table">
										<tr>
											<td align="center" valign="middle" style="padding: 0px;">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr class="bgpink">
														<td width="50">Sr No.</td>
														<td width="50">Bill No</td>
														<td width="70">Bill Date</td>

														<td width="100">Item Name</td>


														<td width="100">GVN QTY</td>
														<td width="100">Item Rate</td>
														<td width="100">Tax Percentage</td>




														<td width="100">GVN Amount</td>
														<td width="200">GVN Remark</td>
														<td width="150">PHOTO 1</td>
														<td width="150">PHOTO 2</td>

													</tr>


													<c:forEach items="${gvnConfList}" var="gvnConfList"
														varStatus="count">
														<tr>

															<td>${count.index+1}<input type="hidden"
																name="gvnIdForPhoto" value="${gvnConfList.itemId * 2}"></td>

															<td>${gvnConfList.billNo}</td>
															<td>${gvnConfList.billDate}</td>
															<td>${gvnConfList.itemName}</td>

															<td><input type="text"
																name="gvn_qty${gvnConfList.itemId}"
																id="gvn_qty${gvnConfList.itemId}" value="0" size="5"
																onkeyup="calcGvn(${gvnConfList.calcBaseRate},${gvnConfList.itemId},${gvnConfList.sgstPer},${gvnConfList.cgstPer})" /></td>




															<td>${gvnConfList.calcBaseRate}</td>
															
															<td id="tax_per${gvnConfList.itemId}"><c:out
																	value="00"></c:out></td>
															
															
															<td id="gvn_amt${gvnConfList.itemId}"><c:out
																	value="00"></c:out></td>

															<td><textarea name="gvn_remark${gvnConfList.itemId}"
																	id="gvn_remark${gvnConfList.itemId}" ></textarea></td>


															<%-- <td><input type="text"
																name="gvn_remark${gvnConfList.itemId}" id=grn_remark
																value="" placeholder="Gvn Remark" /></td> --%>
															<%-- <td>
																	<div class="colOuter">
																	<div class="col1">
																			<div class="col1title"></div>
																		</div>
																		<div class="col2full">
																			<div class="editimg">
																				<div class="editpics">
																					<div class="fileUpload">
																						<span> <i class="fa fa-pencil"></i></span> <input
																							class="upload" type="file" id="gvn_photo1${gvnConfList.itemId}"
																							name="gvn_photo1" />


																					</div>
																				</div>
																				 <img id="image" />
																				<img id="image" src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image"> 
																			</div>
																		</div>
																	</div>
																</td>

																<td><div class="colOuter">
																		<div class="col1">
																			<div class="col1title"></div>
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
																				<img id="image" src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" >
																			</div>
																		</div>
																	</div>
																	</td>
										 --%>




															<td>
																<div class="form-group">
																	<!-- 									<div class="col-sm-9 col-lg-10 controls">
 -->
																	<div class="fileupload fileupload-new"
																		data-provides="fileupload">
																		<div class="fileupload-new img-thumbnail"
																			style="width: 30px; height: 40px;">
																			<img
																				src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
																				alt="" />
																		</div>
																		<div
																			class="fileupload-preview fileupload-exists img-thumbnail"
																			style="max-width: 60px; max-height: 40px; line-height: 10px;"></div>
																		<div>
																			<span class="btn btn-default btn-file"><span
																				class="fileupload-new">Select image</span> <span
																				class="fileupload-exists">Change</span> <input
																				type="file" class="file-input" name="gvn_photo1"
																				id="gvn_photo1${gvnConfList.itemId}"
																				data-rule-required="true" /></span> <a href="#"
																				class="btn btn-default fileupload-exists"
																				data-dismiss="fileupload">Remove</a>
																		</div>
																	</div>

																</div> <!-- </div> -->
															</td>

															<td>

																<div class="form-group">

																	<!-- 									<div class="col-sm-9 col-lg-10 controls">
 -->
																	<div class="fileupload fileupload-new"
																		data-provides="fileupload">
																		<div class="fileupload-new img-thumbnail"
																			style="width: 30px; height: 40px;">
																			<img
																				src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
																				alt="" />
																		</div>
																		<div
																			class="fileupload-preview fileupload-exists img-thumbnail"
																			style="max-width: 60px; max-height: 40px; line-height: 10px;"></div>
																		<div>
																			<span class="btn btn-default btn-file"><span
																				class="fileupload-new">Select image</span> <span
																				class="fileupload-exists">Change</span> <input
																				type="file" class="file-input" name="gvn_photo2"
																				id="gvn_photo2${gvnConfList.itemId}"
																				data-rule-required="true" /></span> <a href="#"
																				class="btn btn-default fileupload-exists"
																				data-dismiss="fileupload">Remove</a>
																		</div>
																	</div>

																</div> <!-- 								</div>

 -->
															</td>


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
function calcGvn(baseRate,itemId,sgstPer,cgstPer){
	
	var gvnQty=$("#gvn_qty"+itemId).val();
	//alert(gvnQty);
	
	
	var gvnAmt=parseFloat(gvnQty)*parseFloat(baseRate);
	//alert(gvnAmt);
	//$("#gvn_amt"+itemId).html(gvnAmt.toFixed(2));

	 var taxableAmt=baseRate*gvnQty;
		
		var totalTax=(taxableAmt*(sgstPer+cgstPer))/100;
		
		var grandTotal=taxableAmt+totalTax;
		
		$("#gvn_amt"+itemId).html(grandTotal.toFixed(2));
		
		
		var taxPer=parseFloat(sgstPer)+parseFloat(cgstPer);
		$("#tax_per"+itemId).html(taxPer.toFixed(2));

var x=$("#gvn_remark"+itemId).val();
if(gvnQty>0){
		
		if(x ==null ||x == ""){
			alert("Enter Remark");
			
		    document.getElementById("gvn_remark"+itemId).focus();
		    
		}
}
};


</script>




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

	<script type="text/javascript">

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#blah')
                .attr('src', e.target.result)
                .width(150)
                .height(200);
        };

        reader.readAsDataURL(input.files[0]);
    }
}

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