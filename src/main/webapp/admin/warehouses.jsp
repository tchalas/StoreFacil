<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.Users" %>
<%@ page import="servlets.admin.warehouses.Warehouses"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - warehouses page</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<c:set var="em" value="0" />	
<c:set var="rr" value="./../css/admin.css" />	
<c:set var="em" value="0" />	
<c:set var="re" value="0" />
				<c:if test="${sessionScope.usr=='user'}">
				
				<c:set var="rr" value="./../css/user.css" />		
				<c:set var="em" value="1" />	
				 </c:if>
				<c:if test="${sessionScope.warepermissions==0}">	
				<c:set var="re" value="1" />
				<c:set var="read" value="readonly" />	
				 </c:if>
<link rel="stylesheet" type="text/css" href=<c:out value="${rr}"/> />	
</head>

<script type="text/javascript">
	var myBoolean = 0;
	var myBoolean2 = 0;
	var request;
	var request2;

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
			window.location.href = '/HelloWorldJSP/admin/admin.jsp';
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

	function validateForm() {

		var name = document.getElementById("warehouseNameInput").value;
		var desc = document.getElementById("warehouseDescTextArea").value;
		var location = document.getElementById("warehouseLocationInput").value;

		var intCheck1 = 0;
		var intCheck2 = 0;
		if (name == null || name == "") {
			intCheck1 = 1;
			intCheck2++;
		}
		if (desc == null || desc == "") {
			intCheck1 = 2;
			intCheck2++;
		}

		if (location == null || location == "") {
			intCheck1 = 3;
			intCheck2++;
		}

		if (intCheck2 >= 2) {
			alert("Kάποια πεδία είναι κενά , παρακαλώ συμπληρώστε τα.");
			return false;
		}

		if (intCheck1 == 1) {
			alert("Το πεδίο 'Όνομα Αποθήκης' είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 2) {
			alert("Το πεδίο 'Περιγραφή Αποθήκης' είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 3) {
			alert("Το πεδίο 'Τοποθεσία Αποθήκης' είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		request = new XMLHttpRequest();
		request.onreadystatechange = checkWarehouse;
		request.open("GET", "/HelloWorldJSP/admin/checkWarehouse?name="
				+ name, true);
		request.send(null);
	}

	function checkWarehouse() {
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "yes") {
				alert("Το όνομα που επιλέξατε υπάρχει , για να συνεχίσετε την εγγραφή , πρέπει να χρησιμοποιήσετε κάποιο άλλο.");
				document.getElementById("warehouseNameInput").value = '';
			}
			if (msg == "no") {
				request2 = new XMLHttpRequest();
				var name = document.getElementById("warehouseNameInput").value;
				var desc = document.getElementById("warehouseDescTextArea").value;
				var select = document.getElementById("warehouseSelect").selectedIndex;
				var selectOption = document.getElementById("warehouseSelect").options;
				var location = document
						.getElementById("warehouseLocationInput").value;
				var finalString = name + '@@@' + desc + '@@@'
						+ selectOption[select].index + '@@@' + location;
				request2.onreadystatechange = insertWarehouse;
				request2.open("GET",
						"/HelloWorldJSP/admin/insertWarehouse?finalString="
								+ finalString, true);
				request2.send(null);

			}
		}
	}

	function insertWarehouse() {
		var response = request2.responseXML;
		var messages = response.getElementsByTagName("Message");
		var message = messages[0];
		var msg = message.getElementsByTagName("Info")[0].textContent;
		if (msg == "yes") {
			showHide('table','table-show');
			alert("Η εγγραφή της αποθήκης ολοκληρώθηκε με επιτυχία.");
		} else {
			alert("Κάτι πήγε στραβά , δοκιμάστε ξανά.");
		}
		document.getElementById("warehouseNameInput").value = '';
		document.getElementById("warehouseDescTextArea").value = '';
		document.getElementById("warehouseSelectNo").selected = true;
		document.getElementById("warehouseLocationInput").value = '';
		window.location.href = '/HelloWorldJSP/admin/warehouses.jsp';
	}
	
	function showWarehouse(ware){
		request = new XMLHttpRequest();
		request.onreadystatechange = nothing;
		request.open("POST",
				"/HelloWorldJSP/admin/warehousePage?ware="
						+ ware, true);
		request.send(null);
	}
	
	function nothing() {
		if (request.readyState == 4) {
			window.location.href = '/HelloWorldJSP/admin/warehousePage.jsp';
		}
	}
</script>

<body id="warehouses">
	<div id="welcome">

		<%
			if (session.getAttribute("userName") != null && (Integer.parseInt(session.getAttribute("warepermissions").toString())) != 2){//&& Users.checkUserIfAdminByUsername((String)session.getAttribute("userName")).equalsIgnoreCase("admin")) {
		%>

		<img src="./../icons/welcome1.gif" alt="banneraki" class="center">

		<br>
		
		<div style="display: flex;">
							
			<h4 id="logout" class="right_profile">
				<a class="hyperlink" href="/HelloWorldJSP/user/showInfo" > Προφίλ    <%=session.getAttribute("userName")%> </a>
			</h4>

			<h4 id="logout" class="right">
				<a href="/HelloWorldJSP/admin/logOutServlet"> Αποσύνδεση </a>
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
		
		<h2>Σελίδα Διαχείρισης Αποθηκών</h2>



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
						<h4 class="tabcss">Σελίδα Διαχειριστή</h4>
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

		<br> <br> <br> <br> <br> <br>
</c:if>

<c:if test="${re!=1}">
		<button id="table-show"
			onclick="showHide('table','table-show');return false;">
			Δημιουργία νέας αποθήκης</button>
</c:if>

		<div id="table" class="cubeWareHouses">
			<br> <label id="warehouseName" class="centerware">Όνομα
				Αποθήκης</label> <input type="text" id="warehouseNameInput" maxlength="20"> <br>
			<br> <label id="warehouseDesc" class="centerware">Περιγραφή
				Αποθήκης</label>
			<textarea id="warehouseDescTextArea" autofocus rows="2" cols="50"
				maxlength="60"
				placeholder="Συμπλήρωσε την περιγραφή της Αποθήκης ..."></textarea>
			<br> <br> <label id="warehouseOpen" class="centerware">Ανοιχτή:
			</label> <select id="warehouseSelect">
				<option id="warehouseSelectNo" value="Όχι">Όχι</option>
				<option id="warehouseSelectYes" value="Ναι">Ναι</option>
			</select> <br> <br> <label id="warehouseLocation" class="centerware">Τοποθεσία
				Αποθήκης : </label><input type="text" id="warehouseLocationInput" maxlength="20"> <br>
			<br>
			<script>
				function clearContents(element) {
					var el = document.getElementById(element);
					el.value = "";
					el.focus();
				}
				
				function clearSelect(element) {
					document.getElementById(element).selected = true;
				}

				clearContents('warehouseNameInput');
				clearContents('warehouseDescTextArea');
				clearContents('warehouseLocationInput');
				clearSelect('warehouseSelectNo');
			</script>
			<button id="insertWarehouse" onclick="validateForm(); return false;">Αποστολή
				Στοιχείων</button>
			<br> <br>
		</div>
		<br> <br> <br> <br>
		
		
		
		
		<!--  Lista twn warehouses... -->
		<div>
			<%
				List<String> warehouses = Warehouses.getNamesWarehouses();
				if (warehouses.size() >= 1) {
			%>
			<table id="userTable" class="pricingtable">
				<tr>
					<th colspan="2" class="prodS" >Aποθήκη</th>
				</tr>


				<%
				for (int i=0; i < warehouses.size(); i++) {
				%>
				<tr >
					<td>
						<h4 class="username">
							<%=warehouses.get(i)%>
						</h4>
					</td>

					<td>
						<a href="warehouseProducts?warename=<%=warehouses.get(i)%>">
						<input type="submit" value="Προβολή Στοιχείων" id="btnref">
						</a>
					</td>

				</tr>
			
			<%
				}
				}
			%>
			</table>
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