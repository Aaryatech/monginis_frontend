<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Item wise Purchase Tax Detail</title>

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
									<th>Sr.No.</th>
									<th>Item Name</th>
									<th>Party Name</th>
									<th>Bill No</th>
									<th>Bill Date</th>
									<th>Qty</th>
									<th>Rate</th>
									<th>Amount</th>
									<th>GRN TYPE</th>
								
								  </tr>
								</thead>
								
								 <tbody >
								  <tbody >
								
								<c:set var="grandTotal"  value="${0 }"/>
								  	<c:forEach items="${reportList}" var="reportList" varStatus="count">
												<tr>
													<td align="center"><c:out value="${count.index+1}" /></td>
													<td><c:out value="${reportList.itemName}" /></td>
													<td>GFPL</td>
													<td><c:out value="${reportList.billNo}" /></td>
													<td><c:out value="${reportList.billDate}" /></td>
														<td><c:out value="${reportList.qty}" /></td>
															<td><c:out value="${reportList.rate}" /></td>
													<td><c:out value="${reportList.total}" /></td>
														<c:set var="grandTotal"  value="${grandTotal+reportList.total }"/>
													<td>GRN <c:out value="${reportList.grnType}" /></td>
												</tr>
												</c:forEach>
								  <tr>
								  <td colspan='7'><b>Total</b></td>
							
								     <td><b><fmt:formatNumber type = "number"  maxFractionDigits = "2" value = "${grandTotal}"/></b></td>
								       <td></td>
								  </tr>
							 </tbody>
								</table>

	
</body>
</html>