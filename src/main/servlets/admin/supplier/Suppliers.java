package servlets.admin.supplier;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connectionPool.ConnectionPool;

public class Suppliers {
		private String name;
		private String address;
		private String afm;
		private String phone;
		
		static Connection con;
		
		static{
			con = null;
		}

		public Suppliers() {
			name = null;
			address = null;
			setAfm(null);
			phone = null;
		}

		// ///////////////////////////////
		// useful functions
		
		
		public static List<String> getNamesSuppliers() {

			List<String> list = new ArrayList<String>();
			try {

				con = ConnectionPool.checkout();

				String Query = "select name from supplier ORDER BY  name ASC ; ";

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
		

		public static Suppliers getWarehouseByName(String name) {
			Suppliers supp = new Suppliers();
			try {
				Connection con = ConnectionPool.checkout();
				PreparedStatement predst = null;
				String Query = "select * from supplier where name = ? ; ";
			    predst = con.prepareStatement(Query);
			    predst.setString(1, name);
				ResultSet rs = predst.executeQuery();
				while (rs.next()) {
					supp.setName(name);
					supp.setAddress(rs.getString(2));
					supp.setAfm(rs.getString(3));
					supp.setPhone(rs.getString(4));
				}

				rs.close();

				ConnectionPool.checkin(con);
			} catch (SQLException ex) {
				System.out.println("Something went wrong to : " + ex.getMessage());
				ex.printStackTrace();
				supp = null;
			}
			return supp;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}


		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}



		public String getPhone() {
			return phone;
		}

		public void setPhone(String phone) {
			this.phone = phone;
		}

		public String getAfm() {
			return afm;
		}

		public void setAfm(String afm) {
			this.afm = afm;
		}

	
}
