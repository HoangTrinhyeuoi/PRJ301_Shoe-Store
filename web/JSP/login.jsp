<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập | Sneaker Space</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #3a7bd5;
            --primary-gradient: linear-gradient(to right, #3a7bd5, #00d2ff);
            --secondary-color: #2d3436;
            --text-color: #2d3436;
            --light-color: #f8f9fa;
            --google-color: #db4437;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #f8f9fa;
            background-image: url('https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 0;
        }

        .navbar {
            background-color: rgba(0, 0, 0, 0.7) !important;
            backdrop-filter: blur(10px);
            padding: 15px 0;
            z-index: 100;
            position: relative;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.8rem;
            color: white !important;
            letter-spacing: 1px;
        }

        .navbar-brand i {
            color: var(--primary-color);
            margin-right: 8px;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 132px); /* 132px = navbar + footer */
            position: relative;
            z-index: 10;
            padding: 30px 0;
        }

        .login-card {
            width: 400px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 2.5rem;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--primary-gradient);
        }

        .login-card h2 {
            font-weight: 700;
            color: var(--text-color);
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 2rem;
            letter-spacing: 0.5px;
        }

        .login-card h2::after {
            content: '';
            display: block;
            width: 50px;
            height: 3px;
            background: var(--primary-gradient);
            margin: 0.7rem auto 0;
            border-radius: 5px;
        }

        .input-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-group input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1px solid #dfe6e9;
            border-radius: 10px;
            font-size: 1rem;
            color: var(--text-color);
            background-color: #f8f9fa;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(58, 123, 213, 0.15);
            outline: none;
            background-color: white;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 15px;
            color: #b2bec3;
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }

        .input-group input:focus + i {
            color: var(--primary-color);
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            background: var(--primary-gradient);
            color: white;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(58, 123, 213, 0.3);
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 1rem;
        }

        .btn-login:hover {
            box-shadow: 0 8px 20px rgba(58, 123, 213, 0.4);
            transform: translateY(-2px);
        }

        .btn-google {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            background: var(--google-color);
            color: white;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(219, 68, 55, 0.3);
            font-size: 1rem;
            text-decoration: none;
        }

        .btn-google i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .btn-google:hover {
            box-shadow: 0 8px 20px rgba(219, 68, 55, 0.4);
            transform: translateY(-2px);
            text-decoration: none;
            color: white;
        }

        .separator {
            display: flex;
            align-items: center;
            color: #b2bec3;
            margin: 1rem 0;
        }

        .separator::before,
        .separator::after {
            content: '';
            flex: 1;
            height: 1px;
            background-color: #dfe6e9;
        }

        .separator::before {
            margin-right: 0.5rem;
        }

        .separator::after {
            margin-left: 0.5rem;
        }

        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            color: var(--text-color);
            font-weight: 500;
        }

        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            background-color: #fff5f5;
            border-left: 4px solid #ff3b30;
            color: #ff3b30;
            padding: 10px 15px;
            margin-bottom: 1.5rem;
            border-radius: 5px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }

        .error-message i {
            margin-right: 10px;
            font-size: 1.1rem;
        }

        footer {
            background-color: rgba(0, 0, 0, 0.85);
            color: white;
            padding: 15px 0;
            position: relative;
            z-index: 10;
            margin-top: auto;
            backdrop-filter: blur(10px);
        }

        footer p {
            margin-bottom: 0.3rem;
            font-size: 0.9rem;
            opacity: 0.9;
        }

        footer p:first-child {
            font-weight: 600;
        }

        /* Hiệu ứng nổi cho social icons */
        .social-icons {
            display: flex;
            justify-content: center;
            margin-top: 0.5rem;
        }

        .social-icons a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            margin: 0 8px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            transition: all 0.3s ease;
        }

        .social-icons a:hover {
            background-color: var(--primary-color);
            transform: translateY(-3px);
        }

        /* Hiệu ứng thêm */
        .animated-bg {
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: var(--primary-gradient);
            border-radius: 50%;
            opacity: 0.1;
            z-index: -1;
        }

        .animated-bg:nth-child(2) {
            bottom: -70px;
            left: -70px;
            top: unset;
            right: unset;
            width: 250px;
            height: 250px;
        }

        @media (max-width: 576px) {
            .login-card {
                width: 90%;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
                <i class="fas fa-shoe-prints"></i>Sneaker Space
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>

    <!-- Form đăng nhập -->
    <div class="login-container">
        <div class="login-card">
            <div class="animated-bg"></div>
            <div class="animated-bg"></div>
            
            <h2>Đăng Nhập</h2>
            
            <%-- Hiển thị thông báo lỗi nếu có --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="input-group">
                    <input type="email" name="email" placeholder="Email" required>
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="input-group">
                    <input type="password" name="password" placeholder="Mật khẩu" required>
                    <i class="fas fa-lock"></i>
                </div>
                
                <%-- Thêm input ẩn để lưu tham số redirect --%>
                <% 
                String redirectURL = (String) request.getAttribute("redirect");
                if (redirectURL == null) {
                    redirectURL = request.getParameter("redirect");
                }
                if (redirectURL != null && !redirectURL.isEmpty()) {
                %>
                    <input type="hidden" name="redirect" value="<%= redirectURL %>">
                <% } %>
                
                <button type="submit" class="btn-login">Đăng Nhập</button>
                
                <div class="separator">hoặc</div>
                
                <%-- Nút đăng nhập Google đã được cập nhật --%>
                <% 
                // Tạo URL Google đăng nhập
                String googleLoginUrl = "https://accounts.google.com/o/oauth2/auth" +
                    "?scope=email%20profile%20openid" +
                    "&redirect_uri=http://localhost:8080/Group_Assignment/loginG" +
                    "&response_type=code" +
                    "&client_id=645828963442-9upejmnjb1ai3s92prkvjq5brh8n1al9.apps.googleusercontent.com" +
                    "&access_type=offline" +
                    "&prompt=consent";

                    
                // Thêm tham số redirect vào URL nếu cần
                if (redirectURL != null && !redirectURL.isEmpty()) {
                    // Thêm tham số redirect vào URL Google để servlet có thể đọc nó
                    googleLoginUrl += "&state=" + redirectURL;
                }
                %>
                
                <a href="<%= googleLoginUrl %>" class="btn-google">
                    <i class="fab fa-google"></i> Đăng nhập bằng Google
                </a>
            </form>
            
            <div class="register-link">
                Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p>&copy; 2025 Sneaker Space</p>
            <p>236 Nguyễn Phúc Chu, P.Nam Ngạn, TP.Thanh Hoá, Thanh Hoá</p>
            <p>Tel: 0329652824</p>
            
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>