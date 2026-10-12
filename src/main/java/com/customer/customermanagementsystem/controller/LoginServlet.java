package com.customer.customermanagementsystem.controller;

import com.customer.customermanagementsystem.model.User;
import com.customer.customermanagementsystem.service.UserService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.customer.customermanagementsystem.validation.UserValidator;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//
//        User loginValidationUser  = new User();
//
//        loginValidationUser.setEmail(email);
//        loginValidationUser.setPassword(password);

        User loginValidationUser = new User(request.getParameter("email"), request.getParameter("password"));

        //User loginValidationUser = new User();

        //loginValidationUser.setEmail(request.getParameter("email"));
        //loginValidationUser.setPassword(request.getParameter("password"));


        Map<String, String> errors = UserValidator.validateLogin(loginValidationUser);

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

        User user = userService.loginUser(request.getParameter("email"), request.getParameter("password"));
        //User user = userService.loginUser();

        if (user != null){

            //create a session
            HttpSession session = request.getSession();

            //save the verified user inside the session
            session.setAttribute("loggedInUser", user);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Map<String, Object> data = new HashMap<>();

            data.put("success", true);
            data.put("message", "Welcome, " + user.getFullName() + "!");

            Gson gson = new Gson();

            response.getWriter().write(gson.toJson(data));

        } else {
            //request.setAttribute("message", "Login Failed. Invalid email or password");
            //request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Map<String, Object> data = new HashMap<>();

            data.put("success", false);
            data.put("message", "Login Failed. Invalid email or password");

            Gson gson = new Gson();

            response.getWriter().write(gson.toJson(data));


        }

    }
}