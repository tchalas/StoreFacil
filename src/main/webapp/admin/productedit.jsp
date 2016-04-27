<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.Users"%>
<%@ page import="servlets.admin.warehouses.WarehouseProductSupplier"%>
<%@ page import="connectionPool.StartUpConnectionPool"%>
<%@ page import="servlets.admin.products.Product"%>
<%@ page import="servlets.admin.warehouses.Warehouses"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html ">
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - edit product</title>
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

 
<%
List<WarehouseProductSupplier> wareProdSupp = new ArrayList<WarehouseProductSupplier>(); 
List<String> wareListExceName = new ArrayList<String>();
Product prod = new Product();
%>

<script type="text/javascript">

	var request;
	var request2;
	

	function validateForm(nameP,serialP,numberWare,transWareH){
		
		nameProduct = nameP;
		serialProduct = serialP;
		
		var dele = document.getElementById("prodDelete").checked;
		
		if(dele == false){
	
			for (var war=0; war < numberWare; war++){
			
				var idware = 'wareProdDelete' + war;
				var deleWare = document.getElementById(idware).checked;
				idware = 'wareName' + war ;
				var x = document.getElementById(idware).selectedIndex;
				var y = document.getElementById(idware).options;
				var wareh = 'warehouseName' + war;
				var warehous = document.getElementById(wareh);
				
				var warehous1 = warehous.innerHTML;
				
				var supp = 'supplierName' + war;
				var suppl = document.getElementById(supp);
				
				var supplier = suppl.innerHTML;
				
				if(deleWare){
					finalString = nameP + '@@@' + serialP + '@@@' + warehous1 + '@@@' + supplier + '@@@' ;;
					request = new XMLHttpRequest();
					request.onreadystatechange = resultDeleteProductWarehouse;
					request.open("GET", "/HelloWorldJSP/admin/deleteProductWarehouse?finalString=" + finalString, true);
					request.send(null);
				}
				else{
					if(y[x].innerHTML != null && y[x].innerHTML != "" && y[x].innerHTML != " "){
						var finalString = nameP + '@@@' + serialP + '@@@' + warehous1 + '@@@' + supplier + '@@@' + y[x].innerHTML + '@@@'; ;
						request = new XMLHttpRequest();
						request.onreadystatechange = resultTransferProductWarehouse;
						request.open("GET", "/HelloWorldJSP/admin/transferProductWarehouse?finalString="
						+finalString, true);
						request.send(null);
					}
				}
			}
			updateProduct();
		}
		else{
			var answer = confirm("Είστε σίγουρος ότι θέλετε να διαγράψετε το Προϊόν " + nameP + " ;");
			if (answer){
				var finalString  = nameP + '@@@' + serialP + '@@@' ;
				request = new XMLHttpRequest();
				request.onreadystatechange = resultDeleteProduct;
				request.open("GET", "/HelloWorldJSP/admin/deleteProduct?finalString="
				+ finalString, true);
				request.send(null);
				
			}
			else{
				document.getElementById("prodDelete").checked = false;
			}
		}
		
		return false;
	}
	
	function resultDeleteProduct(){
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Tο Προϊόν διαγράφθηκε.");
			}
			window.location.href = '/HelloWorldJSP/admin/products.jsp';
		}
		return false;
	}
	
	
	function resultDeleteProductWarehouse(){
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Tο Προϊόν διαγράφθηκε απο την Αποθήκη.");
			}
		}
	}
	
	
	function resultTransferProductWarehouse(){
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Tο Προϊόν μεταφέρθηκε με επιτυχία.");
			}
		}
	}
	
	var x1;
	var x2;
	var x3;
	var x4;
	var x5;
	var x6;
	var x7;
	var x8;
	
	var desc = "";
	var wei = "";
	var mass = "";
	var type = "";
	var dime = "";
	
	var nameProduct;
	var serialProduct;
	
	
	function updateProduct(){
		
		if(desc != x1 || wei != x2 || mass != x3 || type != x4 ||  dime != x5 ){
		x1=document.getElementById("formDescriptionCenterProd").value;
		x2=document.getElementById("formWeight").value;
		x3=document.getElementById("formMass").value;
		x4=document.getElementById("formType").value;
		x5=document.getElementById("formDimensions").value;
		
		desc = x1;
		wei = x2;
		mass = x3;
		type = x4;
		dime = x5;
		

		if(!isNumber(x2)){
			alert("Το πεδίο Βάρος πρέπει να είναι αριθμός");
			document.getElementById("formWeight").value = '';
			return false;
		}

		
		
		if(!isNumber(x3)){
			alert("Το πεδίο Όγκος  πρέπει να είναι αριθμός");
			document.getElementById("formMass").value = '';
			return false;
		}
		
		

		if (x1==null || x1==""){
			alert("Το πεδίο Περιγραφή είναι υποχρεωτικό");
			return false;
			
		}
		
		
		
		if (x1==null || x1==""){
			intCheck1=1;
			intCheck2++;
		}
		
		
		
		if(x2==null || x2==""){
			x2 = " ";
		}
		
		
		
		if (x3==null || x3==""){
			x3 = " ";
		}
		
		
		
		if(x4==null || x4==""){
			x4 = " ";
		}
		
		
		if (x5==null || x5==""){
			x5 = " ";
		}
		
		var finalString  = nameProduct + '@@@' + serialProduct + '@@@' + x1 + '@@@'  + x2 + '@@@' + x3 + '@@@' + x4 + '@@@' + x5 + '@@@';
		
		request = new XMLHttpRequest();
		request.onreadystatechange = everythingIsFine;
		request.open("GET", "/HelloWorldJSP/admin/upadateProduct?finalString="+ finalString, true);
		request.send(null);
		}
	}
	
	function everythingIsFine(){
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "yes") {
				alert("Tο Προϊόν ενημερώθηκε με επιτυχία.");
			}
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			}
			window.location.href = '/HelloWorldJSP/admin/products.jsp';
		}
	}
	
	function isNumber(str){
		
		if(isNaN(str))
		return false;
		else 
		return true;
	}

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
				<a class="hyperlink" href="/HelloWorldJSP/user/showInfo">
					Προφίλ <%=session.getAttribute("userName")%>
				</a>
			</h4>

			<h4 id="logout" class="right">
				<a class="hyperlink" href="/HelloWorldJSP/admin/logOutServlet">
					Αποσύνδεση</a>
			</h4>
		</div>

		<br>

		<h1>Ηλεκτονική πλατφόρμα διαχείρισης Αποθηκών</h1>

		<h2>Σελίδα Προϊόντων</h2>

		
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
						<h4 class="tabcss">Σελίδα Διαχείρισης Προϊόντων</h4>
					</li>
					<li class="lh" id="t5" onClick="change('tab5')">
						<h4 class="tabcss">Σελίδα Διαχείρισης Προμηθευτών</h4>
					</li>
				</ul>
			</div>
		</div>

		<br>
		<br> <br>
		<br> <br>
		<br>
		</c:if>
		<h3 id="search">Επεξεργασία Προϊόντος ${product.getName()} με
			σειριακό αριθμό ${product.getSerial()}</h3>

		<br>
		<br>

		<div class="cube">
			<div class="form_center" >
				<h5 class="centerProd">Το πεδίο με αστερίσκο είναι υποχρεωτικά</h5>
				<br> <label class="centerProd">Περιφραφή* : </label>
				<textarea id="formDescriptionCenterProd" autofocus <c:out value="${read}"/> rows="2"
					cols="30" maxlength="60"
					placeholder="Συμπλήρωσε την περιγραφή του Προϊόντος ...">${product.getDescription()}</textarea>
				<br> <br> <label class="centerProd">Βάρος (σε
					γραμμάρια) : </label> <input type="text" <c:out value="${read}"/> id="formWeight"
					value="<c:out value="${product.getWeight()}"/>" /> <br> <br>
				<label class="centerProd">Όγκος (ακέραιος αριθμός) : </label><input
					type="text" <c:out value="${read}"/> id="formMass"
					value="<c:out value="${product.getMass()}"/>" /> <br> <br>
				<label class="centerProd">Είδος : </label><input type="text"
					id="formType" <c:out value="${read}"/> value="<c:out value="${product.getType()}"/>" /> <br>
				<br> <label class="centerProd"> Διαστάσεις : </label><input
					type="text" <c:out value="${read}"/> id="formDimensions"
					value="<c:out value="${product.getDimensions()}"/>" /> <br> <br>
				

			</div >
		

	<c:if test="${re!=1}">
		<br> <br> 
		
		<label id="productDeleteCheck" class="centerProdDelete">Μπορείτε
				να διαγράψετε το Προϊόν κάνοντας κλικ εδώ : </label><input
				type="checkbox" id="prodDelete"> <br> <br>
		</c:if> 
		<br>
		
		<%
		
		 	prod = (Product) request.getAttribute("product");
		
			wareProdSupp = WarehouseProductSupplier.getListWarehouseProductSupplierByNameAndSerial(prod.getName(),prod.getSerial());
			if( wareProdSupp!= null && wareProdSupp.size() >= 1){
				
		%>
		
		<table class="pricingtable">
			<tr>
				<th colspan="6" class="prodS">Στοιχεία</th>
			</tr>
			<tbody>
				<tr class="title">

					<th>Αποθήκη</th>
					<th>Προμηθευτής</th>
					<th>Ποσότητα</th>
					<th>Τιμή</th>
					<c:if test="${re!=1}">
					<th>Διαγραφή απο την Αποθήκη</th>
					<th>Μεταφορά στην Αποθήκη</th>
					</c:if> 
				</tr>
				<%
				for(int i=0; i < wareProdSupp.size(); i++ ){
					
					wareListExceName =  Warehouses.getNamesWarehousesExceptByName(wareProdSupp.get(i).getNameW());
				%>
				<tr>
					<td id="warehouseName<%=i%>" ><%=wareProdSupp.get(i).getNameW() %></td>
					<td id="supplierName<%=i%>"><%=wareProdSupp.get(i).getNameS() %></td>
					<td ><%=wareProdSupp.get(i).getCapacity() %></td>
					<td ><%=wareProdSupp.get(i).getCost() %></td>
					<c:if test="${re!=1}">
					<td><input
					type="checkbox" id="wareProdDelete<%=i%>">
					</td>
					</c:if>
	<c:if test="${re!=1}">
					<td>
					<select id="wareName<%=i%>" class="styled-select">
					<option id="idWareName0" selected="selected"></option>
					<%
					if(wareListExceName != null){
						for(int j =0; j < wareListExceName.size(); j++){
					%>
					 	
						<option id="idWareName" class="opt"><%=wareListExceName.get(j)%></option>
										
					
					<%
						}
						%>
					<%
					}
					else{
					
					}
					%>
					
					</select>
					
					</td>
					
					</c:if> 
				</tr>
				<%
				}
				%>
				
			</tbody>
		</table>
		
		
		<br> <br>
		<c:if test="${re!=1}"> 
		<button id="btnProductUp" onclick="validateForm('${product.getName()}','${product.getSerial()}','<%=wareProdSupp.size() %>'); return false;">Ενημέρωση
					Στοιχείων</button>
</c:if>
		<br> <br>

		</div>
		<br> <br>
		<br> <br>
		<%
			}
		%>

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
			response.setHeader("Refresh", "5;url=../welcome/welcome.jsp");
			}
		%>
	</div>

</body>
</html>