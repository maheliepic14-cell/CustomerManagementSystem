package com.customer.customermanagementsystem.service;

import com.customer.customermanagementsystem.model.User;
import com.customer.customermanagementsystem.dao.UserDAO;
import com.customer.customermanagementsystem.util.PasswordUtil;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public String registerUser(User user){

        try {
            //check whether user already exist in the database
            if (userDAO.emailExists(user.getEmail())){
                return "Email already exists";
            }

            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());

            user.setPassword(hashedPassword);

            //Add the user to the database
            userDAO.insertUser(user);

            //Registration successfull
            return "User registered successfully";

        } catch (Exception e) {
            e.printStackTrace();
            return "Registration failed";
        }

    }

    public User loginUser(String email, String password){

        try {

            //Find user using user's email
            User user = userDAO.getUserByEmail(email);

            //Email not found
            if (user == null){
                return null;
            }

            //Verify entered password
            if (PasswordUtil.verifyPassword(password, user.getPassword())){
                return user;
            }
            return null;

        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

}