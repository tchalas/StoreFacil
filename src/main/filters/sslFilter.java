package filters;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class sslFilter
 */

public class sslFilter implements Filter {

	private Connection conn  = null;
	
	private HttpSession session;


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
			  //response.setContentType("text/html");
			  
		    HttpServletRequest req = (HttpServletRequest) request;  
		    
		    session = req.getSession(true);
			String file = req.getServletPath();  
			
			 if (file.equals("/welcome/welcome.jsp") || file.equals("/css/welcome.css") || file.equals("/icons/welcome1.gif") || file.equals("/icons/login.jpg") 
					 || file.equalsIgnoreCase("/indexMain.html") ) {
			 chain.doFilter(request, response);
			 }
			 else
			 {	    
			    String scheme = req.getScheme();  
			    String rURI = req.getRequestURI();  
			    System.out.println(scheme);
			    System.out.println(rURI);	    
			    
			    if(scheme.equals("https")) {

			        chain.doFilter(request, response);

			    } else {
	
			    	
	
			        PrintWriter out = response.getWriter();
			        out.println("<HTML>");
			        out.println("<HEAD>");
			        out.println("<TITLE>");
			        out.println("Incorrect Password");
			        out.println("</TITLE>");
			        out.println("</HEAD>");
			        out.println("<BODY>");
			        out.println("<H1>Incorrect Protocol</H1>");
			        out.println("Sorry, use HTTPS.");
			        out.println("</BODY>");
			        out.println("</HTML>");
			        
			        HttpServletResponse httpResponse = (HttpServletResponse) response;
			    	httpResponse.setHeader("Refresh", "3; URL=https://localhost:8443/HelloWorldJSP/welcome/welcome.jsp");
			    }    
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
