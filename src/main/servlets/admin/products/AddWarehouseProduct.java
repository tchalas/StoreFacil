package servlets.admin.products;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddWarehouseProduct
 */
@WebServlet("/AddWarehouseProduct")
public class AddWarehouseProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddWarehouseProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean net = true;
		String[] splits = null;
		

		String output = request.getParameter("stringParameter");
		if (output != null && net) {
			splits = new String[2];
			splits = output.split(" ");
			try{
				ProductWarehouseCapacity.addWarehouseToList(splits[0], Integer.parseInt(splits[1]));
			}catch(Exception e){
				e.printStackTrace();
				net = false;
			}
		}
		if(net){
			
			PrintWriter out = response.getWriter();
			out.println(getResult(splits[0]));
		}
		else{
			PrintWriter out = response.getWriter();
			out.println(getResult("no"));
		}
	}

	public String getResult(String roll) {
		
		String result = "<Messages>";
		result += "<Message>";
		result += "<Info>" + roll + "</Info>";
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
