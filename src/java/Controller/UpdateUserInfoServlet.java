/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import Model.Customer;
import Model.UserGoogleDto;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import DAO.DBconnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author ASUS
 */
public class UpdateUserInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Cập nhật vào database
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                 "UPDATE Customers SET Phone_number = ?, Address = ? WHERE Email = ?")) {
            pstmt.setString(1, phone);
            pstmt.setString(2, address);
            pstmt.setString(3, email);
            int updatedRows = pstmt.executeUpdate();

            if (updatedRows > 0) {
                // Cập nhật session
                HttpSession session = request.getSession();
                session.setAttribute("user.phone", phone);
                session.setAttribute("user.address", address);

                // Chuyển hướng về trang chính
                response.sendRedirect(request.getContextPath() + "/JSP/index.jsp");
            } else {
                request.setAttribute("errorMessage", "Cập nhật không thành công!");
                request.getRequestDispatcher("/JSP/updateInfo.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống, vui lòng thử lại!");
            request.getRequestDispatcher("/JSP/updateInfo.jsp").forward(request, response);
        }
    }
}

