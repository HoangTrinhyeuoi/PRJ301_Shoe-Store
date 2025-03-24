package controller;

import DAO.OrdersDAO;
import Model.Orders;
import DAO.DBconnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/manage-orders") // Đổi URL
public class ManageOrdersServlet extends HttpServlet {
    private OrdersDAO ordersDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = DBconnection.getConnection();
        ordersDAO = new OrdersDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Orders> orderList = ordersDAO.getAllOrders();
            request.setAttribute("orderList", orderList);
            request.getRequestDispatcher("/admin/manage_orders.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("newStatus");

        try {
            ordersDAO.updateOrderStatus(orderId, newStatus);
            response.sendRedirect("manage-orders");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
