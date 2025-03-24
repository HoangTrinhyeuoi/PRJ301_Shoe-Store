<%-- 
    Document   : editProfile
    Created on : Mar 22, 2025, 3:47:30 AM
    Author     : ASUS
--%>

<%@page import="DAO.CustomerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Customer"%>
<%@page import="Model.UserGoogleDto"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa hồ sơ</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <%
            // Lấy thông tin người dùng từ session
            Customer customer = (Customer) session.getAttribute("customer");
            UserGoogleDto googleUser = (UserGoogleDto) session.getAttribute("user");

            boolean isGoogleUser = (googleUser != null);
            boolean isSQLUser = (customer != null);

            String fullName = "";
            String email = "";
            String address = "";
            String phone = "";

            if (isSQLUser) {
                fullName = customer.getFullName() != null ? customer.getFullName() : "";
                email = customer.getEmail();
                address = customer.getAddress() != null ? customer.getAddress() : "";
                phone = customer.getPhoneNumber() != null ? customer.getPhoneNumber() : "";
            } else if (isGoogleUser) {
                fullName = googleUser.getName();
                email = googleUser.getEmail();
                CustomerDAO dao = new CustomerDAO();
                Customer googleCustomer = dao.getCustomerByEmail(email);

                if (googleCustomer != null) {
                    address = googleCustomer.getAddress();
                    phone = googleCustomer.getPhoneNumber();
                }
            }
        %>

        <h2 class="mb-4">Chỉnh sửa hồ sơ</h2>
        <form action="${pageContext.request.contextPath}/updateProfile" method="POST">
            <div class="mb-3">
                <label class="form-label">Email:</label>
                <input type="text" class="form-control" name="email" value="<%= email %>" readonly>
            </div>

            <div class="mb-3">
                <label class="form-label">Họ và tên:</label>
                <input type="text" class="form-control" name="fullName" value="<%= fullName %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại:</label>
                <input type="text" class="form-control" name="phone" value="<%= phone %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Địa chỉ:</label>
                <input type="text" class="form-control" name="address" value="<%= address %>" required>
            </div>

            <% if (isSQLUser) { %>
                <hr>
                <h4>Đổi mật khẩu</h4>
                <div class="mb-3">
                    <label class="form-label">Mật khẩu hiện tại:</label>
                    <input type="password" class="form-control" name="currentPassword" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mật khẩu mới:</label>
                    <input type="password" class="form-control" name="newPassword" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Xác nhận mật khẩu mới:</label>
                    <input type="password" class="form-control" name="confirmPassword" required>
                </div>
            <% } %>

            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
            <a href="${pageContext.request.contextPath}/JSP/profile.jsp" class="btn btn-secondary">Hủy</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

