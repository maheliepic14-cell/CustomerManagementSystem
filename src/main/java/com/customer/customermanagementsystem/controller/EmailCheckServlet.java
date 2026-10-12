package com.customer.customermanagementsystem.controller;

import com.customer.customermanagementsystem.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/check-email")
public class EmailCheckServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");

        boolean exists = false;

        try {
            exists = userDAO.emailExists(email);
        }catch (Exception e){
            e.printStackTrace();
        }

        response.setContentType("text/plain");

        //send text data back to the user's web browser
        response.getWriter().write(exists ? "exists" : "available");

    }
}
