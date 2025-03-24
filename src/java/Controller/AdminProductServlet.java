package controller;

import DAO.AdminProductDAO;
import Model.Product;
import DAO.DBconnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/manage_products")
public class AdminProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = DBconnection.getConnection();
        AdminProductDAO adminProductDAO = new AdminProductDAO(conn);
        List<Product> productList = adminProductDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("/admin/manage_products.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = DBconnection.getConnection();
        AdminProductDAO adminProductDAO = new AdminProductDAO(conn);

        int productId = Integer.parseInt(request.getParameter("productId"));
        String status = request.getParameter("status");

        try {
            adminProductDAO.updateProductStatus(productId, status);
            response.sendRedirect("manage-products"); // Reload trang sau khi cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
