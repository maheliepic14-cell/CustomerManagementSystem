package com.customer.customermanagementsystem.controller;

import com.customer.customermanagementsystem.model.Customer;
import com.customer.customermanagementsystem.service.CustomerService;
import com.customer.customermanagementsystem.websocket.NotificationEndpoint;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/delete-customer")

public class DeleteCustomerServlet extends HttpServlet {

    private CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("id"));

        String senderClientId = request.getParameter("clientId");

        //fetch customer name before deleting

        Customer customer = customerService.getCustomerById(customerId);

        String customerName = "";

        if (customer != null) {
            customerName = customer.getName();
        }

        String message = customerService.deleteCustomer(customerId);

        if ("Customer deleted successfully".equals(message)) {
            NotificationEndpoint.broadcast("Customer deleted " + customerName, senderClientId);
        }

        response.setContentType("application/json");

        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();

        Map<String, Object> data = new HashMap<>();

        if ("Customer deleted successfully".equals(message)) {

            data.put("success", true);
            data.put("message", message);

        } else {

            data.put("success", false);
            data.put("message", message);
        }

        //converts the Java object into a JSON string and send json to browser
        response.getWriter().write(gson.toJson(data));



        //request.getSession().setAttribute("success", message);

        //response.sendRedirect(request.getContextPath() + "/customers");

    }
}