package com.customer.customermanagementsystem.dao;

import com.customer.customermanagementsystem.model.Customer;
import com.customer.customermanagementsystem.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    public void addCustomer(Customer customer) throws SQLException {

        String sql = "insert into customers(name, city, address, phone, email, image_path) values(?,?,?,?,?,?)";

        try (Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, customer.getName());
            statement.setString(2, customer.getCity());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getPhone());
            statement.setString(5, customer.getEmail());
            statement.setString(6, customer.getImagePath());

            statement.executeUpdate();

        }
    }

    public List<Customer> getAllCustomers() throws SQLException{

        List<Customer> customers = new ArrayList<>();

        String sql = "select * from customers";

        try (Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Customer customer = new Customer();

                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setCity(resultSet.getString("city"));
                customer.setAddress(resultSet.getString("address"));
                customer.setPhone(resultSet.getString("phone"));
                customer.setEmail(resultSet.getString("email"));
                customer.setImagePath(resultSet.getString("image_path"));

                customers.add(customer);

            }

        }
        return customers;

    }

    public Customer getCustomerById(Integer customerId) throws SQLException{

        String sql = "select * from customers where customer_id = ?";

        try (Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, customerId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Customer customer = new Customer();

                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setCity(resultSet.getString("city"));
                customer.setAddress(resultSet.getString("address"));
                customer.setPhone(resultSet.getString("phone"));
                customer.setEmail(resultSet.getString("email"));
                customer.setImagePath(resultSet.getString("image_path"));

                return customer;
            }
            return null;
        }

    }

    public List<Customer> getCustomersByPage(int offset, int limit) throws SQLException{

        List<Customer> customers = new ArrayList<>();

        String sql = "select * from customers limit ? offset ?";

        try (Connection connection = DBConnection.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, limit);
            statement.setInt(2, offset);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setCity(resultSet.getString("city"));
                customer.setAddress(resultSet.getString("address"));
                customer.setPhone(resultSet.getString("phone"));
                customer.setEmail(resultSet.getString("email"));
                customer.setImagePath(resultSet.getString("image_path"));

                customers.add(customer);
            }
        }
        return customers;
    }

    public int getCustomerCount() throws SQLException{
        String sql = "select count(*) from customers";

        try (Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql)) {

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        }
        return 0;
    }

    public void updateCustomer(Customer customer) throws SQLException{
        String sql = "update customers set name = ?, city = ?, address = ?, phone = ?, email = ?, image_path = ? where customer_id = ?";

        try (Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, customer.getName());
            statement.setString(2, customer.getCity());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getPhone());
            statement.setString(5, customer.getEmail());
            statement.setString(6, customer.getImagePath());
            statement.setInt(7, customer.getCustomerId());

            statement.executeUpdate();

        }
    }

    public void deleteCustomer(Integer customerId) throws SQLException{

        String sql = "delete from customers where customer_id = ?";

        try (Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, customerId);
            statement.executeUpdate();

        }

    }

    public List<Customer> searchCustomers(String keyword) throws SQLException{

        List<Customer> customers = new ArrayList<>();

        String sql = "select * from customers where name like ? or city like ? or email like ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            //build the search string
            String search = "%" + keyword + "%";

            statement.setString(1, search);
            statement.setString(2, search);
            statement.setString(3, search);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                Customer customer = new Customer();

                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setCity(resultSet.getString("city"));
                customer.setAddress(resultSet.getString("address"));
                customer.setPhone(resultSet.getString("phone"));
                customer.setEmail(resultSet.getString("email"));
                customer.setImagePath(resultSet.getString("image_path"));

                customers.add(customer);

            }return customers;
        }

    }

    public List<Customer> searchCustomersByPage(String keyword, int offset, int limit) throws SQLException{
        List<Customer> customers = new ArrayList<>();

        //compare the actual bytes of the text
        String sql = "select * from customers " + "where binary name like ? " + "or binary city like ? " + "or binary email like ? " + "limit ? offset ?";

        try (Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql)) {

            String search = "%" + keyword + "%";

            statement.setString(1, search);
            statement.setString(2, search);
            statement.setString(3, search);
            statement.setInt(4, limit);
            statement.setInt(5, offset);

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Customer customer = new Customer();

                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setCity(resultSet.getString("city"));
                customer.setAddress(resultSet.getString("address"));
                customer.setPhone(resultSet.getString("phone"));
                customer.setEmail(resultSet.getString("email"));
                customer.setImagePath(resultSet.getString("image_path"));

                customers.add(customer);
            }
        }
        return customers;
    }

    public int getSearchCustomerCount(String keyword) throws SQLException{

        //compare the actual bytes of the text
        String sql = "select count(*) " + "from customers " + "where binary name like ? " + "or binary city like ? " + "or binary email like ?";

        try (Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql)) {

            String search = "%" + keyword + "%";

            statement.setString(1, search);
            statement.setString(2, search);
            statement.setString(3, search);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 0;
        }

    }

    public boolean emailExists(String email) throws SQLException {

        String sql = "select count(*) from customers where email = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        }

        return false;
    }
}