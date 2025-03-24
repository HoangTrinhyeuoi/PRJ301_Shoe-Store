/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import Model.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/updateProfile"})
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        // Kiểm tra đăng nhập
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
            return;
        }
        
        try {
            // Lấy dữ liệu từ form
            int id = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            
            // Cập nhật thông tin người dùng
            CustomerDAO customerDAO = new CustomerDAO();
            
            // Tạo đối tượng Customer với thông tin mới
            Customer updatedCustomer = new Customer(
                id,
                customer.getUserName(),
                customer.getPassword(),
                customer.getEmail(),
                fullName,
                address,
                phone
            );
            
            // Gọi phương thức cập nhật trong DAO
            boolean success = customerDAO.updateCustomerProfile(updatedCustomer);
            
            if (success) {
                // Cập nhật thông tin trong session
                session.setAttribute("customer", updatedCustomer);
                request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin. Vui lòng thử lại!");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Chuyển về trang chỉnh sửa để hiển thị thông báo
        request.getRequestDispatcher("/JSP/editProfile.jsp").forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Chuyển hướng đến trang chỉnh sửa hồ sơ
        request.getRequestDispatcher("/JSP/editProfile.jsp").forward(request, response);
    }
}