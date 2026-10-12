package com.customer.customermanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/customer-form")
public class CustomerFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        //Find customer-form.jsp and transfers the request and response to the JSP.
        request.getRequestDispatcher("/WEB-INF/views/customer-form.jsp").forward(request, response);
    }
}
