package servlets.admin.warehouses;

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
@WebServlet("/UpdateWarehouse")
public class UpdateWarehouse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Connection conn = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateWarehouse() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
		boolean open;
		String update = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		String output = request.getParameter("finalString");
		if (output != null && net) {
			String[] splits = new String[4];
			splits = output.split("@@@");
			
			if(splits[2].equalsIgnoreCase("0")){
				open = false;
			}
			else
				open = true;

			update = "UPDATE warehouse SET description = ? , open = ? , location = ? "
					+ " WHERE name = ?";
			try {
				preparedStatement = conn.prepareStatement(update);

				preparedStatement.setString(1, splits[1]);//description
				preparedStatement.setBoolean(2, open); // warehouse is open ? 
				preparedStatement.setString(3, splits[3]); //location
				preparedStatement.setString(4, splits[0]); //name

				preparedStatement.executeUpdate();

				preparedStatement.close();

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Something went wrong to : "
						+ e.getMessage());
				net = false;
			}
		}

		if (net) {
			PrintWriter out = response.getWriter();
			out.println(getResult("yes"));
		} else {
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
