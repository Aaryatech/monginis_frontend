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

        
</head>
<body>

<!--topLeft-nav-->
<div class="sidebarOuter"></div>
<!--topLeft-nav-->

<!--wrapper-start-->
<div class="wrapper">

<!--topHeader-->
<c:url var="getGrnList" value="/getGrnList" />
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
<h2 class="pageTitle">GRN Details</h2>

</div>


<div class="colOuter">
		<div class="col1"><div class="col1title">From</div></div>
		<div class="col2"><input id="datepicker" class="texboxitemcode texboxcal" placeholder="Delivery Date"  name="from_Date" type="text"  >
		</div>
	</div>

	<div class="colOuter">
		<div class="col1"><div class="col1title">TO</div></div>
		<div class="col2"><input id="datepicker2" class="texboxitemcode texboxcal" placeholder="Delivery Date"  name="to_Date" type="text"  >
		</div>
	</div>
	
<div class="colOuter">
		<div class="col2full">
        	<input name="" class="buttonsaveorder" value="Search..." type="button" onclick="searchGRN()">
			</div>
</div>
    
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
        

    
       
    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table_grid">
												<thead>
												<tr class="bgpink">
														
														<th  >Bill No</th>
														<th >GRN Date</th>
														<th >Item Name</th>
														<th  >RATE</th>
														<th  >Quantity</th>
														<th  >TYPE of GRN</th>
														<th  >Amount</th>
														<th  >Status</th>
														<th  >Remark</th>
														
													</tr>
													</thead>
<tbody>

 <%-- <c:forEach items="${grnList}" var="grnList"> 
  <tr>
    <td><c:out value="${grnList.billNo}"/></td>
    <td><c:out value="${grnList.grnGvnDate}"/></td>
    <td><c:out value="${grnList.itemName}"/></td>
    <td><c:out value="${grnList.itemRate}"/></td>
    <td><c:out value="${grnList.grnGvnQty}"/></td>
   			<c:choose>
					<c:when test="${grnList.grnType==0}">
					<td><c:out value="GRN 1"></c:out></td>
						</c:when>
							<c:when test="${grnList.grnType==1}">
								<td><c:out value="GRN 2"></c:out></td>
									</c:when>
									<c:when test="${grnList.grnType==2}">
										<td><c:out value="GRN 3"></c:out></td>
										</c:when>
									</c:choose>
    <td><c:out value="${grnList.grnGvnAmt}"/></td>
    <td><c:out value="${grnList.grnGvnStatus}"/></td>
    <td><c:out value="${grnList.frGrnGvnRemark}"/></td>
  </tr>
  </c:forEach>   --%>
  
 </tbody>
  

</table>
</td>
  </tr>
</table>
</div>
</div>
</li>

</ul> 
</div>
<!--tabNavigation-->
 
 
		
</div>
<!--rightSidebar-->

</div>
<!--fullGrid-->
</div>
<!--rightContainer-->

</div>
<!--wrapper-end-->

<script type="text/javascript">
	
		function searchGRN() {
			
			$('#table_grid td').remove();
		
			
			var isValid = validate();
			
			if (isValid) {
				
				var fromDate = document.getElementById("datepicker").value;
				var toDate = document.getElementById("datepicker2").value;
				   
				
				$.getJSON('${getGrnList}',{
					
									fromDate : fromDate,
									toDate : toDate,
									ajax : 'true'

								},
								function(data) {

									//$('#table_grid td').remove();
									
									

									if (data == "") {
										alert("No records found !!");

									}

									
									$.each(data,function(key, grndata) {

														var index = key + 1;

														var tr = "<tr>";

														

														var billNo = "<td>&nbsp;&nbsp;&nbsp;"
																+ grndata.billNo
																+ "</td>";
																var grnGvnDate = "<td>&nbsp;&nbsp;&nbsp;"
																	+ grndata.grnGvnDate
																	+ "</td>";
																	var itemName = "<td>&nbsp;&nbsp;&nbsp;"
																		+ grndata.itemName
																		+ "</td>";

																		var itemRate = "<td>&nbsp;&nbsp;&nbsp;"
																			+ grndata.itemRate
																			+ "</td>";

																			var grnGvnQty = "<td>&nbsp;&nbsp;&nbsp;"
																				+ grndata.grnGvnQty
																				+ "</td>";
																				
																				var grnType = "<td>&nbsp;&nbsp;&nbsp;"
																					+ grndata.grnType
																					+ "</td>";

																				var grnGvnAmt = "<td>&nbsp;&nbsp;&nbsp;"
																					+ grndata.grnGvnAmt
																					+ "</td>";

																					var grnGvnStatus = "<td>&nbsp;&nbsp;&nbsp;"
																						+ grndata.grnGvnStatus
																						+ "</td>";
																						
																							var frGrnGvnRemark = "<td>&nbsp;&nbsp;&nbsp;"
																									+ grndata.frGrnGvnRemark
																									+ "</td>";



														

														var trclosed = "</tr>";

														$('#table_grid tbody')
																.append(tr);
														$('#table_grid tbody')
																.append(billNo);
														$('#table_grid tbody')
														.append(grnGvnDate);
														$('#table_grid tbody')
														.append(itemName);
														$('#table_grid tbody')
														.append(itemRate);
														$('#table_grid tbody')
														.append(grnGvnQty);
														$('#table_grid tbody')
														.append(grnType);
														
														$('#table_grid tbody')
														.append(grnGvnAmt);
														
														$('#table_grid tbody')
														.append(grnGvnStatus);
														
														$('#table_grid tbody')
														.append(frGrnGvnRemark);
														
														$('#table_grid tbody')
														.append(trclosed);
														

													})
														

								});

			}
		}
	</script>
	
	
	
		<script type="text/javascript">
		function validate() {
		
		
			var fromDate =$("#datepicker").val();
			var toDate =$("#datepicker2").val();
			

			var isValid = true;

		 if (fromDate == "" || fromDate == null) {

				isValid = false;
				alert("Please select From Date");
			}
		 else if (toDate == "" || toDate == null) {

				isValid = false;
				alert("Please select To Date");
			}
			return isValid;

		}
	</script>






</body>
</html>
