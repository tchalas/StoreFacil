<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.admin.Users" %>
<%@ page import="servlets.admin.warehouses.Warehouses"%>
<%@ page import="servlets.admin.warehouses.WarehouseProductSupplier"%>
<%@ page import="servlets.admin.warehouses.WarehouseLastMovementProduct"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ΤΕΔ - warehouse page</title>
<link rel="icon" type="image/png" href="./../icons/home.png">
<c:set var="em" value="0" />	
<c:set var="rr" value="./../css/admin.css" />	
<c:set var="em" value="0" />	
<c:set var="re" value="0" />
<c:set var="read" value="" />	
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
<%
String deleteWareh = "yes";
%>
<script>
	var request;
	var request2;
	
	function updateWarehouse(name,boolDelete) {
		var finalString;
		var select = document.getElementById("warehouseSelect").selectedIndex;
		var selectOption = document.getElementById("warehouseSelect").options;
		var desc = document.getElementById("warehousePDescTextArea").value;
		var location = document.getElementById("warehouseLocationInput").value;

		var intCheck1 = 0;
		var intCheck2 = 0;
		
		if(boolDelete == "yes") {
			var dele = document.getElementById("wareDelete").checked;
			
			if(dele == false){
				
				
				if (desc == null || desc == "") {
					intCheck1 = 1;
					intCheck2++;
				}
		
				if (location == null || location == "") {
					intCheck1 = 2;
					intCheck2++;
				}
		
				if (intCheck2 == 2) {
					alert("Kάποια πεδία είναι κενά , παρακαλώ συμπληρώστε τα.");
					return false;
				}
		
				else if (intCheck1 == 1) {
					alert("Το πεδίο 'Περιγραφή Αποθήκης' είναι κενό , παρακαλώ συμπληρώστε το.");
					return false;
				}
		
				else if (intCheck1 == 2) {
					alert("Το πεδίο 'Τοποθεσία Αποθήκης' είναι κενό , παρακαλώ συμπληρώστε το.");
					return false;
				}
				
				finalString  = name + '@@@' + desc + '@@@'
				+ selectOption[select].index + '@@@' + location;
				request = new XMLHttpRequest();
				request.onreadystatechange = resultUpdateWarehouse;
				request.open("GET", "/HelloWorldJSP/admin/updateWarehouse?finalString="
						+ finalString, true);
				request.send(null);
			}
			else{
				var answer = confirm("Είστε σίγουρος ότι θέλετε να διαγράψετε την αποθήκη " + name + " ;");
				if (answer){
					finalString  = name;
					request = new XMLHttpRequest();
					request.onreadystatechange = resultDeleteWarehouse;
					request.open("GET", "/HelloWorldJSP/admin/deleteWarehouse?finalString="
							+ finalString, true);
					request.send(null);
				}
				else{
					document.getElementById("wareDelete").checked = false;
				}
			}
		}
		else{

			
			if (desc == null || desc == "") {
				intCheck1 = 1;
				intCheck2++;
			}
	
			if (location == null || location == "") {
				intCheck1 = 2;
				intCheck2++;
			}
			
			if (intCheck2 == 2) {
				alert("Kάποια πεδία είναι κενά , παρακαλώ συμπληρώστε τα.");
				return false;
			}
	
			else if (intCheck1 == 1) {
				alert("Το πεδίο 'Περιγραφή Αποθήκης' είναι κενό , παρακαλώ συμπληρώστε το.");
				return false;
			}
	
			else if (intCheck1 == 2) {
				alert("Το πεδίο 'Τοποθεσία Αποθήκης' είναι κενό , παρακαλώ συμπληρώστε το.");
				return false;
			}
			
			finalString  = name + '@@@' + desc + '@@@'
			+ selectOption[select].index + '@@@' + location;
			request = new XMLHttpRequest();
			request.onreadystatechange = resultUpdateWarehouse;
			request.open("GET", "/HelloWorldJSP/admin/updateWarehouse?finalString="
					+ finalString, true);
			request.send(null);
		}
	}

	function resultUpdateWarehouse() {
		if (request.readyState == 4) {
			var response = request.responseXML;
			var messages = response.getElementsByTagName("Message");
			var message = messages[0];
			var msg = message.getElementsByTagName("Info")[0].textContent;
			if (msg == "no") {
				alert("Υπήρξε κάποιο πρόβλημα , παρακαλώ προσπαθείστε ξανά.");
			} else {
				alert("Η Αποθήκη ενημερώθηκε.");
			}
			window.location.href = '/HelloWorldJSP/admin/warehousePage.jsp';
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
				alert("Η Αποθήκη διαγράφθηκε.");
			}
			window.location.href = '/HelloWorldJSP/admin/warehouses.jsp';
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
			if (session.getAttribute("userName") != null  && (Integer.parseInt(session.getAttribute("warepermissions").toString())) != 2) {
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
			Αποθήκη
			<%=session.getAttribute("warehousePage")%>
		</h2>

		<%
			Warehouses warehouse = Warehouses
						.getWarehouseByName((String) session
								.getAttribute("warehousePage"));
				if (warehouse != null) {
		%>

		<div class="cubeWarepage">
			<br> <label id="warehouseDesc" class="centerwareP">Περιγραφή
				Αποθήκης</label>
			<textarea id="warehousePDescTextArea" autofocus <c:out value="${read}"/> rows="2" cols="50"
				maxlength="60"
				placeholder="Συμπλήρωσε την περιγραφή της Αποθήκης ..."></textarea>
			<br> <br> <label id="warehouseOpen" class="centerwareP">Ανοιχτή:
			</label> <select id="warehouseSelect">
				<option id="warehouseSelectNo" value="Όχι">Όχι</option>
				<option id="warehouseSelectYes" value="Ναι">Ναι</option>
			</select> <br> <br> <label id="warehouseLocation" class="centerwareP">Τοποθεσία
				Αποθήκης : </label><input type="text" id="warehouseLocationInput" <c:out value="${read}"/> maxlength="20"> <br>
			<br>

			<script>
				function setContents(element,value2) {
					var el = document.getElementById(element);
					el.value = value2;
				}

				function setSelect(element) {
					document.getElementById(element).selected = true;
				}
				<%if (warehouse.isOpen()) {%>
				setSelect('warehouseSelectYes');
				<%} else {%>
				setSelect('warehouseSelectNo');
				<%}%>
				setContents('warehousePDescTextArea',"<%=warehouse.getDesc()%>" );
				setContents('warehouseLocationInput',"<%=warehouse.getLocation()%>");
			</script>
			<%
			List<WarehouseProductSupplier> wareProd = new ArrayList<WarehouseProductSupplier>();
			wareProd = WarehouseProductSupplier
										.getListWarehouseProductSupplierByName((String) session
												.getAttribute("warehousePage"));
			if(wareProd != null && wareProd.size() != 0){
				deleteWareh = "no";
				if(wareProd.size() == 1){
			%>
			<label id="warehouseProductNumber" class="centerwareP">Η
				αποθήκη περιέχει 1 Προϊόν </label>
			<%
				}else if(wareProd.size() >= 1){
			%>
			<label id="warehouseProductNumber" class="centerwareP">Η
				αποθήκη περιέχει <%=wareProd.size() %> Προϊόντα </label>
			<%
				}
				%>
			
			<div>

				<br>
				<table id="wareProductTable" class="pricingtable">
					<tr>
						<th colspan="5">Προϊόντα Αποθήκης</th>
					</tr>

					<tr>
						<td>
							<h4 class="username">Όνομα</h4>
						</td>
						<td>
							<h4 class="username">Άριθμός</h4>
						</td>
						<td>
							<h4 class="username">Προμηθευτής</h4>
						</td>
						<td>
							<h4 class="username">Απόθεμα</h4>
						</td>
						<td>
							<h4 class="username">Κόστος</h4>
						</td>
					</tr>
					<c:forEach var="warepro" items="${prowareList}">
			        <tr>
			        <td>
			        <h4 class="username">
			        	${warepro.getNameP()}
			        	</h4>
			        	</td>
			          <td>
			        <h4 class="username">
			        	${warepro.getSerialP()}
			        	</h4>
			        	</td>
			          <td>
			        <h4 class="username">
			        	${warepro.getNameS()}
			        	</h4>
			        	</td>
			          <td>
			        <h4 class="username">
			        	${warepro.getCapacity()}
			        	</h4>
			        	</td>			
					    <td>
			        <h4 class="username">
			        	${warepro.getCost()}
			        	</h4>
			        	</td>		
			   
			        </tr>
        		</c:forEach>
					
				</table>
			</div>

			<%
			}
			
			else{
			%>
			<label id="warehouseProductNumber" class="centerwareP">Η
				αποθήκη περιέχει 0 Προϊόντα </label>
			<%
				}
			%>

<c:if test="${currentPage != 1}">
	 <div class="links">
	 <div style="float: left;margin:0 100px; ">
	 <a href="warehouseProducts?warename=<%=(String) session
	 .getAttribute("warehousePage") %>&page=${currentPage - 1}">Προηγούμενη σελίδα</a>
	 </div>
	 </div>
	 </c:if>
	
	
	
	
	 <%--For displaying Page numbers.
	451	+ The when condition does not display a link for the current page--%>
	
	 <div class="links"><div style="float: left;margin:0 200px;">
	 <c:forEach begin="1" end="${noOfPages}" var="i">
	 <c:choose>
	 <c:when test="${currentPage eq i}">
	 <td>${i}</td>
	
	 </c:when>
	
	 <c:otherwise>
	 <a href="warehouseProducts?warename=<%=(String) session
	 .getAttribute("warehousePage") %>&page=${i}">${i}</a>
	 
	 </c:otherwise>
	 </c:choose>
		 </c:forEach>
	 </div> </div>
	
	
	<c:if test="${currentPage lt noOfPages}">
	<div class="links"><div style="float: left;margin:0 0px;"><a href="warehouseProducts?warename=<%=(String) session
	.getAttribute("warehousePage") %>&page=${currentPage + 1}">Επόμενη σελίδα</a></div> </div>
	
	</c:if>
	<br>
	<br>


			<%
				List<WarehouseLastMovementProduct> listmovement = WarehouseLastMovementProduct
										.getListMovementProductByWarehouseName((String) session
												.getAttribute("warehousePage"));
								if (listmovement != null && listmovement.size() >= 1) {
			%>


			<div>

				<br>
				<table id="wareProductTable" class="pricingtable">
					<tr>
						<th colspan="4">Κίνηση Προϊόντων Αποθήκης</th>
					</tr>

					<tr>
						<td>
							<h4 class="username">Όνομα</h4>
						</td>
						<td>
							<h4 class="username">Άριθμός</h4>
						</td>
						<td>
							<h4 class="username">Κίνηση</h4>
						</td>
						<td>
							<h4 class="username">Ημερομηνία και Ώρα</h4>
						</td>
					</tr>
					
					
					
	
					
					
					<%
						for (WarehouseLastMovementProduct list : listmovement) {
					%>
					
					<tr>
						<td>
							<h4 class="username">
								<%=list.getNameP()%>
							</h4>
						</td>
						<td>
							<h4 class="username">
								<%=list.getSerialP()%>
							</h4>
						</td>
						<%
							if(list.getCommentP().equalsIgnoreCase("insert")){
						%>
						<td>
							<h4 class="username">
								Εισαγωγή προϊόντος στην αποθήκη.
							</h4>
						</td>
						<%
							}else if(list.getCommentP().equalsIgnoreCase("transport")){
						%>
						<td>
							<h4 class="username">
								Μεταφορά προϊόντος στην αποθήκη.
							</h4>
						</td>
						<%
							}else if(list.getCommentP().equalsIgnoreCase("delete")){
						%>
						<td>
							<h4 class="username">
								Διαγραφή προϊόντος απο την αποθήκη.
							</h4>
						</td>
						<%
							}else{
						%>
						<td>
							<h4 class="username">
								Ασαφής προσδιορισμός για το προϊόν
							</h4>
						</td>
						<%
							}
						%>
						<td>
							<h4 class="username">
								<%=list.getTimeP()%>
							</h4>
						</td>
						<%
							}
						%>
					
				</table>
			</div>

			<%
				}
			%>
			
			<%
			if(deleteWareh.equalsIgnoreCase("no")){
			%>
			
<c:if test="${re!=1}">
			<br> <br>
			<button class="pip1" id="updateWarehouse"
				onclick="updateWarehouse('<%=warehouse.getName()%>','no'); return false;">Ενημέρωση
				Στοιχείων</button>
	</c:if>
			<%
			}
			else {
			%>
			
<c:if test="${re!=1}">
			<label id="warehouseProductNumber" class="centerwareP">Μπορείτε
				να διαγράψετε την αποθήκη </label> <br> <label id="warehouseProductDel"
				class="centerwareP"> κάνοντας κλικ εδώ : </label><input
				type="checkbox" id="wareDelete"> <br> <br>
			<button class ="pip1" id="updateWarehouse"
				onclick="updateWarehouse('<%=warehouse.getName()%>','yes'); return false;">Ενημέρωση
				Στοιχείων</button>
		</c:if>
			<%
				}
			%>
			<br> <br>
		</div>
		<br> <br> <br> <br>

		<%
			}
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