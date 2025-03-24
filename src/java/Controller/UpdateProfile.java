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

/**
 *
 * @author ASUS
 */

public class UpdateProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        CustomerDAO customerDAO = new CustomerDAO();

        // Lấy thông tin người dùng từ session
        Customer customer = (Customer) session.getAttribute("customer");
        UserGoogleDto googleUser = (UserGoogleDto) session.getAttribute("user");

        boolean isSQLUser = (customer != null);
        boolean isGoogleUser = (googleUser != null);

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (isSQLUser) {
            // Cập nhật thông tin người dùng SQL
            customer.setFullName(fullName);
            customer.setPhoneNumber(phone);
            customer.setAddress(address);

            // Nếu có đổi mật khẩu
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (currentPassword != null && newPassword != null && confirmPassword != null) {
                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
                    request.getRequestDispatcher("/JSP/editProfile.jsp").forward(request, response);
                    return;
                }

                boolean isPasswordCorrect = customerDAO.checkPassword(customer.getEmail(), currentPassword);
                if (!isPasswordCorrect) {
                    request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                    request.getRequestDispatcher("/JSP/editProfile.jsp").forward(request, response);
                    return;
                }

                // Cập nhật mật khẩu
                customerDAO.updatePassword(customer.getEmail(), newPassword);
            }

            // Lưu thông tin cập nhật
            customerDAO.updateCustomer(customer);
            session.setAttribute("customer", customer);

        } else if (isGoogleUser) {
            // Cập nhật thông tin người dùng Google (trong database)
            Customer googleCustomer = customerDAO.getCustomerByEmail(googleUser.getEmail());
            if (googleCustomer != null) {
                googleCustomer.setFullName(fullName);
                googleCustomer.setPhoneNumber(phone);
                googleCustomer.setAddress(address);

                customerDAO.updateCustomer(googleCustomer);
            }
        }

        response.sendRedirect(request.getContextPath() + "/JSP/profile.jsp");
    }
}

