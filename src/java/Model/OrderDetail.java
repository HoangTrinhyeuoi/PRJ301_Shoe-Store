package Model;

/**
 * Model đại diện cho một mục chi tiết trong đơn hàng
 */
public class OrderDetail {
    private long id;
    private long orderId;
    private long productId;
    private String productName;
    private String productImage;
    private int quantity;
    private double price;

    public OrderDetail() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    /**
     * Tính thành tiền của mục hàng
     * @return Thành tiền (số lượng * đơn giá)
     */
    public double getSubtotal() {
        return price * quantity;
    }
}