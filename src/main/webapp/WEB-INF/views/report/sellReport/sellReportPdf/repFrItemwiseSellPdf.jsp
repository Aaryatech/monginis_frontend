<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Item wise Sell Report</title>

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
									
									<th align="center">Item Name</th>
									<th align="center">Item Id</th>
									<th align="center">Group Name</th>
								 	<th align="center">Quantity</th>
									<th align="center">Amount</th> 
								  </tr>
								</thead>
								 <tbody >
								 <c:set var="totalAmount"   value="${0}"/>
								<c:set var="qty"  value="${0 }"/>
									  	<c:forEach items="${reportList}" var="reportList" varStatus="count">
												<tr>
													<td align="center"><c:out value="${count.index+1}" /></td>
													
													<td><c:out value="${reportList.itemName}" /></td>
													<td><c:out value="${reportList.itemId}" /></td>
													<td><c:out value="${reportList.catName}" /></td>
													<td><c:out value="${reportList.qty}" /></td>
													<c:set var="qty"  value="${qty + reportList.qty }"/>
													
													
													<td><fmt:formatNumber type = "number"  maxFractionDigits = "2" value="${reportList.amount}" /></td>
													 <c:set var="totalAmount" value="${totalAmount + reportList.amount}"/>
													 
													
													
												</tr>
										</c:forEach>
								  <tr>
								  <td colspan='4'><b>Total</b></td>
								  <td><b><c:out value="${qty}" /></b></td>
								     <td><b><fmt:formatNumber type = "number"  maxFractionDigits = "2" value = "${totalAmount}"/></b></td>
								     
								     <!--  <td><b>Total</b></td> -->
								  </tr>
							 </tbody>
								</table>

	
</body>
</html>