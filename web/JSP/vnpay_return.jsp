<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả thanh toán</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome cho icon -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .payment-result-container {
            max-width: 500px;
            text-align: center;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .message {
            font-size: 18px;
            margin-bottom: 20px;
            color: #333;
        }
        .btn-home {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-home:hover {
            background-color: #0056b3;
            color: #fff;
        }
        .redirect-message {
            font-size: 14px;
            color: #666;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="payment-result-container">
        <!-- Hiển thị thông báo chính -->
        <p class="message"><c:out value="${message}" /></p>
        <a href="${pageContext.request.contextPath}/JSP/index.jsp" class="btn-home">
            <i class="fas fa-home me-2"></i>Quay về trang chủ
        </a>
        <p class="redirect-message">Bạn sẽ được tự động điều hướng về trang chủ sau 15 giây...</p>
    </div>

    <!-- JavaScript để tự động điều hướng sau 15 giây -->
    <script>
        setTimeout(function() {
            window.location.href = "${pageContext.request.contextPath}/JSP/index.jsp";
        }, 15000); // 15 giây = 15000 milliseconds
    </script>

    <!-- Bootstrap JS (cho các tính năng như tooltip, nếu cần) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>