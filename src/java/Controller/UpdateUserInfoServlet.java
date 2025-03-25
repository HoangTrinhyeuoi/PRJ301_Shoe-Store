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
        
        // Kiểm tra dữ liệu đầu vào
        if (email == null || email.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() || 
            address == null || address.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("/JSP/updateInfo.jsp").forward(request, response);
            return;
        }
        
        // Cập nhật vào database
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                 "UPDATE Customers SET Phone_number = ?, Address = ? WHERE Email = ?")) {
            
            pstmt.setString(1, phone);
            pstmt.setString(2, address);
            pstmt.setString(3, email);
            
            int updatedRows = pstmt.executeUpdate();
            
            if (updatedRows > 0) {
                // Cập nhật thông tin trong session
                HttpSession session = request.getSession();
                Customer customer = (Customer) session.getAttribute("customer");
                
                if (customer != null) {
                    customer.setPhoneNumber(phone);
                    customer.setAddress(address);
                    session.setAttribute("customer", customer);
                }
                
                // Kiểm tra xem có URL redirect không
                String redirectURL = (String) session.getAttribute("redirect");
                if (redirectURL != null && !redirectURL.isEmpty()) {
                    // Xóa thông tin redirect khỏi session
                    session.removeAttribute("redirect");
                    response.sendRedirect(request.getContextPath() + "/" + redirectURL);
                } else {
                    // Chuyển hướng về trang chính
                    response.sendRedirect(request.getContextPath() + "/JSP/index.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Cập nhật không thành công! Email không tồn tại trong hệ thống.");
                request.getRequestDispatcher("/JSP/updateInfo.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage() + ". Vui lòng thử lại!");
            request.getRequestDispatcher("/JSP/updateInfo.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang updateInfo.jsp
        request.getRequestDispatcher("/JSP/updateInfo.jsp").forward(request, response);
    }
}