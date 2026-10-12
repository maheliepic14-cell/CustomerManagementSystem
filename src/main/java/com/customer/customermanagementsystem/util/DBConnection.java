package com.customer.customermanagementsystem.util;

import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/customer_management_system";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static Connection getConnection() throws SQLException {

        try{
            //Load the mysql jdbc driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e){
            throw new SQLException("Driver not found", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

}
