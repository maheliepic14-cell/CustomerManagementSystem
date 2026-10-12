package com.customer.customermanagementsystem.model;

public class Customer {

    private int customerId;
    private String name;
    private String city;
    private String address;
    private String phone;
    private String email;
    private String imagePath;

    public Customer(){

    }

    public Customer(int customerId, String name, String city, String address, String phone, String email, String imagePath) {
        this.customerId = customerId;
        this.name = name;
        this.city = city;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.imagePath = imagePath;
    }

    public int getCustomerId() {
        return customerId;
    }

    public String getName() {
        return name;
    }

    public String getCity() {
        return city;
    }

    public String getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
