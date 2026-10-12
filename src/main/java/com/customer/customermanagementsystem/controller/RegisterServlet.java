package com.customer.customermanagementsystem.controller;

import com.customer.customermanagementsystem.model.User;
import com.customer.customermanagementsystem.service.UserService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.customer.customermanagementsystem.validation.UserValidator;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    //create userService object
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //forward the request to register.jsp file
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Read submitted values
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //Create user object
        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);

        //Validation
        Map<String, String > errors = UserValidator.validate(user);

/*        if (!errors.isEmpty()){
            request.setAttribute("errors", errors);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }*/

        if (!errors.isEmpty()) {

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Map<String, Object> data = new HashMap<>();

            data.put("success", false);
            data.put("errors", errors);

            Gson gson = new Gson();

            response.getWriter().write(gson.toJson(data));

            return;
        }

        //call service layer
        String message = userService.registerUser(user);

        //Redirect user to login page if registration succeeded

//        if ("User registered successfully".equals(message)){
//
//            request.getSession().setAttribute("success", "Account created successfully. Please login.");
//            response.sendRedirect(request.getContextPath() + "/login");

        if ("User registered successfully".equals(message)) {

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Map<String, Object> data = new HashMap<>();

            data.put("success", true);
            data.put("message", "Account created successfully. Please login.");

            Gson gson = new Gson();

            response.getWriter().write(gson.toJson(data));

        }else {

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Map<String, Object> data = new HashMap<>();

            data.put("success", false);
            data.put("message", message);

            Gson gson = new Gson();

            response.getWriter().write(gson.toJson(data));

        }


    }

}

