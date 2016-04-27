package servlets.admin.supplier;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import connectionPool.ConnectionPool;

import servlets.admin.products.ProductList;


/**
 * Servlet Filter implementation class SuppliersList
 */
@WebFilter("/SuppliersList")
public class SuppliersList implements Filter {
	private HttpSession session ;
	private Connection conn  = null;
	static int minElementsPerPage;
	
	static {
		InputStream is = ProductList.class.getClassLoader().getResourceAsStream("resources/db.properties");
        Properties prop = new Properties();
        try {
			prop.load(is);    
	        minElementsPerPage = Integer.parseInt(prop.getProperty("minElementsPerPage"));
	       
        }catch(IOException e){
        	e.printStackTrace();
        	minElementsPerPage = 10;
        }
		
	}
	

    /**
     * Default constructor. 
     */
    public SuppliersList() {
        // TODO Auto-generated constructor stub
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
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		boolean net = true;
		int NumRecords=0;
		int page=1;
		
		HttpServletRequest req = (HttpServletRequest) request;  
		setSession(req.getSession(true));
		
		try {
			conn = ConnectionPool.checkout();
	        
		} catch (SQLException e) {
			net=false;
			e.printStackTrace();
			
		}
				
	    if(req.getParameter("page") != null) 
	    {
	           String pagee = req.getParameter("page").toString();
	           page = Integer.parseInt(pagee);
	    }
	   
        int offset=(page-1)*minElementsPerPage;		
        ArrayList<Suppliers> supList = new ArrayList<Suppliers>();
		if(net){
			PreparedStatement prs = null;
			String query ="SELECT SQL_CALC_FOUND_ROWS * FROM supplier LIMIT " + offset +"," + String.valueOf(minElementsPerPage);

			Suppliers sup = null;

            try {
				prs = conn.prepareStatement(query);
				
            ResultSet rs = prs.executeQuery();
            while(rs.next()){
            	sup = new Suppliers();
            	sup.setAfm(rs.getString("afm"));
            	sup.setAddress(rs.getString("address"));
            	sup.setName(rs.getString("name"));
            	sup.setPhone(rs.getString("phone"));
            	supList.add(sup);
            }
            rs.close();
            rs = prs.executeQuery("SELECT FOUND_ROWS()");
            if(rs.next())
            {
                NumRecords = rs.getInt(1);
            }
            
            

			ConnectionPool.checkin(conn);
			
            } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
            int NumberPages = (int) Math.ceil(NumRecords * 1.0 / minElementsPerPage);
            req.setAttribute("supList", supList);
            req.setAttribute("noOfPages", NumberPages);
            req.setAttribute("currentPage", page);
            chain.doFilter(req, response);
            
		}
		

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

	public HttpSession getSession() {
		return session;
	}



	public void setSession(HttpSession session) {
		this.session = session;
	}

	
}
