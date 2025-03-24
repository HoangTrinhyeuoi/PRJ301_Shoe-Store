<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Orders" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("role") == null || !userSession.getAttribute("role").equals("admin")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Orders> orderList = (List<Orders>) request.getAttribute("orderList");
%>

<html>
<head>
    <title>Quản lý Đơn hàng</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Quản lý Đơn hàng</h2>
    <table>
        <tr>
            <th>Mã đơn hàng</th>
            <th>Mã khách hàng</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        <% if (orderList != null && !orderList.isEmpty()) { %>
            <% for (Orders order : orderList) { %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getCustomerId() %></td>
                    <td><%= order.getStatus() %></td>
                    <td>
                        <a href="edit_order.jsp?id=<%= order.getOrderId() %>">Sửa</a> |
                        <a href="delete_order.jsp?id=<%= order.getOrderId() %>">Xóa</a>
                    </td>
                </tr>
            <% } %>
        <% } else { %>
            <tr>
                <td colspan="4">Không có đơn hàng nào để hiển thị.</td>
            </tr>
        <% } %>
    </table>
    <a href="admin/dashboard.jsp">Quay lại</a>
</body>
</html>