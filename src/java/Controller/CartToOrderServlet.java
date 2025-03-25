package Controller;

import DAO.OrderDAO;
import Model.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * Servlet xử lý chuyển đổi giỏ hàng thành đơn hàng
 */
@WebServlet(name = "CartToOrderServlet", urlPatterns = {"/checkout"})
public class CartToOrderServlet extends HttpServlet {
    
    private final OrderDAO orderDAO = new OrderDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET request chuyển hướng đến trang giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart-page");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");
            
            if (customer == null) {
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "Bạn cần đăng nhập để thực hiện thanh toán!");
                jsonResponse.addProperty("redirect", request.getContextPath() + "/login?redirect=cart-page");
                
                out.print(gson.toJson(jsonResponse));
                return;
            }
            
            // Tạo đơn hàng từ giỏ hàng
            Map<String, String> result = orderDAO.createOrderFromCart(customer.getCustomerId());
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", result.get("status"));
            jsonResponse.addProperty("message", result.get("message"));
            
            // Nếu tạo đơn hàng thành công, lưu thông báo vào session và chuyển hướng đến trang xác nhận
            if ("success".equals(result.get("status")) && result.containsKey("orderId")) {
                // Lưu thông báo thành công vào session để hiển thị ở trang xác nhận
                session.setAttribute("checkoutSuccessMessage", result.get("message"));
                
                jsonResponse.addProperty("orderId", result.get("orderId"));
                jsonResponse.addProperty("redirect", request.getContextPath() + "/order-confirmation?orderId=" + result.get("orderId"));
            }
            
            out.print(gson.toJson(jsonResponse));
        } catch (Exception e) {
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Lỗi khi xử lý thanh toán: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý chuyển đổi giỏ hàng thành đơn hàng";
    }
}