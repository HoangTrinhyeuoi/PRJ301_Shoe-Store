/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vnpay.common;

import DAO.DBconnection;
import Model.CartItem;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.beans.Statement;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.http.HttpSession;
import Model.Customer;
/**
 *
 * @author CTT VNPAY
 */

public class ajaxServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        try {
            System.out.println("🔹 Servlet bắt đầu xử lý thanh toán...");
            String amountStr = req.getParameter("amount");
            
            if (amountStr == null || amountStr.isEmpty()) {
                System.out.println("❌ Lỗi: amount bị null hoặc rỗng");
                out.write("{\"code\":\"99\",\"message\":\"Amount is required\"}");
                return;
            }

            // Lấy session và kiểm tra
            HttpSession session = req.getSession(false);
            System.out.println("🔍 Session ID: " + (session != null ? session.getId() : "null"));
            if (session == null) {
                System.out.println("❌ Lỗi: Session không tồn tại");
                out.write("{\"code\":\"99\",\"message\":\"Session not found - User not logged in\"}");
                return;
            }

            Object customerObj = session.getAttribute("customer");
            System.out.println("🔍 Customer trong session: " + (customerObj != null ? customerObj.toString() : "null"));
            if (customerObj == null) {
                System.out.println("❌ Lỗi: customer không tồn tại trong session");
                out.write("{\"code\":\"99\",\"message\":\"Customer not found in session - User not logged in\"}");
                return;
            }

            Customer customer = (Customer) customerObj;
            int customerId = customer.getCustomerId();
            System.out.println("✅ CustomerID: " + customerId);

            // Kiểm tra giỏ hàng từ database
            List<CartItem> cart = getCartItemsFromDatabase(customerId);
            System.out.println("🔍 Kiểm tra giỏ hàng: " + (cart != null ? "Có " + cart.size() + " sản phẩm" : "Giỏ hàng null"));
            if (cart == null || cart.isEmpty()) {
                System.out.println("❌ Lỗi: Giỏ hàng trống hoặc không tồn tại");
                out.write("{\"code\":\"99\",\"message\":\"Cart is empty or not found\"}");
                return;
            }
            
            double amountDouble;
            try {
                amountDouble = Double.parseDouble(amountStr);
            } catch (NumberFormatException e) {
                System.out.println("❌ Lỗi: amount không đúng định dạng số");
                out.write("{\"code\":\"99\",\"message\":\"Invalid amount format\"}");
                return;
            }
            
            long amount = (long) (amountDouble * 100);
            System.out.println("✅ Số tiền (VNĐ): " + amount);
            
            // Lưu đơn hàng và chi tiết sản phẩm
            long orderId = saveOrderToDatabase(amount, customerId, cart);  
            if (orderId == 0) {
                System.out.println("❌ Lỗi: Không thể lưu đơn hàng vào database");
                out.write("{\"code\":\"99\",\"message\":\"Failed to create order\"}");
                return;
            }

            // Xóa giỏ hàng sau khi tạo đơn hàng
            clearCart(customerId);

            // Tạo URL thanh toán VnPay
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";
            String vnp_TxnRef = String.valueOf(orderId);
            String vnp_IpAddr = Config.getIpAddress(req);
            String vnp_TmnCode = Config.vnp_TmnCode;
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", "Thanh toán đơn hàng: " + vnp_TxnRef);
            vnp_Params.put("vnp_OrderType", orderType);
            vnp_Params.put("vnp_Locale", "vn");
            vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            vnp_Params.put("vnp_CreateDate", formatter.format(cld.getTime()));
            cld.add(Calendar.MINUTE, 15);
            vnp_Params.put("vnp_ExpireDate", formatter.format(cld.getTime()));

            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            for (String fieldName : fieldNames) {
                String fieldValue = vnp_Params.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    hashData.append(fieldName).append("=").append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8)).append("&");
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.UTF_8)).append("=").append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8)).append("&");
                }
            }
            if (hashData.length() > 0) hashData.setLength(hashData.length() - 1);
            if (query.length() > 0) query.setLength(query.length() - 1);

            String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
            String paymentUrl = Config.vnp_PayUrl + "?" + query + "&vnp_SecureHash=" + vnp_SecureHash;
            System.out.println("✅ URL thanh toán: " + paymentUrl);

            JsonObject job = new JsonObject();
            job.addProperty("code", "00");
            job.addProperty("message", "success");
            job.addProperty("data", paymentUrl);
            Gson gson = new Gson();
            out.write(gson.toJson(job));
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"code\":\"99\",\"message\":\"Internal server error: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }

    // Lấy giỏ hàng từ database
    private List<CartItem> getCartItemsFromDatabase(int customerId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT ci.Product_ID, ci.Quantity, p.Price " +
                     "FROM Cart_Items ci " +
                     "JOIN Carts c ON ci.Cart_ID = c.Cart_ID " +
                     "JOIN Products p ON ci.Product_ID = p.Product_ID " +
                     "WHERE c.Customer_ID = ?";

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setProductId(rs.getInt("Product_ID"));
                item.setQuantity(rs.getInt("Quantity"));
                item.setPrice(rs.getDouble("Price"));
                cartItems.add(item);
            }
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi lấy giỏ hàng từ database: " + e.getMessage());
            e.printStackTrace();
        }
        return cartItems;
    }

    // Xóa giỏ hàng sau khi tạo đơn hàng
    private void clearCart(int customerId) {
        String sql = "DELETE FROM Cart_Items " +
                     "WHERE Cart_ID IN (SELECT Cart_ID FROM Carts WHERE Customer_ID = ?)";
        
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, customerId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi xóa giỏ hàng: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private long saveOrderToDatabase(long amount, int customerId, List<CartItem> cart) {
        long orderId = 0;
        Connection conn = null;
        try {
            conn = DBconnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Lưu đơn hàng
            String sql = "INSERT INTO Orders (Paid_Amount, Status, Customer_ID) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setLong(1, amount);
                stmt.setString(2, "Pending");
                stmt.setInt(3, customerId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            orderId = rs.getLong(1);
                        }
                    }
                }
            }

            // Lưu chi tiết sản phẩm từ giỏ hàng
            if (orderId > 0 && cart != null && !cart.isEmpty()) {
                String sqlItems = "INSERT INTO Order_Items (Order_ID, Product_ID, Quantity, Price) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmtItems = conn.prepareStatement(sqlItems)) {
                    for (CartItem item : cart) {
                        System.out.println("🔍 Lưu sản phẩm: Product_ID=" + item.getProductId() + ", Quantity=" + item.getQuantity() + ", Price=" + item.getPrice());
                        stmtItems.setLong(1, orderId);
                        stmtItems.setInt(2, item.getProductId());
                        stmtItems.setInt(3, item.getQuantity());
                        stmtItems.setDouble(4, item.getPrice());
                        stmtItems.addBatch();
                    }
                    int[] rowsAffected = stmtItems.executeBatch();
                    System.out.println("✅ Đã lưu " + rowsAffected.length + " sản phẩm vào Order_Items");
                }
            }

            conn.commit(); // Commit transaction
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return orderId;
    }
}