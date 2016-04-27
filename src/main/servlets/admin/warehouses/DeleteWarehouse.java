package servlets.admin.warehouses;

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
 * Servlet implementation class DeleteWarehouse
 */
@WebServlet("/DeleteWarehouse")
public class DeleteWarehouse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteWarehouse() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true; 
		String name = request.getParameter("finalString"), msg = null;

		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		if (name != null && net) {
			
			PreparedStatement st = null;
			int delete = 0;
			
			try {
				
				String myq = "DELETE FROM ware_last_movement_product WHERE nameW = ? ;";
				st = conn.prepareStatement(myq);
				st.setString(1, name);
				delete = st.executeUpdate(myq);
				if(delete != 1){
					System.out.println("Row is not deleted ware_last_movement_product.");
				}

			} catch (SQLException ex) {
				System.out.println("Something went wrong : " + ex.getMessage());
				ex.printStackTrace();
				net = false;
			}
			
			try {
				
				String myq = "DELETE FROM ware_product_supp WHERE nameW = ? ;";
				st = conn.prepareStatement(myq);
				st.setString(1, name);
				delete = st.executeUpdate(myq);
				if(delete != 1){
					System.out.println("Row is not deleted ware_product_supp.");
				}

			} catch (SQLException ex) {
				System.out.println("Something went wrong : " + ex.getMessage());
				ex.printStackTrace();
				net = false;
			}
			
			
			try {
				String myq = "DELETE FROM warehouse WHERE name = ? ; ";
				st = conn.prepareStatement(myq);
				st.setString(1, name);
				delete = st.executeUpdate(myq);
				if(delete != 1){
					System.out.println("Row is not deleted warehouse.");
				}

			} catch (SQLException ex) {
				System.out.println("Something went wrong : " + ex.getMessage());
				ex.printStackTrace();
				net = false;
			}

			
		}

		if (net)
			msg = "yes";
		else
			msg = "no";
		

		PrintWriter out = response.getWriter();
		out.println(getResult(msg));

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
