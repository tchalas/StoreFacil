<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.Users"%>
<%@ page import="servlets.admin.products.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - products search page</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<c:set var="em" value="0" />	
<c:set var="rr" value="./../css/products.css" />	
<c:set var="em" value="0" />	
<c:set var="re" value="0" />
				<c:if test="${sessionScope.usr=='user'}">
				
				<c:set var="rr" value="./../css/products.css" />		
				<c:set var="em" value="1" />	
				 </c:if>
				<c:if test="${sessionScope.propermissions==0}">	
				<c:set var="re" value="1" />
				<c:set var="read" value="readonly" />		
				 </c:if>				 
<link rel="stylesheet" type="text/css" href=<c:out value="${rr}"/> />	

<script  type="text/javascript">

function change(namee) {

	var livetab = 't0', i;
	switch (namee) {
	case 'tab1':
		livetab = 't1';
		window.location.href = '/HelloWorldJSP/admin/roles.jsp';
		break;
	case 'tab2':
		livetab = 't2';
		window.location.href = '/HelloWorldJSP/admin/rolesUsers.jsp';
		break;
	case 'tab3':
		window.location.href = '/HelloWorldJSP/admin/warehouses.jsp';
		livetab = 't3';
		break;
	case 'tab4':
		window.location.href = '/HelloWorldJSP/admin/products.jsp';
		livetab = 't4';
		break;
	case 'tab5':
		livetab = 't5';
		window.location.href = '/HelloWorldJSP/admin/suppliers.jsp';
		break;
	}
	for (i = 1; i <= 5; i++) {
		document.getElementById("t" + i).style.backgroundColor = "#1C7AED";
	}
	document.getElementById(livetab).style.backgroundColor = "#70B8B8";
}




</script>
<body>
	<div id="welcome">
		<%
		if (session.getAttribute("userName") != null
				 && (Integer.parseInt(session.getAttribute("propermissions").toString())) != 2) {
				
		%>
		<img src="./../icons/welcome1.gif" alt="banneraki" class="center">

		<br>
		
		<div style="display: flex;">
							
			<h4 id="logout" class="right_profile">
				<a class="hyperlink" href="/HelloWorldJSP/user/showInfo" > Προφίλ <%=session.getAttribute("userName")%> </a>
			</h4>

			<h4 id="logout" class="right">
				<a class="hyperlink" href="/HelloWorldJSP/admin/logOutServlet" > Αποσύνδεση</a>
			</h4>
		</div>

		<br>

		<h1>Ηλεκτονική πλατφόρμα διαχείρισης Αποθηκών</h1>

		
 		<h2>Σελίδα Αποτελεσμάτων Προϊόντων</h2>
			<c:if test="${em==1}">
			<ul id="navigation">
		
		    <li><a href="../user/user.jsp" id = "home" class="link1">Αρχική Σελίδα</a></li>
		    <c:if test="${sessionScope.warepermissions!=2}">
		    <li><a href="./warehouses.jsp" id="apoth" class="link3">Αποθήκες</a></li>
		    </c:if>
		    <c:if test="${sessionScope.propermissions!=2}">
		    <li><a href="./products.jsp" id = "products" class="link4">Προιόντα</a></li>
		    </c:if>
		    <c:if test="${sessionScope.suppermissions!=2}">
		    <li><a href="./suppliers.jsp" id="prom" class="link5">Προμηθευτές</a></li>
		    </c:if>
		   
		</ul>
		</c:if>
	
		<c:if test="${em!=1}">
		<div id="tabbed_section">
			<div id="menu">
				<ul id="ul_tabs">
					<li class="lh" id="t1" onClick="change('tab1')">
						<h4 class="tabcss">Σελίδα Ρόλων Χρηστών</h4>
					</li>
					<li class="lh" id="t2" onClick="change('tab2')">
						<h4 class="tabcss">Σελίδα Λίστας Χρηστών</h4>
					</li>
					<li class="lh" id="t3" onClick="change('tab3')">
						<h4 class="tabcss">Σελίδα Διαχείρισης Αποθηκών</h4>
					</li>
					<li class="lh" id="t4" onClick="change('tab4')">
						<h4 class="tabcss">Σελίδα Προϊόντων</h4>
					</li>
					<li class="lh" id="t5" onClick="change('tab5')">
						<h4 class="tabcss">Σελίδα Διαχείρισης Προμηθευτών</h4>
					</li>
				</ul>
			</div>
		</div>
		<br><br><br><br>
 		</c:if>
 		<h2>Αποτελεσμάτα</h2>
 		<br>
		<table id="tableSearchProducts" class="pricingtable">
			<tbody>
				<tr>
						<th colspan="8" class="prodS">Προϊόν</th>
					</tr>
				<tr >
			  		<th >Όνομα Προϊόντος</th>
			        <th >Σειριακός Αριθμός</th>
			        <th >Περιγραφή</th>
			       	<th >Βάρος</th>
			       	<th >Όγκος</th>
			       	<th >Τύπος</th>
			       	<th >Διαστάσεις</th>
			       	<th >Επιλογή</th>
			       	
		    	</tr>
		  
		        
		       
		        	<c:forEach var="product" items="${productList}">
		        	<tr>
		            	<td >${product.getName()}</td>
		                <td >${product.getSerial()}</td>
		                <td >${product.getDescription()}</td>
		                <td >${product.getWeight()}</td>
		                <td >${product.getMass()}</td>
		                <td >${product.getType()}</td>
		                <td >${product.getDimensions()}</td>
		                <td ><a href="EditProduct?serial=${product.getSerial()}&name=${product.getName()}">Περισσότερα/Επεξεργασία</a></td>
		            </tr>
		            </c:forEach>
		  
		    
		    
			</tbody>
		</table>
		
		<br> <br>
		
				<%
			}

			else {
		%>

		<img src="./../icons/welcome1.gif" alt="banneraki" class="center">

		<h1>Ηλεκτονική πλατφόρμα διαχείρισης Αποθηκών</h1>
		<br> <br>


		<h3>Πρέπει να επιστρέψετε στην αρχική σελίδα.</h3>
		<br> <br> <br> <br> <br> <br>

		<%
			response.setHeader("Refresh", "3;url=../welcome/welcome.jsp");
			}
		%>

</div>

</body>
</html>