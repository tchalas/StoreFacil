package servlets.admin.products;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import connectionPool.ConnectionPool;

public class Product implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private String description;
	private int serial;
	private int weight;
	private String type;
	private String dimensions;
	private int mass;
	private static Connection conn;
	
	static {
		
		conn = null;
		
	}
	
	public Product(){
		name = "";
		description = "";
		type = "";
		dimensions = "";
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getSerial() {
		return serial;
	}

	public void setSerial(int serial) {
		this.serial = serial;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDimensions() {
		return dimensions;
	}

	public void setDimensions(String dimensions) {
		this.dimensions = dimensions;
	}

	public int getMass() {
		return mass;
	}

	public void setMass(int mass) {
		this.mass = mass;
	}

	public static boolean getBooleanProducts() {
		boolean check = false;
		try {
			conn = ConnectionPool.checkout();
			PreparedStatement predst = null;
			String Query = "select * from product ;";
		    predst = conn.prepareStatement(Query);
			ResultSet rs = predst.executeQuery();
			if (rs.next()) {
				check = true;
			}

			rs.close();

			ConnectionPool.checkin(conn);
		} catch (SQLException ex) {
			System.out.println("Something went wrong to : " + ex.getMessage());
			ex.printStackTrace();
			check = false;
		}
		return check;
	}


}