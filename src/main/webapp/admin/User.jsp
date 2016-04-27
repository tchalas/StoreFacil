<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="servlets.admin.*" %>
<%@page import="servlets.admin.userRole.IdRoles"%>
<%@ page import="servlets.admin.userRole.FullUserDB"%>
<%@ page import="servlets.admin.userRole.Users"%>
<%@ page import="servlets.admin.userRole.AuthUser"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - admin User page</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<link rel="stylesheet" type="text/css" href="./../css/admin.css" />

<script type="text/javascript">


	function role(username) {
		var finalString;
		finalString = username + " ";
		var x = document.getElementById("roleId").selectedIndex;
		var y = document.getElementById("roleId").options;
		finalString =finalString + y[x].text;
		request = new XMLHttpRequest();
		request.onreadystatechange = showResultRole;
		request.open("GET", "/HelloWorldJSP/admin/updateUser?finalString="
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
			} else {
				alert("Ο χρήστης ενημερώθηκε.");
			}
			window.location.href = '/HelloWorldJSP/admin/rolesUsers.jsp';
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
</script>
<body>
	<div id="welcome">

		<%
			if (session.getAttribute("userName") != null && servlets.admin.Users.checkUserIfAdminByUsername((String)session.getAttribute("userName")).equalsIgnoreCase("admin")) {
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



		<div id="tabbed_section">
			<div id="menu">
				<ul id="ul_tabs">
					<li class="lh" id="t1" onClick="change('tab1')">
						<h4 class="tabcss">Σελίδα Ρόλων Χρηστών</h4>
					</li>
					<li class="lh" id="t2" onClick="change('tab2')">
						<h4 class="tabcss">Σελίδα  Λίστας Χρηστών</h4>
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

		<h2>
			Χρήστης
			<%=session.getAttribute("userPage")%>
		</h2>

		<%
			FullUserDB fullUser = FullUserDB.getFullUser((String) session
						.getAttribute("userPage"));
				if (fullUser != null) {
		%>
		<div class="cube">
			<h3 class="text">Όνομα</h3>
			<h4 class="text"><%=fullUser.getName()%></h4>
			<h3 class="text">Επώνυμο</h3>
			<h4 class="text"><%=fullUser.getSurname()%></h4>
			<h3 class="text">email</h3>
			<h4 class="text"><%=fullUser.getEmail()%></h4>
			
			
			<%
				List<IdRoles> idRoles = IdRoles.getIdsRoles();
						if (idRoles != null && idRoles.size() >= 1) {
			%>
			<h3 class="text">Επιλογή Ρόλου</h3>
			<select id="roleId" class="styleSelect">
				<%
					for (IdRoles roles : idRoles) {
									String desc = "Ο ρόλος αυτός διαθέτει:";
				%>
				<%
					if (roles.getWarehouses().equalsIgnoreCase("NOPE")) {
										desc += "\nΚανένα Δικαίωμα στις Αποθήκες";
									} else if (roles.getWarehouses().equalsIgnoreCase(
											"READ")) {
										desc += "\nΔικαιώματα ανάγνωσης στις Αποθήκες";
									} else {
										desc += "\nΔικαιώματα διαχείρισης στις Αποθήκες";
									}

					if (roles.getSuppliers().equalsIgnoreCase("NOPE")) {
										desc += "\nΚανένα Δικαίωμα στους Προμηθευτές";
									} else if (roles.getSuppliers().equalsIgnoreCase(
											"READ")) {
										desc += "\nΔικαιώματα ανάγνωσης στους Προμηθευτές";
									} else {
										desc += "\nΔικαιώματα διαχείρισης στους Προμηθευτές";
									}

					if (roles.getProducts().equalsIgnoreCase("NOPE")) {
										desc += "\nΚανένα Δικαίωμα στα Προϊόντα";
									} else if (roles.getProducts().equalsIgnoreCase(
											"READ")) {
										desc += "\nΔικαιώματα ανάγνωσης στα Προϊόντα";
									} else {
										desc += "\nΔικαιώματα διαχείρισης στα Προϊόντα";
									}
				%>

				<option id="<%=roles.getId()%>" class="text" value="" title="<%=desc%>">
					<%=roles.getId()%>
				</option>
				<%
					}
				%>
			</select>
			
			<%
					int perm = AuthUser.getPermiss((String)session.getAttribute("userPage"));
					if(perm!= 0)

				%>
					<script>
					function myFunction(name)
					{
						document.getElementById(name).selected = true;
					}
					
					myFunction(<%= String.valueOf(perm) %>);
					</script>		
			
			<%
				}
			%>
			<br> <br> <br>

			<button id="sendId" class="sendInfo" onclick="role('<%=session.getAttribute("userPage")%>'); return false;">Ενημέρωση</button>
			<br> <br> <br>

		</div>

		<br> <br>
		<%
			}
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