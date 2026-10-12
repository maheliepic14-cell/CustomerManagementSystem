package com.customer.customermanagementsystem.dao;

import com.customer.customermanagementsystem.model.User;
import com.customer.customermanagementsystem.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    //check whether an email is already exists
    public boolean emailExists(String email) throws SQLException {

        //SQL query
        String sql = "select 1 from users where email = ?";

        //open database connection
        try(Connection connection = DBConnection.getConnection();
            //Pre-compiles the SQL query template and prepares it for parameter binding
            PreparedStatement statement  = connection.prepareStatement(sql)) {

            //Replace the placeholder
            statement.setString(1, email);

            //Execute SQL query
            ResultSet resultSet = statement.executeQuery();

            //Return if one matching row exists
            return resultSet.next();
        }

    }

    //New user registration
    public void insertUser(User user) throws SQLException {
        String sql = "insert into users(full_name, email, password) values(?,?,?)";

        //open database connection
        try(Connection connection = DBConnection.getConnection();
            //Pre-compiles the SQL query template and prepares it for parameter binding
            PreparedStatement statement = connection.prepareStatement(sql)) {

            //Replace placeholders
            statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());

            //Execute SQL Query
            statement.executeUpdate();

        }

    }

    //Get the users by email address
    public User getUserByEmail(String email) throws SQLException {

        //SQL query to retrieve a user by email
        String sql = "select * from users where email = ?";

        //open database connection
        try (Connection connection = DBConnection.getConnection();
             //Pre-compiles the SQL query template and prepares it for parameter binding
             PreparedStatement statement = connection.prepareStatement(sql)) {

            //Replace placeholders
            statement.setString(1, email);

            //Execute SQL Query
            try (ResultSet resultSet = statement.executeQuery()) {

                //Move to the first row
                if (resultSet.next()) {

                    //Create a User Object
                    User user = new User();

                    user.setUserId(resultSet.getInt("user_id"));
                    user.setFullName(resultSet.getString("full_name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPassword(resultSet.getString("password"));

                    return user;

                }

            }
            return null;
        }
    }

}
