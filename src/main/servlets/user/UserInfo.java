package servlets.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connectionPool.ConnectionPool;

public class UserInfo {
	
	
	private String username;
	private String name;
	private String surname;
	private String password;
	private String email;
	static Connection con;
	
	
	static{
		con = null;
	}
	
	
	public UserInfo(){
		username = "";
		name = "";
		surname = "";
		password = "";
		email = "";
	}
	
	
	public static UserInfo getUserByUsername(String username){
		
		UserInfo user = new UserInfo();
		
		try {

			con = ConnectionPool.checkout();

			PreparedStatement predst = null;
			String Query = "select * from user where username = ? ; ";
		    predst = con.prepareStatement(Query);
		    predst.setString(1, username);
			ResultSet rs = predst.executeQuery();
			while (rs.next()) {
				user.setUsername(rs.getString(1));
				user.setName(rs.getString(2));
				user.setSurname(rs.getString(3));
				user.setPassword("");
				user.setEmail(rs.getString(5));
			}

			rs.close();

			ConnectionPool.checkin(con);
		} catch (SQLException ex) {
			System.out.println("Something went wrong to : " + ex.getMessage());
			ex.printStackTrace();
			user = null;
		}

		return user;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	
	

}
