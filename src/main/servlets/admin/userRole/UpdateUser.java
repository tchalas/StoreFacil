package servlets.admin.userRole;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class UpdateUser
 */
@WebServlet("/UpdateUser")
public class UpdateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
		String update = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		String output = request.getParameter("finalString");
		if(output != null && net){
			String[] splits = new String[2];
			splits = output.split(" ");
		
		update = "UPDATE AUTHUSERS SET AUTH = TRUE , PERMISSIONS = ? "
                + " WHERE USERNAME = ?";
		try {
			preparedStatement = conn.prepareStatement(update);
		
		
			preparedStatement.setInt(1, Integer.parseInt(splits[1]));
			preparedStatement.setString(2, splits[0]);

	
			preparedStatement.executeUpdate();
		
			preparedStatement.close();

		}
		catch(SQLException e){
			e.printStackTrace();
			System.out.println("Something went wrong to : " + e.getMessage());
			net = false; }
		}
		
		if(net){
			PrintWriter out = response.getWriter();
			out.println(getResult("yes"));
		}
		else {
			PrintWriter out = response.getWriter();
			out.println(getResult("no"));
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
