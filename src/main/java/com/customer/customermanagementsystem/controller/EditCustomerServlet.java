package com.customer.customermanagementsystem.controller;

import com.customer.customermanagementsystem.model.Customer;
import com.customer.customermanagementsystem.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/edit-customer")
public class EditCustomerServlet extends HttpServlet {

    private CustomerService customerService = new CustomerService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("id"));

        //call the service
        Customer customer = customerService.getCustomerById(customerId);
        request.setAttribute("customer", customer);

        //Forward to customer-form.jsp
        request.getRequestDispatcher("/WEB-INF/views/customer-form.jsp").forward(request, response);

    }

}
