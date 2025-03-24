package DAO;

import Model.Orders;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminOrdersDAO {
    private Connection conn;

    public AdminOrdersDAO(Connection conn) {
        this.conn = conn;
    }

public List<Orders> getAllOrders() throws SQLException {
    List<Orders> ordersList = new ArrayList<>();
    String query = "SELECT Order_ID, Customer_ID, Status FROM Orders"; // Fetch only the required columns

    try (PreparedStatement ps = conn.prepareStatement(query)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Orders order = new Orders(
                rs.getInt("Order_ID"),       // Matches Order_ID column
                rs.getInt("Customer_ID"),    // Matches Customer_ID column
                rs.getString("Status")       // Matches Status column
            );
            ordersList.add(order);
        }
    } catch (SQLException e) {
        System.err.println("Error fetching orders: " + e.getMessage());
        throw e; // Re-throw the exception for the caller to handle
    }

    return ordersList;
}
    public void updateOrderStatus(int orderId, String newStatus) throws SQLException {
        String query = "UPDATE Orders SET Status = ? WHERE Order_ID = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
    }
}
