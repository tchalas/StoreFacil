package servlets.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogOut
 */
@WebServlet("/LogOut")
public class LogOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private HttpSession session;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogOutServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession(true);
	    session.setAttribute("userName", null);
	    Cookie cookie = new Cookie("userName", null);
	    cookie.setPath("/HelloWorldJSP/");
	    cookie.setHttpOnly(true);
	    cookie.setMaxAge(0);
	    response.addCookie(cookie);
		String send = "/HelloWorldJSP/welcome/welcome.jsp";
		response.sendRedirect("https://localhost:8443"+send);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession(true);
	    session.setAttribute("userName", null);
	    Cookie cookie = new Cookie("userName", null);
	    cookie.setPath("/HelloWorldJSP");
	    cookie.setHttpOnly(true);
	    cookie.setMaxAge(0);
	    response.addCookie(cookie);
		String send = "/HelloWorldJSP/welcome/welcome.jsp";
		response.sendRedirect("https://localhost:8443"+send);
	}

}
