package Controller;

import java.sql.CallableStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.DBconnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/JSP/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phone");

        String message = "";

        try (Connection conn = DBconnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{CALL RegisterCustomer(?, ?, ?, ?, ?, ?)}")) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setString(4, fullName);
            stmt.setString(5, address);
            stmt.setString(6, phoneNumber);

            // Thực thi stored procedure và lấy kết quả
            boolean hasResult = stmt.execute();
            if (hasResult) {
                try (ResultSet rs = stmt.getResultSet()) {
                    if (rs.next()) {
                        int result = rs.getInt("Result");
                        if (result == 1) {
                            message = "Đăng ký thành công! Vui lòng đăng nhập.";
                        } else {
                            message = "Đăng ký thất bại. Email hoặc username đã tồn tại.";
                        }
                    }
                }
            } else {
                message = "Đăng ký thất bại. Không nhận được kết quả từ hệ thống.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "❌ Lỗi hệ thống: " + e.getMessage();
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("/JSP/register.jsp").forward(request, response);
    }
}