package Controller;

import DAO.OrderDAO;
import Model.Customer;
import Model.Order;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet xử lý hiển thị danh sách đơn hàng của khách hàng
 */
@WebServlet(name = "OrdersServlet", urlPatterns = {"/orders"})
public class OrdersServlet extends HttpServlet {

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
        
        // Log thông tin khách hàng để debug
        System.out.println("OrdersServlet: Customer ID = " + customer.getCustomerId());
        
        // Xử lý phân trang
        int page = 1;
        int ordersPerPage = 5; // Số đơn hàng mỗi trang
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                // Nếu không phải số, mặc định trang 1
                page = 1;
            }
        }
        
        // Xử lý lọc theo trạng thái
        String statusFilter = request.getParameter("status");
        String sortOrder = request.getParameter("sort");
        
        System.out.println("OrdersServlet: Status filter = " + statusFilter);
        System.out.println("OrdersServlet: Sort order = " + sortOrder);
        
        // Lấy tổng số đơn hàng để tính số trang
        int totalOrders = orderDAO.getOrderCount(customer.getCustomerId(), statusFilter);
        int totalPages = (int) Math.ceil((double) totalOrders / ordersPerPage);
        
        System.out.println("OrdersServlet: Total orders = " + totalOrders);
        System.out.println("OrdersServlet: Total pages = " + totalPages);
        
        // Đảm bảo trang hiện tại không vượt quá tổng số trang
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }
        
        // Lấy danh sách đơn hàng theo trang
        List<Order> orders = orderDAO.getFilteredOrders(
                customer.getCustomerId(), 
                statusFilter,  
                sortOrder, 
                page, 
                ordersPerPage
        );
        
        System.out.println("OrdersServlet: Found " + orders.size() + " orders");
        
        // Set attributes cho JSP
        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        
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
        
        // Forward đến trang JSP
        request.getRequestDispatcher("/JSP/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // POST request có thể được xử lý bởi các servlet khác (như OrderDetailServlet)
        // Nếu có yêu cầu xử lý POST ở đây, thêm logic tương ứng
        response.sendRedirect(request.getContextPath() + "/orders");
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị danh sách đơn hàng";
    }
}