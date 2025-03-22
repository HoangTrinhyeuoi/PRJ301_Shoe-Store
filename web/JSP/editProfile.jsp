<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa hồ sơ - Sneaker Space</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            margin-top: 50px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        h1 {
            margin-bottom: 30px;
            color: #333;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            border-radius: 15px 15px 0 0;
            padding: 20px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            border: none;
            border-radius: 50px;
            padding: 10px 25px;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(106, 17, 203, 0.4);
        }
        .btn-secondary {
            background-color: #6c757d;
            border: none;
            border-radius: 50px;
            padding: 10px 25px;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.4);
        }
        .form-control:focus {
            border-color: #6a11cb;
            box-shadow: 0 0 0 0.25rem rgba(106, 17, 203, 0.25);
        }
        .card-body {
            padding: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h1 class="text-center mb-0"><i class="fas fa-user-edit me-2"></i>Chỉnh sửa hồ sơ</h1>
            </div>
            <div class="card-body">
                <% 
                    // Lấy thông tin người dùng từ session
                    Customer customer = (Customer) session.getAttribute("customer");
                    
                    if (customer == null) {
                        // Nếu không có người dùng trong session, chuyển hướng về trang đăng nhập
                        response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
                        return;
                    }
                    
                    // Kiểm tra thông báo lỗi hoặc thành công
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    String successMessage = (String) request.getAttribute("successMessage");
                %>
                
                <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i><%= errorMessage %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                
                <% if (successMessage != null && !successMessage.isEmpty()) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i><%= successMessage %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                    <input type="hidden" name="id" value="<%= customer.getCustomerId() %>">
                    
                    <div class="form-group">
                        <label for="username" class="form-label">Tên đăng nhập:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username" value="<%= customer.getUserName() %>" readonly>
                        </div>
                        <small class="text-muted"><i class="fas fa-info-circle me-1"></i>Tên đăng nhập không thể thay đổi</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="email" class="form-label">Email:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" value="<%= customer.getEmail() %>" readonly>
                        </div>
                        <small class="text-muted"><i class="fas fa-info-circle me-1"></i>Email không thể thay đổi</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="fullName" class="form-label">Họ và tên:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="<%= customer.getFullName() != null ? customer.getFullName() : "" %>" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="address" class="form-label">Địa chỉ:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                            <textarea class="form-control" id="address" name="address" rows="3"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone" class="form-label">Số điện thoại:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                            <input type="text" class="form-control" id="phone" name="phone" value="<%= customer.getPhoneNumber() != null ? customer.getPhoneNumber() : "" %>">
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/JSP/profile.jsp" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Lưu thay đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>