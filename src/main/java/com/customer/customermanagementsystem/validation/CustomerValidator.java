package com.customer.customermanagementsystem.validation;

import com.customer.customermanagementsystem.model.Customer;
import jakarta.servlet.http.Part;

import java.util.HashMap;
import java.util.Map;

public class CustomerValidator {

    public static Map<String, String> validate(Customer customer, Part imagePart) {

        Map<String, String> errors = new HashMap<>();

        //Name validation
        if (customer.getName() == null || customer.getName().trim().isEmpty()){
            errors.put("name", "Customer name is required");
        } else if (customer.getName().length() < 2) {
            errors.put("name", "Customer name must be at least 2 characters");
        } else if (customer.getName().length() > 100) {
            errors.put("name", "Customer name is longer than 100 characters");
        }

        //City validation
        if (customer.getCity() == null || customer.getCity().trim().isEmpty()){
            errors.put("city", "Customer city is required");
        }else if (customer.getCity().length() < 2) {
            errors.put("city", "Customer city name must be at least 2 characters");
        }

        //Address validation
        if (customer.getAddress() == null || customer.getAddress().trim().isEmpty()){
            errors.put("address", "Customer address is required");
        } else if (customer.getAddress().length() <5) {
            errors.put("address", "Customer address must be at least 5 characters");
        }

        //Phone number validation
        if (customer.getPhone() == null || customer.getPhone().trim().isEmpty()){
            errors.put("phone", "Customer phone is required");
        } else if (!customer.getPhone().trim().matches("\\d{10}")){
            errors.put("phone", "Customer phone number must be 10 digits");
        }

        //Email address validation
        if (customer.getEmail() == null || customer.getEmail().trim().isEmpty()){
            errors.put("email", "Customer email is required");
        } else if (customer.getEmail().trim().length() > 100) {
            errors.put("email", "Customer email is longer than 100 characters");
        } else if (!customer.getEmail().trim().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            errors.put("email", "Customer email format is invalid");
        }

        //Image validation
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = imagePart.getSubmittedFileName();
             String lowerFileName = fileName.toLowerCase();

             if (!(lowerFileName.endsWith(".jpg") || lowerFileName.endsWith(".jpeg") || lowerFileName.endsWith(".png") || lowerFileName.endsWith(".gif") || lowerFileName.endsWith(".bmp"))) {
                 errors.put("image", "Only JPG, JPEG, PNG, GIF or WEBP images are allowed");
             }

             long maxSize = 2 * 1024 * 1024;
             if (imagePart.getSize() > maxSize){
                 errors.put("image","Image size must be less than 2MB");
             }

        }

        return errors;
    }
}