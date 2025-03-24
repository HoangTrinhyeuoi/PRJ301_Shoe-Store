package Controller;

import DAO.CartDAO;
import Model.CartItem;
import Model.Customer;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet hiển thị trang giỏ hàng
 */
@WebServlet(name = "CartPageServlet", urlPatterns = {"/cart-page"})
public class CartPageServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Debug để xác định vấn đề
        System.out.println("CartPageServlet: processRequest started");
        
        // Lấy thông tin người dùng từ session
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        // Kiểm tra đăng nhập
        if (customer == null) {
            // Debug
            System.out.println("CartPageServlet: User not logged in, redirecting to login");
            
            // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
            String redirectURL = request.getContextPath() + "/login?redirect=cart-page";
            System.out.println("CartPageServlet: Redirecting to " + redirectURL);
            response.sendRedirect(redirectURL);
            return;
        }
        
        try {
            // Debug
            System.out.println("CartPageServlet: User logged in, customer ID: " + customer.getCustomerId());
            
            // Lấy danh sách sản phẩm trong giỏ hàng
            List<CartItem> cartItems = cartDAO.getCartItems(customer.getCustomerId());
            System.out.println("CartPageServlet: CartItems count: " + cartItems.size());
            
            // Lấy tổng giá trị giỏ hàng
            double totalAmount = cartDAO.getCartTotal(customer.getCustomerId());
            System.out.println("CartPageServlet: Total amount: " + totalAmount);
            
            // Đặt các thuộc tính vào request để hiển thị trong JSP
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("itemCount", cartItems.size());
            
            // Debug
            System.out.println("CartPageServlet: Forward to JSP/cart.jsp");
            
            // Forward đến trang JSP hiển thị giỏ hàng
            String jspPath = "/JSP/cart.jsp";
            System.out.println("CartPageServlet: Forwarding to " + jspPath);
            request.getRequestDispatcher(jspPath).forward(request, response);
        } catch (Exception e) {
            // Xử lý lỗi
            System.out.println("Error in CartPageServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Thêm thông báo lỗi để hiển thị cho người dùng
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải giỏ hàng: " + e.getMessage());
            
            // Forward đến trang lỗi hoặc trang giỏ hàng trống với thông báo lỗi
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet hiển thị trang giỏ hàng";
    }
}