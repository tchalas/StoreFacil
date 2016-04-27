package servlets.admin.userRole;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UserPage
 */
@WebServlet("/UserPage")
public class UserPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private HttpSession session;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPage() {
        super();
        // TODO Auto-generated constructor stub
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		String user = request.getParameter("user");
		session = request.getSession(true);
		session.setAttribute("userPage", user);
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   
		out.println(getResult("comple"));
	}

	
	public String getResult(String roll){
		String info = ""; 
		if(roll.equalsIgnoreCase("no")){
			info = "no";
		} else{ info = roll; }
		String result = "<Messages>";
		result += "<Message>"; 
		result += "<Info>" + info + "</Info>";
		result += "</Message>"; result += "</Messages>";
		return result;
		}
	
}
