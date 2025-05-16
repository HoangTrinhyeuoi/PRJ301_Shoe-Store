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
 * Servlet xử lý hủy đơn hàng
 */
@WebServlet(name = "CancelOrderServlet", urlPatterns = {"/cancel-order"})
public class CancelOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET request sẽ chuyển hướng đến trang danh sách đơn hàng
        response.sendRedirect(request.getContextPath() + "/orders");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=orders");
            return;
        }
        
        // Lấy thông tin từ form
        String orderIdParam = request.getParameter("orderId");
        String reason = request.getParameter("reason");
        String csrfToken = request.getParameter("csrfToken");
        
        // Kiểm tra CSRF token (bảo vệ khỏi tấn công CSRF)
        String sessionToken = (String) session.getAttribute("csrfToken");
        if (sessionToken == null || !sessionToken.equals(csrfToken)) {
            request.setAttribute("errorMessage", "Yêu cầu không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("/JSP/orders.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra tham số
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            request.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ");
            request.getRequestDispatcher("/JSP/orders.jsp").forward(request, response);
            return;
        }
        
        if (reason == null || reason.isEmpty()) {
            reason = "Khách hàng hủy đơn";
        } else if ("OTHER".equals(reason)) {
            String otherReason = request.getParameter("otherReason");
            if (otherReason != null && !otherReason.isEmpty()) {
                reason = otherReason;
            }
        }
        
        try {
            long orderId = Long.parseLong(orderIdParam);
            
            // Lấy thông tin đơn hàng để kiểm tra
            Order order = orderDAO.getOrderById(orderId);
            
            // Kiểm tra đơn hàng có thuộc về khách hàng này không
            if (order == null || order.getCustomerId() != customer.getCustomerId()) {
                request.setAttribute("errorMessage", "Không tìm thấy đơn hàng hoặc bạn không có quyền hủy đơn hàng này");
                request.getRequestDispatcher("/JSP/orders.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra đơn hàng có thể hủy không (chỉ hủy được khi đơn hàng đang chờ xử lý)
            if (!"PENDING".equals(order.getOrderStatus())) {
                request.setAttribute("errorMessage", "Đơn hàng đã được xử lý và không thể hủy");
                request.getRequestDispatcher("/JSP/orders.jsp").forward(request, response);
                return;
            }
            
            // Thực hiện hủy đơn hàng
            boolean result = orderDAO.cancelOrder(orderId, reason);
            
            if (result) {
                request.setAttribute("successMessage", "Đơn hàng #" + orderId + " đã được hủy thành công");
            } else {
                request.setAttribute("errorMessage", "Không thể hủy đơn hàng. Vui lòng thử lại sau");
            }
            
            // Chuyển hướng về trang danh sách đơn hàng
            response.sendRedirect(request.getContextPath() + "/orders");
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ");
            request.getRequestDispatcher("/JSP/orders.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý hủy đơn hàng";
    }
}