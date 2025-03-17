/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import Model.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class LoginServlet extends HttpServlet {

    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Customer customer = customerDAO.login(email, password);

        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            request.getRequestDispatcher("/JSP/index.jsp").forward(request, response); // Chuyển hướng sau khi đăng nhập thành công
        } else {
            request.setAttribute("errorMessage", "Sai tài khoản hoặc mật khẩu!");
            request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
        }
    }
}
