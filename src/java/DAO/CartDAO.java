package DAO;

import Model.CartItem;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartDAO {
    
    // Phương thức thêm sản phẩm vào giỏ hàng
    public Map<String, String> addToCart(int customerId, int productId, int quantity) {
        Map<String, String> result = new HashMap<>();
        
        try (Connection conn = DBconnection.getConnection(); 
             CallableStatement cstmt = conn.prepareCall("{CALL AddToCart(?, ?, ?)}")) {
            
            cstmt.setInt(1, customerId);
            cstmt.setInt(2, productId);
            cstmt.setInt(3, quantity);
            
            cstmt.execute();
            result.put("status", "success");
            result.put("message", "Đã thêm sản phẩm vào giỏ hàng");
            
        } catch (SQLException e) {
            result.put("status", "error");
            result.put("message", "Lỗi khi thêm vào giỏ hàng: " + e.getMessage());
            System.out.println("Lỗi thêm giỏ hàng: " + e.getMessage());
        }
        
        return result;
    }
    
    // Phương thức xóa sản phẩm khỏi giỏ hàng
    public Map<String, String> removeFromCart(int customerId, int productId) {
        Map<String, String> result = new HashMap<>();
        
        try (Connection conn = DBconnection.getConnection()) {
            // Đầu tiên tìm Cart_ID của khách hàng
            int cartId = getCartId(conn, customerId);
            
            if (cartId == -1) {
                result.put("status", "error");
                result.put("message", "Không tìm thấy giỏ hàng");
                return result;
            }
            
            // Sau đó tìm Cart_Item_ID dựa vào Cart_ID và Product_ID
            int cartItemId = getCartItemId(conn, cartId, productId);
            
            if (cartItemId == -1) {
                result.put("status", "error");
                result.put("message", "Không tìm thấy sản phẩm trong giỏ hàng");
                return result;
            }
            
            // Xóa mục khỏi giỏ hàng bằng CartItemID
            try (CallableStatement cstmt = conn.prepareCall("{CALL RemoveFromCart(?)}")) {
                cstmt.setInt(1, cartItemId);
                cstmt.execute();
                
                result.put("status", "success");
                result.put("message", "Đã xóa sản phẩm khỏi giỏ hàng");
            }
            
        } catch (SQLException e) {
            result.put("status", "error");
            result.put("message", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            System.out.println("Lỗi xóa sản phẩm: " + e.getMessage());
        }
        
        return result;
    }
    
    // Helper method để lấy Cart_ID từ Customer_ID
    private int getCartId(Connection conn, int customerId) throws SQLException {
        try (CallableStatement cstmt = conn.prepareCall("{CALL GetOrCreateCart(?, ?)}")) {
            cstmt.setInt(1, customerId);
            cstmt.registerOutParameter(2, Types.INTEGER);
            cstmt.execute();
            
            return cstmt.getInt(2);
        }
    }
    
    // Helper method để lấy Cart_Item_ID từ Cart_ID và Product_ID
    private int getCartItemId(Connection conn, int cartId, int productId) throws SQLException {
        String sql = "SELECT Cart_Item_ID FROM Cart_Items WHERE Cart_ID = ? AND Product_ID = ?";
        try (CallableStatement cstmt = conn.prepareCall(sql)) {
            cstmt.setInt(1, cartId);
            cstmt.setInt(2, productId);
            
            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("Cart_Item_ID");
            } else {
                return -1; // Không tìm thấy
            }
        }
    }
    
    // Phương thức chuyển đổi giỏ hàng thành đơn hàng (checkout)
    public Map<String, String> checkoutCart(int customerId) {
        Map<String, String> result = new HashMap<>();
        
        try (Connection conn = DBconnection.getConnection(); 
             CallableStatement cstmt = conn.prepareCall("{CALL CartToOrder(?, ?)}")) {
            
            cstmt.setInt(1, customerId);
            cstmt.registerOutParameter(2, Types.INTEGER);
            
            cstmt.execute();
            int orderId = cstmt.getInt(2);
            
            result.put("status", "success");
            result.put("message", "Đơn hàng #" + orderId + " đã được tạo thành công");
            result.put("orderId", String.valueOf(orderId));
            
        } catch (SQLException e) {
            result.put("status", "error");
            result.put("message", "Lỗi khi tạo đơn hàng: " + e.getMessage());
            System.out.println("Lỗi checkout: " + e.getMessage());
        }
        
        return result;
    }
    
    // Phương thức lấy danh sách sản phẩm trong giỏ hàng
    public List<CartItem> getCartItems(int customerId) {
        List<CartItem> cartItems = new ArrayList<>();
        
        try (Connection conn = DBconnection.getConnection(); 
             CallableStatement cstmt = conn.prepareCall("{CALL GetCartItems(?)}")) {
            
            cstmt.setInt(1, customerId);
            
            ResultSet rs = cstmt.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("Cart_Item_ID"));
                item.setProductId(rs.getInt("Product_ID"));
                item.setProductName(rs.getString("Product_name"));
                item.setImageUrl(rs.getString("Image_URL"));
                item.setPrice(rs.getDouble("Price"));
                item.setQuantity(rs.getInt("Quantity"));
                item.setSubtotal(rs.getDouble("Subtotal"));
                
                cartItems.add(item);
            }
        } catch (SQLException e) {
            System.out.println("Error in getCartItems: " + e.getMessage());
        }
        
        return cartItems;
    }
    
    // Phương thức lấy số lượng các mục trong giỏ hàng
    public int getCartItemCount(int customerId) {
        int count = 0;
        
        try (Connection conn = DBconnection.getConnection()) {
            // Lấy Cart_ID từ Customer_ID
            int cartId = getCartId(conn, customerId);
            
            if (cartId != -1) {
                // Đếm số mục trong Cart_Items
                String sql = "SELECT COUNT(*) AS ItemCount FROM Cart_Items WHERE Cart_ID = ?";
                try (CallableStatement cstmt = conn.prepareCall(sql)) {
                    cstmt.setInt(1, cartId);
                    
                    ResultSet rs = cstmt.executeQuery();
                    if (rs.next()) {
                        count = rs.getInt("ItemCount");
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getCartItemCount: " + e.getMessage());
        }
        
        return count;
    }
    
    // Phương thức lấy tổng giá trị giỏ hàng
    public double getCartTotal(int customerId) {
        double total = 0;
        
        try (Connection conn = DBconnection.getConnection(); 
             CallableStatement cstmt = conn.prepareCall("{CALL GetCartTotal(?, ?)}")) {
            
            cstmt.setInt(1, customerId);
            cstmt.registerOutParameter(2, Types.DECIMAL);
            
            cstmt.execute();
            total = cstmt.getDouble(2);
            
        } catch (SQLException e) {
            System.out.println("Error in getCartTotal: " + e.getMessage());
        }
        
        return total;
    }
    
    // Phương thức cập nhật số lượng sản phẩm trong giỏ hàng
    public Map<String, String> updateCartItem(int customerId, int productId, int quantity) {
        Map<String, String> result = new HashMap<>();
        
        try (Connection conn = DBconnection.getConnection()) {
            // Đầu tiên tìm Cart_ID của khách hàng
            int cartId = getCartId(conn, customerId);
            
            if (cartId == -1) {
                result.put("status", "error");
                result.put("message", "Không tìm thấy giỏ hàng");
                return result;
            }
            
            // Sau đó tìm Cart_Item_ID dựa vào Cart_ID và Product_ID
            int cartItemId = getCartItemId(conn, cartId, productId);
            
            if (cartItemId == -1) {
                result.put("status", "error");
                result.put("message", "Không tìm thấy sản phẩm trong giỏ hàng");
                return result;
            }
            
            // Cập nhật số lượng
            try (CallableStatement cstmt = conn.prepareCall("{CALL UpdateCartItemQuantity(?, ?)}")) {
                cstmt.setInt(1, cartItemId);
                cstmt.setInt(2, quantity);
                
                cstmt.execute();
                
                result.put("status", "success");
                result.put("message", "Đã cập nhật số lượng sản phẩm");
            }
            
        } catch (SQLException e) {
            result.put("status", "error");
            result.put("message", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            System.out.println("Lỗi cập nhật số lượng: " + e.getMessage());
        }
        
        return result;
    }
    
    // Phương thức xóa toàn bộ giỏ hàng của một khách hàng
    public Map<String, String> clearCart(int customerId) {
        Map<String, String> result = new HashMap<>();
        
        try (Connection conn = DBconnection.getConnection()) {
            // Đầu tiên tìm Cart_ID của khách hàng
            int cartId = getCartId(conn, customerId);
            
            if (cartId == -1) {
                result.put("status", "success");
                result.put("message", "Giỏ hàng đã trống");
                return result;
            }
            
            // Xóa tất cả các mục trong Cart_Items
            String sql = "DELETE FROM Cart_Items WHERE Cart_ID = ?";
            try (CallableStatement cstmt = conn.prepareCall(sql)) {
                cstmt.setInt(1, cartId);
                
                int rowsAffected = cstmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    result.put("status", "success");
                    result.put("message", "Đã xóa toàn bộ giỏ hàng");
                } else {
                    result.put("status", "success");
                    result.put("message", "Giỏ hàng đã trống");
                }
            }
            
        } catch (SQLException e) {
            result.put("status", "error");
            result.put("message", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            System.out.println("Lỗi xóa giỏ hàng: " + e.getMessage());
        }
        
        return result;
    }
}