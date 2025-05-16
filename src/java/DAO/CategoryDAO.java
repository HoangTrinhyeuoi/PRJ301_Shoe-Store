package DAO;

import Model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT Category_ID, Category_name FROM Categories";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("Category_ID"),
                        rs.getString("Category_name"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public Category getCategoryById(int categoryId) {
        Category category = null;
        String sql = "SELECT Category_ID, Category_name FROM Categories WHERE Category_ID = ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                category = new Category(
                        rs.getInt("Category_ID"),
                        rs.getString("Category_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }

    public void addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO Categories (Category_name) VALUES (?)";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category.getName());
            stmt.executeUpdate();
        }
    }

    public void updateCategory(Category category) throws SQLException {
        String sql = "UPDATE Categories SET Category_name = ? WHERE Category_ID = ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category.getName());
            stmt.setInt(2, category.getID());
            stmt.executeUpdate();
        }
    }

    public void deleteCategory(int categoryId) throws SQLException {
        String sql = "DELETE FROM Categories WHERE Category_ID = ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            stmt.executeUpdate();
        }
    }

    public List<Category> searchCategories(String keyword) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT Category_ID, Category_name FROM Categories WHERE Category_name LIKE ?";
        try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("Category_ID"),
                        rs.getString("Category_name"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
}