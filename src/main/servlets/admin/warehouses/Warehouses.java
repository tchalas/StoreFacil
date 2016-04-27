package servlets.admin.warehouses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connectionPool.ConnectionPool;

public class Warehouses {

	private String name;
	private String desc;
	private boolean open;
	private String location;
	static Connection con;
	
	static{
		con = null;
	}

	public Warehouses() {
		name = null;
		desc = null;
		location = null;
	}

	// ///////////////////////////////
	// useful functions
	
	
	public static List<String> getNamesWarehouses() {

		List<String> list = new ArrayList<String>();
		try {

			con = ConnectionPool.checkout();

			String Query = "select name from warehouse ORDER BY  name ASC  ; ";

			ResultSet rs = null;
			rs = con.createStatement().executeQuery(Query);

			while (rs.next()) {
				list.add(rs.getString(1));
			}

			rs.close();

			ConnectionPool.checkin(con);
		} catch (SQLException ex) {
			System.out.println("Something went wrong to : " + ex.getMessage());
			ex.printStackTrace();
		}
		return list;
	}
	
	public static List<String> getNamesWarehousesExceptByName(String name) {

		List<String> list = new ArrayList<String>();
		try {

			con = ConnectionPool.checkout();

			String Query = "select name from warehouse ORDER BY  name ASC  ; ";

			ResultSet rs = null;
			rs = con.createStatement().executeQuery(Query);

			while (rs.next()) {
				if(!rs.getString("name").equalsIgnoreCase(name))
				list.add(rs.getString(1));
			}

			rs.close();

			ConnectionPool.checkin(con);
		} catch (SQLException ex) {
			System.out.println("Something went wrong to : " + ex.getMessage());
			ex.printStackTrace();
		}
		return list;
	}
	

	public static List<Warehouses> getAllWarehouses() {

		List<Warehouses> list = new ArrayList<Warehouses>();
		try {

			con = ConnectionPool.checkout();

			String Query = "select * from warehouse ; ";

			ResultSet rs = null;
			rs = con.createStatement().executeQuery(Query);

			while (rs.next()) {
				Warehouses ware = new Warehouses();
				ware.setName(rs.getString(1));
				ware.setDesc(rs.getString(2));
				ware.setOpen(rs.getBoolean(3));
				ware.setLocation(rs.getString(4));
				list.add(ware);
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

	public static Warehouses getWarehouseByName(String name) {
		Warehouses warehouse = new Warehouses();
		try {
			con = ConnectionPool.checkout();
			PreparedStatement predst = null;
			String Query = "select * from warehouse where name = ? ; ";
		    predst = con.prepareStatement(Query);
		    predst.setString(1, name);
			ResultSet rs = predst.executeQuery();
			while (rs.next()) {
				warehouse.setName(name);
				warehouse.setDesc(rs.getString(2));
				warehouse.setOpen(rs.getBoolean(3));
				warehouse.setLocation(rs.getString(4));
			}

			rs.close();

			ConnectionPool.checkin(con);
		} catch (SQLException ex) {
			System.out.println("Something went wrong to : " + ex.getMessage());
			ex.printStackTrace();
			warehouse = null;
		}
		return warehouse;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

}
