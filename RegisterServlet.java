package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phone");

        String message = "";

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "{CALL RegisterCustomer(?, ?, ?, ?, ?, ?)}";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setString(4, fullName);
            stmt.setString(5, address);
            stmt.setString(6, phoneNumber);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                message = " Đăng ký thành công! Vui lòng đăng nhập.";
            } else {
                message = " Đăng ký thất bại. Email hoặc username đã tồn tại.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "❌ Lỗi hệ thống: " + e.getMessage();
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
