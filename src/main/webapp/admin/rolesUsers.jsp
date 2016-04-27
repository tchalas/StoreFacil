<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.userRole.Users"%>
<%@ page import="servlets.admin.*"%>
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
	function showHide(shID) {

		if (document.getElementById(shID)) {

			if (myBoolean == 0) {
				document.getElementById(shID).style.display = 'block';
				myBoolean = 1;
			} else {
				myBoolean = 0;
				document.getElementById(shID).style.display = 'none';
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
	
	function showUser(user){
		request = new XMLHttpRequest();
		request.onreadystatechange = nothing;
		request.open("POST",
				"/HelloWorldJSP/admin/userPage?user="
						+ user, true);
		request.send(null);
	}
	
	function nothing() {
		if (request.readyState == 4) {
			window.location.href = '/HelloWorldJSP/admin/User.jsp';
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
			window.location.href = '/HelloWorldJSP/admin/admin.jsp';
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

	function roleUser(username, r) {
		var finalString = username + ' ';
		var x = document.getElementById(username + "id1").selectedIndex;
		var y = document.getElementById(username + "id1").options;
		finalString = finalString + y[x].index + ' ';
		x = document.getElementById(username + "id2").selectedIndex;
		y = document.getElementById(username + "id2").options;
		finalString = finalString + y[x].index + ' ';
		x = document.getElementById(username + "id3").selectedIndex;
		y = document.getElementById(username + "id3").options;
		var i = r.parentNode.parentNode.rowIndex;
		finalString = finalString + y[x].index + ' ' + i;
		request = new XMLHttpRequest();
		request.onreadystatechange = showResult;
		request.open("GET",
				"/HelloWorldJSP/admin/insertNoAuthUser?finalString="
						+ finalString, true);
		request.send(null);
	}
	function showResult() {
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Ο χρήστης μόλις ενημερώθηκε για τις ιδιότητες που απέκτησε.");
				document.getElementById('userTable').deleteRow(msg);
			}
		}
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

		<h2>Σελίδα Χρηστών</h2>

		<div id="tabbed_section">
			<div id="menu">
				<ul id="ul_tabs">
					<li class="lh" id="t1" onClick="change('tab1')">
						<h4 class="tabcss">Σελίδα Ρόλων Χρηστών</h4>
					</li>
					<li class="lh" id="t2" onClick="change('tab2')">
						<h4 class="tabcss">Σελίδα Διαχειριστή</h4>
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


		<div>

			<br>
			<%
				List<Users> users = Users.getAllUsers();
					if (users.size() >= 1) {
			%>
			<table id="userTable" class="pricingtable">
				<tr>
					<th colspan="2" class="prodS">Χρήστης</th>
				</tr>


				<%
					for (Users user : users) {
				%>
				<tr >
					<td>
						<h4 class="username">
							<%=user.getUsername()%>
						</h4>
					</td>

					<td>
						<button id="<%=user.getUsername()%>btn" class="showUserBtn" onclick="showUser('<%= user.getUsername() %>'); return false;">Προβολή στοιχείων</button>
					</td>

				</tr>
			
			<%
				}
					}
			%>
			</table>
		</div>

		<%
			if (users.size() == 0) {
		%>
		<h3>Δεν υπάρχει κάποιος χρήστης στην εφαρμογή.</h3>
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