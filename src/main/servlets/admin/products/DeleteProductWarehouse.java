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

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class DeleteProductWarehouse
 */
@WebServlet("/DeleteProductWarehouse")
public class DeleteProductWarehouse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	private Connection conn = null;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProductWarehouse() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
		
		String spl = request.getParameter("finalString"), msg = null;
		String[] splits = new String[4];
		
		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		if (spl != null && net) {
			boolean found = false;
			boolean found1 = false;
			splits = spl.split("@@@");
			PreparedStatement predst = null;
			System.out.println("111111111111111111111111111111");
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
				predst.close();

				} catch (SQLException ex) {
					System.out.println("Something went wrong to : "
							+ ex.getMessage());
					net = false;
				}
			
			if(net){
				System.out.println("222222222222222222222222222");
				PreparedStatement preds2 = null;
				try {
					String myq = "select nameW from ware_product_supp "
						+ " where nameP = ? and serialP = ? ; ";
					preds2 = conn.prepareStatement(myq);
					preds2.setString(1, splits[0]); // name product
					preds2.setInt(2, Integer.parseInt(splits[1])); // serial product
					ResultSet rs = preds2.executeQuery();
					while (rs.next()) {
						if(!rs.getString("nameW").equalsIgnoreCase(splits[2])){
							found = true;
						}
					}
					} catch (SQLException ex) {
						System.out.println("Something went wrong to : "
								+ ex.getMessage());
						net = false;
					}
				
			}
			
			
			if(net && found ){
				int max =0;
				if(net){
					PreparedStatement preds2 = null;
					System.out.println("33333333333333333333333333333");
					try {
						String myq = "select nameS from ware_product_supp "
							+ " where nameP = ? and serialP = ? and nameW = ? ; ";
						preds2 = conn.prepareStatement(myq);
						preds2.setString(1, splits[0]); // name product
						preds2.setInt(2, Integer.parseInt(splits[1])); // serial product
						preds2.setString(3, splits[2]); // name product
						ResultSet rs = preds2.executeQuery();
						while (rs.next()) {
							if(!rs.getString("nameS").equalsIgnoreCase(splits[3])){
								found1 = true;
								System.out.println("founddddddd");
							}
							else if(rs.getString("nameS").equalsIgnoreCase(splits[3])){
								max++;
							}
						}
						} catch (SQLException ex) {
							System.out.println("Something went wrong to : "
									+ ex.getMessage());
							net = false;
						}
					
				}
				
				
				if(net && found1){
						try {
							System.out.println("4444444444444444444444444444444");
							PreparedStatement st = null;
							int delete = 0;
							String myq = "DELETE FROM ware_product_supp WHERE nameP = ? and serialP = ? and nameW = ? and nameS = ? ;";
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
				else if(net && !found1 && max >=1){
					try {
						System.out.println("10000000000010101010101010101010101010101");
						PreparedStatement st = null;
						int delete = 0;
						String myq = "DELETE FROM ware_product_supp WHERE nameP = ? and serialP = ? and nameW = ? and nameS = ? ;";
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
				else{
					try {
						System.out.println("555555555555555555555555555555555555");

						PreparedStatement st = null;
						int delete = 0;
						String myq = "DELETE FROM product WHERE name = ? and serial = ? ;";
						st = conn.prepareStatement(myq);
						st.setString(1, splits[0]);
						st.setInt(2, Integer.parseInt(splits[1]));
		
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
			}
			else{
				
				if(net){
					PreparedStatement preds2 = null;
					System.out.println("66666666666666666666666666666");
					try {
						String myq = "select nameS from ware_product_supp "
							+ " where nameP = ? and serialP = ? and nameW = ? ; ";
						preds2 = conn.prepareStatement(myq);
						preds2.setString(1, splits[0]); // name product
						preds2.setInt(2, Integer.parseInt(splits[1])); // serial product
						preds2.setString(3, splits[2]); // name product
						ResultSet rs = preds2.executeQuery();
						while (rs.next()) {
							if(!rs.getString("nameS").equalsIgnoreCase(splits[3])){
								found1 = true;
								System.out.println("founddddddd");
							}
						}
						} catch (SQLException ex) {
							System.out.println("Something went wrong to : "
									+ ex.getMessage());
							net = false;
						}
					
				}
				
				
				if(net && found1){
					try {
						System.out.println("77777777777777777777777777777777777777");
						PreparedStatement st = null;
						int delete = 0;
						String myq = "DELETE FROM ware_product_supp WHERE nameP = ? and serialP = ? and nameW = ? and nameS = ?;";
						st = conn.prepareStatement(myq);
						st.setString(1, splits[0]);
						st.setInt(2, Integer.parseInt(splits[1]));
						st.setString(3, splits[2]);
						st.setString(4, splits[3]);
						
						delete =  st.executeUpdate();
						if(delete != 1){
							System.out.println("DDDDDen eixe na diagrapsei kati sto deleted ware_product_supp.");
						}
		
					} catch (SQLException ex) {
						System.out.println("Something went wrong : " + ex.getMessage());
						ex.printStackTrace();
						net = false;
					}
				}
				else{
					try {
						System.out.println("888888888888888888888888888888888888888");

						PreparedStatement st = null;
						int delete = 0;
						String myq = "DELETE FROM product WHERE name = ? and serial = ? ;";
						st = conn.prepareStatement(myq);
						st.setString(1, splits[0]);
						st.setInt(2, Integer.parseInt(splits[1]));
		
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
			}
			
		}

		if (net)
			msg = "yes";
		else
			msg = "no";
		
		System.out.println("9999999999999999999999999999   " + msg);

		PrintWriter out = response.getWriter();
		out.println(getResult(msg));
		ConnectionPool.checkin(conn);
		System.out.println("9999999999999999999999999999   " + msg);
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
