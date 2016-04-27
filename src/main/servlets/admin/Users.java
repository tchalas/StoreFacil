package servlets.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connectionPool.ConnectionPool;

public class Users {

	
	private String username;
	private boolean auth;
	private int warehouses;
	private int products;
	private int suppliers;
	static Connection con;
	
	static{
		con = null;
	}
	
	
	public Users(){
		username = "";
		auth = false;
		warehouses = 0;
		products = 0;
		suppliers = 0;
	}

	public static String checkUserIfAdminByUsername(String username){
		
		String check = "user";
		
		try {

			con = ConnectionPool.checkout();

			PreparedStatement predst = null;
			String Query = "select admin from user where username = ? ; ";
		    predst = con.prepareStatement(Query);
		    predst.setString(1, username);
			ResultSet rs = predst.executeQuery();
			if (rs.next()) {
				if(rs.getBoolean(1))
					check = "admin";	
			}

			rs.close();

			ConnectionPool.checkin(con);
		} catch (SQLException ex) {
			System.out.println("Something went wrong to : " + ex.getMessage());
			ex.printStackTrace();
			check = "error";
		}

		return check;
	}
	
	 public static List<Users> getNotAuthUsers() {
		 
		 List<Users> list=new ArrayList<Users>();
		 try{
			 
			 con = ConnectionPool.checkout();
		     
		     String Query = "select * from authusers where auth = false ";
		     
		     ResultSet rs = null;
		     rs = con.createStatement().executeQuery(Query);
	
		      while (rs.next()) {
		    	 Users user=new Users();
		         user.setUsername(rs.getString(1));
		         user.setAuth(false);
		         list.add(user);
		      }
		      
		      
		      rs.close();
	
		      ConnectionPool.checkin(con);
		 }catch(SQLException ex){
	         System.out.println("Something went wrong to : "+ex.getMessage());
			 ex.printStackTrace();
		 }
	    return list;
	  }
	 

	 public static List<Users> getAuthUsers() {
		 
		 List<Users> list=new ArrayList<Users>();
		 try{
			 
			 con = ConnectionPool.checkout();
		     
		     String Query = "select * from authusers where auth = true ";
		     
		     ResultSet rs = null;
		     rs = con.createStatement().executeQuery(Query);
	
		      while (rs.next()) {
		    	 Users user=new Users();
		         user.setUsername(rs.getString(1));
		         switch (rs.getString(3)){
		         	case "NOPE":
		         		user.setWarehouses(2);
		         		break;
		         	case "WRITE" :
		         		user.setWarehouses(1);
		         		break;
		         	case "READ" :
		         		user.setWarehouses(0);
		         		break;
		         }

		         switch (rs.getString(4)){
		         	case "NOPE":
		         		user.setProducts(2);
		         		break;
		         	case "WRITE" :
		         		user.setProducts(1);
		         		break;
		         	case "READ" :
		         		user.setProducts(0);
		         		break;
		         }
		         
		         switch (rs.getString(5)){
		         	case "NOPE":
		         		user.setSuppliers(2);
		         		break;
		         	case "WRITE" :
		         		user.setSuppliers(1);
		         		break;
		         	case "READ" :
		         		user.setSuppliers(0);
		         		break;
		         }
		         user.setAuth(true);
		         list.add(user);
		      }
		      
		      
		      rs.close();
	
		      ConnectionPool.checkin(con);
		 }catch(SQLException ex){
	         System.out.println("Something went wrong to : "+ex.getMessage());
			 ex.printStackTrace();
		 }
	    return list;
	  }
	 
	 
	 
	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public boolean isAuth() {
		return auth;
	}


	public void setAuth(boolean auth) {
		this.auth = auth;
	}


	public int getWarehouses() {
		return warehouses;
	}


	public void setWarehouses(int warehouses) {
		this.warehouses = warehouses;
	}


	public int getProducts() {
		return products;
	}


	public void setProducts(int products) {
		this.products = products;
	}


	public int getSuppliers() {
		return suppliers;
	}


	public void setSuppliers(int suppliers) {
		this.suppliers = suppliers;
	}



	@Override
	public String toString() {
		return "Username: " +getUsername() + " warehouses: " + getWarehouses() + " products: " + getProducts() + " suppliers: " +  getSuppliers() + " auth: " + isAuth(); 
	}
	
	
	
	
}
