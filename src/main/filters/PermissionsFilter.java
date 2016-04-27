package filters;

import java.io.IOException;
import java.io.PrintWriter;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import connectionPool.ConnectionPool;

/**
 * Servlet Filter implementation class sslFilter
 */

public class PermissionsFilter implements Filter {

	
	private static Connection conn;
	
	private HttpSession session;
    /**
     * Default constructor. 
     */

	static {
		conn  = null;
	}
	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
		    FilterChain chain)
		    throws IOException, ServletException 
		  {
		 HttpServletRequest req = (HttpServletRequest) request;  
		 session = req.getSession(true);
		 String usr = "";
		 String file = req.getServletPath();  
		 int perm=-1;
		 if (file.equals("/welcome/welcome.jsp") | file.equals("/welcome/CheckUsernameServlet")  | file.equals("/welcome/CheckInsertUserServlet") | file.equals("/welcome/correctUserPass.jsp") |  file.equals("/welcome/incorrectUserPass.jsp"))
			 {
			 chain.doFilter(request, response);
			 }
		 else
		 {
				int wareperm ;
				int properm ;
				int supperm ;
				
				
				
			 if(session.getAttribute("userName")!=null) 
			 {
				 
				 
				 String user=(String) session.getAttribute("userName");
				 
				 if(!user.equals("admin"))
				 {
					 usr = "user";
				 try {
					conn = ConnectionPool.checkout();
				} catch (SQLException e1) {
					
					e1.printStackTrace();
				}
		        	String ware="" ;
		        	String pro="" ;
		        	String sup="" ;
					PreparedStatement prs2 = null;
					String myq2 = "select permissions from "
			                    + "authusers"
			                    + " where username = ? ;";
					
					try {
						prs2 = conn.prepareStatement(myq2);
					
					
						prs2.setString(1, user);

			        ResultSet rs2 = prs2.executeQuery();
			        while(rs2.next()){
			        	perm = rs2.getInt("permissions");


	        }
			       
			        
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					PreparedStatement prs3 = null;
					String myq3 = "select * from "
			                    + "permissions"
			                    + " where id = ? ;";
					
					try {
						prs3 = conn.prepareStatement(myq3);
					
					
						prs3.setInt(1, perm);

			        ResultSet rs3 = prs3.executeQuery();
			        while(rs3.next()){
			        	
			        	ware = rs3.getString("warehouses");
			        	pro = rs3.getString("products");
			        	sup = rs3.getString("suppliers");
			        	
	        }
			        
			        
					} catch (SQLException e) {

						e.printStackTrace();
					}
					
		        	 wareperm = 2;  	
					if (ware.equals("NOPE"))
			        {
						wareperm = 2;
			        }
			        else if (ware.equals("READ"))
			        {
			        	wareperm = 0;
			        }
			        else if (ware.equals("WRITE"))
			        {
			        	wareperm = 1;
			        }
					
					System.out.println("wawre : " +wareperm);
					
				     
					 properm = 2;  	
					if (pro.equals("NOPE"))
			        {
						properm = 2;
			        }
			        else if (pro.equals("READ"))
			        {
			        	properm = 0;
			        }
			        else if (pro.equals("WRITE"))
			        {
			        	properm = 1;
			        }
					 
					
					
					
					 supperm = 2;  	
					if (sup.equals("NOPE"))
			        {
						supperm = 2;
			        }
			        else if (sup.equals("READ"))
			        {
			        	supperm = 0;
			        }
			        else if (sup.equals("WRITE"))
			        {
			        	supperm = 1;
			        }
				
			  			 
			 }
				 else
				 {
					 wareperm=1;
					 properm=1;
					 supperm=1;
				 }
					

		        	
				 session.setAttribute("propermissions",  properm); 
				 session.setAttribute("suppermissions",  supperm);  
				 session.setAttribute("warepermissions",  wareperm);   
				 
				 session.setAttribute("usr",  usr); 
				
		 }
			 ConnectionPool.checkin(conn);
			 
			 chain.doFilter(request, response);
			 }
		 
		 
		 }

	/**
	 * @see Filter#init(FilterConfig)
	 */
	  private FilterConfig filterConfig = null;

	  public void init(FilterConfig filterConfig) {
		    this.filterConfig = filterConfig;
		  }
	  

}
