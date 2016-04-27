package servlets.user;

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
 * Servlet implementation class UpdateInfo
 */
@WebServlet("/UpdateInfo")
public class UpdateInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private Connection conn  = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
        try{
				conn = ConnectionPool.checkout();
		} catch (SQLException e) {
				e.printStackTrace();
				net = false;
		}
		
		String output = request.getParameter("stringParameter");
		if(output != null && net){
		String[] splits = new String[5];
		splits = output.split(" ");
		
		   PreparedStatement predst = null;
	        try{
	            String update = "UPDATE user SET name = ? , surname = ? , password = ? ,email = ? WHERE username = ?";
	            predst = conn.prepareStatement(update);
	            predst.setString(1, splits[1]);// name
	            predst.setString(2, splits[2]); //surname 		       
	            predst.setString(3, splits[3]);// password
	            predst.setString(4, splits[4]);//email
	            predst.setString(5, splits[0]);//username
	            predst.executeUpdate();
	            predst.close();
	            
	        }catch(SQLException ex){
	            System.out.println("Something went wrong to : "+ex.getMessage());
	            net = false;
	        }
	        
		
		if(net){
			PrintWriter out = response.getWriter();  
			out.println(getResult("yes"));
		}
		
		else{
			PrintWriter out = response.getWriter();  
			System.out.println(getResult("no")); 
			out.println(getResult("no"));
		}
		}
		
		ConnectionPool.checkin(conn);
	}
	
	
	public String getResult(String roll){
		String info = ""; 
		if(roll.equalsIgnoreCase("yes")){
			info = "yes";
		} else{ info = "no"; }
		String result = "<Messages>";
		result += "<Message>"; 
		result += "<Info>" + info + "</Info>";
		result += "</Message>"; result += "</Messages>";
		return result;
		}

}
