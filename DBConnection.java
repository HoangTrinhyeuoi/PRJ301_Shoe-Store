/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:sqlserver://DESKTOP-AHIMF2G\\SQLEXPRESS;databaseName=ShoeStore;encrypt=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "123";
    
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Load SQL Server JDBC Driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        
        // Kết nối database
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
