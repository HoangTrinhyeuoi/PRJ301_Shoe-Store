<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Thông Tin</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; }
        form { max-width: 400px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        label { font-weight: bold; display: block; margin-top: 10px; }
        input { width: 100%; padding: 8px; margin-top: 5px; }
        button { margin-top: 15px; background-color: #28a745; color: white; padding: 10px; border: none; cursor: pointer; }
        button:hover { background-color: #218838; }
        .message { text-align: center; margin-top: 10px; }
    </style>
</head>
<body>
    <h2 align="center">Cập Nhật Thông Tin Cá Nhân</h2>
    <c:if test="${empty sessionScope.user}">
        <p style="color: red; text-align: center;">Bạn chưa đăng nhập! <a href="${pageContext.request.contextPath}/JSP/login.jsp">Đăng nhập ngay</a></p>
    </c:if>
    <c:if test="${not empty sessionScope.user}">
        <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="post">
            <label>Email:</label>
            <input type="email" name="email" value="${sessionScope.user.email}" readonly>
            <label>Họ và Tên:</label>
            <input type="text" name="fullName" value="${sessionScope.user.fullName}" required>
            <label>Số Điện Thoại:</label>
            <input type="text" name="phoneNumber" value="${sessionScope.user.phoneNumber}" required>
            <button type="submit">Cập Nhật</button>
        </form>
    </c:if>
    <div class="message">
        <c:if test="${not empty message}">
            <p style="color: green">${message}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p style="color: red">${error}</p>
        </c:if>
    </div>
    <p align="center"><a href="${pageContext.request.contextPath}/JSP/profile.jsp">Quay lại trang cá nhân</a></p>
</body>
</html>