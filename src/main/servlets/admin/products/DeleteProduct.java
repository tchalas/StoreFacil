package servlets.admin.products;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlets.admin.supplier.WareLastMovementProduct;
import connectionPool.ConnectionPool;

/**
 * Servlet implementation class DeleteProduct
 */
@WebServlet("/DeleteProduct")
public class DeleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	private Connection conn = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("do GEt delete product");
		System.out.println("Tsdsdsdsdsdd");
		boolean net = true; 
		String spl = request.getParameter("finalString"), msg = null;
		List<WareLastMovementProduct> warehLastMove = new ArrayList<WareLastMovementProduct>();
		
		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		if (spl != null && net) {
			String[] splits = new String[2];
			splits = spl.split("@@@");
			
			PreparedStatement st = null;
			
			
			PreparedStatement prs = null;
			try {

				String myq = "select * from ware_product_supp where nameP = ? and serialP = ? ;";
				prs = conn.prepareStatement(myq);
				prs.setString(1, splits[0]);
				prs.setInt(2, Integer.parseInt(splits[1]));
				ResultSet rs = prs.executeQuery();
				while (rs.next()) {
					WareLastMovementProduct wareLast = new WareLastMovementProduct();
					wareLast.setNameW(rs.getString(1));
					wareLast.setNameP(rs.getString(2));
					wareLast.setSerialP(rs.getInt(3));
					wareLast.setNameS(rs.getString(4));
					warehLastMove.add(wareLast);
				}
				rs.close();
			} catch (SQLException ex) {
				System.out.println("Something went wrong : " + ex.getMessage());
				ex.printStackTrace();
				net = false;
			}
			
			
			if(warehLastMove != null && warehLastMove.size()>=1 && net){
				PreparedStatement predst = null;
				for(int ii = 0; ii< warehLastMove.size(); ii++){
					try {
						String insert = "INSERT into "
								+ " ware_last_movement_product (nameW , nameP , serialP , commentP)"
								+ " values (?,?,?,?)";
		
						predst = conn.prepareStatement(insert);
						predst.setString(1, warehLastMove.get(ii).getNameW());// name warehouse
						predst.setString(2, warehLastMove.get(ii).getNameP()); // name product
						predst.setInt(3, warehLastMove.get(ii).getSerialP()); // serial product
						predst.setString(4, "delete");// delete
						predst.executeUpdate();
						predst.close();

					} catch (SQLException ex) {
						System.out.println("Something went wrong to : "
								+ ex.getMessage());
						net = false;
					}
				}
				
			}
			
			if(net){
				try {
					
					String myq = "DELETE FROM ware_product_supp WHERE nameP = ? and serialP = ? ;";
					st = conn.prepareStatement(myq);
					st.setString(1, splits[0]);
					st.setInt(2, Integer.parseInt(splits[1]));
					int delete1 = st.executeUpdate();
					if(delete1 != 1){
						System.out.println("Den eixe na diagrapsei kati sto deleted ware_product_supp.");
					}
	
				} catch (SQLException ex) {
					System.out.println("Something went wrong : " + ex.getMessage());
					ex.printStackTrace();
					net = false;
				}
				
				
				
				try {
					
					String myq = "DELETE FROM product WHERE name = ? and  serial = ? ; ";
					st = conn.prepareStatement(myq);
					st.setString(1, splits[0]);
					st.setInt(2, Integer.parseInt(splits[1]));
					
					int delete1 = st.executeUpdate();
					if(delete1 != 1){
						System.out.println("Den eixe na diagrapsei kati sto deleted product.");
					}
	
	
				} catch (SQLException ex) {
					System.out.println("Something went wrong : " + ex.getMessage());
					ex.printStackTrace();
					net = false;
				}
			}
			
		}

		if (net)
			msg = "yes";
		else
			msg = "no";
		

		PrintWriter out = response.getWriter();
		out.println(getResult(msg));

		ConnectionPool.checkin(conn);
		
		System.out.println("TElos delete  " + msg);
	}

	public String getResult(String roll) {
		String result = "<Messages>";
		result += "<Message>";
		result += "<Info>" + roll + "</Info>";
		result += "</Message>";
		result += "</Messages>";
		return result;
	}


}
