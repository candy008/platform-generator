package com.platform.generator.base;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BaseDao {

	public static String DB_URL = "jdbc:mysql://127.0.0.1/permit"; 
	public static String DB_DRIVER = "com.mysql.jdbc.Driver"; 
	public static String DB_USERNAME = "permit"; 
	public static String DB_PASSWORD = "1234"; 
    
	  static { 
	        try { 
	            Class.forName(DB_DRIVER); 
	        } catch (ClassNotFoundException e) { 
	            e.printStackTrace(); 
	        } 
	    } 
	
    private static Connection conn;
    public static Connection getConnection() { 
        try { 
            conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD); 
        } catch (Exception ex) { 
            ex.printStackTrace();
        } 
        return conn; 
    } 

    
    public static void close(ResultSet rs,Connection conn,Statement sta) { 
        if (rs != null) { 
            try { 
                rs.close(); 
            } catch (SQLException e) { 
                e.printStackTrace(); 
            } 
        } 
        
        if (conn != null) { 
            try { 
                conn.close(); 
            } catch (SQLException e) { 
                e.printStackTrace(); 
            } 
        }
        
        if (sta != null) { 
            try { 
                sta.close(); 
            } catch (SQLException e) { 
                e.printStackTrace(); 
            } 
        } 
        
    } 
    
    
    public static void main(String[] args) {
		conn = getConnection();
		
		try {
			DatabaseMetaData data = conn.getMetaData();
			ResultSet rs = data.getTables("permit", null, "%", null);
			while (rs.next()) {
				String tableName = rs.getString("TABLE_NAME");
				ResultSet rss = data.getColumns(null, null, tableName.trim().toUpperCase(),null);
				while (rss.next()) {
					String s = rss.getString("COLUMN_NAME");
					String ss = rss.getString("REMARKS");
					System.out.println(s);
					System.out.println(ss);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println(conn);
	}
    
}
