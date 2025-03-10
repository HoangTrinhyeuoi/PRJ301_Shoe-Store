/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */
public class Product {
    int Product_ID;
    String Product_Name;
    int Price;
    int Stock_quanitity;
    int Category_ID;
    int Brand_ID;
    String img_url;

    public Product(int Product_ID, String Product_Name, int Price, int Stock_quanitity, int Category_ID, int Brand_ID, String img_url) {
        this.Product_ID = Product_ID;
        this.Product_Name = Product_Name;
        this.Price = Price;
        this.Stock_quanitity = Stock_quanitity;
        this.Category_ID = Category_ID;
        this.Brand_ID = Brand_ID;
        this.img_url = img_url;
    }
    
    
    
    
    public int getProduct_ID() {
        return Product_ID;
    }

    public void setProduct_ID(int Product_ID) {
        this.Product_ID = Product_ID;
    }

    public String getProduct_Name() {
        return Product_Name;
    }

    public void setProduct_Name(String Product_Name) {
        this.Product_Name = Product_Name;
    }

    public int getPrice() {
        return Price;
    }

    public void setPrice(int Price) {
        this.Price = Price;
    }

    public int getStock_quanitity() {
        return Stock_quanitity;
    }

    public void setStock_quanitity(int Stock_quanitity) {
        this.Stock_quanitity = Stock_quanitity;
    }

    public int getCategory_ID() {
        return Category_ID;
    }

    public void setCategory_ID(int Category_ID) {
        this.Category_ID = Category_ID;
    }

    public int getBrand_ID() {
        return Brand_ID;
    }

    public void setBrand_ID(int Brand_ID) {
        this.Brand_ID = Brand_ID;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }
    
    
    
}
