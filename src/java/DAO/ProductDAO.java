package DAO;

import Model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public void deleteProduct(int productId) {
        String sql = "DELETE FROM Products WHERE Product_ID = ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT Product_ID, Product_name, Description, Price, Stock_quantity, Image_URL FROM Products";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock_quantity"),
                        rs.getString("Image_URL"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
    // Cập nhật trạng thái sản phẩm
    public void updateProduct(Product product) {
        String sql = "UPDATE Products SET Name = ?, Price = ?, Stock = ?, Category_ID = ?, Description = ?, Image_URL = ? WHERE Product_ID = ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setDouble(2, product.getPrice());
            stmt.setInt(3, product.getStock());
            stmt.setInt(4, product.getCategoryId());
            stmt.setString(5, product.getDescription());
            stmt.setString(6, product.getImageUrl());
            stmt.setInt(7, product.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateProductStock(int productId, int newStock) throws SQLException {
        String sql = "UPDATE Products SET Stock_quantity = ? WHERE Product_ID = ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, newStock);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }
    
        public void insertProduct(Product product) throws SQLException {
        String sql = "INSERT INTO Products (Product_name, Description, Price, Stock_quantity, Image_URL, Category_ID) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getStock());
            stmt.setString(5, product.getImageUrl());
            stmt.setInt(6, product.getCategoryId());
            stmt.executeUpdate();
        }
    }
    // Lấy toàn bộ sản phẩm Nike Air Jordan từ database
    public List<Product> getAllJordanProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.Product_ID, p.Product_name, p.Description, p.Price, p.Image_URL "
                + "FROM Products p "
                + "JOIN Brands b ON p.Brand_ID = b.Brand_ID "
                + "WHERE b.Brand_name = 'Nike' AND p.Product_name LIKE '%Air Jordan%'";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Image_URL")
                );
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Tìm kiếm sản phẩm theo từ khóa
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT Product_ID, Product_name, Description, Price, Image_URL "
                + "FROM Products WHERE Product_name LIKE ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Image_URL")
                );
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Lấy số lượng sản phẩm còn trong kho
    public int getStockQuantity(int productId) {
        int stock = 0;
        String sql = "SELECT Stock_quantity FROM Products WHERE Product_ID = ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stock = rs.getInt("Stock_quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stock;
    }

    // Lọc sản phẩm theo thể loại
    public List<Product> filterProductsByCategory(String categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.Product_ID, p.Product_name, p.Description, p.Price, p.Image_URL "
                + "FROM Products p "
                + "JOIN Categories c ON p.Category_ID = c.Category_ID "
                + "WHERE c.Category_ID = ?";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Image_URL")
                );
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Lọc sản phẩm theo thương hiệu
    public List<Product> filterProductsByBrand(String brand) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.Product_ID, p.Product_name, p.Description, p.Price, p.Image_URL "
                + "FROM Products p "
                + "JOIN Brands b ON p.Brand_ID = b.Brand_ID "
                + "WHERE b.Brand_name = ?";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, brand);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Image_URL")
                );
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Lọc sản phẩm theo cả thể loại và thương hiệu
    public List<Product> filterProductsByCategoryAndBrand(String categoryId, String brand) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.Product_ID, p.Product_name, p.Description, p.Price, p.Image_URL "
                + "FROM Products p "
                + "JOIN Categories c ON p.Category_ID = c.Category_ID "
                + "JOIN Brands b ON p.Brand_ID = b.Brand_ID "
                + "WHERE c.Category_ID = ? AND b.Brand_name = ?";

        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, categoryId);
            stmt.setString(2, brand);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Image_URL")
                );
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
}
