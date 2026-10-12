package com.customer.customermanagementsystem.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    //Convert plain password into BCrypt hash
    public static String hashPassword(String password){
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    //Compare entered password with stored hash password
    public static boolean verifyPassword(String password, String hashedPassword){
        return BCrypt.checkpw(password, hashedPassword);
    }

}
