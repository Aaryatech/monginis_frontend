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
   

<!--rightNav-->

<!--selectlistbox-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.selectlistbox.js"></script>

<!--selectlistbox-->

<!--datepicker-->

<!--datepicker--> 

<style type="text/css">
select {
    width: 130px;
    height: 30px;
}
</style>   


 <script type="text/javascript" src="https://www.google.com/jsapi">
    </script>
    <script type="text/javascript">

      // Load the Google Transliterate API
      google.load("elements", "1", {
            packages: "transliteration"
          });

      function onLoad() {
        var options = {
            sourceLanguage:
                google.elements.transliteration.LanguageCode.ENGLISH,
            destinationLanguage:
                [google.elements.transliteration.LanguageCode.HINDI],
            shortcutKey: 'ctrl+g',
            transliterationEnabled: true
        };

        // Create an instance on TransliterationControl with the required
        // options.
        var control =
            new google.elements.transliteration.TransliterationControl(options);

        // Enable transliteration in the textbox with id
        // 'transliterateTextarea'.
        control.makeTransliteratable(['transliterateTextarea']);
      }
      google.setOnLoadCallback(onLoad);
    </script>


</head>
<body>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

<!--topHeader-->
<c:url var="findAvailableSlot" value="/getAvailableSlot" />
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

  <form action="${pageContext.request.contextPath}/searchSpCake" method="post" class="form-horizontal" name="form" onsubmit="return validateForm()">
  
	  <div class="fullform">
		<div class="cackleft2">Item Code</div>
		<div class="cackrighttexbox"><input class="texboxitemcode" id="sp_code" value="${specialCake.spCode}" name="sp_code" type="text" autocomplete="off"list="categories">
			
			<datalist id="categories">
			
			     <c:forEach items="${configuredSpCodeList}" var="specialCakeList">	
			           <option value="${specialCakeList}"></option>
		          </c:forEach>
		     </datalist>

		
		
		
		
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
		<img src="${url}${specialCake.spImage}" onerror="this.src='${pageContext.request.contextPath}/resources/images/No_Image_Available.jpg';"></div>
	</div>
	
	
     <div class="fullform">
		<div class="cackleft">Description</div>
		<div class="cackright" id="spDesc"><span class="cakename">${specialCake.spDesc}</span></div>
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
SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

String fDate = formatter.format(date);
System.out.println(""+fDate);
SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MM-yyyy");

String fDate1 = formatter1.format(date);
%>
<%=fDate1 %>
    </div>
	</div>
	
</div>


<!----------------------------------------Form-------------------------------------------------->
<form action="${pageContext.request.contextPath}/orderSpCake"  method="post" class="form-horizontal" name="from_ord" id="validation-form" enctype="multipart/form-data"onsubmit="return validate()">

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
<input type="hidden" name="prevImage" id="prevImage" value="${specialCake.spImage}">
<input type="hidden" name="isFound" id="isFound" value="${isFound}" onchange="onChangeValue()">

<!-- <input type="hidden" name="tax_1" id="tax_1" value="0.00">
<input type="hidden" name="tax_2" id="tax_2" value="0.00"> --><!-- 
<input type="hidden" name="tax_1_amt" id="tax_1_amt" value="0">

<input type="hidden" name="min_weight" id="min_weight" value="5 kg">
<input type="hidden" name="max_weight" id="max_weight" value="8 kg">
<input type="hidden" name="earliest_delivery_date" id="earliest_delivery_date" value="11 Sep 2017"> -->

<input type="hidden" name="isCustChoiceCk" id="isCustChoiceCk" value="${specialCake.isCustChoiceCk}">
<input type="hidden" name="spPhoUpload" id="spPhoUpload" value="${specialCake.spPhoupload}">
<input type="hidden" name="isSlotUsed" id="isSlotUsed" value="${specialCake.isSlotUsed}">


<!--centerForm-->	

<div class="center">

	 <div  class="colOuter">
		<div class="col1"><div class="col1title">Type</div></div>
		<div class="col2full">
         <select name="sptype" tabindex="-1" id="sptype">
              <option value="">Select Type</option>
                 <c:set var= "spCakeType" value="${specialCake.spType}"></c:set>
               <c:choose>
                  
                   <c:when test="${spCakeType=='1'}"> <option value="1">Chocolate</option>   </c:when> 
                    <c:when test="${spCakeType=='2'}"> <option value="2">FC</option>          </c:when>
                <c:otherwise>
                    
                      <option value="1">Chocolate</option>
                        <option value="2">FC</option>
                </c:otherwise>    
              </c:choose>
              
            </select>
			</div>
	</div>
	
    <div class="colOuter">
		<div class="col1"><div class="col1title">Flavour</div></div>
		<div class="col2full" >
                <select name="spFlavour"  tabindex="-1"  onchange="onChangeFlavour()"id="spFlavour">
                              <option value="">Select Flavour</option>
                
                     <option value="">Select Flavour</option>
               </select>
       </div>
	</div>  
		  
	<div class="colOuter">
		<div class="col1"><div class="col1title">Weight</div></div>
		<div class="col2">
		      <c:set var = "dbRate" scope = "session" value = "${sprRate}"/>
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
      </select>
			<div class="err" style="display:none;">Please Enter Weight</div>
		</div>
  </div>
	
	         
	<div class="colOuter">
		<div class="col1"><div class="col1title">Event</div></div>
		<div class="col2"><select name="sp_event" id="sp_event">
  
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
	         <div class="col1"><div class="col1title">Photo Cake1</div></div>
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
	        <div class="col1"><div class="col1title">Photo Cake2</div></div>
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
		<div class="col2full"><textarea id="transliterateTextarea"  name="sp_instructions" cols="" rows="" style="width:200px;height:90px"></textarea></div>
	</div>
	<!-- <div class="colOuter">
	
		<div class="col1"><div class="col1title">Special Instructions</div></div>
		<div class="col2full"><textarea id="transliterateTextarea"  name="sp_instructions" cols="" rows="" style="width:200px;height:90px"></textarea></div>
	</div> -->

	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Delivery Date</div></div>
		<div class="col2"><input id="datepicker" class="texboxitemcode texboxcal" value="<%=fDate %>"  name="datepicker" type="text" >
		</div><div class="col2"> 
      <c:if test = "${specialCake.isSlotUsed=='1'}"> <span class="cakename"id="slotUsedSpan">Check Slots availability</span> </c:if></div>
	</div>
	
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Place of Delivery</div></div>
		<div class="col2full"><input class="texboxitemcode" placeholder="Place of Delivery" name="sp_place" id="sp_place" type="text"></div>
	</div>    
	
	
	<div class="colOuter">
<!-- 		<div class="col1"><div class="col1title">Book For Date</div></div>
 -->		<div class="col2"><input id="datepicker3" class="texboxitemcode texboxcal" placeholder="<%=fDate %>" name="datepicker3" type="hidden">
		</div>
	</div>
	
	
	<div class="colOuter">
		<div class="col1"><input class="texboxitemcode texboxcal2" placeholder="Customer Name" name="sp_cust_name" type="text" id="sp_cust_name"></div>
		<div class="col2"><input id="datepicker4" class="texboxitemcode texboxcal" placeholder="<%=fDate %>" name="datepicker4" type="text"></div>
		<div class="col3"><input class="texboxitemcode" placeholder="Mobile No." name="sp_cust_mobile_no" type="text" id="sp_cust_mobile_no" ></div>
	</div>
	 <span class="cakename"id="slotsNotAvailable"></span>
	
	<div class="colOuter">
		<div class="col1"><input class="texboxitemcode texboxcal2" placeholder="Booked For" name="sp_booked_for_name" type="hidden"id="sp_booked_for_name"></div>
		<div class="col2"><input id="datepicker5" class="texboxitemcode texboxcal" placeholder="<%=fDate %>" name="datepicker5" type="hidden"></div>
		<div class="col3"><input class="texboxitemcode" placeholder="Mobile No." name="sp_book_for_number" type="hidden"id="sp_book_for_number"></div>
	</div>
	
	
	<div class="cackleft" id="error"><span class="cakename">
<c:if test="${not empty errorMessage}">
<h3><c:out value="${errorMessage}"/></h3>
</c:if></span></div>
	
	
</div>

<!--centerForm-->
	
<!--rightForm-->	
<div class="right">
	<div class="priceBox">
		<h2 class="inrbox" id="INR">INR - ${(sprRate*specialCake.spMinwt)}</h2>
		 <input type="hidden" name="sp_grand" id="sp_grand" value="${(sprRate*specialCake.spMinwt)}">   
		<div class="inrboxmiddle">
			<ul>
				<li>
					<div class="priceLeft">Type </div>
					<div class="priceRight"><span>Premium</span></div>
				</li>
				<li>
					<div class="priceLeft">Price </div>
					<div class="priceRight" id="price">${sprRate*specialCake.spMinwt}</div>
					<input name="sp_calc_price" id="sp_calc_price" value="${sprRate*specialCake.spMinwt}" type="hidden">
				</li>
				<li>
					<div class="priceLeft">Add Rate </div>
					<div class="priceRight"  id="rate" >00</div>
					 <input name="sp_add_rate" id="sp_add_rate"  type="hidden" value="0">
				</li>
				<li>
					<div class="priceLeft">Sub Total </div>
					<div class="priceRight"id="subtotal">${sprRate*specialCake.spMinwt}</div>
					<input name="sp_sub_total" id="sp_sub_total"  type="hidden"value="${sprRate*specialCake.spMinwt}">
				</li>
				<li>
					<div class="priceLeft">GST </div>
					<div class="priceRight" id="tax3"> ${specialCake.spTax1+specialCake.spTax2} </div>
					<input type="hidden" id="t3" name="t3" value="${specialCake.spTax1+specialCake.spTax2}">
				</li>
				<li>
					<div class="priceLeft">GST IN RS.</div>
					<div class="priceRight" id="gstrs">${(sprRate*specialCake.spMinwt)*(specialCake.spTax1+specialCake.spTax2)/100}</div>
					<input type="hidden" id="gst_rs" name="gst_rs" value="${(sprRate*specialCake.spMinwt)*(specialCake.spTax1+specialCake.spTax2)/100}">
				</li>
				<li class="total">
					<div class="priceLeft" id="mgstamt">AMT- ${(sprRate*specialCake.spMinwt)-((sprRate*specialCake.spMinwt)*(specialCake.spTax1+specialCake.spTax2)/100)}</div>
					
				   <input type="hidden" name="m_gst_amt" id="m_gst_amt" type="hidden" value="${(sprRate*specialCake.spMinwt)-((sprRate*specialCake.spMinwt)*(specialCake.spTax1+specialCake.spTax2)/100)}">
				
					<div class="priceRight"id="tot">TOTAL-${(sprRate*specialCake.spMinwt)}</div>
					
					 <input type="hidden" name="total_amt" id="total_amt" value="${(sprRate*specialCake.spMinwt)}">
				</li>
				
				<li class="advance">
					<div class="priceLeft">Advance</div>
					<div class="priceRight"><input name="adv" id="adv" value="00" class="tableInput" type="text" onkeyup="advanceFun()"></div>
					
				</li>
			</ul>
		</div>
		<div class="remainamount">
			<div class="priceLeft">Remaining Amount</div>
					<div class="priceRight" id="rmAmt">${(sprRate*specialCake.spMinwt)}</div>
				    <input type="hidden" name="rm_amount" id="rm_amount" value="${(sprRate*specialCake.spMinwt)}">
		</div>
	
	
	</div>
	
	<div class="order-btn">
		<input name="" class="btnSubmit" value="SUBMIT"  type="button" id="click">
		<input name="" class="btnReset" value="RESET" type="hidden">
	</div>
	
</div>
<input type="hidden" id="t1" name="t1" value="${specialCake.spTax1}">
<input type="hidden" id="t2" name="t2" value="${specialCake.spTax2}">
<input type="hidden" id="t1amt" name="t1amt" value="${(sprRate*specialCake.spMinwt)*(specialCake.spTax1)/100}">
<input type="hidden" id="t2amt" name="t2amt" value="${(sprRate*specialCake.spMinwt)*(specialCake.spTax2)/100}">

<input type="hidden" id="dbAdonRate" name="dbAdonRate">
 <input type="hidden" id="dbPrice" name="dbPrice"  value="${sprRate}">
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
	
		
	
});


</script>



<!------------------------GETTING FLAVOURS BY SELECTED FLAVOUR TYPE---------------------------->	
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
<!------------------------------------------------END------------------------------------------------>	
<!------------------------CALLING FUNCTION WHEN WEIGHT CHANGE---------------------------------------->	

<script type="text/javascript">
		function onChange(dbRate) {
			var wt = $('#spwt').find(":selected").text();
			var flavourAdonRate =$("#dbAdonRate").val();
			var tax3 = parseFloat($("#t3").val());
			var tax1 = parseFloat($("#t1").val());
			var tax2 = parseFloat($("#t2").val());
			
			
			var totalCakeRate = wt*dbRate;
			var totalFlavourAddonRate = wt*flavourAdonRate;
		    var add=parseFloat(totalCakeRate+totalFlavourAddonRate);
		    var grandTotal=parseFloat(add);
			var spSubtotal=add;
			
			var gstInRs=(spSubtotal*tax3)/100;
			$('#gstrs').html(gstInRs);  document.getElementById("gst_rs").setAttribute('value',gstInRs);

			var mGstAmt=spSubtotal-gstInRs;
			$('#mgstamt').html('AMT-'+mGstAmt);  document.getElementById("m_gst_amt").setAttribute('value',mGstAmt);
			
			$('#price').html(wt*dbRate);
			$('sp_calc_price').html(wt*dbRate);
			$('#rate').html(wt*flavourAdonRate);	
			document.getElementById("sp_add_rate").setAttribute('value',wt*flavourAdonRate);
			$('#subtotal').html(grandTotal);	
			document.getElementById("sp_sub_total").setAttribute('value',add);
			
			$('#INR').html('INR-'+grandTotal);
			document.getElementById("sp_grand").setAttribute('value',grandTotal);
			$('#tot').html('TOTAL-'+grandTotal);
			document.getElementById("total_amt").setAttribute('value',grandTotal);
			$('#rmAmt').html(grandTotal);
			document.getElementById("rm_amount").setAttribute('value',grandTotal);
			
			$('#t1amt').html((grandTotal*tax1)/100);
			document.getElementById("t1amt").setAttribute('value',(grandTotal*tax1)/100);
			
			$('#t2amt').html((grandTotal*tax2)/100);
			document.getElementById("t2amt").setAttribute('value',(grandTotal*tax2)/100);
			
	}</script> 
<!------------------------------------------------END------------------------------------------------>	
<!------------------------CALLING FUNCTION WHEN FLAVOUR CHANGE FOR GETTING ADDON RATE---------------->		
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
					$("#rate").html(data.spfAdonRate);
				
					document.getElementById("sp_add_rate").setAttribute('value',data.spfAdonRate);
				
					
					var wt = $('#spwt').find(":selected").text();
					
					var flavourAdonRate =data.spfAdonRate;
					
					var tax3 = parseFloat($("#t3").val());
					var tax1 = parseFloat($("#t1").val());
					var tax2 = parseFloat($("#t2").val());
					
					var price = $("#dbPrice").val();
				
					var totalFlavourAddonRate= wt*flavourAdonRate;
					
					 var totalCakeRate= wt*price;
					  var grandTotal=parseFloat(totalCakeRate+totalFlavourAddonRate);
					  
					    $('#price').html(totalCakeRate);$('#sp_calc_price').html(totalCakeRate);
						$('#rate').html(totalFlavourAddonRate);$('#sp_add_rate').html(totalFlavourAddonRate);
						document.getElementById("sp_add_rate").setAttribute('value',totalFlavourAddonRate);
						$('#subtotal').html(totalCakeRate+totalFlavourAddonRate);
						
						document.getElementById("sp_sub_total").setAttribute('value',totalCakeRate+totalFlavourAddonRate);
						$('#INR').html('INR-'+grandTotal);
						document.getElementById("sp_grand").setAttribute('value',grandTotal);
						$('#tot').html('TOTAL-'+grandTotal);
						document.getElementById("total_amt").setAttribute('value',grandTotal);
						$('#rmAmt').html(grandTotal);
						document.getElementById("rm_amount").setAttribute('value',grandTotal);
						
						$('#t1amt').html((grandTotal*tax1)/100);
						document.getElementById("t1amt").setAttribute('value',(grandTotal*tax1)/100);
						
						$('#t2amt').html((grandTotal*tax2)/100);
						document.getElementById("t2amt").setAttribute('value',(grandTotal*tax2)/100);
						
						
						var gstInRs=(grandTotal*tax3)/100;
						$('#gstrs').html(gstInRs); 
						document.getElementById("gst_rs").setAttribute('value',gstInRs);
						var mGstAmt=grandTotal-gstInRs;
						$('#mgstamt').html('AMT-'+mGstAmt);  
						document.getElementById("m_gst_amt").setAttribute('value',mGstAmt);
						
						
					
			
				});
			});
});
</script>
<!------------------------------------------------END------------------------------------------------>	
<!-----------------------------------------------REMAINING AMOUNT ONKEYUP FUNCTION------------------->	
<script type="text/javascript">
function advanceFun() {
	var advance=$("#adv").val();
	var rmamt =$("#total_amt").val();
	$('#rmAmt').html(rmamt-advance);document.getElementById("rm_amount").setAttribute('value',rmamt-advance);
}
</script>
<!------------------------------------------------END------------------------------------------------>	
<script type="text/javascript">
function validateForm() {
    var x = document.forms["form"]["sp_code"].value;
    if (x == "") {
        alert("Special Cake Code must be filled out");
        document.getElementById('sp_code').focus();
        return false;
    }
}
</script>	
<!------------------------------------------------VALIDATIONS---------------------------------------------->	
 <script type="text/javascript">
function validate() {
	
	
    var t1,spId,spCustName,spPlace,spCustMob,sptype,spFlavour;
    t1 = document.getElementById("event_name").value;
    spPlace = document.getElementById("sp_place").value;
    spCustName=document.getElementById("sp_cust_name").value;
    spCustMob=document.getElementById("sp_cust_mobile_no").value; 
    sptype=document.getElementById("sptype").value; 
    spFlavour=document.getElementById("spFlavour").value;
    
    var isValid=true;
    
    if (sptype == "") {
        alert("Please Select Special Cake Type");
        
      
        isValid= false;
    }else  if (spFlavour == "") {
        alert("Please Select Flavour");
        
  
        isValid=false;
    }else  if (t1 == "") {
        alert("Please Enter Event Name");
        document.getElementById('event_name').focus();
        
        isValid=false;
    }else if (spPlace == "") {
        alert("Please Enter Place of delivery");
        document.getElementById('sp_place').focus();

        isValid= false;
    }else if (spCustName == "") {
        alert("Please Enter Customer Name");
        document.getElementById('sp_cust_name').focus();

        isValid= false;
    }else  if (spCustMob == "") {
        alert("Please Enter Customer Mobile Number");
        document.getElementById('sp_cust_mobile_no').focus();
   
        isValid= false;
    };
    
    return isValid;
 
}


</script> 
<!------------------------------------------------END------------------------------------------------>	

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

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
  $( function() {
    $( "#datepicker" ).datepicker({ dateFormat: 'dd-mm-yy' ,
        onSelect: function(date) {
           
      	    	var isSlotUsed =$("#isSlotUsed").val();         

      	    	var produTime =$("#sp_pro_time").val();         
      	     

                  if(isSlotUsed=='1')
                  	{
      			      $.getJSON('${findAvailableSlot}', {
      				  deldate : date,
      				  prodTime: produTime,
      			      ajax : 'true'
      			} , function(availableSlots) {
      				
      			
      				
      				if(availableSlots>0)
      					{
      					
      					$("#slotUsedSpan").html(availableSlots +' Slots Available');
      					
      					}
      				else
      					{
      				
      					$("#slotUsedSpan").html('No Slots Available');
      				
      					
      					}
      				
      			
      			});
             }
         }
      });
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
  
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>

$(document).ready(function () {
    $("#click").click(function ()  {
      	       
      	       var date = $('#datepicker').datepicker({ dateFormat: 'dd-mm-yy' }).val();
      	      
      	    	var isSlotUsed =$("#isSlotUsed").val();         
      	    	
      	    	var produTime =$("#sp_pro_time").val();         
      	    
                  if(isSlotUsed=='1')
                  	{
              
      			      $.getJSON('${findAvailableSlot}', {
      				  deldate : date,
      				  prodTime: produTime,
      			      ajax : 'true'
      			} , function(availableSlots) {
      				
      				
      				
      				if(availableSlots>0)
      					{
      					$("#slotUsedSpan").html(availableSlots +' Slots Available');
      				var valid=	validate();
      				
      				
      				if(valid){
      					document.forms["from_ord"].submit();
      				}	
      					
      					}
      				else
      					{
      				
      					$("#slotsNotAvailable").html('No Slots Available');
      					alert("Sorry, No Slots Available !");
      					}
      				
      			
      			});
             }
         });
});
  
</script> 

<script>
$("isFound").change(function(){
    alert("Special Cake is Not Found");
});
</script>

</body>
</html>
