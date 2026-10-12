package com.customer.customermanagementsystem.controller;

import com.customer.customermanagementsystem.model.Customer;
import com.customer.customermanagementsystem.service.CustomerService;
import com.customer.customermanagementsystem.websocket.NotificationEndpoint;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.customer.customermanagementsystem.validation.CustomerValidator;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/customers")
//Required to parse multipart/form-data requests
@MultipartConfig
public class CustomerServlet extends HttpServlet {

    private CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Setting the Default Page
        int currentPage = 1;
        String pageParam = request.getParameter("page");

        if (pageParam != null && !pageParam.isEmpty()) {
            currentPage = Integer.parseInt(pageParam);
        }

        //Sets limit on how many customer records want to display
        int pageSize = 5;

        //Calculate how many records to skip
        int offset = (currentPage - 1) * pageSize;

        //Read search keyword from URL.
        String keyword = request.getParameter("keyword");

        //create list variable
        List<Customer> customers;

        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                customers = customerService.searchCustomerByPage(keyword, offset, pageSize);

                int totalCustomers = customerService.getSearchCustomerCount(keyword);

                //divide total rows by page limit and round the decimal upward to the nearest whole integer
                int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("keyword", keyword);

            } else {

                customers = customerService.getCustomerByPage(offset, pageSize);

                //Calculating the Total Pages
                int totalCustomers = customerService.getCustomerCount();

                //divide total rows by page limit and round the decimal upward to the nearest whole integer
                int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);

                //customers = customerService.getAllCustomers();
            }

            request.setAttribute("customers", customers);

            request.getRequestDispatcher("/WEB-INF/views/customer-list.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }

        //System.out.println("REAL PATH = " + getServletContext().getRealPath("/"));

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Reads clientId
        String senderClientId = request.getParameter("clientId");

        //Reads customer ID
        String customerIdParam = request.getParameter("customerId");

        //creates a variable and initialized to 0
        int customerId = 0;

        if (customerIdParam != null && !customerIdParam.isEmpty()) {
            customerId = Integer.parseInt(customerIdParam);
        }

        //Read All Form Fields
        String name = request.getParameter("name");
        String city = request.getParameter("city");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        //Read the image itself(Image file)
        Part imagePart = request.getPart("image");

        //File path
        String imagePath = null;

        if (imagePart != null && imagePart.getSize() > 0) {

            //If updating
            Customer existingCustomer = null;

            if (customerId > 0) {
                existingCustomer = customerService.getCustomerById(customerId);
            }

            //Get the original file name
            String fileName = imagePart.getSubmittedFileName();

            //Creating a unique file name
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

            //Upload image path
            String uploadPath = "D:/CustomerUploads";

            //create a file object
            File uploadDir = new File(uploadPath);

            //check if the folder exists
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File destination = new File(uploadDir, uniqueFileName);

            //save the uploaded image
            imagePart.write(destination.getAbsolutePath());

            //tempory
            //System.out.println("PARENT EXISTS = " + uploadDir.exists());
            //System.out.println("PARENT PATH = " + uploadDir.getAbsolutePath());

            //File[] files = uploadDir.listFiles();

            //if (files != null) {
            //for (File file : files) {
            //System.out.println("FILE IN UPLOAD DIR = " + file.getName());
            //}
            //}

            //File savedFile = new File(uploadPath, uniqueFileName);

            //save the file name to the database

            imagePath = uniqueFileName;

            if (existingCustomer != null && existingCustomer.getImagePath() != null && !existingCustomer.getImagePath().isEmpty()) {

                File oldImage = new File("D:/CustomerUploads", existingCustomer.getImagePath());

                if (oldImage.exists()) {
                    oldImage.delete();
                }
            }
        }

        //Keep existing image during update
        if (customerId > 0 && imagePath == null) {

            //Get the customer details from the Database
            Customer existingCustomer = customerService.getCustomerById(customerId);
            ;

            if (existingCustomer != null) {

                imagePath = existingCustomer.getImagePath();

            }
        }

        //create new customer object
        Customer customer = new Customer();

        customer.setCustomerId(customerId);
        customer.setName(name);
        customer.setCity(city);
        customer.setAddress(address);
        customer.setPhone(phone);
        customer.setEmail(email);
        customer.setImagePath(imagePath);

        //Validation
        Map<String, String> errors = CustomerValidator.validate(customer, imagePart);

        if (!errors.isEmpty()) {

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();

            Map<String, Object> data = new HashMap<>();

            data.put("success", false);
            data.put("errors", errors);

            response.getWriter().write(gson.toJson(data));

            return;

            //request.setAttribute("errors", errors);
            //request.setAttribute("customer", customer);
            //request.getRequestDispatcher("/WEB-INF/views/customer-form.jsp").forward(request, response);
            //return;
        }

        String message;

        if (customer.getCustomerId() > 0) {
            message = customerService.updateCustomer(customer);

        } else {
            message = customerService.addCustomer(customer);
        }

        if ("Customer added successfully".equals(message)) {
            NotificationEndpoint.broadcast("Customer added " + customer.getName(), senderClientId);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\":true,\"message\":\"Customer added successfully\"}");

            //request.getSession().setAttribute("success", message);
            //response.sendRedirect(request.getContextPath() + "/customers");

        } else if ("Customer updated successfully".equals(message)) {
            NotificationEndpoint.broadcast("Customer updated " + customer.getName(), senderClientId);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();

            Map<String, Object> data = new HashMap<>();

            data.put("success", true);
            data.put("message", "Customer updated successfully");
            data.put("customer", customer);

            response.getWriter().write(gson.toJson(data));


            //request.getSession().setAttribute("success", message);
            //response.sendRedirect(request.getContextPath() + "/customers");

        } else {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();

            Map<String, Object> data = new HashMap<>();

            data.put("success", false);
            data.put("message", message);

            response.getWriter().write(gson.toJson(data));


            //request.setAttribute("message", message);
            //request.setAttribute("customer", customer);
            //request.getRequestDispatcher("/WEB-INF/views/customer-form.jsp").forward(request, response);
        }


    }
}