package Controller.admin;

import DAO.OrderDAO;
import Model.Order;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public class OrderAdminServlet extends HttpServlet {

    OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        switch (action) {
            case "add" -> {
                try {
                    addOrder(request);
                } catch (SQLException ex) {
                    Logger.getLogger(OrderAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "edit" -> {
                try {
                    editOrder(request);
                } catch (SQLException ex) {
                    Logger.getLogger(OrderAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "delete" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                orderDAO.deleteOrder(id);
            }
        }

        response.sendRedirect("../dashboard_Order");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<Order> listOrder = orderDAO.GetAllOrders();

        session.setAttribute("listOrder", listOrder);

        req.getRequestDispatcher("JSP/admin/dashboard_Order.jsp").forward(req, resp);
    }

    private void addOrder(HttpServletRequest request) throws SQLException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        double paidAmount = Double.parseDouble(request.getParameter("paidAmount"));
        String status = request.getParameter("status");

        Order order = new Order();
        order.setCustomerId(customerId);
        order.setTotalAmount(totalAmount);
        order.setPaidAmount(paidAmount);
        order.setStatus(status);

        orderDAO.insertOrder(order);
    }

    private void editOrder(HttpServletRequest request) throws SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        double paidAmount = Double.parseDouble(request.getParameter("paidAmount"));
        String status = request.getParameter("status");

        Order order = new Order();
        order.setId(id);
        order.setCustomerId(customerId);
        order.setTotalAmount(totalAmount);
        order.setPaidAmount(paidAmount);
        order.setStatus(status);

        orderDAO.updateOrder(order);
    }
}