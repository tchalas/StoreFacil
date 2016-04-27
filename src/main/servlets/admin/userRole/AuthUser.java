package servlets.admin.userRole;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connectionPool.ConnectionPool;

public class AuthUser {
	private String username;
	private boolean auth;
	private int permissions;
	
	
	public AuthUser(){
		setUsername(null);
		setAuth(false);
		setPermissions(0);
	}
	
	
	
	public static int getPermiss(String user){
		int permiss = 0;
		try{
		Connection con = ConnectionPool.checkout();
		PreparedStatement predst = null;
	    String Query = "select permissions from authusers where username = ?; ";
	    predst = con.prepareStatement(Query);
	    predst.setString(1, user);
        ResultSet rs = predst.executeQuery();
	
	    while (rs.next()) {
	    	permiss =rs.getInt(1);
	    }
	      	      
	    rs.close();
	    predst.close();
	    
	    ConnectionPool.checkin(con);
	 }catch(SQLException ex){
         System.out.println("Something went wrong to : "+ex.getMessage());
		 ex.printStackTrace();
	 }
		return permiss;
		
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
}
