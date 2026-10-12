package com.customer.customermanagementsystem.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

//@WebFilter("/customers")
//Filter protects these urls
@WebFilter(urlPatterns = {"/customers", "/edit-customer", "/delete-customer"})
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        //Convert request into an HttpServletRequest
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        //Convert response into an HttpServletResponse
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        //Get existing session
        HttpSession session = httpRequest.getSession(false);

        //Check the login
        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;

        //Push the request forward to the next step in the chain if user logged in
        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");

        }

    }

}
