/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.vnpay.common;

import DAO.DBconnection;
import DAO.OrderDAO;
import Model.Order;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/**
 *
 * @author ASUS
 */


public class VNPayReturnServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("vnp_TxnRef");
        String amountStr = request.getParameter("vnp_Amount");
        String transactionStatus = request.getParameter("vnp_TransactionStatus");
        String responseCode = request.getParameter("vnp_ResponseCode");
        boolean isSuccess = "00".equals(transactionStatus) && "00".equals(responseCode);
        String message = "";

        System.out.println("🔍 VNPayReturnServlet: OrderID=" + orderIdStr + ", TransactionStatus=" + transactionStatus + ", ResponseCode=" + responseCode);

        if (orderIdStr != null && amountStr != null) {
            try {
                long orderId = Long.parseLong(orderIdStr);
                double paidAmount = Double.parseDouble(amountStr) / 100;

                OrderDAO orderDAO = new OrderDAO();
                Order order = orderDAO.getOrderById(orderId);

                if (order != null) {
                    if (order.getCustomerId() == 0) {
                        message = "Đơn hàng không có thông tin khách hàng!";
                    } else if (isSuccess) {
                        // Cập nhật trạng thái đơn hàng và số tiền thanh toán
                        orderDAO.updateOrderStatus(orderId, "PAID");
                        orderDAO.updatePaymentStatus(orderId, paidAmount);
                        message = "Thanh toán thành công qua VNPAY cho đơn hàng của khách hàng ID: " + order.getCustomerId() + "!";
                        System.out.println("✅ Thanh toán thành công: OrderID=" + orderId + ", Status=PAID");
                    } else {
                        message = "Thanh toán thất bại cho đơn hàng của khách hàng ID: " + order.getCustomerId() + "!";
                        System.out.println("❌ Thanh toán thất bại: OrderID=" + orderId);
                    }
                } else {
                    message = "Không tìm thấy đơn hàng!";
                    System.out.println("❌ Không tìm thấy đơn hàng: OrderID=" + orderId);
                }
            } catch (NumberFormatException e) {
                message = "Dữ liệu không hợp lệ!";
                System.out.println("❌ Lỗi dữ liệu không hợp lệ: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            message = "Dữ liệu không hợp lệ!";
            System.out.println("❌ Dữ liệu không hợp lệ: OrderID hoặc Amount null");
        }

        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("JSP/vnpay_return.jsp");
        dispatcher.forward(request, response);
    }
}