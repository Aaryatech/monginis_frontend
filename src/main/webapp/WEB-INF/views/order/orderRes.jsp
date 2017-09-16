<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

    
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
<h2 class="pageTitle">Order Special Cake</h2>
</div>


<!--formBox-->
<div class="ordercake">
<!--leftForm-->
  


<div class="left">


	<div class="fullform">
		<div class="cackleft2">Item Code</div>
		<div class="cackrighttexbox">${specialCake.itemId}</div>
	</div>




	<div class="fullform">
		<div class="cackleft">Name</div>
		<div class="cackright"><span class="cakename">${spName}</span></div>
	</div>
	
	<div class="fullform">
		<div class="cackimg">
		<div class="cackimglable"><img src="http://monginisaurangabad.com/images/lable-premium.png" alt="img"></div>
		<!--<div class="cackimglable"><img src="http://monginisaurangabad.com/images/lable-regular.png" alt="img"></div>-->
		<img src="http://monginisaurangabad.com/uploads/mongiImage/SpecialCake/${spImage}" alt="Tier -Series"></div>
	</div>
        
	<div class="fullform">
		<div class="cackleft">Min Weight</div>
		<div class="cackright">${specialCake.spMinWeight} kg</div>
	</div>
	
	<div class="fullform">
		<div class="cackleft">Max Weight</div>
		<div class="cackright">${specialCake.spMaxWeight} kg</div>
	</div>
	
	<div class="fullform">
		<div class="cackleft">Production Time</div>
		<div class="cackright">${productionTime} Days</div>
	</div>
	
	<div class="fullform">
		<div class="cackleft">Earliest Delivery Date</div>
		<div class="cackright">${specialCake.spEstDelDate}</div>
	</div>
	
</div>
<!--leftForm-->


	
<!--centerForm-->	
<div class="center">

	<div class="colOuter">
		<div class="col1"><div class="col1title">Type</div></div>
		<div class="col2full">
			<c:choose>
		<c:when test="${spType=='0'}">
				FC
				
		</c:when>
		<c:when test="${spType='1'}">
				
				Chocolate
		</c:when>				
						
						
	</c:choose>
			</div>
	</div>
    
<div class="colOuter">
		<div class="col1"><div class="col1title">Flavour</div></div>
		<div class="col2full">
        	${flavourName}			</div>
	</div>    
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Weight</div></div>
		<div class="col2">
      ${specialCake.spWeight} Kg		</div>
	</div>
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Event</div></div>
		<div class="col2">
       ${specialCake.spEvents} - ${specialCake.spEventsName}		</div>
	</div>
	<c:choose>
		<c:when test="${spPhoUpload=='1'}">
	<div class="colOuter">
		<div class="col1"><div class="col1title">Photo</div></div>
		<div class="col2full">
        <img src="http://monginisaurangabad.com/uploads/sp_order/0nsAOrLqsJScreenshotfrom20170817161141.png" alt="img">
        </div>
	</div>
    </c:when>
    </c:choose>
    
	<div class="colOuter">
		<div class="col1"><div class="col1title">Special Instructions</div></div>
		<div class="col2full">${specialCake.spInstructions}</div>
	</div>
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Delivery Date</div></div>
		<div class="col2">${specialCake.spDeliveryDt}</div>
	</div>
	
	<div class="colOuter">
		<div class="col1">
       ${specialCake.spCustName}       </div>
		<div class="col2">
        ${specialCake.spCustDOB}       </div>
		<div class="col3">
        ${specialCake.spCustMobileNo}        </div>
	</div>
	
	<div class="colOuter">
		<div class="col1">
		 ${specialCake.spBookedForName} 
                </div>
		<div class="col2">
		 ${specialCake.spBookForDOB} 
                </div>
		<div class="col3">
		 ${specialCake.spBookForNumber} 
                </div>
	</div>
	
	
</div>
<!--centerForm-->

<!--rightForm-->	
<div class="right">
	<div class="priceBox">
		<h2 class="inrbox">INR - 
        <span id="pro_grand_totla_1">
		 ${specialCake.spGrand}</span></h2>
        
		<div class="inrboxmiddle">
			<ul>
				<li>
					<div class="priceLeft">Type </div>
					<div class="priceRight"><span>Premium</span></div>
				</li>
				<li>
					<div class="priceLeft">Price </div>
					<div class="priceRight" id="pro_price">${specialCake.spPrice}</div>
				</li>
				<li>
					<div class="priceLeft">Add Rate </div>
					<div class="priceRight" id="pro_adon_price">${specialCake.spAddRate}</div>
                    
				</li>
				<li>
					<div class="priceLeft">Sub Total </div>
					<div class="priceRight" id="pro_total_price">${specialCake.spSubTotal}</div>
                   
				</li>
				
				<li class="total">
					<div class="priceLeft">TOTAL</div>
					<div class="priceRight" id="pro_grand_totla">
					${specialCake.spGrand}</div>
				</li>
				
				<li class="advance">
					<div class="priceLeft">Advance</div>
					<div class="priceRight">${specialCake.spAdvance}</div>
				</li>
			</ul>
		</div>
		<div class="remainamount">
			<div class="priceLeft">Remaining Amount</div>
           
					<div class="priceRight" id="rem_amount">
					
				${specialCake.rmAmount}        </div>
		</div>

	
	</div>	
    
    </div>
    

<!--rightForm-->

<!--<div class="messages messagesErr">err message</div>
<div class="messages messagesInfo">info message</div>
<div class="messages messagesSuccess">success message </div>-->
	
</div>


<!--formBox-->

 
		
</div>
	<a href="http://monginisaurangabad.com/index.php/dashboard/special_cake"><h1><< Back</h1></a>
<br/>    
	<a href="http://monginisaurangabad.com/invoices/1337.pdf" target="_blank"><h1>PDF</h1></a>
<!--rightSidebar-->

</div>
<!--fullGrid-->
</div>
<!--rightContainer-->

</div>
<!--wrapper-end-->
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
