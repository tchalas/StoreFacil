package servlets.admin.role;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class ChangeRole
 */
@WebServlet("/ChangeRole")
public class ChangeRole extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeRole() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
		int id=-1;
		String case1 = null, case2 = null, case3 = null;
		String select = null;
		String update = null;
		String[] splits = null;
		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		String output = request.getParameter("finalString");
		if (output != null && net) {
			splits = new String[5];
			splits = output.split(" ");
			switch (splits[1]) {

			case "0":
				case1 = "READ";
				break;
			case "1":
				case1 = "WRITE";
				break;
			case "2":
				case1 = "NOPE";
				break;
			default:
				case1 = "NOPE";
				break;
			}

			switch (splits[2]) {

			case "0":
				case2 = "READ";
				break;
			case "1":
				case2 = "WRITE";
				break;
			case "2":
				case2 = "NOPE";
				break;
			default:
				case2 = "NOPE";
				break;
			}

			switch (splits[3]) {

			case "0":
				case3 = "READ";
				break;
			case "1":
				case3 = "WRITE";
				break;
			case "2":
				case3 = "NOPE";
				break;
			default:
				case3 = "NOPE";
				break;
			}
		}

		PreparedStatement predst = null;
		try {
			select = "select id from permissions where  warehouses = ? and products = ? and suppliers = ?  ; ";
			predst = conn.prepareStatement(select);
			predst.setString(1, case1);
			predst.setString(2, case2);
			predst.setString(3, case3);
			ResultSet rs = predst.executeQuery();
	        while(rs.next()){
	            	id = rs.getInt("id");
	        }
			predst.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("Something went wrong to : " + ex.getMessage());
			net = false;
		}
		if (net && id == -1 ) {
			
			PreparedStatement predst1 = null;
			try {
				update = "UPDATE permissions SET warehouses = ? , products = ? , suppliers = ? where id = ? ;" ;
				predst1 = conn.prepareStatement(update);
				predst1.setString(1, case1);
				predst1.setString(2, case2);
				predst1.setString(3, case3);
				predst1.setInt(4, Integer.parseInt(splits[0]));
				predst1.executeUpdate();
		        predst1.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
				System.out.println("Something went wrong to : " + ex.getMessage());
				net = false;
			}
			
			if(net){
				PrintWriter out = response.getWriter();
				out.println(getResult("yes"));
			}
			else{
				PrintWriter out = response.getWriter();
				out.println(getResult("no"));
			}
		}

		else {
			if(!net){
				PrintWriter out = response.getWriter();
				out.println(getResult("no"));
			}
			else if(id != -1){
				PrintWriter out = response.getWriter();
				out.println(getResult("exists"));
			}
		}

		ConnectionPool.checkin(conn);
	}

	public String getResult(String roll) {
		String info = "";
		if (roll.equalsIgnoreCase("no")) {
			info = "no";
		} else {
			info = roll;
		}
		String result = "<Messages>";
		result += "<Message>";
		result += "<Info>" + info + "</Info>";
		result += "</Message>";
		result += "</Messages>";
		return result;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
