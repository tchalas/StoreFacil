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
 * Servlet implementation class InsertWarehouse
 */
@WebServlet("/InsertWarehouse")
public class InsertWarehouse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	private Connection conn = null;

	public InsertWarehouse() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
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

			PreparedStatement predst = null;
			try {
				String insert = "INSERT into "
						+ " warehouse"
						+ " values (?,?,?,?)";
				predst = conn.prepareStatement(insert);
				predst.setString(1, splits[0]);// name
				predst.setString(2, splits[1]); // desc
				if(splits[2].equalsIgnoreCase("0"))
					predst.setBoolean(3, false);// open
				else
					predst.setBoolean(3, true);// open
				predst.setString(4, splits[3]);// location
				predst.executeUpdate();
				predst.close();

			} catch (SQLException ex) {
				System.out.println("Something went wrong to : "
						+ ex.getMessage());
				net = false;
			}
		}

		if (net) {
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
		if (roll.equalsIgnoreCase("yes")) {
			info = "yes";
		} else {
			info = "no";
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
