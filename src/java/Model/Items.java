package Model;

import java.io.Serializable;

public class Items implements Serializable {
    private int productId;
    private String productName;
    private double price;
    private int stock;
    private String status;

    // Constructor mặc định (bắt buộc để sử dụng JavaBean)
    public Items() {
    }

    // Constructor có tham số
    public Items(int productId, String productName, double price, int stock, String status) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.stock = stock;
        this.status = status;
    }

    public Items(int aInt, String string, String string0, double aDouble, int aInt0, int aInt1, int aInt2, String string1) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    // Getter và Setter (bắt buộc theo chuẩn JavaBean)
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
