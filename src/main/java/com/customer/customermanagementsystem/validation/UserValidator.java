package com.customer.customermanagementsystem.validation;

import com.customer.customermanagementsystem.model.User;

import java.util.HashMap;
import java.util.Map;

public class UserValidator {

    public static Map<String, String> validate(User user){

        Map<String, String> errors = new HashMap<String, String>();

        // Full name validation
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            errors.put("fullName", "Full name is required");
        } else if (user.getFullName().trim().length() < 2) {
            errors.put("fullName", "Full name must be at least 2 characters");
        }


        //Email address validation
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()){
            errors.put("email", "Email is required");
        } else if (user.getEmail().trim().length() > 100) {
            errors.put("email", "Email is longer than 100 characters");
        } else if (!user.getEmail().trim().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            errors.put("email", "Email format is invalid");
        }


        //Password validation
        if (user.getPassword() == null|| user.getPassword().trim().isEmpty()){
            errors.put("password", "Password is required");
        } else if (user.getPassword().length()<8){
            errors.put("password", "Password must be at least 8 characters");
        }

        return errors;

    }

    public static Map<String, String> validateLogin(User user){

        Map<String, String> errors = new HashMap<String, String>();

        //Email address validation
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()){
            errors.put("email", "Email is required");
        } else if (!user.getEmail().trim().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            errors.put("email", "Email format is invalid");
        }

        //Password validation
        if (user.getPassword() == null|| user.getPassword().trim().isEmpty()){
            errors.put("password", "Password is required");
        }
        return errors;
    }
}
