package Model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Model đại diện cho một đơn hàng, phù hợp với cấu trúc bảng hiện tại
 */
public class Order {
    private long id;
    private long customerId;
    private int userId;  // Thêm userId vào đây
    private Timestamp orderDate;
    private double totalAmount;
    private double paidAmount;
    private String status;
    
    // Thông tin bổ sung về khách hàng (từ bảng Customers)
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String shippingAddress;
    
    // Thông tin bổ sung về đơn hàng
    private List<OrderDetail> orderItems;
    private int totalItems;
    private boolean reviewed;
    
    // Constructor
    public Order() {
        this.orderItems = new ArrayList<>();
    }
    
    // Phương thức phái sinh để hỗ trợ hiển thị UI
    
    /**
     * Trả về trạng thái đơn hàng để hiển thị
     * Các trạng thái: PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELED
     */
    public String getOrderStatus() {
        return this.status;
    }
    
    /**
     * Trả về trạng thái thanh toán dựa trên số tiền đã thanh toán
     * PAID: Đã thanh toán đủ, PARTIAL: Thanh toán một phần, UNPAID: Chưa thanh toán
     */
    public String getPaymentStatus() {
        if (this.paidAmount >= this.totalAmount) {
            return "PAID";
        } else if (this.paidAmount > 0) {
            return "PARTIAL";
        } else {
            return "UNPAID";
        }
    }
    
    /**
     * Trả về phương thức thanh toán, mặc định là COD
     */
    public String getPaymentMethod() {
        // Mặc định là COD vì trong bảng không có trường payment_method
        return "COD";
    }
    
    // Getters and Setters
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(long customerId) {
        this.customerId = customerId;
    }

    public int getUserID() {  // Thêm getter cho userID
        return userId;
    }

    public void setUserID(int userId) {  // Thêm setter cho userID
        this.userId = userId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(double paidAmount) {
        this.paidAmount = paidAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public List<OrderDetail> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderDetail> orderItems) {
        this.orderItems = orderItems;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }

    public boolean isReviewed() {
        return reviewed;
    }

    public void setReviewed(boolean reviewed) {
        this.reviewed = reviewed;
    }
    // Thêm phương thức để tính tổng tiền bao gồm phí vận chuyển
    public double calculateFinalTotal(double shippingFee) {
    // Đảm bảo tạm tính không âm
    double subtotal = Math.max(0, this.totalAmount);
    return subtotal + shippingFee;
}
}
