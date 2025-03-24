<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, Model.Items" %>

<%
    List<Items> productList = (List<Items>) request.getAttribute("productList"); 
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 10px; text-align: center; }
        th { background-color: #f2f2f2; }
        form { display: inline; }
    </style>
</head>
<body>
    <h2>Quản lý Sản phẩm</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên sản phẩm</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        <% if (productList != null && !productList.isEmpty()) { 
            for (Items product : productList) { %>
        <tr>
            <td><%= product.getProductId() %></td>
            <td><%= product.getProductName() %></td>
            <td><%= product.getPrice() %></td>
            <td><%= product.getStock() %></td>
            <td><%= product.getStatus() %></td>
            <td>
                <form action="manage-products" method="post">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                    <select name="status">
                        <option value="Còn hàng" <%= "Còn hàng".equals(product.getStatus()) ? "selected" : "" %>>Còn hàng</option>
                        <option value="Hết hàng" <%= "Hết hàng".equals(product.getStatus()) ? "selected" : "" %>>Hết hàng</option>
                    </select>
                    <button type="submit">Cập nhật</button>
                </form>
            </td>
        </tr>
        <%  }} else { %>
        <tr><td colspan="6">Không có sản phẩm nào.</td></tr>
        <% } %>
    </table>
    <a href="admin/dashboard.jsp">Quay lại</a>
</body>
</html>
