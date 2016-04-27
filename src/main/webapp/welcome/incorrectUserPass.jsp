<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ΤΕΔ - incorrect Username or Password</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<link rel="stylesheet" type="text/css" href="./../css/welcome.css" />

</head>
<body>

    
    <div id="welcome">
    
    	<img src="./../icons/welcome1.gif" alt="banneraki" class="center" >	
    	
    	<h1>Καλωσορίσατε στην ηλεκτονική πλατφόρμα διαχείρισης Αποθηκών</h1>
    	
    	<h2>Τα στοιχεία που δώσατε στο σύστημα είναι λανθασμένα. </h2>
    	<br>
    	<br>
    	<br>
    	<h2>Παρακαλώ προσπαθήστε ξανά</h2>
    	<br>
    	<br>
    	<br>
    	<br>
   		<% response.setHeader("Refresh", "3;url=./welcome.jsp"); %>
	</div>
</body>
</html>