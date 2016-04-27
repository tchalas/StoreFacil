package servlets.admin.products;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlets.admin.warehouses.WarehouseProductSupplier;
import connectionPool.ConnectionPool;

/**
 * Servlet implementation class TransferProductWarehouse
 */
@WebServlet("/TransferProductWarehouse")
public class TransferProductWarehouse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TransferProductWarehouse() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WarehouseProductSupplier wareProdOld = new WarehouseProductSupplier();
		WarehouseProductSupplier wareProdNew = new WarehouseProductSupplier();
		boolean net = true; 
		String spl = request.getParameter("finalString"), msg = null;
		String[] splits = new String[5];
		splits = spl.split("@@@");
		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		if (spl != null && net) {
			
			PreparedStatement prs2 = null;
		     String search = "select * from "
		            + " ware_product_supp"
		            + " where nameW = ? and nameP = ?  and serialP = ? and nameS = ? ";
		            	 try {
		            		prs2 = conn.prepareStatement(search);
		 					prs2.setString(1, splits[2]);
		 					prs2.setString(2, splits[0]);
		 					prs2.setInt(3, Integer.parseInt(splits[1]));
		 					prs2.setString(4, splits[3]);
		 					ResultSet rs2 = prs2.executeQuery();
		 					while (rs2.next()) {
		 						wareProdOld = new WarehouseProductSupplier();
		 						wareProdOld.setNameW(splits[2]);
		 						wareProdOld.setNameP(splits[0]);
		 						wareProdOld.setSerialP( Integer.parseInt(splits[1]));
		 						wareProdOld.setNameS(splits[3]);
		 						wareProdOld.setCapacity(Integer.parseInt(rs2.getString("capacity")));
		 						wareProdOld.setCost(Float.parseFloat(rs2.getString("cost")));
		 					}
		 				} catch (SQLException e) {
		 					e.printStackTrace();
		 				}
					
			if(net){
		
			
			PreparedStatement predst = null;
		
			try {
				String insert = "INSERT into "
						+ " ware_last_movement_product (nameW , nameP , serialP , commentP)"
						+ " values (?,?,?,?)";
				predst = conn.prepareStatement(insert);
				predst.setString(1, splits[2]);// name warehouse
				predst.setString(2, splits[0]); // name product
				predst.setInt(3, Integer.parseInt(splits[1])); // serial product
				predst.setString(4, "delete");// delete
				predst.executeUpdate();
				} catch (SQLException ex) {
					System.out.println("Something went wrong to : "
							+ ex.getMessage());
					net = false;
				}
			}
			if(net){

			try {
				PreparedStatement st = null;
				int delete = 0;
				
				String myq = "DELETE FROM ware_product_supp WHERE nameP = ? and serialP = ? and nameW = ? and nameS = ? ;" ; 
				st = conn.prepareStatement(myq);
				st.setString(1, splits[0]);
				st.setInt(2, Integer.parseInt(splits[1]));
				st.setString(3, splits[2]);
				st.setString(4, splits[3]);
				delete =  st.executeUpdate();
					if(delete != 1){
						System.out.println("Den eixe na diagrapsei kati sto deleted ware_product_supp.");
					}
				} catch (SQLException ex) {
					System.out.println("Something went wrong : " + ex.getMessage());
					ex.printStackTrace();
					net = false;
				}
			}
			
			if(net){
				PreparedStatement predst3 = null;
					try {
						String insert = "INSERT into "
								+ " ware_last_movement_product (nameW , nameP , serialP , commentP)"
								+ " values (?,?,?,?)";
						predst3 = conn.prepareStatement(insert);
						predst3.setString(1, splits[4]);// name warehouse
						predst3.setString(2, splits[0]); // name product
						predst3.setInt(3, Integer.parseInt(splits[1])); // serial product
						predst3.setString(4, "transport");// delete
						predst3.executeUpdate();
						predst3.close();

					} catch (SQLException ex) {
						System.out.println("Something went wrong to : "
								+ ex.getMessage());
						net = false;
					}
			}
					
					
			if(net){
				
				try {
					PreparedStatement prs4 = null;
				     String search4 = "select * from "
				            + " ware_product_supp"
				            + " where nameW = ? and nameP = ?  and serialP = ? and nameS = ? ";
        		 prs4 = conn.prepareStatement(search4);
        		 prs4.setString(1, splits[4]);
        		 prs4.setString(2, splits[0]);
        		 prs4.setInt(3, Integer.parseInt(splits[1]));
        		 prs4.setString(4, splits[3]);
 				 ResultSet rs2 = prs4.executeQuery();
 				 while (rs2.next()) {
 					wareProdNew = new WarehouseProductSupplier();
 					wareProdNew.setNameW(splits[4]);
 					wareProdNew.setNameP(splits[0]);
 					wareProdNew.setSerialP( Integer.parseInt(splits[1]));
 					wareProdNew.setNameS(splits[3]);
 					wareProdNew.setCapacity(Integer.parseInt(rs2.getString("capacity")));
 					wareProdNew.setCost(Float.parseFloat(rs2.getString("cost")));
				}
				} catch (SQLException e) {
						e.printStackTrace();
				}
					
				if(wareProdNew.getNameW() != null ){
					Float greater;
					int capacityNew;
					try{
				
						capacityNew = wareProdOld.getCapacity() + wareProdNew.getCapacity();
						if(wareProdNew.getCost() < wareProdOld.getCost() )
							greater = wareProdNew.getCost();
						else
							greater = wareProdNew.getCost();
						
					}catch(Exception e){
						greater = (float) 0;
						capacityNew = 0;
					}
						
	        	PreparedStatement prs6 = null;
			     String search6 = "UPDATE "
				+ " ware_product_supp "
				+ " SET capacity = ? , cost = ? "
				+ " where nameW = ? and nameP = ?  and serialP = ? and nameS = ? ";
				 try {
					 prs6 = conn.prepareStatement(search6);
					 prs6.setInt(1, capacityNew );
					 prs6.setFloat(2, greater);
					 prs6.setString(3, wareProdNew.getNameW());
					 prs6.setString(4, wareProdNew.getNameP());
					 prs6.setInt(5, wareProdNew.getSerialP());
					 prs6.setString(6, wareProdNew.getNameS());
					 prs6.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				 if(!wareProdOld.getNameS().equalsIgnoreCase(wareProdNew.getNameS())){
				 System.out.println("Add kai new Supplier");
				 PreparedStatement prs7 = null;
			     String search7 = "UPDATE "
				+ " ware_product_supp "
				+ " SET capacity = ? , cost = ? "
				+ " where nameW = ? and nameP = ?  and serialP = ? and nameS = ? ";
				 try {
					 prs7 = conn.prepareStatement(search7);
					 prs7.setInt(1, capacityNew );
					 prs7.setFloat(2, greater);
					 prs7.setString(3, wareProdNew.getNameW());
					 prs7.setString(4, wareProdOld.getNameP());
					 prs7.setInt(5, wareProdOld.getSerialP());
					 prs7.setString(6, wareProdOld.getNameS());
					 prs7.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				 }
	        }
	        else{
	        	PreparedStatement predst5 = null;
				try {
					String insert5 = "INSERT into "
							+ " ware_product_supp (nameW , nameP , serialP , nameS , capacity , cost)"
							+ " values (?,?,?,?,?,?)";
					predst5 = conn.prepareStatement(insert5);
					predst5.setString(1, splits[4]);// name warehouse
					predst5.setString(2, splits[0]); // name product
					predst5.setInt(3, Integer.parseInt(splits[1])); // serial product
					predst5.setString(4, splits[3]);// name supp
					predst5.setInt(5, wareProdOld.getCapacity());
					predst5.setFloat(6, wareProdOld.getCost());
					predst5.executeUpdate();
					predst5.close();

				} catch (SQLException ex) {
					System.out.println("Something went wrong to : "
							+ ex.getMessage());
					net = false;
				}
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
