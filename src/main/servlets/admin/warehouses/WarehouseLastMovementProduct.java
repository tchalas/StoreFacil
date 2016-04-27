package servlets.admin.warehouses;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import connectionPool.ConnectionPool;

public class WarehouseLastMovementProduct {

	private int id;
	private String nameW;
	private String nameP;
	private int serialP;
	private String commentP;
	private Timestamp timeP;
	private static int movementProducts;

	static Connection con;

	static {
		InputStream is = WarehouseLastMovementProduct.class.getClassLoader().getResourceAsStream("resources/db.properties");
        Properties prop = new Properties();
			try {
				prop.load(is);
				setMovementProducts(Integer.parseInt(prop.getProperty("movement_products")));
			} catch (IOException e) {
				e.printStackTrace();
				setMovementProducts(0);
			}
			
        con = null;
	}

	public WarehouseLastMovementProduct() {
		nameP = null;
		nameW = null;
		commentP = null;
		timeP = null;
	}

	// ///////////////////////////////
	// useful functions

	public static List<WarehouseLastMovementProduct> getListMovementProductByWarehouseName(String name) {

		List<WarehouseLastMovementProduct> list = new ArrayList<WarehouseLastMovementProduct>();
		try {
			
			con = ConnectionPool.checkout();
			WarehouseLastMovementProduct wareProd;
			PreparedStatement predst = null;
			String Query = "select * from ware_last_movement_product where `nameW` = ? ORDER BY `timeP` desc LIMIT ? ; ";
		    predst = con.prepareStatement(Query);
		    predst.setString(1, name);
		    predst.setInt(2, movementProducts);
			ResultSet rs = predst.executeQuery();
			while (rs.next()) {
				wareProd = new WarehouseLastMovementProduct();
				wareProd.setId(rs.getInt(1));
				wareProd.setNameW(name);
				wareProd.setNameP(rs.getString(3));
				wareProd.setSerialP(rs.getInt(4));
				wareProd.setCommentP(rs.getString(5));
				wareProd.setTimeP(rs.getTimestamp(6));
				list.add(wareProd);
			}

			rs.close();

			ConnectionPool.checkin(con);
		} catch (SQLException ex) {
			System.out.println("Something went wrong to : " + ex.getMessage());
			ex.printStackTrace();
			list = null;
		}
		return list;
	}

	public String getNameW() {
		return nameW;
	}

	public void setNameW(String nameW) {
		this.nameW = nameW;
	}

	public String getNameP() {
		return nameP;
	}

	public void setNameP(String nameP) {
		this.nameP = nameP;
	}

	public int getSerialP() {
		return serialP;
	}

	public void setSerialP(int serialP) {
		this.serialP = serialP;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCommentP() {
		return commentP;
	}

	public void setCommentP(String commentP) {
		this.commentP = commentP;
	}

	public Timestamp getTimeP() {
		return timeP;
	}

	public void setTimeP(Timestamp timeP) {
		this.timeP = timeP;
	}

	public static int getMovementProducts() {
		return movementProducts;
	}

	public static void setMovementProducts(int movementProducts) {
		WarehouseLastMovementProduct.movementProducts = movementProducts;
	}

	
}
