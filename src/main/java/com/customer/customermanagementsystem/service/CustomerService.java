package com.customer.customermanagementsystem.service;

import com.customer.customermanagementsystem.model.Customer;
import com.customer.customermanagementsystem.dao.CustomerDAO;

import java.io.File;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {

    private CustomerDAO customerDAO = new CustomerDAO();

    public String addCustomer(Customer customer) {

        try {
            customerDAO.addCustomer(customer);
            return "Customer added successfully";
        }catch (SQLIntegrityConstraintViolationException e){
            return "Email already exists";
        }catch (Exception e){
            e.printStackTrace();
            return "Unable to add customer. Please try again.";
        }

    }

    public List<Customer> getAllCustomers() {

        try {
            return customerDAO.getAllCustomers();
        }catch (Exception e){
            e.printStackTrace();
            return new ArrayList<>();
        }

    }

    //Get customer by id
    public Customer getCustomerById(int customerId) {

        try {
            return customerDAO.getCustomerById(customerId);

        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    //Get customers by page
    public List<Customer> getCustomerByPage(int offset, int limit) {
        try {
            return customerDAO.getCustomersByPage(offset, limit);
        } catch (Exception e){
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    //Get total customer count
    public int getCustomerCount() {
        try {
            return customerDAO.getCustomerCount();
        }catch (Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    public String updateCustomer(Customer customer) {

        try {

            Customer existingCustomer = getCustomerById(customer.getCustomerId());

            if (existingCustomer == null) {
                return "Customer not found";
            }

            if (
                    existingCustomer.getName().equals(customer.getName())
                            && existingCustomer.getCity().equals(customer.getCity())
                            && existingCustomer.getAddress().equals(customer.getAddress())
                            && existingCustomer.getPhone().equals(customer.getPhone())
                            && existingCustomer.getEmail().equals(customer.getEmail())
                    && java.util.Objects.equals(existingCustomer.getImagePath(), customer.getImagePath())

            )
            {
                return "No changes made";
            }

            customerDAO.updateCustomer(customer);

            return "Customer updated successfully";

        }catch (SQLIntegrityConstraintViolationException e){
            return "Email already exists";
        }catch (Exception e){
            e.printStackTrace();
            return "Unable to add customer. Please try again.";
        }
    }

    public String deleteCustomer(int customerId) {
        try {
            Customer customer = getCustomerById(customerId);
            String imagePath = customer.getImagePath();

            if (customer == null) {
                return "Customer not found";
            }

            if (imagePath != null && !imagePath.isEmpty()) {
                File imageFile = new File("D:/CustomerUploads/" + imagePath);

                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }

            customerDAO.deleteCustomer(customerId);

            return "Customer deleted successfully";

        } catch (Exception e) {
            e.printStackTrace();
            return "Customer not deleted";
        }
    }

    //public List<Customer> searchCustomers(String keyword) {
        //try {
            //return customerDAO.searchCustomers(keyword);
        //}catch (Exception e){
            //throw new RuntimeException(e);
        //}
    //}

    public List<Customer> searchCustomerByPage(String keyword, int offset, int limit) {

        try {
            return customerDAO.searchCustomersByPage(keyword, offset, limit);
        } catch (Exception e){
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public int getSearchCustomerCount(String keyword) {
        try {
            return customerDAO.getSearchCustomerCount(keyword);
        }catch (Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    public boolean emailExists(String email) {

        try {
            return customerDAO.emailExists(email);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }
}