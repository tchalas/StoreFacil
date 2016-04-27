<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.Users" %>
<%@ page import="servlets.admin.supplier.Suppliers"%>
<%@ page import="servlets.admin.warehouses.WarehouseProductSupplier"%>
<%@ page import="servlets.admin.warehouses.WarehouseLastMovementProduct"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ΤΕΔ - supplier page</title>
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
				<c:set var="read" value="readonly" />		
				 </c:if>				 
<link rel="stylesheet" type="text/css" href=<c:out value="${rr}"/> />
</head>



<script>
	var request;
	var request2;
	
	function hasWhiteSpace(s, index) {
		var res = s.indexOf(' ') >= 0;
		return res;
	}
	
	function updateSupplier(name) {
		
		var finalString;
		var address = document.getElementById("supplierAddressInput").value;
		var afm = document.getElementById("supplierAFMInput").value;
		var phone = document.getElementById("supplierPhoneInput").value;

		var intCheck1 = 0;
		var intCheck2 = 0;
		
		var dele = document.getElementById("suppDelete").checked;
			
			if(dele == false){
				
				if (hasWhiteSpace(afm ,"supplierAFMInput" )) {
					alert("Απαγορεύεται η χρήση κενών στο πεδίο Α.Φ.Μ. Προμηθευτή");
					document.getElementById("supplierAFMInput").value = '';
					intCheck1 = 2;
					intCheck2++;
				}
				if (hasWhiteSpace(phone ,"supplierPhoneInput" )) {
					alert("Απαγορεύεται η χρήση κενών στο πεδίο Τηλέφωνο Προμηθευτή");
					document.getElementById("supplierPhoneInput").value = '';
					intCheck1 = 3;
					intCheck2++;
				}
				
				if (address == null || address == "") {
					intCheck1 = 1;
					intCheck2++;
				}
				if (afm == null || afm == "") {
					intCheck1 = 2;
					intCheck2++;
				}
		
				if (phone == null || phone == "") {
					intCheck1 = 3;
					intCheck2++;
				}
		
				if (intCheck2 >= 2) {
					alert("Kάποια πεδία είναι κενά , παρακαλώ συμπληρώστε τα.");
					return false;
				}
		
				else if (intCheck1 == 1) {
					alert("Το πεδίο Διεύθυνση Προμηθευτή είναι κενό , παρακαλώ συμπληρώστε το.");
					return false;
				}
		
				else if (intCheck1 == 2) {
					alert("Το πεδίο Α.Φ.Μ. Προμηθευτή είναι κενό , παρακαλώ συμπληρώστε το.");
					return false;
				}
				
				else if (intCheck1 == 2) {
					alert("Το πεδίο Τηλέφωνο Προμηθευτή είναι κενό , παρακαλώ συμπληρώστε το.");
					return false;
				}
				
				finalString  =  name + '@@@' + address + '@@@'
				+ afm + '@@@' + phone ;
				request = new XMLHttpRequest();
				request.onreadystatechange = resultUpdateSupplier;
				request.open("GET", "/HelloWorldJSP/admin/updateSupplier?finalString="
						+ finalString, true);
				request.send(null);
			}
			else{
				var answer = confirm("Είστε σίγουρος ότι θέλετε να διαγράψετε τον Προμηθευτή " + name + " ;");
				if (answer){
					finalString  = name;
					request = new XMLHttpRequest();
					request.onreadystatechange = resultDeleteWarehouse;
					request.open("GET", "/HelloWorldJSP/admin/deleteSupplier?finalString="
							+ finalString, true);
					request.send(null);
				}
				else{
					document.getElementById("suppDelete").checked = false;
				}
			}
	}

	function resultUpdateSupplier() {
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Ο προμηθευτής ενημερώθηκε.");
			}
			window.location.href = '/HelloWorldJSP/admin/supplierPage.jsp';
		}
	}
	
	function resultDeleteWarehouse(){
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Ο προμηθευτής διαγράφθηκε.");
			}
			window.location.href = '/HelloWorldJSP/admin/suppliers.jsp';
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

		<br> <br> <br> <br> <br> <br>
	 </c:if>
		<h2>
			Προμηθευτής
			<%=session.getAttribute("supplierPage")%>
		</h2>

		<%
			Suppliers supplier = Suppliers.getWarehouseByName((String) session
								.getAttribute("supplierPage"));
				if (supplier != null) {
		%>

		<div class="cubeSuppliersP">
			<br> <label id="supplierAddress" class="centerSupp">Διεύθυνση Προμηθευτή</label>
			<input type="text" id="supplierAddressInput"  <c:out value="${read}"/>	maxlength="40">
			<br> <br> <label id="supplierAFM" class="centerSupp">Α.Φ.Μ. Προμηθευτή
			</label> <input type="text" <c:out value="${read}" /> id="supplierAFMInput" 	maxlength="10">
			<br> <br> <label id="supplierPhone" class="centerSupp">Τηλέφωνο Προμηθευτή</label>
			<input type="text" id="supplierPhoneInput" <c:out value="${read}"/> maxlength="10"> <br>
			<br>

			<script>
				function setContents(element,value2) {
					var el = document.getElementById(element);
					el.value = value2;
				}
				setContents('supplierAddressInput',"<%=supplier.getAddress()%>" );
				setContents('supplierAFMInput',"<%=supplier.getAfm()%>" );
				setContents('supplierPhoneInput',"<%=supplier.getPhone()%>");
			</script>
			
			
			<%
			
			List<WarehouseProductSupplier> suppProd = new ArrayList<WarehouseProductSupplier>();
			suppProd = WarehouseProductSupplier.getListSupplierProductBySupplier((String) session
										.getAttribute("supplierPage"));
			if (suppProd != null && suppProd.size() != 0 ) {
				if( suppProd.size() == 1){
			%>
			
			<label id="supplierProductNumber" class="centerSupp">Ο προμηθευτής παρέχει σε αποθήκες 1 Προϊόν</label>
			<%
				}
				 else{
			%>
			<label id="supplierProductNumber" class="centerSupp">Ο προμηθευτής παρέχει σε αποθήκες <%=suppProd.size()%> Προϊόντα</label>
			<%
								 
				 }
 			%>
			

				<br><br>
				<table id="suppProductTable" class="pricingtable">
					<tr>
						<th colspan="5" class="prodS">Προϊόντα Προμηθευτή</th>
					</tr>

					<tr>
						<td>
							<h4 class="username">Όνομα</h4>
						</td>
						<td>
							<h4 class="username">Άριθμός</h4>
						</td>
						<td>
							<h4 class="username">Αποθήκη</h4>
						</td>
						<td>
							<h4 class="username">Απόθεμα</h4>
						</td>
						<td>
							<h4 class="username">Κόστος</h4>
						</td>
					</tr>

					
				<c:forEach var="supplier" items="${prosupList}">
			        <tr>
			        <td>
			        <h4 class="username">
			        	${supplier.getNameP()}
			        	</h4>
			        	</td>
			          <td>
			        <h4 class="username">
			        	${supplier.getSerialP()}
			        	</h4>
			        	</td>
			          <td>
			        <h4 class="username">
			        	${supplier.getNameW()}
			        	</h4>
			        	</td>
			          <td>
			        <h4 class="username">
			        	${supplier.getCapacity()}
			        	</h4>
			        	</td>			
					    <td>
			        <h4 class="username">
			        	${supplier.getCost()}
			        	</h4>
			        	</td>		
			   
			        </tr>
        		</c:forEach>
					

				</table>

			<br> <br>
			<%
				}
			%>
		
		<c:if test="${re!=1}">		
			<label id="supplierDeleteCheck" class="centerSupp">Μπορείτε
				να διαγράψετε τον Προμηθευτή</label> <br> <label id="supplierCheckDel"
				class="centerSupp"> κάνοντας κλικ εδώ : </label><input
				type="checkbox" id="suppDelete"> <br> <br>
	
			
			<button id="updateSupp"
				onclick="updateSupplier('<%=supplier.getName()%>','no'); return false;">Ενημέρωση
				Στοιχείων</button>
			<br> <br>
				</c:if>	
			<%
						
				}
			%>
			
			
		<c:if test="${currentPage != 1}">
	        <div class="links">
		        <div style="float: left;margin:0 100px; ">
		        	<a href="supplierProducts?suppname=<%=(String) session
							.getAttribute("supplierPage") %>&page=${currentPage - 1}">Προηγούμενη σελίδα</a>
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
                <a href="supplierProducts?suppname=<%=(String) session
					.getAttribute("supplierPage") %>&page=${i}">${i}</a>
                   
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div> </div>
    
        
    <%--For displaying Next link --%>
    <c:if test="${currentPage lt noOfPages}">     
        <div class="links"><div style="float: left;margin:0 0px;"><a href="supplierProducts?suppname=<%=(String) session
					.getAttribute("supplierPage") %>&page=${currentPage + 1}">Επόμενη σελίδα</a></div> </div>

    </c:if>	
	
	<br> <br> <br>
			
	</div>
		<br> <br> <br> <br>

		<%
			} else {
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