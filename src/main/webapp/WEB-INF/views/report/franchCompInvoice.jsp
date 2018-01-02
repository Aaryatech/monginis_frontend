<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Custmore Bill</title>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>
    </title>
    </head>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.style5 {font-size: 10px}
.style6 {font-size: 9px}
.style7 {
	font-size: 12px;
	font-weight: bold;
}
.style8 {
	font-size: 11px;
	font-weight: bold;
}
-->
</style>
</head>

</head>
<body >
	 
				  <table width="250" border="0" cellspacing="0" cellpadding="0" style="padding:5px; font-family:verdana; font-size:12px; border:1px solid #E7E7E7;">
  <tbody>
  <tr>
      <td colspan="2" align="center" style="padding:3px;"><p>BILL OF SUPPLY</p></td>
    </tr>
    <tr>
      <td colspan="2" align="center" style="padding:2px; border-bottom:1px solid #E7E7E7;"><p class="style2" ><b>${billList[0].frName}</b><br /><span style="font-size: 10px; font-family: Arial;">(The Monginis Cake Shop)</span></p>
       </td>
    </tr>
    <tr>
      <td colspan="2" align="center" style="padding:3px;font-family: Arial; border-bottom:1px solid #E7E7E7; font-size:12px;"><p class="style5">${billList[0].frAddress}
         <br />
          Phone:<strong>${billList[0].frMob}</strong><br/><br/>
          <span style="font-size:9px; font-family: Arial;">COMPOSITION TAXABLE PERSON, NOT TO<br />
          COLLECT TAX ON SUPPLIES        </span></td>
    </tr>
    <tr>
      <td colspan="2">
      <table width="100%" border="0" cellspacing="0" cellpadding="7">
  <tbody>
    <tr>
      <td  align="left">Bill No: </td>
      <td align="left">${billList[0].sellBillNo} </td>
      <td >Date:</td>
      <td >${billList[0].billDate }</td>
    </tr>
    <tr>
      <td>Name</td>
      <td colspan="3">${billList[0].custName}</td>
     
      </tr>
    <tr>
      <td colspan="4"><table width="100%" border="0" cellspacing="0" cellpadding="5" class="tbl-inner">
        <tbody>
          <tr>
            <th width="43%" align="left" bgcolor="#ECECEC">Item</th>
            <th width="8%" bgcolor="#ECECEC">Qty</th>
            <th width="13%" bgcolor="#ECECEC">Rate</th>
            <th width="29%" align="center" bgcolor="#ECECEC">Amt</th>
          </tr>
          <c:forEach items="${billList}" var="billList" varStatus="count">
          <tr>
            <td><p style="font-size:12px">${billList.itemName}</p>
				<p style="font-size:10px">hsn123456789</p></td>
            <td align="center"><p style="font-size:12px">${billList.qty}</p></td>
            <td align="center"><p style="font-size:12px">${billList.mrp}</p></td>
            <td align="right"><p style="font-size:12px">${billList.qty*billList.mrp}</p></td>
          </tr>
          </c:forEach>
          <tr>
            <td rowspan="3">&nbsp;</td>
            <td colspan="2" align="right"><span class="style5"><strong>Total :</strong></span></td>
            <td align="right"><span class="style5"><strong>${billList[0].bill_amount}</strong></span></td>
          </tr>
          <tr>
            <td colspan="2" align="right"><span class="style7">Bill Total:</span></td>
            <td align="right"><span class="style7">${billList[0].bill_amount}</span></td>
          </tr>
        </tbody>
      </table></td>
      </tr>
  </tbody>
</table>      </td>
    </tr>
    <tr>
      <td colspan="2">
        <table width="100%" border="0" cellspacing="0" cellpadding="7" >
  
    <tr>
      <td align="center" style="border-top:1px solid #E7E7E7; padding:5px 7px;"><p class="style8">Thank You, VIsit Again !!! &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E. &amp; O.E.</p>        </td>
    </tr>
    <tr>
      <td style="border-top:1px solid #E7E7E7; padding:5px 7px;">We declare that this invoice shows the actual price of the goods<br />
        described and that all particulars are true and correct.</td>
    </tr>
</table>      </td>
    </tr>
    <tr>
      <td width="200" align="center" style="border-top:1px solid #E7E7E7; padding:5px 7px;"><strong>for ${billList[0].frName}</strong></td>
    </tr>
  </tbody>
</table>
				
	
</body>
</html>