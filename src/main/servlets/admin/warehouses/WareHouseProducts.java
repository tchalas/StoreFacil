package servlets.admin.warehouses;

import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connectionPool.ConnectionPool;
import servlets.admin.products.ProductList;
import servlets.admin.warehouses.WarehouseProductSupplier;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class WareHouseProducts
 */
@WebServlet("/WareHouseProducts")
public class WareHouseProducts extends HttpServlet {
	private static final long serialVersionUID = 1L;
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
    public WareHouseProducts() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean net = true;
		int NumRecords=0;
		int page=1;
		
		HttpServletRequest req = (HttpServletRequest) request;  
		setSession(req.getSession(true));
		String warename = " ";
		
	    if(req.getParameter("warename") != null) 
	    {
	    	warename = req.getParameter("warename").toString();
	           System.out.println("mlkkkkkkkkkkk : " +warename);
	           
	    }
	    
	    
		session.setAttribute("warehousePage",warename);
		
	    System.out.println("mlkkkkkkkkkkk : " +warename);
		try {
			conn = (Connection) ConnectionPool.checkout();
	        
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

        ArrayList<WarehouseProductSupplier> wareProd = new ArrayList<WarehouseProductSupplier>();
		if(net){
			WarehouseProductSupplier wareProdSupp= null;
			PreparedStatement prs = null;
			String query ="SELECT SQL_CALC_FOUND_ROWS * from ware_product_supp where `nameW` = ? LIMIT " + offset +"," + String.valueOf(minElementsPerPage) + " ; ";	
			System.out.println("querry " + query );
            try {
				prs = (PreparedStatement) conn.prepareStatement(query);
				prs.setString(1, warename);	
            ResultSet rs = prs.executeQuery();
            while(rs.next()){
				wareProdSupp = new WarehouseProductSupplier();
				wareProdSupp.setNameW(warename);
				wareProdSupp.setNameP(rs.getString(2));
				wareProdSupp.setSerialP(rs.getInt(3));
				wareProdSupp.setNameS(rs.getString(4));
				wareProdSupp.setCapacity(rs.getInt(5));
				wareProdSupp.setCost(rs.getFloat(6));
				wareProd.add(wareProdSupp);
            }
            rs.close();
            rs = prs.executeQuery("SELECT FOUND_ROWS()");
            if(rs.next())
            {
                NumRecords = rs.getInt(1);
            }
            
            
            System.out.println("NumRecords " + NumRecords);
			ConnectionPool.checkin(conn);
			
            } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
            int NumberPages = (int) Math.ceil(NumRecords * 1.0 / minElementsPerPage);
            req.setAttribute("prowareList", wareProd);
            req.setAttribute("noOfPages", NumberPages);
            req.setAttribute("currentPage", page);
            RequestDispatcher view = req.getRequestDispatcher("warehousePage.jsp");
            view.forward(req, response);
            
		}
	    
	    
	    
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	public HttpSession getSession() {
		return session;
	}



	public void setSession(HttpSession session) {
		this.session = session;
	}
	

}
