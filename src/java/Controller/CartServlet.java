package Controller;

import DAO.CartDAO;
import Model.CartItem;
import Model.Customer;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final Gson gson = new GsonBuilder().create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart-page");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contentType = request.getContentType();
        boolean isFormSubmit = contentType != null && contentType.contains("application/x-www-form-urlencoded")
                && request.getParameter("formSubmit") != null;

        // Xử lý form submission từ cart.jsp
        if (isFormSubmit) {
            processFormSubmission(request, response);
            return;
        }

        // Xử lý Ajax request như trước
        processAjaxRequest(request, response);
    }

    private void processFormSubmission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        try {
            switch (action) {
                case "increase" ->
                    cartDAO.increaseCartItemQuantity(customer.getCustomerId(), productId);

                case "decrease" ->
                    cartDAO.decreaseCartItemQuantity(customer.getCustomerId(), productId);

                case "update" -> {
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartDAO.updateCartItem(customer.getCustomerId(), productId, quantity);
                }

                case "remove" ->
                    cartDAO.removeFromCart(customer.getCustomerId(), productId);
            }

            // After processing, redirect back to cart page
            response.sendRedirect(request.getContextPath() + "/cart-page");

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi xử lý giỏ hàng: " + e.getMessage());
            request.getRequestDispatcher("/cart-page").forward(request, response);
        }
    }

    private void processAjaxRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Log tất cả các tham số từ request để debug
            System.out.println("=== DEBUG REQUEST PARAMETERS ===");
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String[] paramValues = request.getParameterValues(paramName);
                for (String paramValue : paramValues) {
                    System.out.println(paramName + " = " + paramValue);
                }
            }
            System.out.println("================================");

            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");

            if (customer == null) {
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "Bạn cần đăng nhập để thao tác với giỏ hàng!");

                out.print(gson.toJson(jsonResponse));
                return;
            }

            // Lấy action từ parameter
            String action = request.getParameter("action");
            System.out.println("Nhận action: " + action); // Debug

            // Original AJAX processing code - maintain all your existing functionality
            if ("add".equals(action)) {
                // Existing code for add action
                String productIdParam = request.getParameter("productId");
                String quantityParam = request.getParameter("quantity");

                System.out.println("Raw productId: " + productIdParam); // Debug
                System.out.println("Raw quantity: " + quantityParam); // Debug

                if (productIdParam == null || productIdParam.trim().isEmpty()) {
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Mã sản phẩm không được để trống");
                    out.print(gson.toJson(jsonResponse));
                    return;
                }

                if (quantityParam == null || quantityParam.trim().isEmpty()) {
                    quantityParam = "1";
                }

                try {
                    int productId = Integer.parseInt(productIdParam.trim());
                    int quantity = Integer.parseInt(quantityParam.trim());

                    if (quantity <= 0) {
                        quantity = 1;
                    }

                    System.out.println("Thêm sản phẩm: " + productId + ", Số lượng: " + quantity); // Debug

                    Map<String, String> result = cartDAO.addToCart(customer.getCustomerId(), productId, quantity);

                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", result.get("status"));
                    jsonResponse.addProperty("message", result.get("message"));

                    if ("success".equals(result.get("status"))) {
                        int itemCount = cartDAO.getCartItemCount(customer.getCustomerId());
                        jsonResponse.addProperty("itemCount", itemCount);
                    }

                    out.print(gson.toJson(jsonResponse));
                } catch (NumberFormatException e) {
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Lỗi định dạng số: " + e.getMessage());
                    out.print(gson.toJson(jsonResponse));
                }
            } else if ("update".equals(action)) {
                // Existing code for update action
                try {
                    String productIdParam = request.getParameter("productId");
                    String quantityParam = request.getParameter("quantity");

                    if (productIdParam == null || quantityParam == null) {
                        throw new IllegalArgumentException("Thiếu tham số cần thiết");
                    }

                    int productId = Integer.parseInt(productIdParam.trim());
                    int quantity = Integer.parseInt(quantityParam.trim());

                    if (quantity <= 0) {
                        Map<String, String> result = cartDAO.removeFromCart(customer.getCustomerId(), productId);

                        JsonObject jsonResponse = new JsonObject();
                        jsonResponse.addProperty("status", result.get("status"));
                        jsonResponse.addProperty("message", "Đã xóa sản phẩm khỏi giỏ hàng");

                        int itemCount = cartDAO.getCartItemCount(customer.getCustomerId());
                        double cartTotal = cartDAO.getCartTotal(customer.getCustomerId());
                        jsonResponse.addProperty("itemCount", itemCount);
                        jsonResponse.addProperty("cartTotal", cartTotal);

                        out.print(gson.toJson(jsonResponse));
                    } else {
                        Map<String, String> result = cartDAO.updateCartItem(customer.getCustomerId(), productId, quantity);

                        JsonObject jsonResponse = new JsonObject();
                        jsonResponse.addProperty("status", result.get("status"));
                        jsonResponse.addProperty("message", result.get("message"));

                        if ("success".equals(result.get("status"))) {
                            double cartTotal = cartDAO.getCartTotal(customer.getCustomerId());
                            jsonResponse.addProperty("cartTotal", cartTotal);
                        }

                        out.print(gson.toJson(jsonResponse));
                    }
                } catch (Exception e) {
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Lỗi cập nhật giỏ hàng: " + e.getMessage());
                    out.print(gson.toJson(jsonResponse));
                }
            } // Continue with all your existing AJAX handlers
            else if ("remove".equals(action)) {
                // Existing code for remove action
                try {
                    String productIdParam = request.getParameter("productId");

                    if (productIdParam == null) {
                        throw new IllegalArgumentException("Thiếu mã sản phẩm");
                    }

                    int productId = Integer.parseInt(productIdParam.trim());

                    Map<String, String> result = cartDAO.removeFromCart(customer.getCustomerId(), productId);

                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", result.get("status"));
                    jsonResponse.addProperty("message", result.get("message"));

                    if ("success".equals(result.get("status"))) {
                        int itemCount = cartDAO.getCartItemCount(customer.getCustomerId());
                        double cartTotal = cartDAO.getCartTotal(customer.getCustomerId());
                        jsonResponse.addProperty("itemCount", itemCount);
                        jsonResponse.addProperty("cartTotal", cartTotal);
                    }

                    out.print(gson.toJson(jsonResponse));
                } catch (Exception e) {
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Lỗi xóa sản phẩm: " + e.getMessage());
                    out.print(gson.toJson(jsonResponse));
                }
            } else if ("clear".equals(action)) {
                // Existing code for clear action
                try {
                    Map<String, String> result = cartDAO.clearCart(customer.getCustomerId());

                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", result.get("status"));
                    jsonResponse.addProperty("message", result.get("message"));

                    out.print(gson.toJson(jsonResponse));
                } catch (Exception e) {
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Lỗi xóa giỏ hàng: " + e.getMessage());
                    out.print(gson.toJson(jsonResponse));
                }
            } else if ("checkout".equals(action)) {
                // Existing code for checkout action
                try {
                    Map<String, String> result = cartDAO.checkoutCart(customer.getCustomerId());

                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", result.get("status"));
                    jsonResponse.addProperty("message", result.get("message"));

                    if ("success".equals(result.get("status")) && result.containsKey("orderId")) {
                        jsonResponse.addProperty("orderId", result.get("orderId"));
                    }

                    out.print(gson.toJson(jsonResponse));
                } catch (Exception e) {
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("status", "error");
                    jsonResponse.addProperty("message", "Lỗi thanh toán: " + e.getMessage());
                    out.print(gson.toJson(jsonResponse));
                }
            } else {
                // Handle unknown actions
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "Không xác định được hành động: " + action);
                out.print(gson.toJson(jsonResponse));
            }
        } catch (Exception e) {
            // Bắt tất cả các ngoại lệ và luôn trả về JSON
            System.out.println("Lỗi ngoại lệ chung: " + e.getMessage());
            e.printStackTrace();

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Lỗi xử lý: " + e.getMessage());

            out.print(gson.toJson(jsonResponse));
        }
    }

    @Override
    public String getServletInfo() {
        return "Cart Servlet";
    }
}
