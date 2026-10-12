package com.customer.customermanagementsystem.controller;

import com.customer.customermanagementsystem.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/check-customer-email")
public class CheckCustomerEmailServlet extends HttpServlet {

    private CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");

        boolean exists = customerService.emailExists(email);

        response.setContentType("text/plain");

        if (exists) {
            response.getWriter().write("exists");
        } else {
            response.getWriter().write("available");
        }

    }

}
