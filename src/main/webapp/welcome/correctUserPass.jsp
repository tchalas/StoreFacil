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
    	
    	<h2>Αγαπητέ <%= session.getAttribute( "userName" ) %> , εκκρεμεί η αίτηση εγγραφής σας από το διαχειριστή.</h2>
    	<br>
    	<br>
    	<h3>Παρακαλώ προσπαθήστε αργότερα.</h3>
    	<br>
    	<br>
   		<% 
   		session.setAttribute("userName", null);
   		response.setHeader("Refresh", "3;url=./welcome.jsp"); %>
	</div>
</body>
</html>