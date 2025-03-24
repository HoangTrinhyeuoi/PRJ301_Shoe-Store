package DAO;

import Model.Items;
import Model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminProductDAO {
    private Connection conn;

    public AdminProductDAO(Connection conn) {
        this.conn = conn;
    }

    // Lấy danh sách tất cả sản phẩm để admin quản lý
public List<Items> getAllProducts() throws SQLException {
    List<Items> productsList = new ArrayList<>();
    String query = "SELECT * FROM Products"; // Adjusted to match the Products table

    try (PreparedStatement ps = conn.prepareStatement(query)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Items product = new Items(
                rs.getInt("Product_ID"),         // Matches Product_ID column
                rs.getString("Product_name"),    // Matches Product_name column
                rs.getString("Description"),     // Matches Description column
                rs.getDouble("Price"),           // Matches Price column
                rs.getInt("Stock_quantity"),     // Matches Stock_quantity column
                rs.getInt("Category_ID"),        // Matches Category_ID column
                rs.getInt("Brand_ID"),           // Matches Brand_ID column
                rs.getString("Image_URL")        // Matches Image_URL column
            );
            productsList.add(product);
        }
    } catch (SQLException e) {
        System.err.println("Error fetching products: " + e.getMessage());
        throw e; // Re-throw the exception for the caller to handle
    }

    return productsList;
}
    // Cập nhật trạng thái sản phẩm
    public void updateProductStatus(int productId, String status) throws SQLException {
        String query = "UPDATE Products SET status = ? WHERE Product_ID = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, productId);
            ps.executeUpdate();
        }
    }

}
