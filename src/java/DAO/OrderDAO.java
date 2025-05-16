package DAO;

import Model.Order;
import Model.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.sql.CallableStatement;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

/**
 * DAO xử lý dữ liệu đơn hàng
 */
public class OrderDAO {

    public void deleteOrder(int id) {
        String deleteItemsSql = "DELETE FROM Order_Items WHERE Order_ID = ?";
        String deleteOrderSql = "DELETE FROM Orders WHERE Order_ID = ?";
        try (Connection conn = DBconnection.getConnection()) {
            // Xóa Order_Items trước
            try (PreparedStatement stmtItems = conn.prepareStatement(deleteItemsSql)) {
                stmtItems.setInt(1, id);
                stmtItems.executeUpdate();
            }
            // Sau đó xóa Orders
            try (PreparedStatement stmtOrder = conn.prepareStatement(deleteOrderSql)) {
                stmtOrder.setInt(1, id);
                int rowsAffected = stmtOrder.executeUpdate();
                System.out.println("Rows deleted from Orders: " + rowsAffected);
            }
        } catch (SQLException e) {
            System.out.println("Error deleting order ID " + id + ": " + e.getMessage());
            e.printStackTrace();
        }
    }
    public void insertOrder(Order order) throws SQLException {
        String sql = "INSERT INTO Orders (Customer_ID, Total_amount, Paid_Amount, Status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, order.getCustomerId());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setDouble(3, order.getPaidAmount());
            stmt.setString(4, order.getStatus());
            stmt.executeUpdate();
        }
    }

    public List<Order> GetAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.Full_name, c.Email, c.Phone_number, c.Address "
                + "FROM Orders o "
                + "LEFT JOIN Customers c ON o.Customer_ID = c.Customer_ID "
                + "ORDER BY o.Order_date DESC";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            System.out.println("🔍 GetAllOrders: Executing query...");
            try (ResultSet rs = pstmt.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("Order_ID"));
                    order.setCustomerId(rs.getInt("Customer_ID"));
                    order.setOrderDate(rs.getTimestamp("Order_date"));
                    order.setTotalAmount(rs.getDouble("Total_amount"));
                    order.setPaidAmount(rs.getDouble("Paid_Amount"));
                    order.setStatus(rs.getString("Status"));

                    if (rs.getLong("Customer_ID") != 0) {
                        order.setCustomerName(rs.getString("Full_name"));
                        order.setCustomerEmail(rs.getString("Email"));
                        order.setCustomerPhone(rs.getString("Phone_number"));
                        order.setShippingAddress(rs.getString("Address"));
                    } else {
                        order.setCustomerName("Khách hàng không xác định");
                        order.setCustomerEmail("Không có email");
                        order.setCustomerPhone("Không có số điện thoại");
                        order.setShippingAddress("Không có địa chỉ");
                    }

                    int itemCount = getOrderItemCount(order.getId());
                    order.setTotalItems(itemCount);

                    orders.add(order);
                    count++;
                }
                System.out.println("🔍 GetAllOrders: Found " + count + " orders");
            }
        } catch (SQLException e) {
            System.out.println("❌ Error in GetAllOrders: " + e.getMessage());
            e.printStackTrace();
        }

        return orders;
    }

    /**
     * Lấy thông tin đơn hàng theo ID
     *
     * @param orderId ID đơn hàng cần lấy
     * @return Đối tượng Order hoặc null nếu không tìm thấy
     */
    public Order getOrderById(long orderId) {
        Order order = null;
        String sql = "SELECT o.*, c.Full_name, c.Email, c.Phone_number, c.Address "
                + "FROM Orders o "
                + "LEFT JOIN Customers c ON o.Customer_ID = c.Customer_ID "
                + // Chuyển thành LEFT JOIN
                "WHERE o.Order_ID = ?";  // Kiểm tra theo Order_ID

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, orderId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("Order_ID"));
                    order.setCustomerId(rs.getInt("Customer_ID"));
                    order.setOrderDate(rs.getTimestamp("Order_date"));
                    order.setTotalAmount(rs.getDouble("Total_amount"));
                    order.setPaidAmount(rs.getDouble("Paid_Amount"));
                    order.setStatus(rs.getString("Status"));

                    // Kiểm tra Customer_ID có NULL hay không
                    if (rs.getLong("Customer_ID") != 0) {
                        // Thông tin khách hàng từ bảng Customer nếu có
                        order.setCustomerName(rs.getString("Full_name"));
                        order.setCustomerEmail(rs.getString("Email"));
                        order.setCustomerPhone(rs.getString("Phone_number"));
                        order.setShippingAddress(rs.getString("Address"));
                    } else {
                        // Nếu không có Customer_ID, thì set thông tin khách hàng là null hoặc một thông báo khác
                        order.setCustomerName("Khách hàng không xác định");
                        order.setCustomerEmail("Không có email");
                        order.setCustomerPhone("Không có số điện thoại");
                        order.setShippingAddress("Không có địa chỉ");
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getOrderById: " + e.getMessage());
            e.printStackTrace();
        }

        return order;
    }

    /**
     * Lấy danh sách chi tiết đơn hàng theo ID đơn hàng
     *
     * @param orderId ID đơn hàng
     * @return Danh sách chi tiết đơn hàng
     */
    public List<OrderDetail> getOrderDetailsByOrderId(long orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT od.*, p.Product_name, p.Image_url "
                + "FROM Order_Items od "
                + "JOIN Products p ON od.Product_ID = p.Product_ID "
                + "WHERE od.Order_ID = ?";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, orderId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setId(rs.getLong("Order_Item_ID"));
                    detail.setOrderId(rs.getLong("Order_ID"));
                    detail.setProductId(rs.getLong("Product_ID"));
                    detail.setQuantity(rs.getInt("Quantity"));
                    detail.setPrice(rs.getDouble("Price"));

                    // Thông tin sản phẩm
                    detail.setProductName(rs.getString("Product_name"));
                    detail.setProductImage(rs.getString("Image_url"));

                    orderDetails.add(detail);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getOrderDetailsByOrderId: " + e.getMessage());
            e.printStackTrace();
        }

        return orderDetails;
    }

    /**
     * Cập nhật trạng thái thanh toán của đơn hàng
     *
     * @param orderId ID đơn hàng
     * @param paidAmount Số tiền đã thanh toán
     * @return true nếu cập nhật thành công, ngược lại false
     */
    public boolean updatePaymentStatus(long orderId, double paidAmount) {
        String sql = "UPDATE Orders SET Paid_Amount = ? WHERE Order_ID = ?";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setDouble(1, paidAmount);
            pstmt.setLong(2, orderId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error in updatePaymentStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
        public void updateOrder(Order order) {
        String sql = "UPDATE Orders SET Customer_ID = ?, Total_amount = ?, Paid_Amount = ?, Status = ? WHERE Order_ID = ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, order.getCustomerId());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setDouble(3, order.getPaidAmount());
            stmt.setString(4, order.getStatus());
            stmt.setInt(5, order.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    /**
     * Cập nhật trạng thái đơn hàng
     *
     * @param orderId ID đơn hàng
     * @param status Trạng thái mới
     * @return true nếu cập nhật thành công, ngược lại false
     */
    public boolean updateOrderStatus(long orderId, String status) {
        String sql = "UPDATE Orders SET Status = ? WHERE Order_ID = ?";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setLong(2, orderId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error in updateOrderStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy danh sách đơn hàng của một khách hàng
     *
     * @param customerId ID khách hàng
     * @return Danh sách đơn hàng
     */
    public List<Order> getOrdersByCustomerId(long customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.Full_name, c.Email, c.Phone_number, c.Address "
                + "FROM Orders o "
                + "JOIN Customers c ON o.Customer_ID = c.Customer_ID "
                + "WHERE o.Customer_ID = ? "
                + "ORDER BY o.Order_date DESC";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, customerId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("Order_ID"));
                    order.setCustomerId(rs.getInt("Customer_ID"));
                    order.setOrderDate(rs.getTimestamp("Order_date"));
                    order.setTotalAmount(rs.getDouble("Total_amount"));
                    order.setPaidAmount(rs.getDouble("Paid_Amount"));
                    order.setStatus(rs.getString("Status"));

                    // Thông tin khách hàng
                    order.setCustomerName(rs.getString("Full_name"));
                    order.setCustomerEmail(rs.getString("Email"));
                    order.setCustomerPhone(rs.getString("Phone_number"));
                    order.setShippingAddress(rs.getString("Address"));

                    // Lấy số lượng items trong đơn hàng
                    int itemCount = getOrderItemCount(order.getId());
                    order.setTotalItems(itemCount);

                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getOrdersByCustomerId: " + e.getMessage());
            e.printStackTrace();
        }

        return orders;
    }

    /**
     * Lấy số lượng mặt hàng trong một đơn hàng
     *
     * @param orderId ID đơn hàng
     * @return Số lượng mặt hàng
     */
    private int getOrderItemCount(long orderId) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS ItemCount FROM Order_Items WHERE Order_ID = ?";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, orderId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("ItemCount");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getOrderItemCount: " + e.getMessage());
            e.printStackTrace();
        }

        return count;
    }

    /**
     * Lấy tổng số đơn hàng của một khách hàng
     *
     * @param customerId ID khách hàng
     * @param status Trạng thái đơn hàng để lọc (có thể null)
     * @return Tổng số đơn hàng thỏa điều kiện
     */
    public int getOrderCount(long customerId, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS total FROM Orders WHERE Customer_ID = ?");

        // Thêm điều kiện lọc nếu có
        if (status != null && !status.isEmpty()) {
            sql.append(" AND Status = ?");
        }

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            pstmt.setLong(paramIndex++, customerId);

            if (status != null && !status.isEmpty()) {
                pstmt.setString(paramIndex++, status);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getOrderCount: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Lấy danh sách đơn hàng đã lọc và phân trang
     *
     * @param customerId ID khách hàng
     * @param status Trạng thái đơn hàng để lọc (có thể null)
     * @param sortOrder Thứ tự sắp xếp (newest, oldest, highPrice, lowPrice)
     * @param page Trang hiện tại
     * @param ordersPerPage Số đơn hàng mỗi trang
     * @return Danh sách đơn hàng thỏa điều kiện
     */
    public List<Order> getFilteredOrders(long customerId, String status, String sortOrder, int page, int ordersPerPage) {
        List<Order> orders = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT o.*, c.Full_name, c.Email, c.Phone_number, c.Address "
                + "FROM Orders o "
                + "JOIN Customers c ON o.Customer_ID = c.Customer_ID "
                + "WHERE o.Customer_ID = ?");

        // Thêm điều kiện lọc nếu có
        if (status != null && !status.isEmpty()) {
            sql.append(" AND o.Status = ?");
        }

        // Thêm thứ tự sắp xếp
        sql.append(" ORDER BY ");
        if (sortOrder != null) {
            switch (sortOrder) {
                case "oldest":
                    sql.append("o.Order_date ASC");
                    break;
                case "highPrice":
                    sql.append("o.Total_amount DESC");
                    break;
                case "lowPrice":
                    sql.append("o.Total_amount ASC");
                    break;
                default:
                    sql.append("o.Order_date DESC"); // Mặc định là mới nhất
                    break;
            }
        } else {
            sql.append("o.Order_date DESC"); // Mặc định là mới nhất
        }

        // Thêm phân trang - SQL Server
        int offset = (page - 1) * ordersPerPage;
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            pstmt.setLong(paramIndex++, customerId);

            if (status != null && !status.isEmpty()) {
                pstmt.setString(paramIndex++, status);
            }

            pstmt.setInt(paramIndex++, offset);
            pstmt.setInt(paramIndex++, ordersPerPage);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("Order_ID"));
                    order.setCustomerId(rs.getInt("Customer_ID"));
                    order.setOrderDate(rs.getTimestamp("Order_date"));
                    order.setTotalAmount(rs.getDouble("Total_amount"));
                    order.setPaidAmount(rs.getDouble("Paid_Amount"));
                    order.setStatus(rs.getString("Status"));

                    // Thông tin khách hàng
                    order.setCustomerName(rs.getString("Full_name"));
                    order.setCustomerEmail(rs.getString("Email"));
                    order.setCustomerPhone(rs.getString("Phone_number"));
                    order.setShippingAddress(rs.getString("Address"));

                    // Lấy số lượng items trong đơn hàng
                    int itemCount = getOrderItemCount(order.getId());
                    order.setTotalItems(itemCount);

                    // Tải chi tiết đơn hàng
                    List<OrderDetail> orderDetails = getOrderDetailsByOrderId(order.getId());
                    order.setOrderItems(orderDetails);

                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getFilteredOrders: " + e.getMessage());
            e.printStackTrace();
        }

        return orders;
    }

    /**
     * Hủy đơn hàng
     *
     * @param orderId ID đơn hàng
     * @param reason Lý do hủy
     * @return true nếu hủy thành công, ngược lại false
     */
    public boolean cancelOrder(long orderId, String reason) {
        String sql = "UPDATE Orders SET Status = 'CANCELED' WHERE Order_ID = ? AND Status = 'PENDING'";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, orderId);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Hoàn trả sản phẩm về kho nếu cần
                restoreProductStock(conn, orderId);
                return true;
            }

            return false;
        } catch (SQLException e) {
            System.out.println("Error in cancelOrder: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Hoàn trả số lượng sản phẩm về kho khi hủy đơn hàng
     *
     * @param conn Kết nối cơ sở dữ liệu
     * @param orderId ID đơn hàng
     * @throws SQLException nếu có lỗi SQL
     */
    private void restoreProductStock(Connection conn, long orderId) throws SQLException {
        String selectSql = "SELECT Product_ID, Quantity FROM Order_Items WHERE Order_ID = ?";
        String updateSql = "UPDATE Products SET Stock_quantity = Stock_quantity + ? WHERE Product_ID = ?";

        try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
            selectStmt.setLong(1, orderId);

            try (ResultSet rs = selectStmt.executeQuery()) {
                while (rs.next()) {
                    long productId = rs.getLong("Product_ID");
                    int quantity = rs.getInt("Quantity");

                    // Cập nhật số lượng tồn kho
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, quantity);
                        updateStmt.setLong(2, productId);
                        updateStmt.executeUpdate();
                    }
                }
            }
        }
    }

    /**
     * Tạo đơn hàng mới từ giỏ hàng
     *
     * @param customerId ID khách hàng
     * @return Map chứa thông tin kết quả (status, message, orderId)
     */
    public Map<String, String> createOrderFromCart(long customerId) {
        Map<String, String> result = new HashMap<>();

        try (Connection conn = DBconnection.getConnection()) {
            // Bắt đầu transaction
            conn.setAutoCommit(false);

            try {
                // Tính tổng giá trị giỏ hàng
                double totalAmount = calculateCartTotal(conn, customerId);

                // Tạo đơn hàng mới
                long orderId = createNewOrder(conn, customerId, totalAmount);

                // Chuyển các mục từ giỏ hàng sang đơn hàng
                moveCartItemsToOrder(conn, customerId, orderId);

                // Xóa các mục trong giỏ hàng
                clearCart(conn, customerId);

                // Commit transaction
                conn.commit();

                result.put("status", "success");
                result.put("message", "Đơn hàng #" + orderId + " đã được tạo thành công");
                result.put("orderId", String.valueOf(orderId));
            } catch (SQLException e) {
                // Rollback transaction nếu có lỗi
                conn.rollback();
                throw e;
            } finally {
                // Khôi phục chế độ auto-commit
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            result.put("status", "error");
            result.put("message", "Lỗi khi tạo đơn hàng: " + e.getMessage());
            System.out.println("Error in createOrderFromCart: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    /**
     * Tính tổng giá trị giỏ hàng
     *
     * @param conn Kết nối đến DB
     * @param customerId ID khách hàng
     * @return Tổng giá trị giỏ hàng
     * @throws SQLException Nếu có lỗi SQL
     */
    private double calculateCartTotal(Connection conn, long customerId) throws SQLException {
        double total = 0;
        String sql = "SELECT SUM(ci.Quantity * p.Price) AS Total "
                + "FROM Cart_Items ci "
                + "JOIN Carts c ON ci.Cart_ID = c.Cart_ID "
                + "JOIN Products p ON ci.Product_ID = p.Product_ID "
                + "WHERE c.Customer_ID = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, customerId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble("Total");
                }
            }
        }

        return total;
    }

    /**
     * Tạo đơn hàng mới
     *
     * @param conn Kết nối đến DB
     * @param customerId ID khách hàng
     * @param totalAmount Tổng giá trị đơn hàng
     * @return ID của đơn hàng mới
     * @throws SQLException Nếu có lỗi SQL
     */
    private long createNewOrder(Connection conn, long customerId, double totalAmount) throws SQLException {
        String sql = "INSERT INTO Orders (Customer_ID, Order_date, Total_amount, Paid_Amount, Status) "
                + "VALUES (?, GETDATE(), ?, 0, 'PENDING');"
                + "SELECT SCOPE_IDENTITY() AS Order_ID";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, customerId);
            pstmt.setDouble(2, totalAmount);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong("Order_ID");
                }
            }
        }

        throw new SQLException("Failed to create new order");
    }

    /**
     * Chuyển các mục từ giỏ hàng sang đơn hàng
     *
     * @param conn Kết nối đến DB
     * @param customerId ID khách hàng
     * @param orderId ID đơn hàng
     * @throws SQLException Nếu có lỗi SQL
     */
    private void moveCartItemsToOrder(Connection conn, long customerId, long orderId) throws SQLException {
        String sql = "INSERT INTO Order_Items (Order_ID, Product_ID, Quantity, Price) "
                + "SELECT ?, ci.Product_ID, ci.Quantity, p.Price "
                + "FROM Cart_Items ci "
                + "JOIN Carts c ON ci.Cart_ID = c.Cart_ID "
                + "JOIN Products p ON ci.Product_ID = p.Product_ID "
                + "WHERE c.Customer_ID = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, orderId);
            pstmt.setLong(2, customerId);

            pstmt.executeUpdate();
        }
    }

    /**
     * Xóa các mục trong giỏ hàng
     *
     * @param conn Kết nối đến DB
     * @param customerId ID khách hàng
     * @throws SQLException Nếu có lỗi SQL
     */
    private void clearCart(Connection conn, long customerId) throws SQLException {
        String sql = "DELETE FROM Cart_Items "
                + "WHERE Cart_ID IN (SELECT Cart_ID FROM Carts WHERE Customer_ID = ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, customerId);

            pstmt.executeUpdate();
        }
    }
}
