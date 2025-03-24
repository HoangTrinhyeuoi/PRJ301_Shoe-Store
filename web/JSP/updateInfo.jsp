<%-- 
    Document   : updateInfo
    Created on : Mar 22, 2025, 2:06:08 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật thông tin</title>
</head>
<body>
    <h2>Cập nhật thông tin cá nhân</h2>
    <form action="${pageContext.request.contextPath}/update" method="post">
        <label>Email:</label>
        <input type="text" name="email" value="${sessionScope.user.email}" readonly><br>

        <label>Số điện thoại:</label>
        <input type="text" name="phone" required><br>

        <label>Địa chỉ:</label>
        <input type="text" name="address" required><br>

        <button type="submit">Cập nhật</button>
    </form>
</body>
</html>
