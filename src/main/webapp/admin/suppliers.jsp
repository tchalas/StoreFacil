<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.supplier.Suppliers"%>
<%@ page import="servlets.admin.Users" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - suppliers page</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<c:set var="em" value="0" />	
<c:set var="rr" value="./../css/admin.css" />	
<c:set var="em" value="0" />	
<c:set var="re" value="0" />
				<c:if test="${sessionScope.usr=='user'}">
				
				<c:set var="rr" value="./../css/user.css" />		
				<c:set var="em" value="1" />	
				 </c:if>
				<c:if test="${sessionScope.suppermissions==0}">	
				<c:set var="re" value="1" />	
				 </c:if>				 
<link rel="stylesheet" type="text/css" href=<c:out value="${rr}"/> />	
</head>

<script type="text/javascript">

	var myBoolean = 0;
	var myBoolean2 = 0;
	var request;
	var request2;

	function isNumber(str){
		
		if(isNaN(str))
		return false;
		else 
		return true;
	}
	
	function showHide(shID, shID2) {

		if (document.getElementById(shID)) {

			if (myBoolean == 0) {
				document.getElementById(shID).style.display = 'block';
				document.getElementById(shID2).style.display = 'none';
				myBoolean = 1;
			} else {
				myBoolean = 0;
				document.getElementById(shID).style.display = 'none';
				document.getElementById(shID2).style.display = 'block';
			}

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
			livetab = 't3';
			window.location.href = '/HelloWorldJSP/admin/warehouses.jsp';
			break;
		case 'tab4':
			livetab = 't4';
			window.location.href = '/HelloWorldJSP/admin/products.jsp';
			break;
		case 'tab5':
			livetab = 't5';
			window.location.href = '/HelloWorldJSP/admin/admin.jsp';
			break;
		}
		for (i = 1; i <= 5; i++) {
			document.getElementById("t" + i).style.backgroundColor = "#1C7AED";
		}
		document.getElementById(livetab).style.backgroundColor = "#70B8B8";
	}

	function hasWhiteSpace(s, index) {
		var res = s.indexOf(' ') >= 0;
		return res;
	}
	
	function validateSupplierForm() {

		var intCheck1 = 0;
		var intCheck2 = 0;
		
		var name = document.getElementById("supplierNameInput").value;
		var address = document.getElementById("supplierAddressInput").value;
		var afm = document.getElementById("supplierAFMInput").value;
		var phone = document.getElementById("supplierPhoneInput").value;

		if (hasWhiteSpace(name ,"supplierNameInput" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Όνομα Προμηθευτή");
			document.getElementById("supplierNameInput").value = '';
			intCheck1 = 1;
			intCheck2++;
		}
		
		if (hasWhiteSpace(afm ,"supplierAFMInput" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Α.Φ.Μ. Προμηθευτή");
			document.getElementById("supplierAFMInput").value = '';
			intCheck1 = 3;
			intCheck2++;
		}
		if (hasWhiteSpace(phone ,"supplierPhoneInput" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Τηλέφωνο Προμηθευτή");
			document.getElementById("supplierPhoneInput").value = '';
			intCheck1 = 4;
			intCheck2++;
		}
		
		
		if(!isNumber(afm)){
			alert("Το πεδίο Α.Φ.Μ. πρέπει να είναι αριθμός");
			document.getElementById("supplierAFMInput").value = '';
			return false;
		}
		
		if(!isNumber(phone)){
			alert("Το πεδίο Τηλέφωνο πρέπει να είναι αριθμός");
			document.getElementById("supplierPhoneInput").value = '';
			return false;
		}
		
		if (name == null || name == "") {
			intCheck1 = 1;
			intCheck2++;
		}
		if (address == null || address == "") {
			intCheck1 = 2;
			intCheck2++;
		}

		if (afm == null || afm == "") {
			intCheck1 = 3;
			intCheck2++;
		}
		
		if (phone == null || phone == "") {
			intCheck1 = 4;
			intCheck2++;
		}

		if (intCheck2 >= 2) {
			alert("Kάποια πεδία είναι κενά , παρακαλώ συμπληρώστε τα.");
			return false;
		}

		if (intCheck1 == 1) {
			alert("Το πεδίο Όνομα Προμηθευτή είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 2) {
			alert("Το πεδίο Διεύθυνση Προμηθευτή είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 3) {
			alert("Το πεδίο Α.Φ.Μ. Προμηθευτή είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 4) {
			alert("Το πεδίο Τηλέφωνο Προμηθευτή είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}
		
		request = new XMLHttpRequest();
		request.onreadystatechange = checkSupplier;
		request.open("GET", "/HelloWorldJSP/admin/checkSupplier?name="
				+ name, true);
		request.send(null);
	}

	function checkSupplier() {
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "yes") {
				alert("Το όνομα που επιλέξατε υπάρχει , για να συνεχίσετε την εγγραφή , πρέπει να χρησιμοποιήσετε κάποιο άλλο.");
				document.getElementById("supplierNameInput").value = '';
			}
			if (msg == "no") {
				request2 = new XMLHttpRequest();
				var name = document.getElementById("supplierNameInput").value;
				var address = document.getElementById("supplierAddressInput").value;
				var afm = document.getElementById("supplierAFMInput").value;
				var phone = document.getElementById("supplierPhoneInput").value;
				var finalString = name + '@@@' + address + '@@@'
						+ afm + '@@@' + phone;
				request2.onreadystatechange = insertSupplier;
				request2.open("POST",
						"/HelloWorldJSP/admin/insertSupplier?finalString="
								+ finalString, true);
				request2.send(null);

			}
		}
	}

	function insertSupplier() {
		var response = request2.responseXML;
		var messages = response.getElementsByTagName("Message");
		var message = messages[0];
		var msg = message.getElementsByTagName("Info")[0].textContent;
		if (msg == "yes") {
			showHide('table3','table-show3');
			alert("Η εγγραφή του Προμηθευτή  ολοκληρώθηκε με επιτυχία.");
		} else {
			alert("Κάτι πήγε στραβά , δοκιμάστε ξανά. Προσοχή σε κάποια πεδία ίσως να χρειάζεται να εισάγεται μόνο αριθμούς, όπως στα πεδία Α.Φ.Μ. και Τηλέφωνο Προμηθευτή");
			
		}
		document.getElementById("supplierNameInput").value = '';
		document.getElementById("supplierAddressInput").value = '';
		document.getElementById("supplierAFMInput").value = '';
		document.getElementById("supplierPhoneInput").value = '';
		window.location.href = '/HelloWorldJSP/admin/suppliers.jsp';
	}
	
	function showSupplier(supp){
		request = new XMLHttpRequest();
		request.onreadystatechange = nothing;
		request.open("POST",
				"/HelloWorldJSP/admin/supplierPage?supp="
						+ supp, true);
		request.send(null);
	}
	
	function nothing() {
		if (request.readyState == 4) {
			window.location.href = '/HelloWorldJSP/admin/supplierPage.jsp';
		}
	}
</script>

<body id="suppliers">
	<div id="welcome">

		<%
		if (session.getAttribute("userName") != null
				 && (Integer.parseInt(session.getAttribute("suppermissions").toString())) != 2) {
		%>

		<img src="./../icons/welcome1.gif" alt="banneraki" class="center">

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
		
		<c:if test="${em==1}">
				 <ul id="navigation">
		
		    <li><a href="../user/user.jsp" id = "home" class="link1">Αρχική Σελίδα</a></li>
		    <c:if test="${sessionScope.warepermissions!=2}">
		    <li><a href="./warehouses.jsp" id="apoth" class="link3">Αποθήκες</a></li>
		    </c:if>
		    <c:if test="${sessionScope.propermissions!=2}">
		    <li><a href="./products.jsp"  id = "products" class="link4">Προιόντα</a></li>
		    </c:if>
		    <c:if test="${sessionScope.suppermissions!=2}">
		    <li><a href="./suppliers.jsp" id="prom" class="link5">Προμηθευτές</a></li>
		    </c:if>
		   
				</ul>
			</c:if>
		<h2>Σελίδα Διαχείρισης Προμηθευτών</h2>
		
				
			
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
						<h4 class="tabcss">Σελίδα Διαχειριστή</h4>
					</li>
				</ul>
			</div>
		</div>

		<br> <br> <br> <br> <br> <br>
 </c:if>

<c:if test="${re!=1}">
		<button id="table-show3"
			onclick="showHide('table3','table-show3');return false;">
			Δημιουργία νέου προμηθευτή</button>


		<div id="table3" class="cubeSuppliers">
			<br> <label id="supplierName" class="centerware">Όνομα
				Προμηθευτή</label> <input type="text" id="supplierNameInput" maxlength="20"> <br>
			<br> <label id="supplierAdd" class="centerware">Διεύθυνση Προμηθευτή</label>
			 <input type="text" id="supplierAddressInput" maxlength="40"> <br>
			 <br> <label id="supplierAFM" class="centerware">Α.Φ.Μ. Προμηθευτή
			</label> <input type="text" id="supplierAFMInput" maxlength="10"> <br>
			<br> <label id="supplierPhone" class="centerware">Τηλέφωνο Προμηθευτή:
			</label> <input type="text" id="supplierPhoneInput" maxlength="10"> <br><br>
			
			<script>
				function clearContents(element) {
					var el = document.getElementById(element);
					el.value = "";
					el.focus();
				}

				clearContents('supplierNameInput');
				clearContents('supplierAddressInput');
				clearContents('supplierAFMInput');
				clearContents('supplierPhoneInput');
				
			</script>
			
			<button id="insertSupplier" onclick="validateSupplierForm(); return false;">Αποστολή
				Στοιχείων</button>
			<br> <br>
		</div>
		<br> <br> <br> <br>
	 </c:if>		
		
		
		
		<!--  List of suppliers... -->
		<div>
			<%
				List<String> suppliers = Suppliers.getNamesSuppliers();
				if (suppliers.size() >= 1) {
			%>
			<table id="userTable" class="pricingtable" > 
				<tr>
					<th colspan="2" class="prodS">Προμηθευτής</th>
				</tr>


        <c:forEach var="supplier" items="${supList}">
	        <tr>
	        <td>
	        <h4 class="username">
	        	${supplier.getName()}
	        	</h4>
	        	</td>
				<td>
					<a href="supplierProducts?suppname=${supplier.getName()}">
						<input type="submit" value="Προβολή Στοιχείων" id="btnref">
					</a>
					</td>

	        </tr>
        </c:forEach>



			
			<%
				
				}
			%>
			</table>
		 	<br>

	<c:if test="${currentPage != 1}">
        <div class="links">
        <div style="float: left;margin:0 100px; ">
        	<a href="suppliers.jsp?page=${currentPage - 1}">Προηγούμενη σελίδα</a>
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
                <a href="suppliers.jsp?page=${i}">${i}</a>
                   
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div> </div>
    
        
    <%--For displaying Next link --%>
    <c:if test="${currentPage lt noOfPages}">     
        <div class="links"><div style="float: left;margin:0 0px;"><a href="suppliers.jsp?page=${currentPage + 1}">Επόμενη σελίδα</a></div> </div>

    </c:if>	
			
			
			<br> <br> <br> <br>
			<br> <br>
		</div>
		
		
		
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