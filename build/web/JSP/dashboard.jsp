<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.io.PrintWriter" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("role") == null || !userSession.getAttribute("role").equals("admin")) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <h2>Chào mừng Admin!</h2>
    <ul>
        <li><a href="manage_products.jsp">Quản lý Sản phẩm</a></li>
        <li><a href="manage_orders.jsp">Quản lý Đơn hàng</a></li>
        <li><a href="../logout">Đăng xuất</a></li>
    </ul>
</body>
</html>
