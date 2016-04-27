package servlets.admin.supplier;

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
 * Servlet implementation class CheckSupplier
 */
@WebServlet("/CheckSupplier")
public class CheckSupplier extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckSupplier() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true, found = false; 
		String name = request.getParameter("name"), msg = null;

		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		if (name != null && net) {
			PreparedStatement prs = null;
			try {

				String myq = "select * from supplier where name = ? ";
				prs = conn.prepareStatement(myq);
				prs.setString(1, name);
				ResultSet rs = prs.executeQuery();
				while (rs.next()) {
					found = true;
				}
			} catch (SQLException ex) {
				System.out.println("Something went wrong : " + ex.getMessage());
				ex.printStackTrace();
			}
		}

		if (!found)
			msg = "no";
		else
			msg = "yes";
		

		PrintWriter out = response.getWriter();
		out.println(getResult(msg));

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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
