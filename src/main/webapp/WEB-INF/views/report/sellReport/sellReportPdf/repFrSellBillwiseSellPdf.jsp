<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bill wise Sell Report</title>

<style type="text/css">
table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: left;
      padding: 2px;
    font-size: 10;
}

tr:nth-child(even){background-color: #f2f2f2}

th {
    background-color: #EA3291;
    color: white;
}
</style>
</head>
<body onload="myFunction()">

	<table width="100%" border="0" cellspacing="0"
														cellpadding="0" id="table_grid" class="table table-bordered">
								<thead >
									<tr class="bgpink">
									<th align="right" style="width:100px">Sr no.</th>
									<th align="center">Bill No</th>
									<th align="center">Date</th>
									<th align="center">Amount</th>
									<th align="center">Payment Mode</th>
								
									
									
								  </tr>
								</thead>
								
								 <tbody >
								 <c:set var="totalAmount"   value="${0}"/>
								
							
								  	<c:forEach items="${reportList}" var="reportList" varStatus="count">
												<tr>
													<td align="center"><c:out value="${count.index+1}" /></td>
												<td><c:out value="${reportList.sellBillNo}" /></td>
												<td><c:out value="${reportList.billDate}" /></td>
												
													<td><fmt:formatNumber type = "number"  maxFractionDigits = "2" value="${reportList.payableAmt}" /></td>
													 <c:set var="totalAmount" value="${totalAmount + reportList.payableAmt}"/>
													 
													 <c:choose>
																	<c:when test="${reportList.paymentMode==1}">
																	
																		<td><c:out value="Cash" /></td>
																	</c:when>
																	<c:when test="${reportList.paymentMode==2}">
																	
																		<td><c:out value="Card" /></td>
																	</c:when>
																	<c:when test="${reportList.paymentMode==3}">
																	
																		<td><c:out value="Other" /></td>
																	</c:when>
													</c:choose>
												
														
													
													
												</tr>
												</c:forEach>
								  <tr>
								  <td colspan='3'><b>Total</b></td>
								  <td><b><fmt:formatNumber type = "number"  maxFractionDigits = "2" value ="${totalAmount}"/></b></td>
								    
								  </tr>
							 </tbody>
								</table>

	
</body>
</html>