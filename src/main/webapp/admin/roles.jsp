<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.role.Roles"%>
<%@ page import="servlets.admin.Users" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - roles users</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<link rel="stylesheet" type="text/css" href="./../css/admin.css" />


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

	function showHide2(shID) {

		if (document.getElementById(shID)) {

			if (myBoolean2 == 0) {
				document.getElementById(shID).style.display = 'block';
				myBoolean2 = 1;
			} else {
				myBoolean2 = 0;
				document.getElementById(shID).style.display = 'none';
			}

		}
	}

	function change(namee) {

		var livetab = 't0', i;
		switch (namee) {
		case 'tab1':
			livetab = 't1';
			window.location.href = '/HelloWorldJSP/admin/admin.jsp';
			break;
		case 'tab2':
			livetab = 't2';
			window.location.href = '/HelloWorldJSP/admin/rolesUsers.jsp';
			break;
		case 'tab3':
			window.location.href='/HelloWorldJSP/admin/warehouses.jsp';
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

	function role() {
		var finalString;
		var x = document.getElementById("wareId").selectedIndex;
		var y = document.getElementById("wareId").options;
		finalString = y[x].index + ' ';
		x = document.getElementById("prodId").selectedIndex;
		y = document.getElementById("prodId").options;
		finalString = finalString + y[x].index + ' ';
		x = document.getElementById("suppId").selectedIndex;
		y = document.getElementById("suppId").options;
		finalString = finalString + y[x].index + ' ';
		request = new XMLHttpRequest();
		request.onreadystatechange = showResultRole;
		request.open("GET", "/HelloWorldJSP/admin/insertRole?finalString="
				+ finalString, true);
		request.send(null);
	}

	function showResultRole() {
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else if (msg == "exists") {
				alert("Ο κανόνας αυτός υπάρχει , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Προστέθηκε νέος ρόλος");
			}
			document.getElementById("wareR").selected = true;
			document.getElementById("prodR").selected = true;
			document.getElementById("suppR").selected = true;
			showHide('table', 'table-show');
			window.location.href = '/HelloWorldJSP/admin/roles.jsp';
		}
	}

	function changeRole(id, row) {
		var finalString = id + ' ';
		var x = document.getElementById(id + "select1").selectedIndex;
		var y = document.getElementById(id + "select1").options;

		if (y[x].text.indexOf("Α") >= 0) {
			finalString = finalString + 0 + ' ';
		} else if (y[x].text.indexOf("Δ") >= 0) {
			finalString = finalString + 1 + ' ';
		} else {
			finalString = finalString + 2 + ' ';
		}

		x = document.getElementById(id + "select2").selectedIndex;
		y = document.getElementById(id + "select2").options;

		if (y[x].text.indexOf("Α") >= 0) {
			finalString = finalString + 0 + ' ';
		} else if (y[x].text.indexOf("Δ") >= 0) {
			finalString = finalString + 1 + ' ';
		} else {
			finalString = finalString + 2 + ' ';
		}

		x = document.getElementById(id + "select3").selectedIndex;
		y = document.getElementById(id + "select3").options;

		if (y[x].text.indexOf("Α") >= 0) {
			finalString = finalString + 0 + ' ';
		} else if (y[x].text.indexOf("Δ") >= 0) {
			finalString = finalString + 1 + ' ';
		} else {
			finalString = finalString + 2 + ' ';
		}

		request = new XMLHttpRequest();
		request.onreadystatechange = showResultChangeRole;
		request.open("GET", "/HelloWorldJSP/admin/changeRole?finalString="
				+ finalString, true);
		request.send(null);
	}

	function showResultChangeRole() {
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else if (msg == "exists") {
				alert("Ο κανόνας αυτός υπάρχει , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Ο ρόλος τροποποιήθηκε");
			}
			window.location.href = '/HelloWorldJSP/admin/roles.jsp';
		}
	}
</script>
<body>
	<div id="welcome">

		<%
			if (session.getAttribute("userName") != null && Users.checkUserIfAdminByUsername((String)session.getAttribute("userName")).equalsIgnoreCase("admin")) {
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

		<h2>Σελίδα Ρόλων Χρηστών</h2>

		<div id="tabbed_section">

			<div id="menu">
				<ul id="ul_tabs">
					<li class="lh" id="t1" onClick="change('tab1')">
						<h4 class="tabcss">Σελίδα Διαχειριστή</h4>
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

		<br> <br> <br> <br> <br> <br>



		<button id="table-show"
			onclick="showHide('table','table-show');return false;">
			Δημιουργία νέου ρόλου</button>


		<div id="table" class="more1">

			<br>
			<table id="userTable" class="pricingtable" >
				<tr>
					<th colspan="2" class="prodS">Ρόλος</th>
				</tr>

				<tr>
					<td>
						<h4 class="username">Δικαιώματα Αποθηκών</h4>
					</td>
					<td><select id="wareId" class="styled-select">
							<option id="wareR" class="opt">Ανάγνωσης</option>
							<option id="wareW" class="opt">Διαχείρισης</option>
							<option id="wareN" class="opt">Κανένα</option>
					</select></td>
				</tr>
				<tr>
					<td>
						<h4 class="username">Δικαιώματα Προϊόντων</h4>
					</td>
					<td><select id="prodId" class="styled-select">
							<option id="prodR" class="opt">Ανάγνωσης</option>
							<option id="prodW" class="opt">Διαχείρισης</option>
							<option id="prodN" class="opt">Κανένα</option>
					</select></td>
				</tr>
				<tr>
					<td>
						<h4 class="username">Δικαιώματα Προμηθευτών</h4>
					</td>
					<td><select id="suppId" class="styled-select">
							<option id="suppR" class="opt">Ανάγνωσης</option>
							<option id="suppW" class="opt">Διαχείρισης</option>
							<option id="suppN" class="opt">Κανένα</option>
					</select></td>
				</tr>
				<tr>
					<td colspan="2">
						<button id="sendId" class="sendData"
							onclick="role(); return false;">Ενημέρωση</button>
					</td>
				</tr>
			</table>
		</div>



		<br> <br> <br>

		<div>
			<%
				List<Roles> listRole = Roles.getRoles();
					if (listRole.size() >= 1) {
			%>

			<br>

			<table class="pricingtable">
				<tr>
					<th>Χαρακτηριστικό Ρόλου</th>
					<th>Δικαιώματα Αποθηκών</th>
					<th>Δικαιώματα Προϊόντων</th>
					<th>Δικαιώματα Προμηθευτών</th>
					<th>Δικαιώματα Προμηθευτών</th>
				</tr>


				<%
					for (Roles role : listRole) {
				%>
				<tr>
					<td>
						<h4 class="username">
							<%=role.getId()%>
						</h4>
					</td>
					<td><select id="<%=role.getId()%>select1"
						class="styled-select">
							<%
								if (role.getWarehouses().equalsIgnoreCase("READ")) {
							%>
							<option id="wareW2" class="opt">Ανάγνωσης</option>
							<option id="wareR2" class="opt">Διαχείρησης</option>
							<option id="wareN2" class="opt">Κανένα</option>
							<%
								}
							%>
							<%
								if (role.getWarehouses().equalsIgnoreCase("WRITE")) {
							%>
							<option id="wareR2" class="opt">Διαχείρησης</option>
							<option id="wareW2" class="opt">Ανάγνωσης</option>
							<option id="wareN2" class="opt">Κανένα</option>
							<%
								}
							%>

							<%
								if (role.getWarehouses().equalsIgnoreCase("NOPE")) {
							%>
							<option id="wareN2" class="opt">Κανένα</option>
							<option id="wareR2" class="opt">Ανάγνωσης</option>
							<option id="wareW2" class="opt">Διαχείρησης</option>
							<%
								}
							%>
					</select></td>


					<td><select id="<%=role.getId()%>select2"
						class="styled-select">
							<%
								if (role.getProducts().equalsIgnoreCase("READ")) {
							%>
							<option id="prodW2" class="opt">Ανάγνωσης</option>
							<option id="prodR2" class="opt">Διαχείρησης</option>
							<option id="prodN2" class="opt">Κανένα</option>
							<%
								}
							%>
							<%
								if (role.getProducts().equalsIgnoreCase("WRITE")) {
							%>

							<option id="prodR2" class="opt">Διαχείρησης</option>
							<option id="prodW2" class="opt">Ανάγνωσης</option>
							<option id="prodN2" class="opt">Κανένα</option>
							<%
								}
							%>

							<%
								if (role.getProducts().equalsIgnoreCase("NOPE")) {
							%>
							<option id="prodN2" class="opt">Κανένα</option>
							<option id="prodR2" class="opt">Ανάγνωσης</option>
							<option id="prodW2" class="opt">Διαχείρησης</option>
							<%
								}
							%>

					</select></td>
					<td><select id="<%=role.getId()%>select3"
						class="styled-select">
							<%
								if (role.getSuppliers().equalsIgnoreCase("READ")) {
							%>

							<option id="suppW2" class="opt">Ανάγνωσης</option>
							<option id="suppR2" class="opt">Διαχείρησης</option>
							<option id="suppN2" class="opt">Κανένα</option>
							<%
								}
							%>
							<%
								if (role.getSuppliers().equalsIgnoreCase("WRITE")) {
							%>


							<option id="suppN2" class="opt">Διαχείρησης</option>
							<option id="suppW2" class="opt">Ανάγνωσης</option>
							<option id="suppR2" class="opt">Κανένα</option>
							<%
								}
							%>
							<%
								if (role.getSuppliers().equalsIgnoreCase("NOPE")) {
							%>
							<option id="suppN2" class="opt">Κανένα</option>
							<option id="suppW2" class="opt">Ανάγνωσης</option>
							<option id="suppR2" class="opt">Διαχείρησης</option>
							<%
								}
							%>

					</select></td>
					<td>
						<button id="<%=role.getId()%>btn" class="sendData1"
							onclick="changeRole('<%=role.getId()%>',this); return false;">
							Ενημέρωση</button>
					</td>
				</tr>
				<%
					}
						}
				%>

			</table>

			<br> <br> <br>

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