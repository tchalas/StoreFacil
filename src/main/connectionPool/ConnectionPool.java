package connectionPool;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Vector;



 public class ConnectionPool implements Runnable{
    // Number of initial connections to make. 
    private int initialConnectionCount = 5;     
    
    // A list of available connections for use. 
    private static Vector<Connection> availableConnections = new Vector<Connection>(); 
    
    // A list of connections being used currently. 
    private static Vector<Connection> usedConnections = new Vector<Connection>(); 
     
    private static String urlString = null; 
    
    private static String userName = null;     
     
    private static String password = null;     
     
    private Thread cleanupThread = null; 
         
    public ConnectionPool(String url, String user, String passwd){ 

    	try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException | IllegalAccessException
				| ClassNotFoundException e1) {
			e1.printStackTrace();
		}       
    	  
    	urlString = url; 
        userName = user; 
        password = passwd; 

        for(int cnt=0; cnt<initialConnectionCount; cnt++) 
        { 
            // Add a new connection to the available list. 
            try {
				availableConnections.addElement(getConnection());
			} catch (SQLException e) {
				e.printStackTrace();
			} 
        } 
         
        // Create the cleanup thread 
        cleanupThread = new Thread(this); 
        cleanupThread.start();
    }     
     
    private static Connection getConnection() throws SQLException 
    {
        return DriverManager.getConnection(urlString, userName, password); 
    } 
     
    public synchronized static Connection checkout() throws SQLException 
    { 
        Connection newConnxn = null; 
         
        if(availableConnections.size() == 0) {
            // Create one more connection 
             newConnxn = getConnection(); 
            // Add this connection to the "Used" list. 
             usedConnections.addElement(newConnxn);
        } 
        else 
        { 
            // Connections exist ! 
            // Get a connection object 
            newConnxn = (Connection)availableConnections.lastElement(); 
            availableConnections.removeElement(newConnxn); 
            usedConnections.addElement(newConnxn);
        }         
        return newConnxn; 
    } 
     

    public synchronized static void checkin(Connection c) 
    { 
        if(c != null) 
        { 
            // Remove from used list. 
            usedConnections.removeElement(c); 
            // Add to the available list 
            availableConnections.addElement(c);         
        } 
    }             
     
    public int availableCount() 
    { 
        return availableConnections.size(); 
    } 
     
    public void run() 
    { 
        try 
        { 
            while(true) 
            { 
                synchronized(this) 
                { 
                    while(availableConnections.size() > initialConnectionCount) 
                    { 
                        // Clean up 
                        Connection c = (Connection)availableConnections.lastElement(); 
                        availableConnections.removeElement(c); 
                        c.close(); 
                    } 
                     
                } 

                 
                //Sleep 1 minute  
                Thread.sleep(60000 * 1); 
            }     
        } 
        catch(SQLException sqle) 
        { 
            sqle.printStackTrace(); 
        } 
        catch(Exception e) 
        { 
            e.printStackTrace(); 
        } 
    }
    
}
