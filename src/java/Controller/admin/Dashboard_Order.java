package Controller.admin;

import DAO.OrderDAO;
import Model.Order;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Dashboard_Order extends HttpServlet {

    OrderDAO orderDao = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Order> listOrder = orderDao.GetAllOrders();

        session.setAttribute("listOrder", listOrder);

        // Forward to dashboard
        request.getRequestDispatcher("JSP/admin/dashboard_Order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
