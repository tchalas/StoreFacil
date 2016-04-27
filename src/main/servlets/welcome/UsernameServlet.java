package servlets.welcome;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import connectionPool.ConnectionPool;

/**
 * Servlet implementation class UsernameServlet
 */
@WebServlet("/UsernameServlet")
public class UsernameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Connection conn  = null;
	
    /**
     * Default constructor. 
     */
    public UsernameServlet() {
    	
    }

    
  
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
		String output = request.getParameter("stringParameter");
		String id = "";
		
		try {
			conn = ConnectionPool.checkout();
	        net = true;
		} catch (SQLException e) {
			e.printStackTrace();
			net=false;
		}

		if(output != null && net){
			PreparedStatement prs = null;
	        try{
	        	
	            String myq = "select name from "
	                        + "user"
	                        + " where username = ? ";
	            prs = conn.prepareStatement(myq);
	            prs.setString(1, output);
	            ResultSet rs = prs.executeQuery();
	            while(rs.next()){
	            	id = rs.getString("name");
	            }
	        }catch(SQLException ex){
	            System.out.println("Something went wrong : " +ex.getMessage());
	            id = "";
	        }
		}
		
		if (id.equalsIgnoreCase(""))
			id = "no";
		else 
			id = "yes";
		
		response.setContentType("text/xml");
		PrintWriter out = response.getWriter();  
		out.println(getResult(id));
		
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
