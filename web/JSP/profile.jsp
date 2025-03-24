<%@page import="DAO.CustomerDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Customer" %>
<%@ page import="Model.UserGoogleDto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ người dùng - Sneaker Space</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .profile-container {
            max-width: 800px;
            margin: 50px auto;
        }
        .profile-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .profile-header {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid rgba(255, 255, 255, 0.5);
            margin: 0 auto 1rem;
            background-color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: #6a11cb;
        }
        .profile-info {
            padding: 2rem;
        }
        .info-group {
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
        }
        .info-label {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }
        .info-value {
            font-size: 1.1rem;
            font-weight: 500;
        }
        .btn-edit {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-edit:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(106, 17, 203, 0.4);
            color: white;
        }
        .btn-back {
            background: #6c757d;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.4);
            color: white;
        }
        .btn-logout {
            background: #dc3545;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-logout:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
            color: white;
        }
        .not-available {
            color: #dc3545;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <%
            // Lấy thông tin người dùng từ session
            Customer customer = (Customer) session.getAttribute("customer");
            UserGoogleDto googleUser = (UserGoogleDto) session.getAttribute("user");
            
            boolean isLoggedIn = (customer != null || googleUser != null);
            
            if (!isLoggedIn) {
                // Người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
                response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
                return;
            }
            
            // Xác định thông tin người dùng để hiển thị
            String userName = "";
            String fullName = "";
            String email = "";
            String address = "";
            String phone = "";
            int userId = 0;
            
            if (customer != null) {
                userId = customer.getCustomerId();
                userName = customer.getUserName();
                fullName = customer.getFullName() != null ? customer.getFullName() : "";
                email = customer.getEmail();
                address = customer.getAddress() != null ? customer.getAddress() : "";
                phone = customer.getPhoneNumber() != null ? customer.getPhoneNumber() : "";
            } else if (googleUser != null) {
                userName = googleUser.getName();
                fullName = googleUser.getName();
                email = googleUser.getEmail();
                CustomerDAO dao = new CustomerDAO();
                Customer googleCustomer = dao.getCustomerByEmail(email); // Thêm phương thức này

                if (googleCustomer != null) {
                    address = googleCustomer.getAddress();
                    phone = googleCustomer.getPhoneNumber();
                }
            }
            
            // Lấy chữ cái đầu tiên của username cho avatar
            String firstChar = !userName.isEmpty() ? userName.substring(0, 1).toUpperCase() : "U";
        %>
        
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    <%= firstChar %>
                </div>
                <h2><%= fullName.isEmpty() ? userName : fullName %></h2>
                <p class="mb-0"><i class="fas fa-user me-2"></i><%= userName %></p>
            </div>
            
            <div class="profile-info">
                <div class="info-group">
                    <div class="info-label">Email</div>
                    <div class="info-value"><i class="fas fa-envelope me-2"></i><%= email %></div>
                </div>
                
                <div class="info-group">
                    <div class="info-label">Họ và tên</div>
                    <div class="info-value">
                        <% if (fullName != null && !fullName.isEmpty()) { %>
                            <i class="fas fa-user-tag me-2"></i><%= fullName %>
                        <% } else { %>
                            <span class="not-available"><i class="fas fa-exclamation-circle me-2"></i>Chưa cập nhật</span>
                        <% } %>
                    </div>
                </div>
                
                <div class="info-group">
                    <div class="info-label">Địa chỉ</div>
                    <div class="info-value">
                        <% if (address != null && !address.isEmpty()) { %>
                            <i class="fas fa-map-marker-alt me-2"></i><%= address %>
                        <% } else { %>
                            <span class="not-available"><i class="fas fa-exclamation-circle me-2"></i>Chưa cập nhật</span>
                        <% } %>
                    </div>
                </div>
                
                <div class="info-group">
                    <div class="info-label">Số điện thoại</div>
                    <div class="info-value">
                        <% if (phone != null && !phone.isEmpty()) { %>
                            <i class="fas fa-phone me-2"></i><%= phone %>
                        <% } else { %>
                            <span class="not-available"><i class="fas fa-exclamation-circle me-2"></i>Chưa cập nhật</span>
                        <% } %>
                    </div>
                </div>
                
                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/JSP/index.jsp" class="btn btn-back">
                        <i class="fas fa-home me-2"></i>Trang chủ
                    </a>
                    
                    <div>
                        <% if (customer != null || googleUser != null) { %>
                            <a href="${pageContext.request.contextPath}/JSP/editProfile.jsp" class="btn btn-edit me-2">
                                <i class="fas fa-user-edit me-2"></i>Chỉnh sửa hồ sơ
                            </a>
                        <% } %>
                        
    
                        
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">
                            <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>