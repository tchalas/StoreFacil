package servlets.admin.products;

import servlets.admin.supplier.Suppliers;
import servlets.admin.warehouses.*;

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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class ProductList
 */
@WebServlet("/ProductList")
public class ProductList implements Filter {
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
     * @see HttpServlet#HttpServlet()
     */
    public ProductList() {
        super();
    }

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
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
		
		ArrayList<Warehouses> wareList = new ArrayList<Warehouses>();
		if(net){
			PreparedStatement prs = null;
			PreparedStatement prs1 = null;
			String query ="SELECT SQL_CALC_FOUND_ROWS * FROM product LIMIT " + offset +"," + String.valueOf(minElementsPerPage);
			String warequery ="SELECT * FROM warehouse ORDER BY  name ASC ;";
			String suppquery ="SELECT * FROM supplier ORDER BY  name ASC ;";
			ArrayList<Product> arrayList = new ArrayList<Product>();
			ArrayList<Suppliers> arraySupp = new ArrayList<Suppliers>();
			Product pro = null;
			Warehouses ware = null;
            try {
				prs = conn.prepareStatement(query);
				
            ResultSet rs = prs.executeQuery();
            while(rs.next()){
            	 pro = new Product();
            	pro.setSerial(rs.getInt("serial"));
            	pro.setDescription(rs.getString("description"));
            	pro.setName(rs.getString("name"));
            	arrayList.add(pro);
            }
            rs.close();
            rs = prs.executeQuery("SELECT FOUND_ROWS()");
            if(rs.next())
            {
                NumRecords = rs.getInt(1);
            }
            
            prs1 = conn.prepareStatement(warequery);
            ResultSet rs1 = prs1.executeQuery();
            while(rs1.next()){
	           	ware = new Warehouses();
	           	ware.setName(rs1.getString("name"));
	           	wareList.add(ware);
           }
           rs1.close();
            
           ResultSet rs2 = null;
           rs2 = conn.createStatement().executeQuery(suppquery);

			while (rs2.next()) {
				Suppliers supp = new Suppliers();
				supp.setName(rs2.getString("name"));
				arraySupp.add(supp);
			}

			rs2.close();
            

			ConnectionPool.checkin(conn);
			
            } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
            int NumberPages = (int) Math.ceil(NumRecords * 1.0 / minElementsPerPage);
            req.setAttribute("wareList", wareList);
            req.setAttribute("productList", arrayList);
            req.setAttribute("noOfPages", NumberPages);
            req.setAttribute("currentPage", page);
            req.setAttribute("arraySupp", arraySupp);
            chain.doFilter(req, response);
            
		}
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
	}



	public HttpSession getSession() {
		return session;
	}



	public void setSession(HttpSession session) {
		this.session = session;
	}

}
