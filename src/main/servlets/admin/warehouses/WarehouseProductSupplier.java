package servlets.admin.warehouses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connectionPool.ConnectionPool;

public class WarehouseProductSupplier {

	private String nameW;
	private String nameP;
	private int serialP;
	private String nameS;
	private int capacity;
	private Float cost;

	static Connection con;

	static {
		con = null;
	}

	public WarehouseProductSupplier() {
		nameP = null;
		nameW = null;
		nameS = null;
	}

	// ///////////////////////////////
	// useful functions
	
	public static List<WarehouseProductSupplier> getListSupplierProductBySupplier(String name) {

		List<WarehouseProductSupplier> list = new ArrayList<WarehouseProductSupplier>();
		try {
			
			con = ConnectionPool.checkout();
			WarehouseProductSupplier wareProdSupp;
			PreparedStatement predst = null;
			String Query = "select * from ware_product_supp where `nameS` = ? ORDER BY  `nameP` ASC  ; ";
		    predst = con.prepareStatement(Query);
		    predst.setString(1, name);
			ResultSet rs = predst.executeQuery();
			while (rs.next()) {
				wareProdSupp = new WarehouseProductSupplier();
				wareProdSupp.setNameW(rs.getString(1));
				wareProdSupp.setNameP(rs.getString(2));
				wareProdSupp.setSerialP(rs.getInt(3));
				wareProdSupp.setNameS(rs.getString(4));
				wareProdSupp.setCapacity(rs.getInt(5));
				wareProdSupp.setCost(rs.getFloat(6));
				list.add(wareProdSupp);
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

	public static List<WarehouseProductSupplier> getListWarehouseProductSupplierByName(String name) {

		List<WarehouseProductSupplier> list = new ArrayList<WarehouseProductSupplier>();
		try {
			
			con = ConnectionPool.checkout();
			WarehouseProductSupplier wareProdSupp;
			PreparedStatement predst = null;
			String Query = "select * from ware_product_supp where `nameW` = ? ; ";
		    predst = con.prepareStatement(Query);
		    predst.setString(1, name);
			ResultSet rs = predst.executeQuery();
			while (rs.next()) {
				wareProdSupp = new WarehouseProductSupplier();
				wareProdSupp.setNameW(name);
				wareProdSupp.setNameP(rs.getString(2));
				wareProdSupp.setSerialP(rs.getInt(3));
				wareProdSupp.setNameS(rs.getString(4));
				wareProdSupp.setCapacity(rs.getInt(5));
				wareProdSupp.setCost(rs.getFloat(6));
				list.add(wareProdSupp);
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

	
	public static List<WarehouseProductSupplier> getListWarehouseProductSupplierByNameAndSerial(String name , int serial) {

		List<WarehouseProductSupplier> list = new ArrayList<WarehouseProductSupplier>();
		try {
			
			con = ConnectionPool.checkout();
			WarehouseProductSupplier wareProdSupp;
			PreparedStatement predst = null;
			String Query = "select * from ware_product_supp where `nameP` = ? and `serialP` = ?; ";
		    predst = con.prepareStatement(Query);
		    predst.setString(1, name);
		    predst.setInt(2, serial);
			ResultSet rs = predst.executeQuery();
			while (rs.next()) {
				wareProdSupp = new WarehouseProductSupplier();
				wareProdSupp.setNameW(rs.getString("nameW"));
				wareProdSupp.setNameP(rs.getString("nameP"));
				wareProdSupp.setSerialP(rs.getInt("serialP"));
				wareProdSupp.setNameS(rs.getString("nameS"));
				wareProdSupp.setCapacity(rs.getInt("capacity"));
				wareProdSupp.setCost(rs.getFloat("cost"));
				list.add(wareProdSupp);
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

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getNameS() {
		return nameS;
	}

	public void setNameS(String nameS) {
		this.nameS = nameS;
	}

	public Float getCost() {
		return cost;
	}

	public void setCost(Float cost) {
		this.cost = cost;
	}

}
