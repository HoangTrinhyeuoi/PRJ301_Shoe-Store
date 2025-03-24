/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import Model.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CompleteGoogleLogin", urlPatterns = {"/CompleteGoogleLogin"})
public class CompleteGoogleLogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        
        CustomerDAO customerDAO = new CustomerDAO();
        boolean updated = customerDAO.updateUserInfo(email, address, phone);
        
        if (updated) {
            // Lấy thông tin đầy đủ của người dùng
            Customer customer = customerDAO.getCustomerByEmail(email);
            
            // Lưu thông tin người dùng vào session
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            
            // Chuyển hướng đến trang index.jsp
            response.sendRedirect(request.getContextPath() + "/JSP/index.jsp");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/JSP/additionalInfo.jsp").forward(request, response);
        }
    }
}