package servlets.admin.userRole;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connectionPool.ConnectionPool;

public class Users {

	
	private String username;
	private boolean auth;
	private int permissions;
	
	public Users(){
		username = "";
		auth = false;
		setPermissions(0);
	}

	
	
	 public static List<Users> getAllUsers() {
		 
		 List<Users> list=new ArrayList<Users>();
		 try{
			 
			 Connection con = ConnectionPool.checkout();
		     
		     String Query = "select * from authusers;";
		     
		     ResultSet rs = null;
		     rs = con.createStatement().executeQuery(Query);
	
		      while (rs.next()) {
		    	 Users user=new Users();
		         user.setUsername(rs.getString(1));
		         user.setAuth(rs.getBoolean(2));
		         user.setPermissions(rs.getInt(3));
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
			 
			 Connection con = ConnectionPool.checkout();
		     
		     String Query = "select * from authusers where auth = true ";
		     
		     ResultSet rs = null;
		     rs = con.createStatement().executeQuery(Query);
	
		      while (rs.next()) {
		    	 Users user=new Users();
		         user.setUsername(rs.getString(1));
		         user.setPermissions(rs.getInt(3));
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


	public int getPermissions() {
		return permissions;
	}



	public void setPermissions(int permissions) {
		this.permissions = permissions;
	}
	
	
	@Override
	public String toString() {
		return "Username: " +getUsername() + " auth: " + isAuth() + " permissions: " + getPermissions(); 
	}

	
}
