package com.customer.customermanagementsystem.util;

import java.sql.Connection;

public class DBConnectionTest {
    public static void main(String[] args) {
        try {
            Connection connection = DBConnection.getConnection();

            if (connection != null) {
                System.out.println("Connection successful");
            }

        }catch (Exception e){
            System.out.println("Connection failed");
            e.printStackTrace();
        }
    }
}
