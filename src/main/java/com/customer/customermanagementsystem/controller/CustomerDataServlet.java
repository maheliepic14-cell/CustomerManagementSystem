package com.customer.customermanagementsystem.controller;

import com.customer.customermanagementsystem.model.Customer;
import com.customer.customermanagementsystem.service.CustomerService;
import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/customers-data")
public class CustomerDataServlet extends HttpServlet {

    private CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int page = 1;

        String pageParam = request.getParameter("page");

        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        int pageSize = 5;
        int offset = (page - 1) * pageSize;

        String keyword = request.getParameter("keyword");

        List<Customer> customers;

        int totalCustomers;

        //check if a keyword was entered
        if (keyword != null && !keyword.trim().isEmpty()) {

            customers = customerService.searchCustomerByPage(keyword, offset, pageSize);

            totalCustomers = customerService.getSearchCustomerCount(keyword);

        }
        else {

            //Get normal customers with pagination
            customers = customerService.getCustomerByPage(offset, pageSize);

            //get the total number of customers
            totalCustomers = customerService.getCustomerCount();
        }

        int totalPages = (int) Math.ceil((double) totalCustomers/pageSize);

        Map<String, Object> data = new HashMap<>();

        data.put("customers", customers);
        data.put("currentPage", page);
        data.put("totalPages", totalPages);

        Gson gson = new Gson();

        //tell the browser the data i'm sending is json
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        //Send json to the browser
        response.getWriter().write(gson.toJson(data));


    }
}