package servlets.admin.products;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class EditProduct
 */

public class EditProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection conn  = null; 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		boolean net = true;
		
		String name=request.getParameter("name");
		String serial=request.getParameter("serial");
		
		try {
			conn = ConnectionPool.checkout();
	       
		} catch (SQLException e) {
			net=false;
			e.printStackTrace();
			
		}
		
		if(net){
			PreparedStatement prs = null;
            String query = "select * from "
                + "product"
                + " where name = ? and serial = ?";
           
			Product pro = null;
            
				try {
					prs = conn.prepareStatement(query);
					prs.setString(1, name);
					prs.setString(2, serial);
            ResultSet rs = prs.executeQuery();
            while(rs.next()){
            	pro = new Product();
            	pro.setName(rs.getString("name"));
            	pro.setDescription(rs.getString("description"));
            	pro.setSerial(rs.getInt("serial"));
            	pro.setWeight(rs.getInt("weight"));
            	pro.setType(rs.getString("type"));
            	pro.setDimensions(rs.getString("dimensions"));
            	pro.setMass(rs.getInt("mass"));
            }
            rs.close();
            
        	} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            request.setAttribute("product", pro);
            RequestDispatcher view = request.getRequestDispatcher("/admin/productedit.jsp");
            view.forward(request, response);
            
            }
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
