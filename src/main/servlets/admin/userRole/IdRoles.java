package servlets.admin.userRole;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connectionPool.ConnectionPool;

public class IdRoles {
	
	private int id;
	
	private String warehouses;
	private String suppliers;
	private String products;
	
	
	public IdRoles(){
		id = -1;
		warehouses = null;
		suppliers = null;
		products = null;
	}
	
	
	public static  List<IdRoles> getIdsRoles() {
		 
		 List<IdRoles> list = new ArrayList<IdRoles>();
		 try{
			 
			 Connection con = ConnectionPool.checkout();
		     
		     String Query = "select * from permissions; ";
		     
		     ResultSet rs = null;
		     rs = con.createStatement().executeQuery(Query);
	
		      while (rs.next()) {
		    	 IdRoles role = new IdRoles();
		    	 role.setId(rs.getInt(1));
		    	 role.setWarehouses(rs.getString(2));
		    	 role.setSuppliers(rs.getString(3));
		    	 role.setProducts(rs.getString(4));
		         list.add(role);
		      }
		      	      
		      rs.close();
	
		      ConnectionPool.checkin(con);
		      
		 }catch(SQLException ex){
	         System.out.println("Something went wrong to : "+ex.getMessage());
			 ex.printStackTrace();
		 }
	    return list;
	  }


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getWarehouses() {
		return warehouses;
	}


	public void setWarehouses(String warehouses) {
		this.warehouses = warehouses;
	}


	public String getSuppliers() {
		return suppliers;
	}


	public void setSuppliers(String suppliers) {
		this.suppliers = suppliers;
	}


	public String getProducts() {
		return products;
	}


	public void setProducts(String products) {
		this.products = products;
	}


}
