<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate,java.util.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
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
<h2 class="pageTitle">Order Special Cake</h2>
</div>


 <!--formBox-->
<div class="ordercake">
<!--leftForm-->
<div class="left">

  <form action="searchSpCake" method="post" class="form-horizontal" name="form" onsubmit="return validateForm()">
  
	  <div class="fullform">
		<div class="cackleft2">Item Code</div>
		<div class="cackrighttexbox"><input class="texboxitemcode" id="sp_code" value="${specialCake.spCode}" name="sp_code" type="text">
		<div class="searchrecord"><input name="" class="btnsearch" value="" type="submit"> </div>
	   </div>
     </div>
 </form>
	
	<div class="fullform">
		<div class="cackleft">Name</div>
		<div class="cackright" id="sp_name"><span class="cakename">${specialCake.spName}</span></div>
	</div>

	<div class="fullform">
		<div class="cackimg">
		<div class="cackimglable"></div>
		<img src="${url}${spImage}" alt="image"></div>
	</div>


	<div class="fullform">
		<div class="cackleft">Min Weight</div>
		<div class="cackright" id="spMinWt">${specialCake.spMinwt}Kg</div>
	</div>
	
	<div class="fullform">
		<div class="cackleft">Max Weight</div>
		<div class="cackright"id="spMaxWt">${specialCake.spMaxwt}Kg</div>
	</div>
	
	<div class="fullform">
		<div class="cackleft">Production Time</div>
		<div class="cackright"id="spProTime">${specialCake.spBookb4}Days</div>
	</div>
	<c:set var="p" value="${specialCake.spCode}"/>
	<div class="fullform">
    <div class="cackleft">Earliest  Delivery Date</div>
    <div class="cackright" > 

  
<c:set var="increment" value="${spBookb4}"></c:set>

<%
int incr=(int) pageContext.getAttribute("increment");
// Create a Calendar object
Calendar calendar = Calendar.getInstance();

// Get current day from calendar
int day = calendar.get(Calendar.DATE);
// Get current month from calendar
int month = calendar.get(Calendar.MONTH) + 1;  
// Get current year from calendar
int year = calendar.get(Calendar.YEAR);
calendar.add(Calendar.DATE, incr);

day = calendar.get(Calendar.DATE);
month = calendar.get(Calendar.MONTH);  
year = calendar.get(Calendar.YEAR);

Calendar cal = Calendar.getInstance();

cal.set(year, month, day);
Date date = cal.getTime();
SimpleDateFormat formatter = new SimpleDateFormat("dd MMM yyyy");

String fDate = formatter.format(date);
System.out.println(""+fDate);
SimpleDateFormat formatter1 = new SimpleDateFormat("MM-dd-yyyy");

String fDate1 = formatter1.format(date);
%>
<%=fDate %>
    </div>
	</div>
	
</div>

<!--leftForm-->
<form action="orderSpCake"  method="post" class="form-horizontal" name="from_ord" id="from_ord" enctype="multipart/form-data">

<input type="hidden" name="mode_add" id="mode_add" value="add_book">


<input type="hidden" name="sp_id" id="sp_id" value="${specialCake.spId}">

<input type="hidden" name="sp_min_weight" id="sp_min_weight" value="${specialCake.spMinwt}">
<input type="hidden" name="sp_max_weight" id="sp_max_weight" value="${specialCake.spMaxwt}">
<input type="hidden" name="sp_pro_time" id="sp_pro_time" value="${specialCake.spBookb4}">
<input type="hidden" name="sp_est_del_date" id="sp_est_del_date" value="<%= fDate1%>">
<input type="hidden" name="production_time" id="production_time" value="${specialCake.spBookb4} ">
<input type="hidden" name="sp_code" id="sp_code" value="${specialCake.spCode}">
<input type="hidden" name="sp_name" id="sp_name" value="${specialCake.spName}">
<input type="hidden" name="fr_code" id="fr_code" value="4">
<input type="hidden" name="spPhoUpload" id="spPhoUpload" value="${specialCake.spPhoupload}">
<input type="hidden" name="isCustCh" id="isCustCh" value="${specialCake.isCustChoiceCk}">
<!-- <input type="hidden" name="tax_1" id="tax_1" value="0.00">
<input type="hidden" name="tax_2" id="tax_2" value="0.00"> --><!-- 
<input type="hidden" name="tax_1_amt" id="tax_1_amt" value="0">
<input type="hidden" name="tax_2_amt" id="tax_2_amt" value="0">
<input type="hidden" name="min_weight" id="min_weight" value="5 kg">
<input type="hidden" name="max_weight" id="max_weight" value="8 kg">

<input type="hidden" name="earliest_delivery_date" id="earliest_delivery_date" value="11 Sep 2017"> -->
<!--centerForm-->	
<div class="center">

	 <div  class="colOuter">
		<div class="col1"><div class="col1title">Type</div></div>
		<div class="col2full">
         <select name="sptype" tabindex="-1" id="sptype">
              <option value="">Select Type</option>
                 <c:set var= "spCakeType" value="${specialCake.spType}"></c:set>
               <c:choose>
                   <c:when test="${spCakeType=='0'}"> <option value="0">FC</option>          </c:when>
                   <c:when test="${spCakeType=='1'}"> <option value="1">Chocolate</option>   </c:when> 
                <c:otherwise>
                      <option value="0">FC</option>
                      <option value="1">Chocolate</option>
                </c:otherwise>    
              </c:choose>
              
            </select>
			</div>
	</div>
    <div class="colOuter">
		<div class="col1"><div class="col1title">Flavour</div></div>
		<div class="col2full" >
                <select name="spFlavour"  tabindex="-1"  onchange="onChangeFlavour()"id="spFlavour">
        		     <option value=""> </option>
                     <option value="">Select Flavour</option>
               </select>
       </div>
	</div>  
	<!-- <div class="colOuter">
		<div class="col1"><div class="col1title">Weight</div></div>
		<div class="col2"><input class="texboxitemcode" name="" type="text"><div class="weightkg">kg</div>
		</div>
	</div> -->
	  
	<div class="colOuter">
		<div class="col1"><div class="col1title">Weight</div></div>
		<div class="col2">
		      <c:set var = "dbRate" scope = "session" value = "${specialCake.sprRate}"/>
		  <%--  <c:set var = "dbRate" scope = "session" value = "${sp_wt}"/>
		   		 <c:set var = "tRate" scope = "session" value = "${weight*dbRate}"/> --%>
		  <%int a=1; %>
        <select name="spwt" id="spwt" onchange="onChange('${dbRate}')">
 	    

        
         <c:forEach var ="i" begin ="${specialCake.spMinwt}" end ="${specialCake.spMaxwt}" step="1">
      <option value="${i}">${i}</option>
   
    
     <c:choose>
            <c:when test="${i != specialCake.spMaxwt}">
                <option value="${i+0.5}">${i+0.5}</option> 
            </c:when>
           
        </c:choose>
      
      </c:forEach>
                     
              
            </select><!--<div class="weightkg">kg</div>-->
			<div class="err" style="display:none;">Please Enter Weight</div>
		</div>
	</div>
	
	         
	<div class="colOuter">
		<div class="col1"><div class="col1title">Event</div></div>
		<div class="col2"><select name="sp_event" id="sp_event">
              <option value="">Select Event</option>
              <c:forEach items="${eventList.getEvent()}" var="eventList">
              <option value="${eventList.speName}"><c:out value="${eventList.speName}" /></option>
             </c:forEach>
            </select></div>
		<div class="col3"><input class="texboxitemcode" placeholder="Name" name="event_name" type="text" id="event_name">
		</div>
	</div>
	
		<c:choose>
		<c:when test="${specialCake.isCustChoiceCk=='1'}">
		
	<div class="colOuter">
	    <div class="col1"><div class="col1title">Photo Cake</div></div>
	    	<div class="col2full"><div class="editimg">
	    	    <div class="editpics">
	    	        <div class="fileUpload">
                                <span> <i class="fa fa-pencil"></i></span>
                                <input class="upload" type="file" id="order_photo" name="order_photo"/>
                                
                                
                            </div>
                            </div>
                             <img id="image" />
                           <!-- <img id="image" src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" alt="img">-->
                            </div>
                            </div>
                            </div>
	<div class="colOuter">
	    <div class="col1"><div class="col1title">Customer Choice Cake</div></div>
	    	<div class="col2full"><div class="editimg">
	    	    <div class="editpics">
	    	        <div class="fileUpload">
                                <span> <i class="fa fa-pencil"></i></span>
                                <input class="upload" type="file" id="cust_choice_ck" name="cust_choice_ck"/>
                                
                                
                            </div>
                            </div>
                             <img id="img" />
                           <!-- <img id="image" src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" alt="img">-->
                            </div>
                            </div>
                            </div>
	
	
	</c:when>
		
		
		
		
	<c:when test="${specialCake.spPhoupload=='1'}">
	
	<div class="colOuter">
	    <div class="col1"><div class="col1title">Photo Cake</div></div>
	    	<div class="col2full"><div class="editimg">
	    	    <div class="editpics">
	    	        <div class="fileUpload">
                                <span> <i class="fa fa-pencil"></i></span>
                                <input class="upload" type="file" id="order_photo" name="order_photo"/>
                                
                                
                            </div>
                            </div>
                             <img id="image" />
                           <!-- <img id="image" src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" alt="img">-->
                            </div>
                            </div>
                            </div>
	
	</c:when>
	<c:otherwise>
	</c:otherwise>

</c:choose>
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Special Instructions</div></div>
		<div class="col2full"><textarea class="textarea" name="sp_instructions" cols="" rows="" id="sp_instructions"></textarea></div>
	</div>
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Delivery Date</div></div>
		<div class="col2"><input id="datepicker" class="texboxitemcode texboxcal" placeholder="<%=fDate1 %>"  name="datepicker" type="text" >
		</div>
	</div>
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Place of Delivery</div></div>
		<div class="col2full"><input class="texboxitemcode" placeholder="Place of Delivery" name="sp_place" id="sp_place" type="text"></div>
	</div>    
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Book For Date</div></div>
		<div class="col2"><input id="datepicker3" class="texboxitemcode texboxcal" placeholder="<%=fDate1 %>" name="datepicker3" type="text">
		</div>
	</div>
	
	<div class="colOuter">
		<div class="col1"><input class="texboxitemcode texboxcal2" placeholder="Customer Name" name="sp_cust_name" type="text" id="sp_cust_name"></div>
		<div class="col2"><input id="datepicker4" class="texboxitemcode texboxcal" placeholder="DOB" name="datepicker4" type="text"></div>
		<div class="col3"><input class="texboxitemcode" placeholder="Mobile No." name="sp_cust_mobile_no" type="text" id="sp_cust_mobile_no"></div>
	</div>
	
	<div class="colOuter">
		<div class="col1"><input class="texboxitemcode texboxcal2" placeholder="Booked For" name="sp_booked_for_name" type="text"id="sp_booked_for_name"></div>
		<div class="col2"><input id="datepicker5" class="texboxitemcode texboxcal" placeholder="DOB" name="datepicker5" type="text"></div>
		<div class="col3"><input class="texboxitemcode" placeholder="Mobile No." name="sp_book_for_number" type="text"id="sp_book_for_number"></div>
	</div>
	
	
</div>
<!--centerForm-->
	
<!--rightForm-->	
<div class="right">
	<div class="priceBox">
		<h2 class="inrbox" id="INR">INR - ${specialCake.sprRate+specialCake.spTax1+specialCake.spTax2}</h2>
		 <input type="hidden" name="sp_grand" id="sp_grand" value="${specialCake.sprRate+specialCake.spTax1+specialCake.spTax2}">   
		<div class="inrboxmiddle">
			<ul>
				<li>
					<div class="priceLeft">Type </div>
					<div class="priceRight"><span>Premium</span></div>
				</li>
				<li>
					<div class="priceLeft">Price </div>
					<div class="priceRight" id="price">${specialCake.sprRate}</div>
					<input name="sp_calc_price" id="sp_calc_price" value="${specialCake.sprRate}" type="hidden">
				</li>
				<li>
					<div class="priceLeft">Add Rate </div>
					<div class="priceRight"  id="rate" >00</div>
					 <input name="sp_add_rate" id="sp_add_rate"  type="hidden" value="0">
				</li>
				<li>
					<div class="priceLeft">Sub Total </div>
					<div class="priceRight"id="subtotal">00</div>
					<input name="sp_sub_total" id="sp_sub_total"  type="hidden">
				</li>
				<li>
					<div class="priceLeft">Tax 1 @ 10% </div>
					<div class="priceRight" id="tax1">${specialCake.spTax1}</div>
					
				</li>
				<li>
					<div class="priceLeft">Tax 2 @ 5% </div>
					<div class="priceRight" id="tax2">${specialCake.spTax2}</div>
				</li>
				
				<li class="total">
					<div class="priceLeft">TOTAL</div>
					<div class="priceRight"id="tot">${specialCake.sprRate+specialCake.spTax1+specialCake.spTax2}</div>
					 <input type="hidden" name="total_amt" id="total_amt" value="${specialCake.sprRate+specialCake.spTax1+specialCake.spTax2}">
				</li>
				
				<li class="advance">
					<div class="priceLeft">Advance</div>
					<div class="priceRight"><input name="adv" id="adv" value="00" class="tableInput" type="text" onkeyup="advanceFun()"></div>
					
				</li>
			</ul>
		</div>
		<div class="remainamount">
			<div class="priceLeft">Remaining Amount</div>
					<div class="priceRight" id="rmAmt">${specialCake.sprRate+specialCake.spTax1+specialCake.spTax2}</div>
				    <input type="hidden" name="rm_amount" id="rm_amount" value="${specialCake.sprRate+specialCake.spTax1+specialCake.spTax2}">
		</div>
	
	
	</div>
	<div class="order-btn">
		<input name="" class="btnSubmit" value="SUBMIT" type="submit" onClick="return empty()">
		<input name="" class="btnReset" value="RESET" type="button">
	</div>
</div>
<input type="hidden" id="t1" name="t1" value="${specialCake.spTax1}">
<input type="hidden" id="t2" name="t2" value="${specialCake.spTax2}">
<input type="hidden" id="dbAdonRate" name="dbAdonRate">
<input type="hidden" id="dbPrice" name="dbPrice"  value="${specialCake.sprRate}">
<input type="hidden" id="sp_id" name="sp_id"  value="${specialCake.spId}">
</form>
<!--rightForm-->


<!--formBox-->

 
		
</div>
<!--rightSidebar-->

</div>
<!--fullGrid-->
</div>
<!--rightContainer-->

</div>
<!--wrapper-end-->
<script type="text/javascript">
function ChooseContact(data) {

	document.getElementById ("friendName").value = (data.value)*2;

	}

</script>
<script>
$(function() {
    $('#sp_code').change(function(){
        $('.col').hide();
        $('#' + $(this).val()).show();
    });
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


<script type="text/javascript">
$(document).ready(function() { 
	$('#sptype').change(
			function() {
				$.getJSON('${findItemsByCatId}', {
					spType : $(this).val(),
					ajax : 'true'
				}, function(data) {
					var html = '<option value="">Flavour</option>';
					
					var len = data.length;
					
					for ( var i = 0; i < len; i++) {
						html += '<option value="' + data[i].spfId + '">'
								+ data[i].spfName + '</option>';
					}
					html += '</option>';
					$('#spFlavour').html(html);
					$('#spFlavour').form-control('refresh');

				});
			});
});
</script>
<script type="text/javascript">
		function onChange(dbRate) {
			var wt = $('#spwt').find(":selected").text();
			var flavourAdonRate =$("#dbAdonRate").val();
			var tax1 = parseFloat($("#t1").val());
			var tax2 = parseFloat($("#t2").val());
			var t=tax1+tax2;
		    var p = wt*dbRate;
			var r = wt*flavourAdonRate;
		    var add=parseFloat(p+r);
		    var t1=parseFloat(add+t);
		    
			//var tot=(select*dbRate)+(wt*flavourAdonRate);
			$('#price').html(wt*dbRate);$('sp_calc_price').html(wt*dbRate);
			$('#rate').html(wt*flavourAdonRate);	  document.getElementById("sp_add_rate").setAttribute('value',wt*flavourAdonRate);
			$('#subtotal').html(add);	document.getElementById("sp_sub_total").setAttribute('value',add);
			$('#INR').html(t1);document.getElementById("sp_grand").setAttribute('value',t1);
			$('#tot').html(t1);document.getElementById("total_amt").setAttribute('value',t1);
			$('#rmAmt').html(t1);document.getElementById("rm_amount").setAttribute('value',t1);
		}</script> 

		
<script type="text/javascript">

		function onChangeFlavour() {
			var wt = $('#spwt').find(":selected").text();
			var flavourAdonRate =$("#dbAdonRate").val();
			var a=document.getElementById('dbAdonRate');
			
			var tax1 = $("#t1").val();
			var tax2 = $("#t2").val();
			var price = $("#dbPrice").val();
			var t=tax1+tax2;
			var r = wt*flavourAdonRate;
			 var p = wt*price;
			 // var add=parseFloat();
			    var t1=parseFloat(add+t);
			    $('#price').html(p);$('#sp_calc_price').html(p);
				$('#rate').html(r);$('#sp_add_rate').html(r);document.getElementById("sp_add_rate").setAttribute('value',r);
				$('#subtotal').html(p+r);document.getElementById("sp_sub_total").setAttribute('value',p+r);
				$('#INR').html(t1);document.getElementById("sp_grand").setAttribute('value',t1);
				$('#tot').html(t1);document.getElementById("total_amt").setAttribute('value',t1);
				$('#rmAmt').html(t1);document.getElementById("rm_amount").setAttribute('value',t1);
		}
</script>
		
<script type="text/javascript">
$(document).ready(function() { 
	$('#spFlavour').change(
			function() {
				$.getJSON('${findAddOnRate}', {
					spfId : $(this).val(),
					ajax : 'true'
				}, function(data) {
					 $('#rate').empty();	
					 $("#dbAdonRate").val(data.spfAdonRate);
					$("#rate").html(data.spfAdonRate);document.getElementById("sp_add_rate").setAttribute('value',data.spfAdonRate);
					var price =parseFloat($("#price").text());
					var tax1 = parseFloat($("#t1").val());
					var tax2 = parseFloat($("#t2").val());
					
					var subtotal=price+data.spfAdonRate;
				
					$("#subtotal").html(subtotal);document.getElementById("sp_sub_total").setAttribute('value',subtotal);
					var t=tax1+tax2;
					$('#tot').html(subtotal+t);document.getElementById("total_amt").setAttribute('value',subtotal+t);
					$('#rmAmt').html(subtotal+t);document.getElementById("rm_amount").setAttribute('value',subtotal+t);
					$('#INR').html(subtotal+t);document.getElementById("sp_grand").setAttribute('value',subtotal+t);
				});
			});
});
</script>
<script type="text/javascript">
function advanceFun() {
	var advance=$("#adv").val();
	var rmamt =$("#tot").text();
	$('#rmAmt').html(rmamt-advance);document.getElementById("rm_amount").setAttribute('value',rmamt-advance);
}
</script>
<script type="text/javascript">
function validateForm() {
    var x = document.forms["form"]["sp_code"].value;
    if (x == "") {
        alert("Special Cake Code must be filled out");
        return false;
    }
}
</script>	

<script type="text/javascript">
function empty() {
    var t1,spId;
    t1 = document.getElementById("sp_instructions").value;
    
    spId=document.getElementById("sp_id").value;
   
    
    if (t1 == ""||spId=="") {
        alert("Some Field is Empty");
        return false;
    };
}


</script>
<script>

 document.getElementById("order_photo").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
        // get loaded data and render thumbnail.
        document.getElementById("image").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

</script>
<script>

 document.getElementById("cust_choice_ck").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
        // get loaded data and render thumbnail.
        document.getElementById("img").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

</script>
</body>
</html>
