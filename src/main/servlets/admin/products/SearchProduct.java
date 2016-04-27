package servlets.admin.products;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connectionPool.ConnectionPool;

/**
 * Servlet implementation class SearchProduct
 */

public class SearchProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection conn  = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
            
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		boolean net = true;
		int counter = 0;
		int counterNull = 0;
		int serialP = 0;
		List<Product> proList = new ArrayList<Product>();
		
		String name=request.getParameter("proname");
		String serial=request.getParameter("proserial");
		String desc=request.getParameter("prodesc");
		String supp = request.getParameter("prosupp");
		
		
		if(name == null || name.equalsIgnoreCase("")){
			name = "";
			counter = 1;
			counterNull++;
		}
		if(serial == null || serial.equalsIgnoreCase("") ){
			serial = "";
			counter = 2;
			counterNull++;
		}
		else{
			try  
			  {  
			    serialP = Integer.parseInt(serial);  
			  }  
			  catch(NumberFormatException nfe)  
			  {  
				  	String send = "/HelloWorldJSP/admin/productErrorPage.jsp";
					response.sendRedirect("https://localhost:8443"+send);
		            return;
			  }  
		}
		if(desc == null || desc.equalsIgnoreCase("")){
			desc = "";
			counter = 3;
			counterNull++;
		}
		if(supp == null || supp.equalsIgnoreCase("") ){
			supp = "";
			counter = 4;
			counterNull++;
		}

		
		
		if(counterNull == 4){
			String send = "/HelloWorldJSP/admin/products.jsp";
			response.sendRedirect("https://localhost:8443"+send);
            return;
		}
		
		
		try {
			conn = ConnectionPool.checkout();        
		} catch (SQLException e) {
			net=false;
			e.printStackTrace();
			
		}
		
		
		if(counter == 4 && net){
			PreparedStatement prs = null;
            String query = "select * from "
                + "product"
                + " where ";
			if(!name.equals("")){
				if(!serial.equals("")){
					if(!desc.equals("")){
						query += "name = ? and serial = ? and description = ? ;";
						System.out.println(query);
						try {
							prs = conn.prepareStatement(query);
							prs.setString(1, name);
							prs.setInt(2, serialP);
							prs.setString(3, desc);
							ResultSet rs = prs.executeQuery();
							while (rs.next()) {
								Product prod = new Product();
								prod.setName(rs.getString("name"));
								prod.setDescription(rs.getString("description"));
								prod.setSerial(rs.getInt("serial"));
								prod.setWeight(rs.getInt("weight"));
								prod.setType(rs.getString("type"));
								prod.setDimensions(rs.getString("dimensions"));
								prod.setMass(rs.getInt("mass"));
								proList.add(prod);
							}
							rs.close();
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					else{
						query += "name = ? and serial = ? ;";
						System.out.println(query);
						try {
							prs = conn.prepareStatement(query);
							prs.setString(1, name);
							prs.setInt(2, serialP);
							ResultSet rs = prs.executeQuery();
							while (rs.next()) {
								Product prod = new Product();
								prod.setName(rs.getString("name"));
								prod.setDescription(rs.getString("description"));
								prod.setSerial(rs.getInt("serial"));
								prod.setWeight(rs.getInt("weight"));
								prod.setType(rs.getString("type"));
								prod.setDimensions(rs.getString("dimensions"));
								prod.setMass(rs.getInt("mass"));
								proList.add(prod);
							}
							rs.close();
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				else if(!desc.equals("")){
					query += "name = ? and description = ? ;";
					System.out.println(query);
					try {
						prs = conn.prepareStatement(query);
						prs.setString(1, name);
						prs.setString(2, desc);
						ResultSet rs = prs.executeQuery();
						while (rs.next()) {
							Product prod = new Product();
							prod.setName(rs.getString("name"));
							prod.setDescription(rs.getString("description"));
							prod.setSerial(rs.getInt("serial"));
							prod.setWeight(rs.getInt("weight"));
							prod.setType(rs.getString("type"));
							prod.setDimensions(rs.getString("dimensions"));
							prod.setMass(rs.getInt("mass"));
							proList.add(prod);
						}
						rs.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				else{
					query += "name = ? ;";
					System.out.println(query);
					try {
						prs = conn.prepareStatement(query);
						prs.setString(1, name);
						ResultSet rs = prs.executeQuery();
						while (rs.next()) {
							Product prod = new Product();
							prod.setName(rs.getString("name"));
							prod.setDescription(rs.getString("description"));
							prod.setSerial(rs.getInt("serial"));
							prod.setWeight(rs.getInt("weight"));
							prod.setType(rs.getString("type"));
							prod.setDimensions(rs.getString("dimensions"));
							prod.setMass(rs.getInt("mass"));
							proList.add(prod);
						}
						rs.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			else if(!serial.equals("")){
				if(!desc.equals("")){
					query += "serial = ? and description = ? ;";
					System.out.println(query);
					try {
						prs = conn.prepareStatement(query);
						prs.setInt(1, serialP);
						prs.setString(2, desc);
						ResultSet rs = prs.executeQuery();
						while (rs.next()) {
							Product prod = new Product();
							prod.setName(rs.getString("name"));
							prod.setDescription(rs.getString("description"));
							prod.setSerial(rs.getInt("serial"));
							prod.setWeight(rs.getInt("weight"));
							prod.setType(rs.getString("type"));
							prod.setDimensions(rs.getString("dimensions"));
							prod.setMass(rs.getInt("mass"));
							proList.add(prod);
						}
						rs.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				else{
					query += "serial = ? ;";
					System.out.println(query);
					try {
						prs = conn.prepareStatement(query);
						prs.setInt(1, serialP);
						ResultSet rs = prs.executeQuery();
						while (rs.next()) {
							Product prod = new Product();
							prod.setName(rs.getString("name"));
							prod.setDescription(rs.getString("description"));
							prod.setSerial(rs.getInt("serial"));
							prod.setWeight(rs.getInt("weight"));
							prod.setType(rs.getString("type"));
							prod.setDimensions(rs.getString("dimensions"));
							prod.setMass(rs.getInt("mass"));
							proList.add(prod);
						}
						rs.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			else{
				query += "description = ? ;";
				System.out.println(query);
				System.out.println("---> " + desc);
				try {
					prs = conn.prepareStatement(query);
					prs.setString(1, desc);
					ResultSet rs = prs.executeQuery();
					while (rs.next()) {
						Product prod = new Product();
						prod.setName(rs.getString("name"));
						prod.setDescription(rs.getString("description"));
						prod.setSerial(rs.getInt("serial"));
						prod.setWeight(rs.getInt("weight"));
						prod.setType(rs.getString("type"));
						prod.setDimensions(rs.getString("dimensions"));
						prod.setMass(rs.getInt("mass"));
						proList.add(prod);
					}
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			 }
			
			
			 if(proList.size() >=1){
				 	request.setAttribute("productList", proList);
			        RequestDispatcher view = request.getRequestDispatcher("/admin/productsearch.jsp");
			        view.forward(request, response);
	            }
	            else{
	            	RequestDispatcher view = request.getRequestDispatcher("/admin/productNoResults.jsp");
	    	        view.forward(request, response);
	            }
			 
			////// telos tou if me ton supplier null ...
		}
		else{
			if(counterNull == 3){
				List<Product> producList = new ArrayList<Product>();
				List<Product> producList2 = new ArrayList<Product>();
				PreparedStatement prs = null;
	            String query = "select * from "
	                + "ware_product_supp"
	                + " where nameS = ? ;";
	            try {
					prs = conn.prepareStatement(query);
					prs.setString(1, supp);
					ResultSet rs = prs.executeQuery();
					while (rs.next()) {
						Product prod = new Product();
						prod.setName(rs.getString("nameP"));
						prod.setSerial(rs.getInt("serialP"));
						producList.add(prod);
					}
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
	            PreparedStatement prs2 = null;
	            if(producList.size() >=1){
		            for(int i=0 ; i<producList.size(); i++){
		            	 String search = "select * from "
		     	                + "product"
		     	                + " where name = ? and serial = ? ;";
		            	 try {
		            		prs2 = conn.prepareStatement(search);
		 					prs2.setString(1, producList.get(i).getName());
		 					prs2.setInt(2, producList.get(i).getSerial());
		 					ResultSet rs2 = prs2.executeQuery();
		 					while (rs2.next()) {
		 						Product prod1 = new Product();
		 						prod1.setName(rs2.getString(1));
								prod1.setDescription(rs2.getString(2));
								prod1.setSerial(rs2.getInt(3));
								prod1.setWeight(rs2.getInt(4));
								prod1.setType(rs2.getString(5));
								prod1.setDimensions(rs2.getString(6));
								prod1.setMass(rs2.getInt(7));
								producList2.add(prod1);
		 					}
		 				} catch (SQLException e) {
		 					e.printStackTrace();
		 				}
		            }
				}
	            if(producList2.size() >=1){
	            	
	            	Map<String, Product> map = new LinkedHashMap<>();
	            	for (Product pro : producList2) {
	            		String check = pro.getName() + String.valueOf(pro.getSerial());	          
	            		map.put(check, pro);
	            	}
	            	producList2.clear();
	            	producList2.addAll(map.values());   
	            	
	            	request.setAttribute("productList", producList2);
	    	        RequestDispatcher view = request.getRequestDispatcher("/admin/productsearch.jsp");
	    	        view.forward(request, response);
	            }
	            else{
	            	RequestDispatcher view = request.getRequestDispatcher("/admin/productNoResults.jsp");
	    	        view.forward(request, response);
	            }
			}
			else{
				///////////////
				ArrayList<Product> producList = new ArrayList<Product>();
				ArrayList<Product> producList2 = new ArrayList<Product>();
				PreparedStatement pr = null;
	            String que = "select * from "
	                + "ware_product_supp"
	                + " where nameS = ? ;";
	            try {
					pr = conn.prepareStatement(que);
					pr.setString(1, supp);
					ResultSet rs = pr.executeQuery();
					while (rs.next()) {
						Product prod = new Product();
						prod.setName(rs.getString("nameP"));
						prod.setSerial(rs.getInt("serialP"));
						producList.add(prod);
					}
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
	            
	            
				PreparedStatement prs = null;
	            if(producList.size()>=1){
	            	for(int i=0; i<producList.size(); i++){
	            		  String query = "select * from "
	          	                + " product"
	          	                + " where ";
						if(!name.equals("")){
							if(!serial.equals("")){
								if(!desc.equals("")){
									query += "name = ? and serial = ? and description = ? ;";
									try {
										prs = conn.prepareStatement(query);
										prs.setString(1, producList.get(i).getName());
										prs.setInt(2, producList.get(i).getSerial());
										prs.setString(3, desc);
										ResultSet rs = prs.executeQuery();
										while (rs.next()) {
											if(rs.getString("name").equalsIgnoreCase(name) && rs.getInt("serial") == serialP 
													&& rs.getString("description").equalsIgnoreCase(desc)  ){
											Product prod = new Product();
											prod.setName(rs.getString("name"));
											prod.setDescription(rs.getString("description"));
											prod.setSerial(rs.getInt("serial"));
											prod.setWeight(rs.getInt("weight"));
											prod.setType(rs.getString("type"));
											prod.setDimensions(rs.getString("dimensions"));
											prod.setMass(rs.getInt("mass"));
											producList2.add(prod);
											}
										}
										rs.close();
									} catch (SQLException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
								}
								else{
									query += "name = ? and serial = ? ;";
									System.out.println(query);
									try {
										prs = conn.prepareStatement(query);
										prs.setString(1, producList.get(i).getName());
										prs.setInt(2, producList.get(i).getSerial());
										ResultSet rs = prs.executeQuery();
										while (rs.next()) {
											if(rs.getString("name").equalsIgnoreCase(name) && rs.getInt("serial") == serialP ){
											Product prod = new Product();
											prod.setName(rs.getString("name"));
											prod.setDescription(rs.getString("description"));
											prod.setSerial(rs.getInt("serial"));
											prod.setWeight(rs.getInt("weight"));
											prod.setType(rs.getString("type"));
											prod.setDimensions(rs.getString("dimensions"));
											prod.setMass(rs.getInt("mass"));
											producList2.add(prod);
											}
										}
										rs.close();
									} catch (SQLException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
								}
							}
							else if(!desc.equals("")){
								query += "name = ? and description = ? ;";
								System.out.println(query);
								try {
									prs = conn.prepareStatement(query);
									prs.setString(1, producList.get(i).getName());
									prs.setString(2, desc);
									ResultSet rs = prs.executeQuery();
									while (rs.next()) {
										if(rs.getString("name").equalsIgnoreCase(name) && rs.getString("description").equalsIgnoreCase(desc)  ){
										Product prod = new Product();
										prod.setName(rs.getString("name"));
										prod.setDescription(rs.getString("description"));
										prod.setSerial(rs.getInt("serial"));
										prod.setWeight(rs.getInt("weight"));
										prod.setType(rs.getString("type"));
										prod.setDimensions(rs.getString("dimensions"));
										prod.setMass(rs.getInt("mass"));
										producList2.add(prod);
										}
									}
									rs.close();
								} catch (SQLException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
							}
							else{
								query += "name = ? ;";
								System.out.println(query);
								try {
									prs = conn.prepareStatement(query);
									prs.setString(1, producList.get(i).getName());
									ResultSet rs = prs.executeQuery();
									while (rs.next()) {
										if(rs.getString("name").equalsIgnoreCase(name) ){
										Product prod = new Product();
										prod.setName(rs.getString("name"));
										prod.setDescription(rs.getString("description"));
										prod.setSerial(rs.getInt("serial"));
										prod.setWeight(rs.getInt("weight"));
										prod.setType(rs.getString("type"));
										prod.setDimensions(rs.getString("dimensions"));
										prod.setMass(rs.getInt("mass"));
										producList2.add(prod);
										}
									}
									rs.close();
								} catch (SQLException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
							}
						}
						else if(!serial.equals("")){
							if(!desc.equals("")){
								query += "serial = ? and description = ? ;";
								System.out.println(query);
								try {
									prs = conn.prepareStatement(query);
									prs.setInt(1, producList.get(i).getSerial());
									prs.setString(2, desc);
									ResultSet rs = prs.executeQuery();
									while (rs.next()) {
										if( rs.getInt("serial") == serialP 
												&& rs.getString("description").equalsIgnoreCase(desc)  ){
										Product prod = new Product();
										prod.setName(rs.getString("name"));
										prod.setDescription(rs.getString("description"));
										prod.setSerial(rs.getInt("serial"));
										prod.setWeight(rs.getInt("weight"));
										prod.setType(rs.getString("type"));
										prod.setDimensions(rs.getString("dimensions"));
										prod.setMass(rs.getInt("mass"));
										producList2.add(prod);
										}
									}
									rs.close();
								} catch (SQLException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
							}
							else{
								query += "serial = ? ;";
								System.out.println(query);
								try {
									prs = conn.prepareStatement(query);
									prs.setInt(1, producList.get(i).getSerial());
									ResultSet rs = prs.executeQuery();
									while (rs.next()) {
										if(rs.getInt("serial") == serialP ){
										Product prod = new Product();
										prod.setName(rs.getString("name"));
										prod.setDescription(rs.getString("description"));
										prod.setSerial(rs.getInt("serial"));
										prod.setWeight(rs.getInt("weight"));
										prod.setType(rs.getString("type"));
										prod.setDimensions(rs.getString("dimensions"));
										prod.setMass(rs.getInt("mass"));
										producList2.add(prod);
										}
									}
									rs.close();
								} catch (SQLException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
							}
						}
						else{
							query += "description = ? ;";
							System.out.println(query);
							System.out.println("---> " + desc);
							try {
								prs = conn.prepareStatement(query);
								prs.setString(1, desc);
								ResultSet rs = prs.executeQuery();
								while (rs.next()) {
									if(rs.getString("description").equalsIgnoreCase(desc)  ){
									Product prod = new Product();
									prod.setName(rs.getString("name"));
									prod.setDescription(rs.getString("description"));
									prod.setSerial(rs.getInt("serial"));
									prod.setWeight(rs.getInt("weight"));
									prod.setType(rs.getString("type"));
									prod.setDimensions(rs.getString("dimensions"));
									prod.setMass(rs.getInt("mass"));
									producList2.add(prod);
									}
								}
								rs.close();
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
	            	}
				}
	            if(producList2.size() >=1){
	            	
	            	Map<String, Product> map = new LinkedHashMap<>();
	            	for (Product pro : producList2) {
	            		String check = pro.getName() + String.valueOf(pro.getSerial());	          
	            		map.put(check, pro);
	            	}
	            	producList2.clear();
	            	producList2.addAll(map.values());    
	            	System.out.println("Product list + " + producList2.size());
	            	request.setAttribute("productList", producList2);
	    	        RequestDispatcher view = request.getRequestDispatcher("/admin/productsearch.jsp");
	    	        view.forward(request, response);
	            }
	            else{
	            	RequestDispatcher view = request.getRequestDispatcher("/admin/productNoResults.jsp");
	    	        view.forward(request, response);
	            }
				
				//////////////
			}

		}
	}

}
