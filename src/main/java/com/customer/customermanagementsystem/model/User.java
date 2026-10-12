package com.customer.customermanagementsystem.model;

public class User {

    private int userId;
    private String fullName;
    private String email;
    private String password;

    public User() {

    }

    public User(int userId, String fullName, String email, String password){
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }

    public User(String email, String password){
        this.email = email;
        this.password = password;
    }

    public int getUserId(){
        return userId;
    }

    public String getFullName(){
        return fullName;
    }

    public String getEmail(){
        return email;
    }

    public String getPassword(){
        return password;
    }

    public void setUserId(int userId){
        this.userId = userId;
    }

    public void setFullName(String fullName){
        this.fullName = fullName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
