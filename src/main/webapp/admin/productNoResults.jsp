<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="servlets.admin.Users"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - product error page</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<link rel="stylesheet" type="text/css" href="./../css/admin.css" />

<body>
	<div id="welcome">

		<%
			if (session.getAttribute("userName") != null
					&& Users.checkUserIfAdminByUsername(
							(String) session.getAttribute("userName"))
							.equalsIgnoreCase("admin")) {
		%>

		<img src="./../icons/welcome1.gif" alt="banneraki" class="center">

		<br>
		<br>
		
		<h1>Ηλεκτονική πλατφόρμα διαχείρισης Αποθηκών</h1>

		<h2>Αναζήτηση Προϊόντος</h2>

		<h3>Δεν υπήρξε κάποιο αποτέλεσμα στην Αναζήτηση</h3>
    	<br>
    	<br>
    	<h3>Παρακαλώ προσπαθήστε ξανά.</h3>
		<br> <br>
		<%
			response.setHeader("Refresh", "3;url=../admin/products.jsp");
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