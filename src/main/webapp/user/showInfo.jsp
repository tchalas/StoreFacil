<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="servlets.user.UserInfo"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - admin User page</title>
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

<script type="text/javascript">

	var request;
	var request2;
	
	function hasWhiteSpace(s, index) {
		var res = s.indexOf(' ') >= 0;
	return res;	
	}
	
	

	function updateInfo(username) {
		var x1 = document.getElementById("formName").value;
		var x2 = document.getElementById("formSurname").value;
		var x3 = document.getElementById("formPwd").value;
		var x4 = document.getElementById("formPwdAgain").value;
		var x5 = document.getElementById("formEmail").value;
		var stringParameter;
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
		
		if (hasWhiteSpace(x3 ,"formPwd" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Κωδικός χρήστη");
			document.getElementById("formPwd").value = '';
			intCheck1 = 3;
			intCheck2++;
		}
		if (hasWhiteSpace(x4 ,"formPwdAgain" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο Επιβεβαίωση κωδικού");
			document.getElementById("formPwdAgain").value = '';
			intCheck1 = 4;
			intCheck2++;
		}
		if (hasWhiteSpace(x5 ,"formEmail" )) {
			alert("Απαγορεύεται η χρήση κενών στο πεδίο email");
			document.getElementById("formEmail").value = '';
			intCheck1 = 5;
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
			alert("Το πεδίο Κωδικός χρήστη είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 4) {
			alert("Το πεδίο Επιβεβαίωση κωδικού χρήστη είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (intCheck1 == 5) {
			alert("Το πεδίο email είναι κενό , παρακαλώ συμπληρώστε το.");
			return false;
		}

		if (x3 != x4) {
			alert("Τα πεδία Κωδικός χρήστη και Επιβεβαίωση κωδικού χρήστη είναι διαφορετικά.");
			document.getElementById("formPwd").value = '';
			document.getElementById("formPwdAgain").value = '';
			return false;
		}

		
		request = new XMLHttpRequest();
		stringParameter = username + ' ' + x1 + ' ' + x2 + ' ' + x3 +  ' ' + x5;
		request.onreadystatechange = showResult;
		request.open("POST",
				"/HelloWorldJSP//user/updateInfo?stringParameter="
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
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Ο χρήστης ενημερώθηκε.");
			}
			window.location.href = '/HelloWorldJSP/welcome/welcome.jsp';
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
			if (session.getAttribute("userName") != null){
					//&& servlets.admin.Users.checkUserIfAdminByUsername(
						//	(String) session.getAttribute("userName"))
						//	.equalsIgnoreCase("admin")) {
		%>

		<img src="./../icons/welcome1.gif" alt="banneraki" class="center">

		<br>

		<div style="display: flex;">

			<h4 id="logout" class="rightInfo">
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
		    <li><a href="./products.jsp"  id = "products" class="link4">Προιόντα</a></li>
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
 </c:if>	
		<br> <br> <br> <br> <br> <br>

		<h2 class="h2profile">
			Προφίλ
			<%=session.getAttribute("userName")%>
		</h2>

		<%
			UserInfo user = UserInfo.getUserByUsername((String) session
						.getAttribute("userName"));
				if (user != null) {
		%>
		
		
		<div class="cube">
		<br><br>
			<label class="centerInfo" >Όνομα : </label> <input type="text" id="formName"
				maxlength="20"> <br> <br> <label class="centerInfo">Επώνυμο :
			</label> <input  type="text" id="formSurname" maxlength="20"> 
			<br><br>
			<label class="centerInfo">Κωδικός χρήστη : </label><input  type="password" id="formPwd"
				maxlength="20"> <br> <br> <label class="centerInfo" >Επιβεβαίωση
				κωδικού χρήστη : </label> <input  type="password" id="formPwdAgain"
				maxlength="20"> <br> <br> <label class="centerInfo">email : </label>
			<input class="text" type="text" id="formEmail" maxlength=""> <br> <br>

			<script>
				function setContents(element,value2) {
					var el = document.getElementById(element);
					el.value = value2;
				}

			
				setContents('formName',"<%=user.getName()%>" );
				setContents('formSurname',"<%=user.getSurname()%>" );
				setContents('formEmail',"<%=user.getEmail()%>" )
			</script>


			<button id="sendId" class="sendInfo"
				onclick="updateInfo('<%=session.getAttribute("userName")%>'); return false;">Ενημέρωση στοιχείων</button>
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