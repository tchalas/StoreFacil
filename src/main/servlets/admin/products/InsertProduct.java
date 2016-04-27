package servlets.admin.products;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class InsertProduct
 */
@WebServlet("/InsertProduct")
public class InsertProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean net = true;
		String[] splits = new String[9];
		
		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}
		
		String output = request.getParameter("finalString");
		splits = output.split("@@@");
		
		if (output != null && net) {
			
			PreparedStatement predst = null;
			try {
				String insert = "INSERT into "
						+ " product"
						+ " values (?,?,?,?,?,?,?)";
				predst = conn.prepareStatement(insert);
				predst.setString(1, splits[0]);// name
				predst.setString(2, splits[1]); // desc
				predst.setInt(3, Integer.parseInt(splits[2])); // serial
				
				if(splits[5] == null || splits[5].equalsIgnoreCase("") || splits[5].equalsIgnoreCase(" "))
					predst.setInt(4, 0); // weight
				else
					predst.setInt(4, Integer.parseInt(splits[5])); // weight
				
				if(splits[7] == null || splits[7].equalsIgnoreCase("") || splits[7].equalsIgnoreCase(" ") )
					predst.setString(5, ""); // type
				else
					predst.setString(5, splits[7]); // type
				
				if(splits[8] == null || splits[8].equalsIgnoreCase("")  || splits[8].equalsIgnoreCase(" "))
					predst.setString(6, ""); // dimensions
				else
					predst.setString(6, splits[8]); // dimensions
				
				if(splits[6] == null || splits[6].equalsIgnoreCase("") || splits[6].equalsIgnoreCase(" ") )
					predst.setInt(7, 0); // mass
				else
					predst.setInt(7, Integer.parseInt(splits[6])); // mass
				
				predst.executeUpdate();
				predst.close();

			} catch (SQLException ex) {
				System.out.println("Something went wrong to : INSERT into "
						+ " product"
						+ ex.getMessage());
				net = false;
			}
		}
		
		if(net){
			List<ProductSuppCost> list = ProductSuppCost.getSupplierToList();
			List<ProductWarehouseCapacity> wareList = ProductWarehouseCapacity.getWarehouseToList();
			PreparedStatement predst1 = null;
			PreparedStatement predst2 = null;
			for(int i =0; i < list.size(); i++){
				for(int wa = 0; wa<wareList.size(); wa++)
					if(net){
						try {
							String insert = "INSERT into "
									+ " ware_product_supp"
									+ " values (?,?,?,?,?,?)";
							predst1 = conn.prepareStatement(insert);
							predst1.setString(1, wareList.get(wa).getName());// name Warehouse
							predst1.setString(2, splits[0]); // name Product
							predst1.setInt(3, Integer.parseInt(splits[2])); // serial product
							predst1.setString(4, list.get(i).getName()); // name Supplier
							predst1.setInt(5,  wareList.get(wa).getCapacity()); // capacity
							predst1.setFloat(6, list.get(i).getCost()); // cost
							predst1.executeUpdate();
						} catch (SQLException ex) {
							System.out.println("Something went wrong to INSERT into "
									+ " ware_product_supp" 
									+ ex.getMessage());
							net = false;
						}
						
						try {
							String insert2 = "INSERT into "
									+ " ware_last_movement_product"
									+ " (nameW , nameP, serialP, commentP)"
									+ " values (?,?,?,?)";
							predst2 = conn.prepareStatement(insert2);
							predst2.setString(1, wareList.get(wa).getName());// name Warehouse
							predst2.setString(2, splits[0]); // name Product
							predst2.setInt(3, Integer.parseInt(splits[2])); // serial product
							predst2.setString(4, "insert"); // commentP insert		
							predst2.executeUpdate();
						} catch (SQLException ex) {
							System.out.println("Something went wrong to INSERT into "
									+ " ware_last_movement_product" 
									+ ex.getMessage());
							net = false;
						}
						
						
					}
			}
		}

		if (net) {
			PrintWriter out = response.getWriter();
			out.println(getResult("yes"));
		}
		else {
			PrintWriter out = response.getWriter();
			out.println(getResult("no"));
		}

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
}
