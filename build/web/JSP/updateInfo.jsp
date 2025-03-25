<%-- 
    Document   : updateInfo
    Created on : Mar 22, 2025, 2:06:08 AM
    Author     : ASUS
--%>
<%@page import="Model.Customer"%>
<%@page import="Model.UserGoogleDto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật thông tin cá nhân - Sneaker Space</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #4ecdc4;
            --dark-color: #1a1a2e;
            --light-color: #f7f7f7;
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-color);
            padding-top: 20px;
        }
        
        .form-container {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 700px;
            margin: 0 auto;
        }
        
        .logo {
            display: block;
            margin: 0 auto 30px;
            max-width: 150px;
        }
        
        .form-title {
            color: var(--dark-color);
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .form-title:after {
            content: '';
            position: absolute;
            width: 80px;
            height: 3px;
            background-color: var(--primary-color);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }
        
        .form-control {
            padding: 12px 15px;
            border-radius: 10px;
            border: 1px solid #ced4da;
            transition: var(--transition);
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(255, 107, 107, 0.25);
        }
        
        .form-text {
            color: #6c757d;
            font-style: italic;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
            transition: var(--transition);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
            background: linear-gradient(135deg, #ff5252 0%, #ff7070 100%);
        }
        
        .btn-secondary {
            background-color: var(--dark-color);
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(26, 26, 46, 0.3);
            transition: var(--transition);
        }
        
        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(26, 26, 46, 0.4);
        }
        
        .alert {
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;
        }
        
        .google-info {
            background-color: #f8f9fa;
            border-left: 4px solid var(--primary-color);
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;
        }
        
        .google-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
        }
        
        .footer-text {
            text-align: center;
            margin-top: 30px;
            color: #6c757d;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .user-details {
            flex-grow: 1;
        }
        
        .user-name {
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 0;
        }
        
        .user-email {
            color: #6c757d;
            margin-bottom: 0;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .form-container {
            animation: fadeIn 0.8s ease forwards;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="form-container">
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                Customer customer = (Customer) session.getAttribute("customer");
                UserGoogleDto googleUser = (UserGoogleDto) session.getAttribute("user");
                
                String email = "";
                String name = "";
                
                if (customer != null) {
                    email = customer.getEmail();
                    name = customer.getFullName();
                } else if (googleUser != null) {
                    email = googleUser.getEmail();
                    name = googleUser.getName();
                }
            %>
            
            <div class="text-center mb-4">
                <img src="${pageContext.request.contextPath}/img/adidas_predator.jpg" alt="Sneaker Space Logo" class="img-fluid mb-3" style="max-width: 100px; border-radius: 10px;">
                <h1 class="h2 mb-0">Sneaker Space</h1>
            </div>
            
            <h2 class="form-title">Cập nhật thông tin cá nhân</h2>
            
            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <div class="google-info mb-4">
                <div class="user-info">
                    <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                        <span class="text-white fw-bold"><%= name.substring(0, 1).toUpperCase() %></span>
                    </div>
                    <div class="user-details ms-3">
                        <p class="user-name"><%= name %></p>
                        <p class="user-email"><%= email %></p>
                    </div>
                </div>
                <p class="mb-0"><i class="bi bi-info-circle-fill me-2 text-primary"></i>Để hoàn tất quá trình đăng nhập với Google, bạn vui lòng cung cấp thêm một số thông tin cần thiết.</p>
            </div>
            
            <form action="${pageContext.request.contextPath}/update" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="email" value="<%= email %>">
                
                <div class="mb-4">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-phone"></i></span>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại của bạn" required pattern="[0-9]{10}">
                        <div class="invalid-feedback">
                            Vui lòng nhập số điện thoại hợp lệ (10 số).
                        </div>
                    </div>
                    <div class="form-text">Số điện thoại của bạn để liên hệ khi giao hàng</div>
                </div>
                
                <div class="mb-4">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                        <textarea class="form-control" id="address" name="address" rows="3" placeholder="Nhập địa chỉ đầy đủ của bạn" required></textarea>
                        <div class="invalid-feedback">
                            Vui lòng nhập địa chỉ của bạn.
                        </div>
                    </div>
                    <div class="form-text">Địa chỉ đầy đủ để giao hàng</div>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                    <a href="${pageContext.request.contextPath}/JSP/index.jsp" class="btn btn-secondary me-md-2">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check2-circle me-2"></i>Hoàn tất đăng ký
                    </button>
                </div>
            </form>
            
            <p class="footer-text mt-4">
                <i class="bi bi-shield-lock me-1"></i>
                Chúng tôi cam kết bảo mật thông tin cá nhân của bạn
            </p>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.querySelectorAll('.needs-validation')
            
            // Loop over them and prevent submission
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html>