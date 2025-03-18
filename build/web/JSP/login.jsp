<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sneaker Space - Đăng Nhập</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #6a11cb;
            --secondary-color: #2575fc;
            --bg-gradient: linear-gradient(to right, #6a11cb 0%, #2575fc 100%);
            --text-color-dark: #333;
            --text-color-light: #f4f4f4;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--bg-gradient);
            color: var(--text-color-dark);
            line-height: 1.6;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 1rem;
        }

        .login-wrapper {
            display: flex;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border-radius: 20px;
            overflow: hidden;
            max-width: 1000px;
            width: 100%;
            background: white;
        }

        .login-image {
            flex: 1;
            background: url('https://images.unsplash.com/photo-1556740714-7b7cd4c vote for q070b21e2a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') no-repeat center center;
            background-size: cover;
            position: relative;
        }

        .login-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(106, 17, 203, 0.7);
            background: linear-gradient(135deg, rgba(106, 17, 203, 0.8) 0%, rgba(37, 117, 252, 0.8) 100%);
        }

        .login-content {
            flex: 1;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h2 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .form-control {
            border: 2px solid #e0e0e0;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(106, 17, 203, 0.25);
        }

        .btn-login {
            background: var(--bg-gradient);
            color: white;
            border: none;
            padding: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: transform 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            color: white;
        }

        .btn-google {
            background: white;
            color: #757575;
            border: 2px solid #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s ease;
        }

        .btn-google:hover {
            background: #f5f5f5;
            transform: translateY(-3px);
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 1.5rem 0;
            color: #999;
        }

        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e0e0e0;
        }

        .divider:not(:empty)::before {
            margin-right: 1em;
        }

        .divider:not(:empty)::after {
            margin-left: 1em;
        }

        @media (max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
            }

            .login-image {
                height: 200px;
            }

            .login-content {
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-wrapper">
            <div class="login-image"></div>
            <div class="login-content">
                <div class="login-header">
                    <h2>Sneaker Space</h2>
                    <p class="text-muted">Đăng nhập để trải nghiệm</p>
                </div>

                <%-- Hiển thị thông báo lỗi nếu có --%>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger text-center" role="alert">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                            <input type="email" class="form-control border-start-0" id="email" name="email" 
                                   placeholder="Nhập email của bạn" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-lock text-muted"></i></span>
                            <input type="password" class="form-control border-start-0" id="password" name="password" 
                                   placeholder="Nhập mật khẩu" required>
                        </div>
                    </div>
                    <div class="mb-3 d-flex justify-content-between align-items-center">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Ghi nhớ đăng nhập
                            </label>
                        </div>
                        <a href="#" class="text-decoration-none text-muted">Quên mật khẩu?</a>
                    </div>
                    
                    <button type="submit" class="btn btn-login w-100 mb-3">Đăng Nhập</button>
                    
                    <div class="divider">Hoặc</div>
                    
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/Group_Assignment/loginG&response_type=code&client_id=645828963442-9upejmnjb1ai3s92prkvjq5brh8n1al9.apps.googleusercontent.com&access_type=offline&prompt=consent" 
                       class="btn btn-google w-100">
                        <i class="bi bi-google"></i> Đăng nhập bằng Google
                    </a>
                </form>
                
                <div class="text-center mt-3">
                    Bạn chưa có tài khoản? 
                    <a href="register.jsp" class="text-decoration-none text-primary">Đăng ký ngay</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
