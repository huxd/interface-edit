package JavaBean;
import java.sql.*;
public class ConnectDb {
    private Connection con;
    public ConnectDb() {
	    try {
	        Class.forName("com.mysql.jdbc.Driver").newInstance();
		    con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
		}
		catch(Exception e) {
		    con = null;
		}
	}
	public Connection getConnection() {
	    return con;
	}
}
