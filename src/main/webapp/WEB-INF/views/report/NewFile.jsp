<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.io.*,java.sql.* ,javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat,java.text.DateFormat,com.itextpdf.text.*,com.itextpdf.text.pdf.*,java.io.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
      <title>files.jsp</title>
<meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
     
    </head>
    <body style="background-color:#FFFFCC;">
   
<%
 String d="div"; 
String y= "year";
String m ="month1"; 
%>
<%
try
{
response.setContentType("application/pdf");   
response.setHeader("content-disposition","attachment; filename="+"monthwise.pdf");   
String m1="something data from db";
ResultSet rs=null;
Statement st=null;

 %>
<center>
  <b></b><font size="4" face="Georgia, Arial" color="maroon">O&M Activity Monitoring system
   <br/>Status Report on Details of Live Files for the Division - <%=d %>   <br/>
  NIC- Ministry of Petroleum & Natural Gas<br/>  
 Files opened in<%=m1 %><%=y %> </font>  <br/><br/>  <br/><br/>
  </center>
 
   <%
    
   %> 
   <center>
  <table border="1" bordercolor="black" cellpadding="3" cellspacing="5">
  <tr>
  <th><font size="3" color="blue">In Section</font></th>
  <th><font size="3" color="blue"> File No.(Computer File No.)</font></th>
   <th><font size="3" color="blue"> Subject</font></th>
  <th><font size="3" color="blue"> Opened Date</font></th>
  </tr>
  <%
 //response.setContentType("application/pdf");
 String FILE = "/Users/MIRACLEINFOTAINMENT/ATS/uplaods/FirstPdf.pdf";
 Document document = new Document();
 PdfWriter.getInstance(document, new FileOutputStream(FILE));
  document.open();
  String name=null;
int yr =Integer.parseInt(y);  
  DateFormat dtFormat = new SimpleDateFormat("dd/MM/yyyy");   
String formattedDate=dtFormat.format(rs.getDate("open_dt"));  
 %>
  <tr>
  <td>name </td>
  <td>rs.getString(1) rs.getInt(10) </td>
  <td>rs.getString(2) </td>
  <td>formattedDate </td>
  </tr>
   
  <%
  document.close();
  response.setContentType("application/pdf");
    response.setHeader("content-disposition","attachment;filename="+"FirstPdf.pdf");
    byte[] buf = new byte[8192]; 
    FileInputStream in = new FileInputStream(FILE);
    OutputStream out1 = response.getOutputStream();
     int c;  
     while ((c = in.read(buf, 0, buf.length)) > 0) {  
       out1.write(buf, 0, c);  
     }  
     out1.flush();  
   out1.close();
  }
  catch(Exception e)
  {
    }
 
   %>
 
  </table>
   
  <br/><br/>
  <input class=button type="button" value="Print" name="pr" title="Print" onClick="window.print();">
  </center>
 
   
  </body>
  </html>  