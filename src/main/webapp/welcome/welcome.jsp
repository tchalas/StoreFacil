<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="servlets.admin.Users"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - welcome page</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<link rel="stylesheet" type="text/css" href="./../css/welcome.css" />


<!-- Javascript Code -->

<script type="text/javascript">
	var request;
	var request2;

	function hasWhiteSpace(s, index) {
		var res = s.indexOf(' ') >= 0;
		return res;
	}

	function showHide(shID) {
		if (document.getElementById(shID)) {
			if (document.getElementById(shID + '-show').style.display != 'none') {
				document.getElementById(shID + '-show').style.display = 'none';
				document.getElementById(shID).style.display = 'block';
				document.getElementById('h3text').style.display = "none";
			} else {
				document.getElementById(shID + '-show').style.display = 'inline';
				document.getElementById(shID).style.display = 'none';
				document.getElementById('h3text').style.display = "block";
				document.getElementById("formName").value = '';
				document.getElementById("formSurname").value = '';
				document.getElementById("formUser").value = '';
				document.getElementById("formPwd").value = '';
				document.getElementById("formPwdAgain").value = '';
				document.getElementById("formEmail").value = '';
			}
		}
	}

	function validateForm() {
		var x1 = document.getElementById("formName").value;
		var x2 = document.getElementById("formSurname").value;
		var x3 = document.getElementById("formUser").value;
		var x4 = document.getElementById("formPwd").value;
		var x5 = document.getElementById("formPwdAgain").value;
		var x6 = document.getElementById("formEmail").value;
		var intCheck1 = 0;
		var intCheck2 = 0;

		if (hasWhiteSpace(x1 ,"formName" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Όνομα");
			document.getElementById("formName").value = '';
			intCheck1 = 1;
			intCheck2++;
		}
		if (hasWhiteSpace(x2 ,"formSurname" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Επώνυμο");
			document.getElementById("formSurname").value = '';
			intCheck1 = 2;
			intCheck2++;
		}
		if (hasWhiteSpace(x3 ,"formUser" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Όνομα χρήστη");
			document.getElementById("formUser").value = '';
			intCheck1 = 3;
			intCheck2++;
		}
		if (hasWhiteSpace(x4 ,"formPwd" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Κωδικός χρήστη");
			document.getElementById("formPwd").value = '';
			intCheck1 = 4;
			intCheck2++;
		}
		if (hasWhiteSpace(x5 ,"formPwdAgain" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Επιβεβαίωση κωδικού");
			document.getElementById("formPwdAgain").value = '';
			intCheck1 = 5;
			intCheck2++;
		}
		if (hasWhiteSpace(x6 ,"formEmail" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο email");
			document.getElementById("formEmail").value = '';
			intCheck1 = 6;
			intCheck2++;
		}
		
		if (x1 == null || x1 == "") {
			intCheck1 = 1;
			intCheck2++;
		}
		if (x2 == null || x2 == "") {
			intCheck1 = 2;
			intCheck2++;
		}
		if (x3 == null || x3 == "") {
			intCheck1 = 3;
			intCheck2++;
		}
		if (x4 == null || x4 == "") {
			intCheck1 = 4;
			intCheck2++;
		}
		if (x5 == null || x5 == "") {
			intCheck1 = 5;
			intCheck2++;
		}
		if (x6 == null || x6 == "") {
			intCheck1 = 6;
			intCheck2++;
		}
		if (intCheck2 >= 2) {
			alert("Kάποια πεδία είναι κενά , παρακαλώ συμπληρώστε τα.");
			return false;
		}

		if (intCheck1 == 1) {
			alert("Το πεδίο Όνομα είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 2) {
			alert("Το πεδίο Επώνυμο είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 3) {
			alert("Το πεδίο Όνομα χρήστη είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 4) {
			alert("Το πεδίο Κωδικός χρήστη είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 5) {
			alert("Το πεδίο Επιβεβαίωση κωδικού χρήστη είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 6) {
			alert("Το πεδίο email είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (x4 != x5) {
			alert("Τα πεδία Κωδικός χρήστη και Επιβεβαίωση κωδικού χρήστη είναι διαφορετικά.");
			document.getElementById("formPwd").value = '';
			document.getElementById("formPwdAgain").value = '';
			return false;
		}

		request = new XMLHttpRequest();
		var stringParameter = document.getElementById("formUser").value;
		request.onreadystatechange = showResult;
		request.open("GET",
				"https://localhost:8443/HelloWorldJSP/welcome/CheckUsernameServlet?stringParameter="
				+ stringParameter, true);
		request.send(null);

		return false;

	}

	function showResult() {
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "yes") {
				alert("Το username που επιλέξατε υπάρχει , για να συνεχίσετε την εγγραφή , πρέπει να χρησιμοποιήσετε κάποιο άλλο.");
				document.getElementById("formUser").value = '';
			}
			if (msg == "no") {
				request2 = new XMLHttpRequest();
				var x1 = document.getElementById("formName").value;
				var x2 = document.getElementById("formSurname").value;
				var x3 = document.getElementById("formUser").value;
				var x4 = document.getElementById("formPwd").value;
				var x5 = document.getElementById("formPwdAgain").value;
				var x6 = document.getElementById("formEmail").value;
				var finalString = x1 + ' ' + x2 + ' ' + x3 + ' ' + x4 + ' '
						+ x5 + ' ' + x6;
				request2.onreadystatechange = insertUser;
				request2.open("GET",
						"https://localhost:8443/HelloWorldJSP/welcome/CheckInsertUserServlet?finalString="
								+ finalString, true);
				request2.send(null);

			}
		}
	}

	function insertUser() {
		var response = request2.responseXML;
		var messages = response.getElementsByTagName("Message");
		var message = messages[0];
		var msg = message.getElementsByTagName("Info")[0].textContent;
		if (msg == "yes") {
			showHide('form');
			alert("Η εγγραφή σας ολοκληρώθηκε με επιτυχία.");
		} else {
			alert("Κάτι πήγε στραβά , δοκιμάστε ξανά.");
			document.getElementById("formName").value = '';
			document.getElementById("formSurname").value = '';
			document.getElementById("formUser").value = '';
			document.getElementById("formPwd").value = '';
			document.getElementById("formPwdAgain").value = '';
			document.getElementById("formEmail").value = '';
		}
	}
</script>


</head>
<body>
	<%
		if (session.getAttribute("userName") != null) {
			String check = servlets.admin.Users
					.checkUserIfAdminByUsername((String) session
							.getAttribute("userName"));
			if (check.equalsIgnoreCase("admin")) {
				response.sendRedirect("../admin/admin.jsp");
				System.out.println("I am admin");
			} else if (check.equalsIgnoreCase("user")) {
				System.out.println("I am user");
				response.sendRedirect("../user/user.jsp");
			} else {
				System.out.println("Broken URL!!!");
				%>
				
				<script>
				function logout(){
	    			var xhr = new XMLHttpRequest();
	    			xhr.open("GET",
							"https://localhost:8443/HelloWorldJSP/admin/logOutServlet", true);
	    			xhr.send(null);
				}
				
				logout();
				
				</script>
				
				<%
				
			}

		}
	%>


	<div id="welcome">

		<img src="./../icons/welcome1.gif" alt="banneraki" class="center">

		<h1>Καλωσορίσατε στην ηλεκτονική πλατφόρμα διαχείρισης Αποθηκών</h1>

		<h2>Για να συνεχίσετε στον ιστότοπο θα πρέπει να συνδεθείτε ,</h2>
		<h2>συμπληρώνοντας τα στοιχεία σύνδεσης στην παρακάτω φόρμα.</h2>
		<br> <br> <br>
		<div class="forma_right">
			<form action="https://localhost:8443/HelloWorldJSP/welcome/actionFormServlet" method="POST">
				Όνομα χρήστη : <input type="text" id="user" name="userForm">
				<br> <br> Κωδικός χρήστη : <input type="password" id="pwd"
					name="pwdForm"> <br> <br>

				<button id="btnConnect">Σύνδεση</button>

				<br> <br>

			</form>
		</div>

		<img src="./../icons/login.jpg" alt="LogIn" class="left"> <br>
		<br> <br>

		<h3 id="h3text">
			Αν δεν έχετε αυτά τα στοιχεία , θα πρέπει να συμπληρώσετε την
			παρακάτω <a href="#" id="form-show" class="showLink"
				onclick="showHide('form');return false;"> φόρμα εγραφής.</a>
		</h3>

		<div id="form" class="more">

			<form class="form_center" name="addNewUser" autocomplete="off">


				<h4 id="hidden_form_center">Παρακαλώ συμπληρώστε την παρακάτω φόρμα εγραφής.</h4>

				<label>Όνομα : </label> <input type="text" id="formName"
					maxlength="20"> <br> <br> <label>Επώνυμο
					: </label> <input type="text" id="formSurname" maxlength="20"> <br>
				<br> <label id="redtext">Όνομα χρήστη : </label> <input
					type="text" id="formUser" maxlength="20"> <br> <br>
				<label>Κωδικός χρήστη : </label><input type="password" id="formPwd"
					maxlength="20"> <br> <br> <label>Επιβεβαίωση
					κωδικού χρήστη : </label> <input type="password" id="formPwdAgain"
					maxlength="20"> <br> <br> <label>email :
				</label> <input type="text" id="formEmail" maxlength=""> <br>
				<br>

				<script>
					function setContents(element, value2) {
						var el = document.getElementById(element);
						el.value = value2;
					}

					setContents('formName', '');
					setContents('formSurname', '');
					setContents('formUser', '');
					setContents('formPwd', '');
					setContents('formPwdAgain', '');
					setContents('formEmail', '');
				</script>

				<button id="btnSendData" onclick="validateForm(); return false;">Αποστολή
					Στοιχείων</button>

				<br> <br>

				<p>
					<a href="#" id="form-hide" class="hideLink"
						onclick="showHide('form');return false;">Ακύρωση.</a>
				</p>
			</form>
		</div>
	</div>
</body>
</html>