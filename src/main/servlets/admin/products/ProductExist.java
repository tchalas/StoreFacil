package servlets.admin.products;

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
 * Servlet implementation class ProductExist
 */
@WebServlet("/ProductExist")
public class ProductExist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Connection conn = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductExist() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true, found = false;
		try {
			conn = ConnectionPool.checkout();
		} catch (SQLException e) {
			e.printStackTrace();
			net = false;
		}

		String output = request.getParameter("finalString");
		if (output != null && net) {
			String[] splits = new String[2];
			splits = output.split("@@@");
			PreparedStatement prs = null;
			try {

				String myq = "select * from product where name = ? and serial = ?";
				prs = conn.prepareStatement(myq);
				prs.setString(1, splits[0]);
				prs.setInt(2, Integer.parseInt(splits[1]));
				ResultSet rs = prs.executeQuery();
				while (rs.next()) {
					found = true;
				}
			} catch (SQLException ex) {
				System.out.println("Something went wrong : " + ex.getMessage());
				ex.printStackTrace();
			}
		}
		
		String msg="";
		
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

}
