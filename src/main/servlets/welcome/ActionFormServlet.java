package servlets.welcome;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class ActionFormServlet
 */
@WebServlet("/ActionFormServlet")
public class ActionFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn  = null;
	
	private HttpSession session;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActionFormServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user=request.getParameter("userForm");
		String pwd=request.getParameter("pwdForm");
		String username=null;
		boolean checkUser = false;
		boolean auth = false,admin = false;
		session = request.getSession(true);
		
		if(user.equalsIgnoreCase("") || user == null || pwd == null || pwd.equalsIgnoreCase("")){
			response.sendRedirect("/HelloWorldJSP/welcome/welcome.jsp");
		}
		
		else{
		
			try{
				conn = ConnectionPool.checkout();
			
				PreparedStatement prs = null;
				String myq = "select * from "
		                       + "user"
		                       + " where username = ?  and password = ? ;";
		        prs = conn.prepareStatement(myq);
		        prs.setString(1, user);
		        prs.setString(2, pwd);
		        ResultSet rs = prs.executeQuery();
		        while(rs.next()){
		        	checkUser = true;
		        	admin = rs.getBoolean("admin");
		        	username = rs.getString("username");
		        }
		    }catch(SQLException ex){
		        System.out.println("Something went wrong : " +ex.getMessage());
		        ex.printStackTrace();
		    }
			
			if(admin){
				session.setAttribute("userName", username);
				response.sendRedirect("https://localhost:8443" + "/HelloWorldJSP/admin/admin.jsp");
			}
			  
			if(checkUser && !admin){
			
			session.setAttribute("userName", user);
			
				
				try {
					PreparedStatement prs1 = null;
					String myq1 = "select auth from "
			                    + "authusers"
			                    + " where username = ? ;";
			        
					prs1 = conn.prepareStatement(myq1);
					prs1.setString(1, user);
			        ResultSet rs1 = prs1.executeQuery();
			        while(rs1.next()){
			        	auth = rs1.getBoolean("auth");
			        }
				} catch (SQLException e) {
					System.out.println("Something went wrong : " +e.getMessage());
					e.printStackTrace();
					auth = false;
				}
				
				
				if(!auth){
					String sendURI = "/HelloWorldJSP/welcome/correctUserPass.jsp";
					response.sendRedirect("https://localhost:8443"+sendURI);
				}else{
					String sendURI = "/HelloWorldJSP/user/user.jsp";
					response.sendRedirect("https://localhost:8443"+sendURI);
				}
					
			}
			else if ( !admin){
				String sendURI = "/HelloWorldJSP/welcome/incorrectUserPass.jsp";
				response.sendRedirect("https://localhost:8443"+sendURI);
			}
			
		}
	}

}
