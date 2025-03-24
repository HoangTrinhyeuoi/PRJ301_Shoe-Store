package Controller;

import DAO.OrderDAO;
import Model.Customer;
import Model.Order;
import Model.OrderDetail;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet xử lý hiển thị và thao tác với chi tiết đơn hàng
 */
@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=orders");
            return;
        }
        
        // Lấy ID đơn hàng từ parameter
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            // Nếu không có ID, chuyển về trang danh sách đơn hàng
            request.setAttribute("errorMessage", "Không tìm thấy đơn hàng");
            request.getRequestDispatcher("/orders").forward(request, response);
            return;
        }
        
        try {
            long orderId = Long.parseLong(orderIdParam);
            
            // Lấy thông tin đơn hàng
            Order order = orderDAO.getOrderById(orderId);
            
            // Kiểm tra đơn hàng có tồn tại và thuộc về khách hàng hiện tại
            if (order == null || order.getCustomerId() != customer.getCustomerId()) {
                request.setAttribute("errorMessage", "Không tìm thấy đơn hàng hoặc bạn không có quyền xem đơn hàng này");
                request.getRequestDispatcher("/orders").forward(request, response);
                return;
            }
            
            // Lấy chi tiết đơn hàng
            List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(orderId);
            
            // Set attributes cho JSP
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            
            // Lấy thông báo từ session nếu có
            String successMessage = (String) session.getAttribute("successMessage");
            String errorMessage = (String) session.getAttribute("errorMessage");
            
            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage"); // Xóa sau khi đã lấy
            }
            
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                session.removeAttribute("errorMessage"); // Xóa sau khi đã lấy
            }
            
            // Forward đến trang chi tiết đơn hàng
            request.getRequestDispatcher("/JSP/orderDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ");
            request.getRequestDispatcher("/orders").forward(request, response);
        }
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
        
        // Lấy action từ parameter
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        // Lấy ID đơn hàng từ parameter
        String orderIdParam = request.getParameter("orderId");
        
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            session.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        try {
            long orderId = Long.parseLong(orderIdParam);
            
            // Lấy thông tin đơn hàng
            Order order = orderDAO.getOrderById(orderId);
            
            // Kiểm tra đơn hàng có tồn tại và thuộc về khách hàng hiện tại
            if (order == null || order.getCustomerId() != customer.getCustomerId()) {
                session.setAttribute("errorMessage", "Không tìm thấy đơn hàng hoặc bạn không có quyền thao tác với đơn hàng này");
                response.sendRedirect(request.getContextPath() + "/orders");
                return;
            }
            
            // Xử lý các action
            switch (action) {
                case "cancelOrder":
                    cancelOrder(request, response, order);
                    break;
                    
                default:
                    response.sendRedirect(request.getContextPath() + "/order-detail?id=" + orderId);
                    break;
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }
    
    /**
     * Xử lý hủy đơn hàng
     */
    private void cancelOrder(HttpServletRequest request, HttpServletResponse response, Order order)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Kiểm tra đơn hàng có thể hủy không
        if (!"PENDING".equals(order.getStatus())) {
            session.setAttribute("errorMessage", "Đơn hàng đã được xử lý và không thể hủy");
            response.sendRedirect(request.getContextPath() + "/order-detail?id=" + order.getId());
            return;
        }
        
        // Lấy lý do hủy
        String reason = request.getParameter("reason");
        
        if (reason == null || reason.isEmpty()) {
            reason = "Khách hàng hủy đơn";
        } else if ("OTHER".equals(reason)) {
            String otherReason = request.getParameter("otherReason");
            if (otherReason != null && !otherReason.isEmpty()) {
                reason = otherReason;
            }
        }
        
        // Thực hiện hủy đơn hàng
        boolean result = orderDAO.cancelOrder(order.getId(), reason);
        
        if (result) {
            session.setAttribute("successMessage", "Đơn hàng #" + order.getId() + " đã được hủy thành công");
        } else {
            session.setAttribute("errorMessage", "Không thể hủy đơn hàng. Vui lòng thử lại sau");
        }
        
        // Chuyển hướng về trang danh sách đơn hàng
        response.sendRedirect(request.getContextPath() + "/orders");
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý chi tiết đơn hàng";
    }
}