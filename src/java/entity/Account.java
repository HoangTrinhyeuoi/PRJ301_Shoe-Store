/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */
public class Account {
       
    int Customers_ID;
    String User_name;
    String Password;
    String Email;
    String Full_name;
    String Address;
    String Phone;

    public Account(int Customers_ID, String User_name, String Password, String Email, String Full_name, String Address, String Phone) {
        this.Customers_ID = Customers_ID;
        this.User_name = User_name;
        this.Password = Password;
        this.Email = Email;
        this.Full_name = Full_name;
        this.Address = Address;
        this.Phone = Phone;
    }

    @Override
    public String toString() {
        return "Account{" + "Customers_ID=" + Customers_ID + ", User_name=" + User_name + ", Password=" + Password + ", Email=" + Email + ", Full_name=" + Full_name + ", Address=" + Address + ", Phone=" + Phone + '}';
    }
    
    
    
    public int getCustomers_ID() {
        return Customers_ID;
    }

    public void setCustomers_ID(int Customers_ID) {
        this.Customers_ID = Customers_ID;
    }

    public String getUser_name() {
        return User_name;
    }

    public void setUser_name(String User_name) {
        this.User_name = User_name;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getFull_name() {
        return Full_name;
    }

    public void setFull_name(String Full_name) {
        this.Full_name = Full_name;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }
    
    
}
