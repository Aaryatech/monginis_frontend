<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Date wise Sell Report</title>

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
									<!-- <th align="center">Bill No</th> -->
									<th align="center">Date</th>
									<th align="center">Amount</th>
									<th align="center">Cash</th>
								 	<th align="center">Card</th>
									<th align="center">Other </th> 
								  </tr>
								</thead>
								
								
								 <tbody >
								 <c:set var="totalAmount"   value="${0}"/>
								<c:set var="totalCash"  value="${0 }"/>
								<c:set var="totalCard"  value="${0 }"/>
								<c:set var="totalOther"  value="${0 }"/>
								  	<c:forEach items="${reportList}" var="reportList" varStatus="count">
												<tr>
													<td align="center"><c:out value="${count.index+1}" /></td>
													<td><c:out value="${reportList.billDate}" /></td>
													<c:set var="amt"  value="${reportList.cash + reportList.card + reportList.other }"/>
													<td><fmt:formatNumber type = "number"  maxFractionDigits = "2" value="${amt}" /></td>
													 <c:set var="totalAmount" value="${totalAmount + amt}"/>
													 
													<td><c:out value="${reportList.cash}" /></td>
														<c:set var="totalCash"  value="${totalCash + reportList.cash}"/>
													<td><c:out value="${reportList.card}" /></td>
														<c:set var="totalCard"  value="${totalCard+reportList.card }"/>
													<td><c:out value="${reportList.other}" /></td>
														<c:set var="totalOther"  value="${totalOther+reportList.other }"/>
													<%-- <td><c:out value="${reportList.sess}" /></td> --%>
													
													
												</tr>
												</c:forEach>
								  <tr>
								  <td colspan='2'><b>Total</b></td>
								  <td><b><fmt:formatNumber type = "number"  maxFractionDigits = "2" value ="${totalAmount}"/></b></td>
								     <td><b><fmt:formatNumber type = "number"  maxFractionDigits = "2" value = "${totalCash}"/></b></td>
								      <td><b><fmt:formatNumber type = "number"  maxFractionDigits = "2" value = "${totalCard}"/></b></td>
								       <td><b><fmt:formatNumber type = "number"  maxFractionDigits = "2" value = "${totalOther}"/></b></td>
								     <!--  <td><b>Total</b></td> -->
								  </tr>
							 </tbody>
								</table>

	
</body>
</html>