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

<!--selectlistbox-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.selectlistbox.js"></script>

<!--selectlistbox-->

<!--datepicker-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
  $( function() {
    $( "#datepicker" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
  $( function() {
    $( "#datepicker2" ).datepicker({ dateFormat: 'dd-mm-yy' });
  } );
 
  </script>
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
	<c:url var="findAllRegularSpCk" value="/getAllRegularSpCk" />
            <c:url var="findSpecialCkById" value="/getSpecialCkById" />
<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

<!--topHeader-->
<%-- <c:url var="findAddOnRate" value="/getAddOnRate" />
<c:url var="findItemsByCatId" value="/getFlavourBySpfId" />
<c:url var="findAllMenus" value="/getAllTypes" /> --%>
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
<h2 class="pageTitle">Regular Special Cake Order</h2>
</div>

<form action="${pageContext.request.contextPath}/orderRegularSpCake"  method="post" class="form-horizontal" name="from_reg_ord" id="validation-form" onsubmit="return validateForm()">


 <!--formBox-->
<div class="ordercake">


<!--leftForm-->
<div class="left">


<div class="fullform">
		<div class="cackleft">Category</div>
		<div class="cackright"><select name="regular_sp_cake" id="regular_sp_cake" required>
              <option value="">Select Special Cake</option>
              
               <c:forEach items="${categoryResponse}" var="mCategoryWithSubCat">
               
              <option value="${mCategoryWithSubCat.subCatId}"><c:out value="${mCategoryWithSubCat.subCatName}" /></option>
           
           
             </c:forEach>				
            </select>
			</div>
	</div>
    <div class="fullform">
		<div class="cackleft2">Regular Special Cake</div>
		<div class="cackrighttexbox"><%-- <input class="texboxitemcode" id="regular_items" value="" name="regular_items" type="text" autocomplete="off"list="itemCategories">
			
			 <datalist id="itemCategories">
			
			     <c:forEach items="${configuredSpCodeList}" var="specialCakeList">	
			           <option value="${specialCakeList}"></option>
		          </c:forEach>
		     </datalist>  --%>
		     <select data-placeholder="Select Item"

                 tabindex="6"

                    id="regSpCkItem" name="regSpCkItem"required>

                         <option value="">Select Regular SP Cake</option>
           






</select>

	   </div>
     </div>
	
	
	<div class="fullform">
		<div class="cackleft">Name</div>
		<div class="cackright" id="sp_name"><span class="cakename" id="rg_ck_name">- - - -</span></div>
	</div>
 &nbsp; &nbsp; &nbsp;
 
	<div class="fullform">
		<div class="cackimg">
		<div class="cackimglable"></div>
		<img src="${url}${specialCake.spImage}" onerror="this.src='${pageContext.request.contextPath}/resources/images/No_Image_Available.jpg';"></div>
	</div>
	&nbsp;
	
     <div class="fullform">
		<div class="cackleft">Description</div>
		<div class="cackright" id="spDesc"><span class="cakename" id="reg_desc">- - - -</span></div>
	</div>
	
	
	
	
	<%
// Create a Calendar object
Calendar calendar = Calendar.getInstance();

// Get current day from calendar
int day = calendar.get(Calendar.DATE);
// Get current month from calendar
int month = calendar.get(Calendar.MONTH) + 1;  
// Get current year from calendar
int year = calendar.get(Calendar.YEAR);
calendar.add(Calendar.DATE, 0);

day = calendar.get(Calendar.DATE);
month = calendar.get(Calendar.MONTH);  
year = calendar.get(Calendar.YEAR);

Calendar cal = Calendar.getInstance();

cal.set(year, month, day);
Date date = cal.getTime();
SimpleDateFormat formatter = new SimpleDateFormat("dd MMM yyyy");

String fDate = formatter.format(date);
System.out.println(""+fDate);
SimpleDateFormat formatter1 = new SimpleDateFormat("dd MMM yyyy");

String fDate1 = formatter1.format(date);%>
<%-- 
<%=fDate %>
    </div>
	</div> --%>
	
</div>


 <input type="hidden" name="rg_sp_name" id="rg_sp_name" >
 <input type="hidden" name="rg_sp_desc" id="rg_sp_desc" value="NA">


<div class="center">

	
	
	         
	<div class="colOuter">
		<div class="col1"><div class="col1title">Event</div></div>
		<div class="col2"><select name="sp_event" id="sp_event">
  
              <c:forEach items="${eventList.getEvent()}" var="eventList">
              <option value="${eventList.speName}"><c:out value="${eventList.speName}" /></option>
             </c:forEach>
            </select></div>
		<div class="col3"><input class="texboxitemcode" placeholder="Name" name="event_name" type="text" id="event_name" required>
		</div>
	</div>
	
<div class="colOuter">
		
	</div>
		&nbsp;
	
	<div class="colOuter">
			<div class="col1"><div class="col1title">Quantity</div></div>
		   <div class="col2full"><input class="texboxitemcode" placeholder="" name="sp_qty" type="text" id="sp_qty" onkeyup="calculatePerQuantity()" required></div>
	</div>
		
	<div class="colOuter"></div>
	&nbsp;



	<div class="colOuter">
		<div class="col1"><div class="col1title">Delivery Date</div></div>
		<div class="col2full"><input id="datepicker" class="texboxitemcode texboxcal" placeholder="Delivery Date"  name="datepicker" type="text" required>
		</div>
	</div>
	<div class="colOuter"></div>
	
	&nbsp;&nbsp;
	<div class="colOuter">
		<div class="col1"><div class="col1title">Place of Delivery</div></div>
		<div class="col2full"><input class="texboxitemcode" placeholder="Place of Delivery" name="sp_place" id="sp_place" type="text" required></div>
	</div>    
	
	
	<div class="colOuter">
		
	</div>
	&nbsp;&nbsp;
	
	
	<div class="colOuter">
	<div class="col1"><div class="col1title">Customer Name</div></div>
	<div class="col2full"><input class="texboxitemcode texboxcal2" placeholder="Customer Name" name="sp_cust_name" type="text" id="sp_cust_name"required></div>
	</div>
	
	&nbsp;&nbsp;<div class="colOuter"></div>
	
	<div class="colOuter">
		<div class="col1"><div class="col1title">Customer DOB</div></div>
		<div class="col2full"><input id="datepicker2" class="texboxitemcode texboxcal" placeholder="Customer DOB" name="datepicker2" type="text" required></div>
	</div>
	
	&nbsp;&nbsp;<div class="colOuter"></div>
	
	<div class="colOuter">
			<div class="col1"><div class="col1title">Customer Mobile No.</div></div>
		   <div class="col2full"><input class="texboxitemcode" placeholder="Mobile No." name="sp_cust_mobile_no" type="text" id="sp_cust_mobile_no" required></div>
	</div>
	
	&nbsp;&nbsp;<div class="colOuter"></div>
	
	<div class="colOuter">
		<div class="col1"><input class="texboxitemcode texboxcal2" placeholder="Booked For" name="sp_booked_for_name" type="hidden"id="sp_booked_for_name"></div>
		<div class="col2"><input id="datepicker5" class="texboxitemcode texboxcal" placeholder="" name="datepicker5" type="hidden"></div>
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
		<h2 class="inrbox" id="INR">INR - </h2>
		 <input type="hidden" name="sp_grand" id="sp_grand" value="">   
		<div class="inrboxmiddle">
			<ul>
				
				<li>
					<div class="priceLeft">Price </div>
					<div class="priceRight" id="price"></div>
					<input name="sp_calc_price" id="sp_calc_price" value="" type="hidden">
				</li>
				
				<li>
					<div class="priceLeft">Sub Total </div>
					<div class="priceRight"id="subtotal"></div>
					<input name="sp_sub_total" id="sp_sub_total"  type="hidden"value="">
				</li>
				<li>
					<div class="priceLeft">GST </div>
					<div class="priceRight" id="tax3">%</div>
					<input type="hidden" id="t3" name="t3" value="">
				</li>
				<li>
					<div class="priceLeft">GST IN RS.</div>
					<div class="priceRight" id="gstrs"></div>
					<input type="hidden" id="gst_rs" name="gst_rs" value="">
				</li>
				<li class="total">
					<div class="priceLeft" id="mgstamt">AMT- </div>
					
				   <input type="hidden" name="m_gst_amt" id="m_gst_amt" value="">
				
					<div class="priceRight"id="tot">TOTAL-</div>
					
					 <input type="hidden" name="total_amt" id="total_amt" value="">
				</li>
				
				<li class="advance">
					<div class="priceLeft">Advance</div>
					<div class="priceRight"><input name="adv" id="adv" value="00" class="tableInput" type="text" onkeyup="advanceFun()"></div>
					
				</li>
			</ul>
		</div>
		<div class="remainamount">
			<div class="priceLeft">Remaining Amount</div>
					<div class="priceRight" id="rmAmt"></div>
				    <input type="hidden" name="rm_amount" id="rm_amount" value="">
		</div>
	
	
	</div>
	
	<div class="order-btn">
		<input name="" class="btnSubmit" value="SUBMIT" type="submit" onClick="return empty()">
		<input name="" class="btnReset" value="RESET" type="hidden">
	</div>
	
</div>
<input type="hidden" id="t1" name="t1" value="">
<input type="hidden" id="t2" name="t2" value="">
<input type="hidden" id="dbAdonRate" name="dbAdonRate">
 <input type="hidden" id="dbPrice" name="dbPrice"  value="">
<input type="hidden" id="sp_id" name="sp_id"  value="">

<input type="hidden" id="frRateCat" name="frRateCat"  value="${frDetails.getFrRateCat()}">
<input type="hidden" id="rate" name="rate"  value="">
<input type="hidden" id="MRP" name="MRP"  value="">

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
	$('#regular_sp_cake').change(
			function() {
				$.getJSON('${findAllRegularSpCk}', {
					regular_sp_cake: $(this).val(),
					ajax : 'true'
				}, function(data) {
					//var html = '<option value="">Regular Cakes</option>';
 				
					var len = data.length;
					
					$('#regSpCkItem')
				    .find('option')
				    .remove()
				    .end()
				    
		/* 
				    function(data){ 
		                 $("#price").text(data.itemMrp3);
		                } 
					 */
					// $("#itemCategories").append($("<option></option>").attr( "value","").text("")
					
					 $("#regSpCkItem").append(
                                $("<option></option>").attr(
                                    "value",'-1').text('Select Regular SP Cake')
                            );		
							
					for ( var i = 0; i < len; i++) {
						
						/* html += '<option value="' + data[i].menuId + '">'
								+ data[i].menuTitle + '</option>'; */
				          
                        $("#regSpCkItem").append(
                                $("<option></option>").attr(
                                    "value", data[i].id).text(data[i].itemName)
                            );
					}
				 	//html += '</option>';
					/* $('#itemCategories').html(html);
					$('#itemCategories').form-control chosen('refresh');  */
					   $("#regSpCkItem").trigger("chosen:updated");
					 
				});
			});
});
</script>
<!-- <!------------------------GETTING FLAVOURS BY SELECTED FLAVOUR TYPE---------------------------->	
 <script type="text/javascript">
$(document).ready(function() { 
	

	$('#regSpCkItem').change(
			function() {
				$.getJSON('${findSpecialCkById}', {
					itemCategories : $(this).val(),
					ajax : 'true'
				}, function(data) {
					
					var len = data.length;
					
					var itemMrp3
					var frRateCat = $("#frRateCat").val();
					//alert(frRateCat)
					if(frRateCat==1)
					{  
						data.itemMrp3=data.itemMrp1;
						document.getElementById("rate").setAttribute('value',data.itemRate1);
					
					}
					else if(frRateCat==2)
					{
						data.itemMrp3=data.itemMrp2;
						document.getElementById("rate").setAttribute('value',data.itemRate2);
					}
					else
					{
						data.itemMrp3=data.itemMrp3;
						document.getElementById("rate").setAttribute('value',data.itemRate3);

					}	
					document.getElementById("MRP").setAttribute('value',data.itemMrp3);
					
					
					    $("#rg_ck_name").text(data.itemName);
					    document.getElementById("rg_sp_name").setAttribute('value',data.itemName); 
					    
		                 $("#price").text(data.itemMrp3);
							document.getElementById("sp_calc_price").setAttribute('value',data.itemMrp3);

		                 $("#subtotal").text(data.itemMrp3);  
							document.getElementById("sp_sub_total").setAttribute('value',data.itemMrp3);

		     			 $("#INR").text('INR-'+data.itemMrp3);  
		     			document.getElementById("sp_grand").setAttribute('value',data.itemMrp3);

		     			$("#tax3").html(data.itemTax3+' %');
		     			document.getElementById("t3").setAttribute('value',data.itemTax3);

		     		    var gstInRs=(data.itemMrp3*data.itemTax3)/100;
						$('#gstrs').html(gstInRs); 
						document.getElementById("gst_rs").setAttribute('value',gstInRs);
						
						$('#tot').html('TOTAL-'+data.itemMrp3);
						document.getElementById("total_amt").setAttribute('value',data.itemMrp3);

						var mGstAmt=(data.itemMrp3)-gstInRs;

						$('#mgstamt').html('AMT-'+mGstAmt);  
						document.getElementById("m_gst_amt").setAttribute('value',mGstAmt);
						
						$('#rmAmt').html(data.itemMrp3);
						document.getElementById("rm_amount").setAttribute('value',data.itemMrp3);
						
						document.getElementById("sp_qty").setAttribute('value',1);


					/* for ( var i = 0; i < len; i++) {
						html += '<option value="' + data[i].spfId + '">'
								+ data[i].spfName + '</option>'; */
				/* 	} */
					html += '</option>';
				/* 	$('#spFlavour').html(html); */
/*  					$('#spFlavour').form-control('refresh');
 */
				});
			});
});
</script>
<!-- <!-- ----------------------CALLING FUNCTION WHEN WEIGHT CHANGE--------------------------------------	

<script type="text/javascript">
		function onChange(itemCategories) {
			
			var tax3 = parseFloat($("#t3").val());
			
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
			
	}</script> 
 -->
<!-----------------------------------------------REMAINING AMOUNT ONKEYUP FUNCTION------------------->	
<script type="text/javascript">
function advanceFun() {
	var advance=$("#adv").val();
	var rmamt =$("#total_amt").val();
	$('#rmAmt').html(rmamt-advance);
	document.getElementById("rm_amount").setAttribute('value',rmamt-advance);
}
</script>
<!------------------------------------------------END------------------------------------------------>	


<script type="text/javascript">
function calculatePerQuantity() {
	var qty=$("#sp_qty").val();
	
	var price=$("#MRP").val();
	
	var tax=$("#t3").val();
	
	var calcPrice=(qty*price);
	
	var calGstRs=(calcPrice*tax)/100;
	
	var mGstAmt=calcPrice-calGstRs;

	
	
	
	
	
	
	
	$("#price").text(calcPrice);
	document.getElementById("sp_calc_price").setAttribute('value',calcPrice);

 $("#subtotal").text(calcPrice);  
	document.getElementById("sp_sub_total").setAttribute('value',calcPrice);

	 $("#INR").text('INR-'+calcPrice);  
	document.getElementById("sp_grand").setAttribute('value',calcPrice);

	$("#tax3").html(tax+' %');
	document.getElementById("t3").setAttribute('value',tax);

$('#gstrs').html(calGstRs); 
document.getElementById("gst_rs").setAttribute('value',calGstRs);

$('#tot').html('TOTAL-'+calcPrice);
document.getElementById("total_amt").setAttribute('value',calcPrice);


$('#mgstamt').html('AMT-'+mGstAmt);  
document.getElementById("m_gst_amt").setAttribute('value',mGstAmt);

$('#rmAmt').html(calcPrice);
document.getElementById("rm_amount").setAttribute('value',calcPrice);
	
	
	
	
	
var advance=$("#adv").val();
var rmamt =$("#total_amt").val();

$('#rmAmt').html(rmamt-advance);
document.getElementById("rm_amount").setAttribute('value',rmamt-advance);
	

	
}
</script>












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
function validateForm() {
    var t1,spId,spCustName,spPlace,spCustMob,spqty;
    t1 = document.getElementById("event_name").value;
    spPlace = document.getElementById("sp_place").value;
    spCustName=document.getElementById("sp_cust_name").value;
    spCustMob=document.getElementById("sp_cust_mobile_no").value; 
    spqty=document.getElementById("sp_qty").value; 
    if (spqty == "") {
        alert("Please Select Regular Special Cake Quantity");
        

        return false;
    };
    
  
    if (t1 == "") {
        alert("Please Enter Event Name");
        document.getElementById('event_name').focus();
        return false;
    };
    
    if (spPlace == "") {
        alert("Please Enter Place of delivery");
        document.getElementById('sp_place').focus();

        return false;
    };
   if (spCustName == "") {
        alert("Please Enter Customer Name");
        document.getElementById('sp_cust_name').focus();
        return false;
    };
   
     
    if (spCustMob == "") {
        alert("Please Enter Customer Mobile Number");
        document.getElementById('sp_cust_mobile_no').focus();

        return false;
    };
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
<!-- <script>

 document.getElementById("cust_choice_ck").onchange = function () {
    var reader = new FileReader();

    reader.onload = function (e) {
        // get loaded data and render thumbnail.
        document.getElementById("img").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

</script> -->
<script>
$("isFound").change(function(){
    alert("Special Cake is Not Found");
});
</script>

</body>
</html>
