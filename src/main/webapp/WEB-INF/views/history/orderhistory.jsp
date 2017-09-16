<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib
    uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
  
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>Monginis</title>
<link href="${pageContext.request.contextPath}/resources/css/monginis.css" rel="stylesheet" type="text/css"/>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/feviconicon.png" type="image/x-icon"/> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>

<!--rightNav-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/menuzord.js"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery("#menuzord").menuzord({
		align:"left"
	});
});
</script>
<!--rightNav-->

<!--selectlistbox-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.selectlistbox.js"></script>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
  $( function() {
    $( "#datepicker" ).datepicker();
  } );
  $( function() {
    $( "#datepicker2" ).datepicker();
  } );
  $( function() {
    $( "#datepicker3" ).datepicker();
  } );
  $( function() {
    $( "#datepicker4" ).datepicker();
  } );
  $( function() {
    $( "#datepicker5" ).datepicker();
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
                <jsp:param name="myMenu" value="${menuList}"/>
        
    </jsp:include>


<!--leftNav-->



<!--rightSidebar-->
<div class="sidebarright">
<div class="order-left">
<h2 class="pageTitle">Order History</h2>
<!--<h3 class="pageTitle2">Order Date : 22-02-2017 </h3>-->
</div>

<form name="frm_search" id="frm_search" method="post" action="itemHistory">
<input type="hidden" name="mod_ser" id="mod_ser" value="search_result">

<div class="colOuter">
		<div class="col1"><div class="col1title">Group</div></div>
		<div class="col2full"><select name="group" id="group" required>
              <option value="">Select Type</option>
           <option value="${menuId}" selected>${menuTitle}</option>
									<c:forEach items="${menusList}" var="menusList">
              <option value="${menusList.menuId}">${menusList.menuTitle}</option>
           </c:forEach>   
            </select>
			</div>
	</div>

	<div class="colOuter">
		<div class="col1"><div class="col1title">Delivery Order / GRN / GVN  Date</div></div>
		<div class="col2"><input id="datepicker" class="texboxitemcode texboxcal" placeholder="Delivery Date"  name="datepicker" type="text" value="${spDeliveryDt}" >
		</div>
	</div>
	
<div class="colOuter">
		<div class="col2full">
        	<input name="" class="buttonsaveorder" value="Search..." type="submit">
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

	
	

	

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
  <tr>
    <td align="center" valign="middle" style="padding:0px;">
         <c:set var = "selectedMenu" scope = "session" value = "${selectedMenu}"/>

<c:choose>
    <c:when test="${selectedMenu.getIsSameDayApplicable()=='0'}">
       
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="bgpink">
    <td style="width:130px;">Type</td>
    <td style="width:130px;">Item Code</td>
    <td>Item Name</td>
    <td>MRP</td>
    <td>Quantity</td>
    <td>Rate</td>
    <td>Total</td>
  </tr>

 <c:forEach items="${orderHistory}" var="orderList"> 
  <tr>
    <td><c:out value="${orderList.orderType}"/></td>
    <td><c:out value="${orderList.itemId}"/></td>
    <td><c:out value="${orderList.itemName}"/></td>
    <td><c:out value="${orderList.orderMrp}"/></td>
    <td><c:out value="${orderList.orderQty}"/></td>
    <td><c:out value="${orderList.orderRate}"/></td>
    <td><c:out value="00"/></td>
  </tr>
  </c:forEach>   
  
 
  

</table>
        <br />
    </c:when>  
      <c:when test="${selectedMenu.getIsSameDayApplicable()=='1'}">
       
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="bgpink">
    <td style="width:130px;">Type</td>
    <td style="width:130px;">Item Code</td>
    <td>Item Name</td>
    <td>MRP</td>
    <td>Quantity</td>
    <td>Rate</td>
    <td>Total</td>
  </tr>

 <c:forEach items="${orderHistory}" var="orderList"> 
  <tr>
    <td><c:out value="${orderList.orderType}"/></td>
    <td><c:out value="${orderList.itemId}"/></td>
    <td><c:out value="${orderList.itemName}"/></td>
    <td><c:out value="${orderList.orderMrp}"/></td>
    <td><c:out value="${orderList.orderQty}"/></td>
    <td><c:out value="${orderList.orderRate}"/></td>
    <td><c:out value="00"/></td>
  </tr>
  </c:forEach>   
  
 
  

</table>
        <br />
    </c:when>     
    <c:otherwise>
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="bgpink">
    <td style="width:130px;">Item Code</td>
    <td style="width:130px;">Item Name</td>
    <td style="width:130px;">Flavour</td>
    <td>Event</td>
    <td>Delivery Date</td>
    <td>Rate</td>
    <td>Add Rate</td>
    <td>Total</td>
    <td>View</td>
    <td>PDF</td>
  </tr>
 <c:forEach items="${orderHistory}" var="orderList"> 
  <tr>
    <td><c:out value="${orderList.spId}"/></td>
    <td><c:out value="${orderList.spName}"/></td>
      <td><c:out value="${orderList.spfName}"/></td>
    <td><c:out value="${orderList.spEvents}"/></td>
    <td><c:out value="${orderList.spDeliveryDt}"/></td>
    <td><c:out value="${orderList.spPrice}"/></td>
    <td><c:out value="${orderList.spAddRate}"/></td>
    <td><c:out value="${orderList.spGrand}"/></td>
    <td><c:out value="${orderList.spGrand}"/></td>
    <td><c:out value="${orderList.spGrand}"/></td>
    
  </tr>
  </c:forEach>   
  
 
  

</table>
        <br />
    </c:otherwise>
</c:choose>

   






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
<a href="http://monginisaurangabad.com/index.php/dashboard/order_export?sel_group=1&sel_date=2017-09-05" class="buttonsaveorder">EXPORT TO EXCEL</a>
<!--<input name="" class="buttonsaveorder" value="EXPORT TO EXCEL" type="button">-->
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



</body>
</html>
