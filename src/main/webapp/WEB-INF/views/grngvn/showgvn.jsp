<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


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
					<div class="col-md-12">
						<h2 class="pageTitle">Apply GVN</h2>
					</div>
				</div>

				<br />

				<div class="row">
					<div class="col-md-12">
						<!--table-->
						<form
							action="${pageContext.request.contextPath}/getGvnBillDetails"
							name="grn" id="grn" method="get">

							<div class="colOuter">
<div class="col-md-2">
					<h4>Select Bill </h4>
				</div>

								<div class="col-md-3">
									<select name="bill_no" id="bill_no"  style="width: 250px; background-color: white; height: 40px" >
										<option value="0">--Select BILL--</option>

										<c:forEach items="${frBillList}" var="frBillList">


											<option value="${frBillList.billNo}">Bill No- ${frBillList.billNo} Bill Date- ${frBillList.billDate}</option>

										</c:forEach>

									</select>

								</div>

								<br>


								<!-- 	<div class="form-group"> -->
																	<div class="col-sm-9 col-sm-offset-6 col-lg-5 col-lg-offset-0">


<!-- 								<div class="col-md-4">
 -->
									<button type="submit" class="buttonsaveorder" style=" width: 100px; height: 40px">
										 Search
									</button>
									<!--<button type="button" class="btn">Cancel</button>-->

								</div>
							</div>
							<!-- </div> -->
						</form>

					</div>
					<!-- 						</form>
 -->
					<form action="${pageContext.request.contextPath}/addGvnProcess"
						name="grn_add" id="grn_add" enctype="multipart/form-data"
						method="post">

						<div class="clearfix"></div>

						<div id="table-scroll" class="table-scroll">
							<div id="faux-table" class="faux-table" aria="hidden"></div>
							<div class="table-wrap">
								<table id="table_grid" class="main-table">
									<thead>
										<tr class="bgpink">
										<!-- 	<th class="col-md-1">Sr No.</th>
											<th class="col-md-1">Bill No</th>
											<th class="col-md-1">Date</th> -->
											<th class="col-md-2">Item Name</th>
											<th class="col-md-1">QTY</th>
											<th class="col-md-1">Rate</th>
											<th class="col-md-1">Tax %</th>
											<th class="col-md-1">Amount</th>
											<th class="col-md-1">Remark</th>
											<th class="col-md-1">PHOTO 1</th>
											<th class="col-md-1">PHOTO 2</th>

										</tr>
									</thead>
									<tbody>

										<c:forEach items="${gvnConfList}" var="gvnConfList"
											varStatus="count">
											<tr>

												<%-- <td class="col-md-1">${count.index+1}<input
													type="hidden" name="gvnIdForPhoto"
													value="${gvnConfList.itemId * 2}"></td>

												<td class="col-md-1">${gvnConfList.billNo}</td>
												<td class="col-md-1">${gvnConfList.billDate}</td> --%>
												<td class="col-md-2">${gvnConfList.itemName}</td>

												<td class="col-md-1"><input type="text"
													name="gvn_qty${gvnConfList.itemId}"
													id="gvn_qty${gvnConfList.itemId}" size="5"
													onkeyup="calcGvn(${gvnConfList.calcBaseRate},${gvnConfList.itemId},${gvnConfList.sgstPer},${gvnConfList.cgstPer})" /></td>

												<td class="col-md-1">${gvnConfList.calcBaseRate}</td>

												<td class="col-md-1" id="tax_per${gvnConfList.itemId}"><c:out
														value="00"></c:out></td>


												<td class="col-md-1" id="gvn_amt${gvnConfList.itemId}"><c:out
														value="00"></c:out></td>

												<%-- <td class="col-md-1"><textarea
														name="gvn_remark${gvnConfList.itemId}"
														id="gvn_remark${gvnConfList.itemId}"></textarea></td>
														
														 --%>
														
																<td class="col-md-1">
																<select name="gvn_remark${gvnConfList.itemId}" style="width: 200px"
																id="gvn_remark${gvnConfList.itemId}" class="form-control" >
																<option selected  value="selectRemark">Select Remark</option>
																<c:forEach items="${remarkList}" var="remarkList">
																${remarkList.remark}
																<option value="${remarkList.remark}">${remarkList.remark}</option>
																</c:forEach>
																</select></td>

												<td class="col-md-1">

													<div class="form-group">


														<div class="fileUpload">
															<input class="upload upld" type='file' name="gvn_photo1"
																id="gvn_photo1${gvnConfList.itemId}"
																data-rule-required="true" /> <img style="width: 45px"
																src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
																alt="" />
														</div>


														<!-- <a href="#" data-dismiss="fileupload"><i
															class="fa fa-close"></i></a>
 -->
													</div> <!-- </div> -->
												</td>

												<td class="col-md-1">

													<div class="form-group">
														<div>
															<div class="fileUpload">
																<input class="upload upld" type='file' name="gvn_photo2"
																	id="gvn_photo2${gvnConfList.itemId}"
																	data-rule-required="true" /> <img style="width: 45px"
																	src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
																	alt="" />
															</div>


															<!-- <a href="#" data-dismiss="fileupload"><i
																class="fa fa-close"></i></a> -->
														</div>


													</div> <!-- 								</div>
 -->
												</td>

											</tr>

										</c:forEach>

									</tbody>

								</table>
							</div>
						</div>


						<div class="form-group">

							<button type="submit" class="buttonsaveorder">
								<i class="fa fa-check"></i> Save
							</button>
							<!--<button type="button" class="btn">Cancel</button>-->

						</div>
					</form>
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

<!--easyTabs-->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<!--easyTabs-->
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
});

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
	
	var gvnQty=$("#gvn_qty"+itemId).val()
	//alert(gvnQty);
	//$("#gvn_qty"+itemId).html(gvnQty);

	
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

<script type="text/javascript">
function readURL(input) {

    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $(input).next('img').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

$(".upld").change(function () {
    readURL(this);
});

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