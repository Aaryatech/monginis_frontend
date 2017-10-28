<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>



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

<!--selectlistbox-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.selectlistbox.js"></script>
<script>
function createByJson() {
	var jsonData = [					
					{description:'Choos your payment gateway', value:'', text:'Payment Gateway'},					
					{image:'${pageContext.request.contextPath}/resources/images/msdropdown/icons/Amex-56.png', description:'My life. My card...', value:'amex', text:'Amex'},
					{image:'${pageContext.request.contextPath}/resources/images/msdropdown/icons/Discover-56.png', description:'It pays to Discover...', value:'Discover', text:'Discover'},
					{image:'${pageContext.request.contextPath}/resources/images/msdropdown/icons/Mastercard-56.png', title:'For everything else...', description:'For everything else...', value:'Mastercard', text:'Mastercard'},
					{image:'${pageContext.request.contextPath}/resources/images/msdropdown/icons/Cash-56.png', description:'Sorry not available...', value:'cash', text:'Cash on devlivery', disabled:true},
					{image:'${pageContext.request.contextPath}/resources/images/msdropdown/icons/Visa-56.png', description:'All you need...', value:'Visa', text:'Visa'},
					{image:'${pageContext.request.contextPath}/resources/images/msdropdown/icons/Paypal-56.png', description:'Pay and get paid...', value:'Paypal', text:'Paypal'}
					];
	$("#byjson").msDropDown({byJson:{data:jsonData, name:'payments2'}}).data("dd");
}
$(document).ready(function(e) {		
	//no use
	try {
		var pages = $("#pages").msDropdown({on:{change:function(data, ui) {
												var val = data.value;
												if(val!="")
													window.location = val;
											}}}).data("dd");

		var pagename = document.location.pathname.toString();
		pagename = pagename.split("/");
		pages.setIndexByValue(pagename[pagename.length-1]);
		$("#ver").html(msBeautify.version.msDropdown);
	} catch(e) {
		//console.log(e);	
	}
	
	$("#ver").html(msBeautify.version.msDropdown);
		
	//convert
	$("select").msDropdown({roundedBorder:false});
	createByJson();
	$("#tech").data("dd");
});
function showValue(h) {
	console.log(h.name, h.value);
}
$("#tech").change(function() {
	console.log("by jquery: ", this.value);
})
//
</script>
<!--selectlistbox-->

<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
var todaysDate=new Date();
var min=new Date(todaysDate.setDate(todaysDate.getDate()+2));

  $( function() {
    $( "#datepicker" ).datepicker({ dateFormat: 'dd-mm-yy', minDate:min}
    	);
  } );
  $( function() {
    $( "#datepicker2" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
  $( function() {
    $( "#datepicker3" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
  $( function() {
    $( "#datepicker4" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
  $( function() {
    $( "#datepicker5" ).datepicker({ dateFormat: 'dd-mm-yy' });
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
						<h2 class="pageTitle">Special Day Cake Order</h2>
						<!--<h3 class="pageTitle2">Order Date : 22-02-2017 </h3>-->
					</div>

					<form name="frm_search" id="frm_search" method="post"
						action="searchItems">
						<input type="hidden" name="mod_ser" id="mod_ser"
							value="search_result">

						<div class="colOuter">
							<div class="col1">
								<div class="col1title">Select Day</div>
							</div>
							<div class="col2full">
								<select name="spdayId" id="spdayId" required>
										<option value="0">Select Day</option>

								 <c:forEach items="${configureSpDayFrList}" var="configureSpDayFr" varStatus="count">
									
									  <%--   <c:choose>
									   <c:when test="${spdayId=='0'}"> --%>
								    
									
									   	<option value="${configureSpDayFr.spdayId}">${configureSpDayFr.spdayName}</option>
									   
							    <%--        </c:when>
							           
							           <c:otherwise>
							           
							           
							           
							           </c:otherwise>
							           
							           
									 	</c:choose> --%>
									 	
									 	
									   
									</c:forEach>
									
									
									
								
									
									
									
								
								</select>
							</div>
						</div>

						<div class="colOuter">
							<div class="col1">
								<div class="col1title">Delivery Date</div>
							</div>
							<div class="col2">
								<input id="datepicker" class="texboxitemcode texboxcal"
									placeholder="Delivery Date" name="datepicker" type="text" value="${delDate}">
							</div>
						</div>

						<div class="colOuter">
							<div class="col2full">
								<input name="" class="buttonsaveorder" value="Search..."
									type="submit">
							</div>
						</div>

					</form>
	
					<form action="${pageContext.request.contextPath}/saveSpDayCakeOrder"
						name="form1" method="post">
						
					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->
						<ul class="cd-tabs-content">
							<!--tab1-->
							<li data-content="tab1" class="selected">
								<div class="table-responsive">
									<div class="shInnerwidth">


	                     <input type="hidden" name="menuId" value="${menuId}">
						<input type="hidden" name="rateCat" value="${frDetails.frRateCat}">



										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="table">
											<tr>
												<td align="center" valign="middle" style="padding: 0px;">
													<c:set var="selectedMenu" scope="session"
														value="${selectedMenu}" /> 

															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr class="bgpink">

																<td>Item Name</td>
																<td>Quantity</td>
																<td>MRP</td>
																<td>Rate</td>
																<td>Total</td>
															</tr>

																	<c:forEach var="items" items="${itemList}"
																varStatus="loop">

																	<c:choose>
																		<c:when test="${frDetails.frRateCat=='1'}">
																			<tr>

																				<td><c:out value='${items.itemName}' /></td>
																				<td><input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}' class="tableInput"
																					type="number" onkeydown="myFunction()"
																					onchange="onChange('${items.itemRate1}',${items.id})"></td>
																				<td><c:out value='${items.itemMrp1}' /></td>

																				<td><c:out value='${items.itemRate1}' /></td>
																				<c:set var="rate" value="${items.itemRate1}" />
																				<c:set var="qty" value="${items.itemQty}" />
																				<td id="total${items.id}"><c:out
																						value='${rate * qty}' /></td>
																			</tr>
																		</c:when>

																		<c:when test="${frDetails.frRateCat=='2'}">
																			<tr>

																				<td><c:out value='${items.itemName}' /></td>
																				<td><input name='${items.id}'
																					id='${items.itemId}' value='${items.itemQty}'
																					class="tableInput" type="text"
																					onchange="onChange('${items.itemRate2}',${items.id})"></td>
																				<td><c:out value='${items.itemMrp1}' /></td>

																				<td><c:out value='${items.itemRate2}' /></td>
																				<c:set var="rate" value="${items.itemRate2}" />
																				<c:set var="qty" value="${items.itemQty}" />
																				<td id="total${items.id}"><c:out
																						value='${rate * qty}' /></td>
																			</tr>
																		</c:when>

																		<c:when test="${frDetails.frRateCat=='3'}">
																			<tr>

																				<td><c:out value='${items.itemName}' /></td>
																				<td><input name='${items.id}' id='${items.id}'
																					value='${items.itemQty}' class="tableInput"
																					type="text" 
																					onchange="onChange('${items.itemRate3}',${items.id})"></td>
																				<td><c:out value='${items.itemMrp3}' /></td>

																				<td><c:out value='${items.itemRate3}' /></td>
																				<c:set var="rate" value="${items.itemRate3}" />
																				<c:set var="qty" value="${items.itemQty}" />
																				<td id="total${items.id}"><c:out
																						value='${rate * qty}' /></td>
																			</tr>
																		</c:when>
																	</c:choose>

															
															</c:forEach>




															</table>
															<br />
													




															







												</td>
											</tr>
										</table>
									</div>
								</div>
							</li>
							<!--tab1-->

							<!--tab2-->

							<!--tab2-->

							<!--tab3-->

							<!--tab4-->
						</ul>
					</div>
					<!--tabNavigation-->

					<!--<div class="order-btn"><a href="#" class="saveOrder">SAVE ORDER</a></div>-->
					<div class="order-btn textcenter">

							<input name="" class="buttonsaveorder" value="SAVE ORDER"
								type="button" ONCLICK="button1()">
						</div>



					</form>

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
	<script src="http://monginisaurangabad.com/js/main.js"></script>
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

	<script type="text/javascript">
           
            function button1()
            {

             //   document.form1.buttonName.value = "SAVE ORDER";
                form1.submit();
            }    
           
        </script>

	<script type="text/javascript">
		function onChange(rate,id) {

			//calculate total value  
			var qty = $('#'+id).val();
			
			var total = rate * qty;
			
			  $('#total'+id).html(total);
			
		}
	</script>

	<script type="text/javascript">
		function onKeyDown(id) {
			alert("alert");
			var e = $('#'+id).val();
			
			if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
		             // Allow: Ctrl/cmd+A
		            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: Ctrl/cmd+C
		            (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: Ctrl/cmd+X
		            (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
		             // Allow: home, end, left, right
		            (e.keyCode >= 35 && e.keyCode <= 39)) {
		                 // let it happen, don't do anything
		                 return;
		        }
		        // Ensure that it is a number and stop the keypress
		        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))) {
		            e.preventDefault();
		        }
		    };
			
		}
</script>
<script type="text/javascript">
$(document).ready(function() {
    $("#5").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl/cmd+A
            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: Ctrl/cmd+C
            (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: Ctrl/cmd+X
            (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))) {
            e.preventDefault();
        }
    });
});
</script>

</body>
</html>
