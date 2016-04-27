package servlets.welcome;

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

import connectionPool.StartUpConnectionPool;
import connectionPool.ConnectionPool;

/**
 * Servlet implementation class InsertUserServlet
 */
@WebServlet("/InsertUserServlet")
public class InsertUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    

	
	private Connection conn  = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertUserServlet() {
        super();       
    }
 
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean net = true;
        try{
				conn = ConnectionPool.checkout();
		} catch (SQLException e) {
				e.printStackTrace();
				net = false;
		}
		
		String output = request.getParameter("finalString");
		if(output != null && net){
		String[] splits = new String[6];
		splits = output.split(" ");
		
		   PreparedStatement predst = null;
	        try{
	            String insert = "INSERT into "+
	            		StartUpConnectionPool.tableName + " values (?,?,?,?,?,?)";
	            predst = conn.prepareStatement(insert);
	            predst.setString(1, splits[2]);// username
	            predst.setString(2, splits[0]); //name 		       
	            predst.setString(3, splits[1]);// Surname
	            predst.setString(4, splits[3]);//password
	            predst.setString(5, splits[5]);//email
	            predst.setBoolean(6, false);//admin
	            predst.executeUpdate();
	            predst.close();
	            
	        }catch(SQLException ex){
	            System.out.println("Something went wrong to : "+ex.getMessage());
	            net = false;
	        }
	        
	        
	        
	        PreparedStatement predst1 = null;
	        try{
	            String insert = "INSERT into "+
	            		"authusers" + " values (?,?,?)";
	            predst1 = conn.prepareStatement(insert);
	            predst1.setString(1, splits[2]);// username
	            predst1.setBoolean(2, false);//admin
	            predst1.setInt(3, 0);//role
	            predst1.executeUpdate();
	            predst1.close();
	            
	        }catch(SQLException ex){
	        	ex.printStackTrace();
	            System.out.println("Something went wrong to : "+ex.getMessage());
	            net = false;
	        }
			
		}
		
		if(net){
			PrintWriter out = response.getWriter();  
			System.out.println(getResult("yes")); 
			out.println(getResult("yes"));
		}
		
		else{
			PrintWriter out = response.getWriter();  
			System.out.println(getResult("no")); 
			out.println(getResult("no"));
		}
		
		ConnectionPool.checkin(conn);
	}

	
	public String getResult(String roll) {

		String result = "<Messages>";
		result += "<Message>";
		result += "<Info>" + roll + "</Info>";
		result += "</Message>";
		result += "</Messages>";
		return result;
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
