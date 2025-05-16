package Controller;

import DAO.OrderDAO;
import Model.Customer;
import Model.Order;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet xử lý hiển thị trang xác nhận đơn hàng sau khi thanh toán
 */
@WebServlet(name = "OrderConfirmationServlet", urlPatterns = {"/order-confirmation"})
public class OrderConfirmationServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy thông tin đơn hàng từ session hoặc parameter
        String orderIdParam = request.getParameter("orderId");
        String successMessage = (String) session.getAttribute("checkoutSuccessMessage");
        
        // Xóa thông báo thành công khỏi session để tránh hiển thị lại
        session.removeAttribute("checkoutSuccessMessage");
        
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            // Nếu không có ID đơn hàng, chuyển về trang chủ
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            long orderId = Long.parseLong(orderIdParam);
            
            // Lấy thông tin đơn hàng
            Order order = orderDAO.getOrderById(orderId);
            
            // Kiểm tra đơn hàng có tồn tại và thuộc về khách hàng hiện tại
            if (order == null || order.getCustomerId() != customer.getCustomerId()) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            
            // Set attributes cho JSP
            request.setAttribute("orderId", orderId);
            request.setAttribute("totalAmount", order.getTotalAmount());
            
            if (successMessage != null && !successMessage.isEmpty()) {
                request.setAttribute("successMessage", successMessage);
            } else {
                request.setAttribute("successMessage", "Đơn hàng của bạn đã được đặt thành công!");
            }
            
            // Forward đến trang JSP
            request.getRequestDispatcher("/JSP/order-confirmation.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // POST requests không được hỗ trợ cho servlet này
        response.sendRedirect(request.getContextPath() + "/orders");
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý trang xác nhận đơn hàng";
    }
}