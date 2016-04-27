package servlets.admin.role;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connectionPool.ConnectionPool;

public class Roles {

	
	private int id;
	private String warehouses;
	private String products;
	private String suppliers;
	
	public Roles(){
		setId(-1);
		setWarehouses(null);
		setProducts(null);
		setSuppliers(null);
	}

	
	
	 public static List<Roles> getRoles() {
		 
		 List<Roles> list=new ArrayList<Roles>();
		 try{
			 
			 Connection con = ConnectionPool.checkout();
		     
		     String Query = "select * from permissions ORDER BY id ASC ";
		     
		     ResultSet rs = null;
		     rs = con.createStatement().executeQuery(Query);
	
		      while (rs.next()) {
		    	 Roles role = new Roles();
		    	 role.setId(rs.getInt(1));
		    	 role.setWarehouses((rs.getString(2)));
		    	 role.setProducts((rs.getString(3)));
		    	 role.setSuppliers((rs.getString(4)));
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
	 


	@Override
	public String toString() {
		return "id: " + getId() + " warehouses: " + getWarehouses() + " products: " + getProducts() + " suppliers: " +  getSuppliers() ; 
	}



	public String getWarehouses() {
		return warehouses;
	}



	public void setWarehouses(String warehouses) {
		this.warehouses = warehouses;
	}



	public String getProducts() {
		return products;
	}



	public void setProducts(String products) {
		this.products = products;
	}



	public String getSuppliers() {
		return suppliers;
	}



	public void setSuppliers(String suppliers) {
		this.suppliers = suppliers;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}
	
	
	
	
}
