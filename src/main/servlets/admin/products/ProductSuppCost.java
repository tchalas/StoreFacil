package servlets.admin.products;

import java.util.ArrayList;
import java.util.List;

public class ProductSuppCost {
	
	private String name;
	private Float cost;
	private static List<ProductSuppCost> globalListSuppliers = new ArrayList<ProductSuppCost>();	
	public ProductSuppCost(String name, Float cost){
		this.name = name;
		this.cost = cost;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Float getCost() {
		return cost;
	}

	public void setCost(Float cost) {
		this.cost = cost;
	}
	
	
	public static void addSupplierToList(String name , Float cost){
		
		ProductSuppCost supp = new ProductSuppCost(name , cost);
		globalListSuppliers.add(supp);
	}
	
	public static void clearSupplierToList(){
		
		globalListSuppliers = new ArrayList<ProductSuppCost>();
		
	}
	
	public static boolean sizeSupplierToList(){
		
		if( globalListSuppliers!=null && globalListSuppliers.size() >= 1 )
			return true;
		else
			return false;

	}
	
public static List<ProductSuppCost> getSupplierToList(){
	
		return globalListSuppliers;

	}
	

}
