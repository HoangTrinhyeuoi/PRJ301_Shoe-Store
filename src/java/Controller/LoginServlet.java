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
    
    // Thêm phương thức doGet để xử lý GET request
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số redirect nếu có
        String redirectURL = request.getParameter("redirect");
        if (redirectURL != null && !redirectURL.isEmpty()) {
            // Lưu lại tham số redirect vào request để form login có thể sử dụng
            request.setAttribute("redirect", redirectURL);
        }
        
        // Chuyển hướng đến trang đăng nhập
        request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Lấy tham số redirect từ form (nếu có)
        String redirectURL = request.getParameter("redirect");
        
        Customer customer = customerDAO.login(email, password);
        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            
            // Nếu có URL redirect, chuyển hướng đến URL đó sau khi đăng nhập thành công
            if (redirectURL != null && !redirectURL.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/" + redirectURL);
            } else {
                // Nếu không có URL redirect, chuyển hướng đến trang chủ
                request.getRequestDispatcher("/JSP/index.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Sai tài khoản hoặc mật khẩu!");
            // Lưu lại tham số redirect để form vẫn giữ được thông tin này sau khi đăng nhập thất bại
            if (redirectURL != null && !redirectURL.isEmpty()) {
                request.setAttribute("redirect", redirectURL);
            }
            request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
        }
    }
}