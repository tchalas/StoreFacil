package servlets.admin.products;

import java.util.ArrayList;
import java.util.List;

public class ProductWarehouseCapacity {

	
	private String name;
	private int capacity;
	private static List<ProductWarehouseCapacity> globalListWarehouses = new ArrayList<ProductWarehouseCapacity>();	
	public ProductWarehouseCapacity(String name, int capacity){
		this.name = name;
		this.capacity = capacity;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public int getCapacity() {
		return capacity;
	}
	
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	
	public static void addWarehouseToList(String name , int capacity){
		
		ProductWarehouseCapacity ware = new ProductWarehouseCapacity(name , capacity);
		globalListWarehouses.add(ware);
	}
	
	public static void clearWarehouseToList(){
		
		globalListWarehouses = new ArrayList<ProductWarehouseCapacity>();
		
	}
	
	public static boolean sizeWarehouseToList(){
		
		if( globalListWarehouses!=null && globalListWarehouses.size() >= 1 )
			return true;
		else
			return false;

	}
	
	public static List<ProductWarehouseCapacity> getWarehouseToList(){
	
		return globalListWarehouses;

	}


}
