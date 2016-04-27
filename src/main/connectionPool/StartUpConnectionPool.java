package connectionPool;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class StartUpConnectionPool {

	private static String ip,username,password,database;
	private static int port;
	public static String tableName;
	
	
	public static void main(String[] a){
		
		InputStream is = StartUpConnectionPool.class.getClassLoader().getResourceAsStream("resources/db.properties");
        Properties prop = new Properties();
        try {
			prop.load(is);
		
	        ip = prop.getProperty("ip");
	        port = Integer.parseInt(prop.getProperty("port"));
	        database = prop.getProperty("database");
	        username = prop.getProperty("username");
	        if(prop.getProperty("password").equalsIgnoreCase("none"))
	        	password = "";
	        else
	        	password = prop.getProperty("password");
	        
	        tableName = prop.getProperty("tableName");
	       
	        
	        String url = "jdbc:mysql://"+ip+":"+port+"/"+database+"?autoReconnect=true";
	              
	        new ConnectionPool(url, username, password);
	        
        }catch(IOException e){
        	e.printStackTrace();
        }
	}
	
	
	
	
}
