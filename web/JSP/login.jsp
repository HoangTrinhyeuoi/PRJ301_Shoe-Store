<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="CSS/login.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Sneaker Space</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>

<!-- Form đăng nhập -->
<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4 shadow-lg" style="width: 400px;">
        <h2 class="text-center mb-3">Đăng Nhập</h2>

        <%-- Hiển thị thông báo lỗi nếu có --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger text-center">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="POST">
            <div class="mb-3">
                <input type="email" class="form-control" name="email" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Mật khẩu" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">ĐĂNG NHẬP</button>
            <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/Group_Assignment/loginG&response_type=code&client_id=645828963442-9upejmnjb1ai3s92prkvjq5brh8n1al9.apps.googleusercontent.com&access_type=offline&prompt=consent" class="btn btn-danger w-100">
                <i class="bi bi-google"></i> Đăng nhập bằng Google
            </a>
        </form>

        <div class="text-center mt-3">
            <a href="register.jsp">Bạn chưa có tài khoản?</a>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-3">
    <p>&copy; 2025 Sneaker Space</p>
    <p>236 Nguyễn Phúc Chu, P.Nam Ngạn, TP.Thanh Hoá, Thanh Hoá</p>
    <p>Tel: 0329652824</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
