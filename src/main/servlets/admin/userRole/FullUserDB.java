package servlets.admin.userRole;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import connectionPool.ConnectionPool;

public class FullUserDB {

	private String username;
	private String name;
	private String surname;
	private String email;
	
	
	public FullUserDB(){
		username = "";
		name = "";
		surname = "";
		email = "";
	}
	
	
	
	public static FullUserDB getFullUser(String username){
		FullUserDB fullUser = new FullUserDB();		
		 try{
		 Connection con = ConnectionPool.checkout();
	     String query = "SELECT * FROM user where username = " +" '"+ username +"' " ;
	     ResultSet rs = null;
	     rs = con.createStatement().executeQuery(query);

	      while (rs.next()) {
		    	 fullUser.setName(rs.getString(2));
		    	 fullUser.setSurname(rs.getString(3));
		    	 fullUser.setEmail(rs.getString(5));
	      }
	      	      
	      rs.close();

	      ConnectionPool.checkin(con);
	      
	 }catch(SQLException ex){
        System.out.println("Something went wrong to : "+ex.getMessage());
        
		 ex.printStackTrace();
	 }
		
		return fullUser;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getSurname() {
		return surname;
	}



	public void setSurname(String surname) {
		this.surname = surname;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}
	
	public String toString(){
		return getUsername() + " " + getName() + " " + getSurname() + " " + getEmail();
	} 
	
}
