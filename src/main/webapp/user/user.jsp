<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page import="servlets.user.UserInfo"%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - user page</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<link rel="stylesheet" type="text/css" href="./../css/user.css" />

<script  type="text/javascript">




</script> 
 

<body id="home">
<%PageContext pagecontext; %>
<%JspFactory Fact; %>
<%Fact = JspFactory.getDefaultFactory(); %>
<%ServletContext gg; %>

 <%pagecontext = Fact.getPageContext(this, request, response, "", true, 233, true);%>

 <div id="welcome">
 <img src="./../icons/welcome1.gif" alt="banneraki" class="center" >
 
 		<br>
		<div style="display: flex;">
							
			<h4 id="logout" class="right_profile">
				<a class="hyperlink" href="/HelloWorldJSP/user/showInfo" > Προφίλ    <%=session.getAttribute("userName")%> </a>
			</h4>

			<h4 id="logout" class="right">
				<a class="hyperlink" href="/HelloWorldJSP/admin/logOutServlet" > Αποσύνδεση </a>
			</h4>
		</div>
		<br>
 
 <h1>Ηλεκτονική πλατφόρμα διαχείρισης Αποθηκών</h1>

 <ul id="navigation">

    <li><a href="./user.jsp" id = "home" class="link1">Αρχική Σελίδα</a></li>
    <c:if test="${sessionScope.warepermissions!=2}">
    <li><a href="/HelloWorldJSP/admin/warehouses.jsp" id="apoth" class="link3">Αποθήκες</a></li>
    </c:if>
    <c:if test="${sessionScope.propermissions!=2}">
    <li><a href="/HelloWorldJSP/admin/products.jsp" id = "products" class="link4">Προιόντα</a></li>
    </c:if>
    <c:if test="${sessionScope.suppermissions!=2}">
    <li><a href="/HelloWorldJSP/admin/suppliers.jsp" id="prom" class="link5">Προμηθευτές</a></li>
    </c:if>
   
</ul>

<%
UserInfo user = UserInfo.getUserByUsername((String) session
		.getAttribute("userName"));
%>

<table id="table" class="pricingtable" >   
               <tr>
               <th colspan="2" class="prodS">Στοιχεία</th>
               </tr>
               <tr>
               <td>Ονομα</td>
               <td> <%=user.getName()%></td>
               </tr>
               <tr>
               <td>Επώνυμο</td>
               <td> <%=user.getSurname()%></td>
               </tr>
               <tr>
               <td>email</td>
               <td> <%=user.getEmail()%></td>
               </tr>
               <td>Ημέρα εγγραφής</td>      

   
                     <jsp:useBean id="timeValues" class="java.util.Date"/>
   					 <c:set target="${timeValues}" value="${pageContext.session.creationTime}" property="time"/>
      				 <c:set var="ceateTime" value="${pageContext.session.creationTime}" scope="session"/>   
         			 <td> <p><fmt:formatDate type="both" dateStyle="long" timeStyle="long" value='${timeValues}'  />  <p> </td> 
                  </tr>
                </table>   

  	<br> <br><br>
    	<br> <br><br>
    	<br> <br>
   </div>

</body>
</html>