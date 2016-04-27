<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.products.Product" %>
<%@ page import="servlets.admin.products.ProductSuppCost" %>
<%@ page import="servlets.admin.products.ProductWarehouseCapacity" %>
<%@ page import="servlets.admin.Users"%>
<%@ page import="servlets.admin.products.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html">
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - products</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<c:set var="em" value="0" />	
<c:set var="rr" value="./../css/products.css" />	
<c:set var="em" value="0" />	
<c:set var="re" value="0" />
				<c:if test="${sessionScope.usr=='user'}">
				
				<c:set var="rr" value="./../css/user.css" />		
				<c:set var="em" value="1" />	
				 </c:if>
				<c:if test="${sessionScope.propermissions==0}">	
				<c:set var="re" value="1" />	
				 </c:if>				 
<link rel="stylesheet" type="text/css" href=<c:out value="${rr}"/> />		
<%
	ProductSuppCost.clearSupplierToList();
	ProductWarehouseCapacity.clearWarehouseToList();
%>
<script  type="text/javascript">

function isNumber(str){
	
	if(isNaN(str))
	return false;
	else 
	return true;
}

function isFloat(n) {
	return n != "" && !isNaN(n) && Math.round(n) != n || n.indexOf(".0")  >= 0;
}

var request;
var request2;

function addSupplier(){
	var cost = document.getElementById("formSupplierCost").value;
	var x = document.getElementById("supp").selectedIndex;
	var y = document.getElementById("supp").options;
	if(y == null || x == null ){
		  alert("Δεν υπάρχουν άλλοι Προμηθευτές , παρακαλώ συνεχείστε στην ολοκλήρωση του Προϊόντος");
		  document.getElementById("formSupplierCost").value = '';
		  return false;
	}
	var suppName = y[x].innerHTML;
	
	var intCheck1=0;
	
	if (cost==null || cost==""){
		intCheck1=1;
	}
	
	if(isNumber(cost)){
		if (!isFloat(cost)){
			var str2 = ".00";
			cost = cost.concat(str2);
		}
	}
	else{
		 alert("Το πεδίο Τιμή Προμηθευτή πρέπει να είναι είτε ακέραιος είτε δεκαδικός , αλλά αντί για κόμμα πρέπει να βάλετε τελέια.");
		 document.getElementById("formSupplierCost").value = '';
		 return false;
	}
	
	if(intCheck1 == 1){
		  alert("Το πεδίο Τιμή Προμηθευτή είναι κενό , παρακαλώ συμπληρώστε το.");
		  return false;
	}
	
	var stringParameter = suppName + " " + cost;
	request = new XMLHttpRequest();
	request.onreadystatechange = checkAddSupplier;
	request.open("GET", "/HelloWorldJSP/admin/addSupplierProduct?stringParameter="
			+ stringParameter, true);
	request.send(null);

}


function checkAddSupplier(){
	if (request.readyState == 4) {
		var response = request.responseXML;
		var messages = response.getElementsByTagName("Message");
		var message = messages[0];
		var msg = message.getElementsByTagName("Info")[0].textContent;
		if (msg == "no") {
			alert("Κάτι πήγε στραβά , δοκιμάστε ξανά. Προσοχή στο πεδίο Τιμή χρειάζεται να εισάγεται μόνο δεκαδικούς αριθμούς. Δοκιμάστε ξανά");
			document.getElementById("formSupplierCost").value = '';
		}
		else{
			alert("Ο Προμηθευτής που επιλέξατε εισήχθει , τώρα μπορείτε να εισάγεται και άλλον Προμηθευτήςή να εισάγεται όλα τα απαραίτητα στοιχεί του Προϊόντος");
			var x = document.getElementById("supp");
			x.remove(x.selectedIndex);
			document.getElementById("supp").selectedIndex = 0;
			document.getElementById("formSupplierCost").value = '';
		}
	}
}


function addWarehouse(){
	var capacity = document.getElementById("formCount").value;
	var x = document.getElementById("ware").selectedIndex;
	var y = document.getElementById("ware").options;
	if(y == null || x == null ){
		  alert("Δεν υπάρχουν άλλες Αποθήκες , παρακαλώ συνεχείστε στην ολοκλήρωση του Προϊόντος");
		  document.getElementById("formCount").value = '';
		  return false;
	}
	var wareName = y[x].innerHTML;
	
	var intCheck1=0;
	
	if (capacity==null || capacity==""){
		intCheck1=1;
	}
	
	if(!isNumber(capacity)){
		 alert("Το πεδίο Ποσότητα πρέπει να εείναι ακέραιος αριθμός.");
		 document.getElementById("formCount").value = '';
		 return false;
	}
	
	if(intCheck1 == 1){
		  alert("Το πεδίο Ποσότητα είναι κενό , παρακαλώ συμπληρώστε το.");
		  return false;
	}
	
	var stringParameter = wareName + " " + capacity;
	request = new XMLHttpRequest();
	request.onreadystatechange = checkAddWarehouse;
	request.open("GET", "/HelloWorldJSP/admin/addWarehouseProduct?stringParameter="
			+ stringParameter, true);
	request.send(null);

}

function checkAddWarehouse(){
	if (request.readyState == 4) {
		var response = request.responseXML;
		var messages = response.getElementsByTagName("Message");
		var message = messages[0];
		var msg = message.getElementsByTagName("Info")[0].textContent;
		if (msg == "no") {
			alert("Κάτι πήγε στραβά , δοκιμάστε ξανά. Προσοχή στο πεδίο Ποσότητα χρειάζεται να εισάγεται μόνο ακέραιους αριθμούς. Δοκιμάστε ξανά");
			document.getElementById("formCount").value = '';
		}
		else{
			alert("Η Αποθήκη που επιλέξατε εισήχθει , τώρα μπορείτε να εισάγεται και άλλη Αποθήκη ή να εισάγεται όλα τα απαραίτητα στοιχεί του Προϊόντος");
			var x = document.getElementById("ware");
			x.remove(x.selectedIndex);
			document.getElementById("ware").selectedIndex = 0;
			document.getElementById("formCount").value = '';
		}
	}
}



	
function hasWhiteSpace(s, index) {
	var res = s.indexOf(' ') >= 0;
	return res;
}
	var xselect;
	var selectWare;
	var x1;
	var x2;
	var x3;
	var x5;
	var x6;
	var x7;
	var x8;

function validateForm(){
	
	var intCheck1=0;
	var intCheck2=0;
	x1=document.getElementById("formName").value;
	x2=document.getElementById("formDescription").value;
	x3=document.getElementById("formSerial").value;
	xselect = document.getElementById("ware").selectedIndex;
	selectWare = document.getElementById("ware").options;
	x5=document.getElementById("formWeight").value;
	x6=document.getElementById("formMass").value;
	x7=document.getElementById("formType").value;
	x8=document.getElementById("formDimensions").value;
	
	
	if(!isNumber(x3)){
		alert("Το πεδίο Σειριακός Αριθμός πρέπει να είναι αριθμός");
		document.getElementById("formSerial").value = '';
		return false;
	}
	
	
	if(!isNumber(x5)){
		alert("Το πεδίο Βάρος πρέπει να είναι αριθμός");
		document.getElementById("formWeight").value = '';
		return false;
	}

	if(!isNumber(x6)){
		alert("Το πεδίο Όγκος  πρέπει να είναι αριθμός");
		document.getElementById("formMass").value = '';
		return false;
	}
	
	if (hasWhiteSpace(x1 ,"formName" )) {
		alert("Απαγορεύεται η χρήση κενών στο πεδίο Όνομα");
		document.getElementById("formName").value = '';
		intCheck1 = 1;
		intCheck2++;
	}

	
	if (hasWhiteSpace(x7 ,"formType" )) {
		alert("Απαγορεύεται η χρήση κενών στο πεδίο Είδος");
		document.getElementById("formType").value = '';
		intCheck1 = 7;
		intCheck2++;
	}
	
	if (hasWhiteSpace(x8 ,"formDimensions" )) {
		alert("Απαγορεύεται η χρήση κενών στο πεδίο Διαστάσεις . Παράδειγμα 100(μήκος) Χ 70(πλάτος) x 50(ύψος)");	
		document.getElementById("formDimensions").value = '';
		intCheck1 = 8;
		intCheck2++;
	}

	if (x1==null || x1==""){
		intCheck1=1;
		intCheck2++;
	}
	if(x2==null || x2==""){
		intCheck1=2;
		intCheck2++;
	}
	if (x3==null || x3==""){
		intCheck1=3;
		intCheck2++;
	}



  	if(intCheck2 >= 2){
		  alert("Kάποια πεδία είναι κενά , παρακαλώ συμπληρώστε τα.");
		  return false;
	}
	  
	if(intCheck1 == 1){
		alert("Το πεδίο Όνομα είναι κενό , παρακαλώ συμπληρώστε το.");
		return false;
	}
	  
	if(intCheck1 == 2){
		alert("Το πεδίο Περιφραφή είναι κενό , παρακαλώ συμπληρώστε το.");
		return false;
	}
	  
	if(intCheck1 == 3){
		alert("Το πεδίο Σειριακός Αριθμός είναι κενό , παρακαλώ συμπληρώστε το.");
		return false;
	}
	  

	if(intCheck1 == 5){
		alert("Το πεδίο Βάρος χρήστη είναι κενό , παρακαλώ συμπληρώστε το.");
		return false;
	}
	  
	if(intCheck1 == 6){
		alert("Στο πεδίο Όγκος έγινε κάποιο λάθος , παρακαλώ συμπληρώστε το.");
	  	return false;
	}
	  
	if(intCheck1 == 7){
		alert("Στο πεδίο Είδος έγινε κάποιο λάθος , παρακαλώ συμπληρώστε το.");
		return false;
	}
	  
	if(intCheck1 == 8){
		alert("Στο πεδίο Διαστάσεις  έγινε κάποιο λάθος , παρακαλώ συμπληρώστε το.");
		return false;
	}
	
	request = new XMLHttpRequest();
	request.onreadystatechange = everythingIsFine;
	request.open("POST", "/HelloWorldJSP/admin/numberSuppliersList", true);
	request.send(null);
	 
  
}

function everythingIsFine(){
	
	if (request.readyState == 4) {
		var response = request.responseXML;
		var messages = response.getElementsByTagName("Message");
		var message = messages[0];
		var msg = message.getElementsByTagName("Info")[0].textContent;
		if (msg == "yes") {
			request2 = new XMLHttpRequest();
			request2.onreadystatechange = everythingIsFineWarehouses;
			request2.open("POST", "/HelloWorldJSP/admin/numberWarehousesList", true);
			request2.send(null);
		}
		if (msg == "no") {
			alert("Πρέπει να προσθέσετε τουλάχιστον έναν Προμηθευτή");
		}
	}		 
	  return false;
}
	
	function everythingIsFineWarehouses(){
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "yes") {
				nameSerialExists();
			}
			if (msg == "no") {
				alert("Πρέπει να προσθέσετε τουλάχιστον μία Αποθήκη");
			}
		}		 
		  return false;
	}
	
	function nameSerialExists() {
		
	var finalString;
	
	finalString = x1 + '@@@' + x3;
	
	request = new XMLHttpRequest();
	request.onreadystatechange = checkNameSerial;
	request.open("POST", "/HelloWorldJSP/admin/productExist?finalString="
			+ finalString, true);
	request.send(null);
	}
	
	function checkNameSerial(){
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "yes") {
				alert("Το Όνομα και ο κωδικός που επιλέξατε υπάρχει , για να συνεχίσετε την εγγραφή Προϊόντος πρέπει να χρησιμοποιήσετε άλλα στοιχεία.");
				document.getElementById("formName").value = '';
				document.getElementById("formSerial").value = '';
			}
			if (msg == "no") {
				request2 = new XMLHttpRequest();
				if(x5 == null || x5 == "" )
					x5 = " ";
				if(x6 == null || x6 == "" )
					x6 = " ";
				if(x7 == null || x7 == "" )
					x7 = " ";
				if(x8 == null || x8 == "" )
					x8 = " ";
				finalString = x1 + '@@@' + x2 + '@@@' + x3 + '@@@' + 'AAAA'  + '@@@' + 'AAAA' + '@@@' + x5 + '@@@' + x6 + '@@@' + x7  + '@@@' + x8 + '@@@';
				
				request2 = new XMLHttpRequest();
				request2.onreadystatechange = insertProduct;
				request2.open("POST",
						"/HelloWorldJSP/admin/insertProduct?finalString="
								+ finalString, true);
				request2.send(null);
			}
		}
	}
	
	function insertProduct() {
		if (request2.readyState == 4) {
			var response = request2.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "yes") {
				
				alert("Η εγγραφή του Προϊόντος  ολοκληρώθηκε με επιτυχία.");
			} else {
				alert("Κάτι πήγε στραβά , δοκιμάστε ξανά.");
			}
			window.location.href = '/HelloWorldJSP/admin/products.jsp';
		}
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
			window.location.href = '/HelloWorldJSP/admin/admin.jsp';
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


	function showHide(shID) {
		   if (document.getElementById(shID)) {
		      if (document.getElementById(shID+'-show').style.display != 'none') {
		    	  	document.getElementById(shID+'-show').style.display = 'none';
		         	document.getElementById(shID).style.display = 'block';
		         	document.getElementById('h3text').style.display = "none";
		      }
		      else {
		         document.getElementById(shID+'-show').style.display = 'inline';
		         document.getElementById(shID).style.display = 'none';
		         document.getElementById('h3text').style.display = "block";
		         document.getElementById("formName").value = '';
		     	 document.getElementById("formDescription").value = '';
		     	 document.getElementById("formSerial").value = '';
		     	 document.getElementById("formSupplier").value = '';
		     	 document.getElementById("formWeight").value = '';
		     	 document.getElementById("ware").value = '';
		      }
		   }
		}
	
</script>
<body id="products">
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

		<h2 class="pip">Σελίδα Προϊόντων</h2>
		
		
		
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
						<h4 class="tabcss">Σελίδα Διαχειριστή</h4>
					</li>
					<li class="lh" id="t5" onClick="change('tab5')">
						<h4 class="tabcss">Σελίδα Διαχείρισης Προμηθευτών</h4>
					</li>
				</ul>
			</div>
		</div>
		<br><br><br><br>
		</c:if>
 		<h3 id="search"  class="pip1">Αναζήτηση Προϊόντος</h3>
 		<br>
	
	<div class="cube">
	<br>
    <form action="/HelloWorldJSP/admin/SearchProduct" method="POST" method="post" name="frm">
      <table id="tableSearch">
        <tr><td colspan=10 style="font-size:10pt;" align="center">
        <br>
        <h3 class="textSearch" >Συμπληρώστε ένα ή περισσότερα από τα παρακάτω στοιχεία </h3></td></tr>
        <tr><td ><b>Όνομα</b></td>
          <td><input  type="text" name="proname" id="namePro">
        </td>       
         <td ><b>Σειριακός Αριθμός</b></td>
          <td><input  type="text" name="proserial" id="serialPro">
        </td>
        </tr>
        <tr>
        <td><b>Περιγραφή</b></td>
          <td><textarea id="formDescription1" autofocus rows="2" cols="30"
				maxlength="60" name="prodesc"
				placeholder="Συμπλήρωσε την περιγραφή του Προϊόντος ..."></textarea></td>          
          <td><b>Προμηθευτής</b></td>
          <td> 
			    <select  name="prosupp" id="suppSearch">
 				<c:forEach var="supp" items="${arraySupp}">
			    <option value="${supp.getName()}">${supp.getName()}</option>
			    </c:forEach>
			    </select>
        </td>
        </tr>      
        <tr><td colspan=6 align="center" >
        <br>
        <button id="btnProductSearch" onclick="Search(); return false;">Αναζήτηση</button>
        <br><br>		
      </table>
    </form>
 		
 		
 		
 		<script>
 		function fisrtSelected() {
			document.getElementById("suppSearch").selectedIndex = -1;
 		}
 		
		function setContents(element, value2) {
			var el = document.getElementById(element);
			el.value = value2;
		}
			fisrtSelected();
			setContents('namePro', '');
			setContents('serialPro', '');
			setContents('descPro', '');
			setContents('suppPro', '');
		</script>
 
 <c:if test="${re!=1}">
    	<h3 id="h3text" class="pip2">Για να εισάγετε νέο Προϊόν πατήστε <a href="#" id="cubeProduct-show" class="showLink" onclick="showHide('cubeProduct');return false;"> εδώ .</a> </h3>
   </c:if>	  	
   
	
    	<div id="cubeProduct" class="more">
	       
	        <form class="form_center" name="addNewProduct">
	        	<br>
	        	<label class="centerProduct" >Παρακαλώ συμπληρώστε την παρακάτω φόρμα εισαγωγής Προϊόντος. </label>
	        	<br>
	        	<h5 class="centerProduct1">Τα πεδία με αστερίσκο είναι υποχρεωτικά</h5>
	        
				<label class="centerProduct1" >Όνομα*			          :		</label> <input type="text" id="formName"> 
				<br>
				<br> 
 				<label class="centerProduct1">Περιφραφή* 					  :		</label>
 				<textarea id="formDescription" autofocus rows="2" cols="30"
				maxlength="60"
				placeholder="Συμπλήρωσε την περιγραφή του Προϊόντος ..."></textarea>
 				<br>
 				<br>
 				<label id="redtext" class="centerProduct1" >Σειριακός Αριθμός (ακέραιος αριθμός)*				  :		</label> <input type="text" id="formSerial"> 
				<br>
				<br>
				<label class="centerProduct1">Αποθήκη* 					  :		</label> 
				<select  name="warehouse" id="ware">
 				<c:forEach var="ware" items="${wareList}">
			    <option value="${ware.getName()}">${ware.getName()}</option>
			    </c:forEach>
			    </select>
			    <label class="centerProduct2" >Ποσότητα* 					  :		</label> <input type="text" id="formCount">
			    <br>
 				<label class="centerProduct" >*Μπορείτε να προσθέσετε όσες Αποθήκες επιθυμείτε στο συγκεκριμένο Προϊόν.*</label> 
 				<br>
 				<button id="btnProductAddSupplier" onclick="addWarehouse(); return false;">Προσθήκη Αποθήκης και Ποσότητας</button>
 				
 				<br>
 				<br>
 				<label class="centerProduct1" >Βάρος (σε γραμμάρια) :		</label> <input type="text" id="formWeight">
 				<br>
 				<br>
 				<label class="centerProduct4" >Προμηθευτής*			  :		</label>
 				<select  name="supplier" id="supp">
 				<c:forEach var="supp" items="${arraySupp}">
			    <option value="${supp.getName()}">${supp.getName()}</option>
			    </c:forEach>
			    </select>
 				<label class="centerProduct2" >Τιμή* (ευρώ με τελεία τα λεπτά)			  :		</label> <input type="text" id="formSupplierCost">
 				<br>
 				<label class="centerProduct" >*Μπορείτε να προσθέσετε όσους προμθευτές επιθυμείτε στο συγκεκριμένο Προϊόν.*</label> 
 				<br>
 				<button id="btnProductAddSupplier" onclick="addSupplier(); return false;">Προσθήκη Προμηθευτή και Τιμής</button>
 				<br>
 				<br>
 				<label class="centerProduct1" >Όγκος (ακέραιος αριθμός)	  :		</label><input type="text" id="formMass">
 				<br>
 				<br>
 				<label class="centerProduct1" >Είδος			  :		</label><input type="text" id="formType">
 				<br>
 				<br> 
 				<label class="centerProduct1" > Διαστάσεις			  :		</label><input type="text" id="formDimensions">
 				<br>
 				<br> 	 								
 				<button id="btnProductCancel" onclick="validateForm(); return false;">Αποστολή  Στοιχείων</button>
 				
 				<br> <br>
			
	        <p><a href="#" id="cubeProduct-hide" class="centerProduct3" onclick="showHide('cubeProduct');return false;">Ακύρωση.</a></p>
	        <script>
			function fisrtSelected() {
				document.getElementById("ware").selectedIndex = 0;
				document.getElementById("supp").selectedIndex = 0;
			}
			fisrtSelected();
		</script>
	        </form>    
      	</div>


		<script>
		function setContents(element, value2) {
			var el = document.getElementById(element);
			el.value = value2;
		}
			setContents('formName', '');
			setContents('formDescription', '');
			setContents('formSerial', '');
			setContents('formCount', '');
			setContents('formWeight', '');
			setContents('formSupplierCost', '');
			setContents('formMass', '');
			setContents('formType', '');
			setContents('formDimensions', '');
		</script>
		<br>
 		<br>



	<%
		boolean check=false;
		check = Product.getBooleanProducts();
		if(check){
	%>
	<table class="pricingtable" id="pip">
	<tr>
		<th colspan="4" class="prodS">Προϊόν</th>
	</tr>
  		<tbody><tr class="title">
    
            <th>Ονομα Προιόντος</th>
            <th>Περιγραφή</th>
            <th>Σειριακός Αριθμός</th>
            <th>Επιλογή</th>
    	</tr>
  
        <c:forEach var="product" items="${productList}">
	        <tr>
	        	<td>${product.getName()}</td>
	            <td>${product.getDescription()}</td>
	            <td>${product.getSerial()}</td>
				<td><a href="EditProduct?serial=${product.getSerial()}&name=${product.getName()}">Περισσότερα/Επεξεργασία</a></td>
	        </tr>
        </c:forEach>
    	</tbody>
 	</table>
 	
 	<br>

	<c:if test="${currentPage != 1}">
        <div class="links">
        <div style="float: left;margin:0 100px; ">
        	<a href="products.jsp?page=${currentPage - 1}">Προηγούμενη σελίδα</a>
        </div>
        </div>
    </c:if>




 
    <%--For displaying Page numbers.
    The when condition does not display a link for the current page--%>
    
    <div class="links"><div style="float: left;margin:0 200px;">
        <c:forEach begin="1" end="${noOfPages}" var="i">
            <c:choose>
                <c:when test="${currentPage eq i}">
                    <td>${i}</td>
                </c:when>
                <c:otherwise>
                <a href="products.jsp?page=${i}">${i}</a>
                   
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div> </div>
    
        
    <%--For displaying Next link --%>
    <c:if test="${currentPage lt noOfPages}">     
        <div class="links"><div style="float: left;margin:0 0px;"><a href="products.jsp?page=${currentPage + 1}">Επόμενη σελίδα</a></div> </div>

    </c:if>
        <br> <br> <br> 
        
	<%
		}
	%>
	</div>
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