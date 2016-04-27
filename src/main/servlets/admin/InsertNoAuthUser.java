package servlets.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class InsertNoAuthUser
 */
@WebServlet("/InsertNoAuthUser")
public class InsertNoAuthUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn  = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertNoAuthUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
		String case1 = null,case2 = null,case3 = null;
		String update = null;
		String[] splits = null;
		update = "UPDATE authusers ";
        try{
				conn = ConnectionPool.checkout();
		} catch (SQLException e) {
				e.printStackTrace();
				net = false;
		}
		
		String output = request.getParameter("finalString");
		if(output != null && net){
		splits = new String[5];
		splits = output.split(" ");
		switch (splits[1]){
			
		case "0" : case1 = "READ";
			break;
		case "1" : case1 = "WRITE";
			break;
		case "2" : case1 = "NOPE";
			break;
		default: case1 = "NOPE";
        	break;
		}
		
		switch (splits[2]){
		
		case "0" : case2 = "READ";
			break;
		case "1" : case2 = "WRITE";
			break;
		case "2" : case2 = "NOPE";
			break;
		default: case2 = "NOPE";
        	break;
		}
		
		switch (splits[3]){
		
		case "0" : case3 = "READ";
			break;
		case "1" : case3 = "WRITE";
			break;
		case "2" : case3 = "NOPE";
			break;
		default: case3 = "NOPE";
        	break;
		}
		
		
		   PreparedStatement predst = null;
	        try{
	            update = "UPDATE authusers SET warehouses = ? ,  products = ? , suppliers = ? , auth = true where username = ? ; ";
	            predst = conn.prepareStatement(update);
	            predst.setString(1, case1);// username
	            predst.setString(2, case2); //name 		       
	            predst.setString(3, case3);// Surname
	            predst.setString(4, splits[0]);//password
	            predst.executeUpdate();
	            predst.close();
	            
	        }catch(SQLException ex){
	            System.out.println("Something went wrong to : "+ex.getMessage());
	            net = false;
	        }
	        
			
		}
		
		if(net){
			PrintWriter out = response.getWriter();   
			out.println(getResult(splits[4]));
		}
		
		else{
			PrintWriter out = response.getWriter();  
			out.println(getResult("no"));
		}
		
		ConnectionPool.checkin(conn);
	}

	
	public String getResult(String roll){
		String info = ""; 
		if(roll.equalsIgnoreCase("no")){
			info = "no";
		} else{ info = roll; }
		String result = "<Messages>";
		result += "<Message>"; 
		result += "<Info>" + info + "</Info>";
		result += "</Message>"; result += "</Messages>";
		return result;
		}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
