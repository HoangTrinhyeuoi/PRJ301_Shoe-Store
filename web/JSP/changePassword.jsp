<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
        .error-message {
            color: red;
            margin-top: 5px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Đổi mật khẩu</h1>
        
        <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        
        <form action="updatePassword" method="post" id="passwordForm">
            <input type="hidden" name="id" value="${user.id}">
            
            <div class="form-group">
                <label for="currentPassword">Mật khẩu hiện tại:</label>
                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
            </div>
            
            <div class="form-group">
                <label for="newPassword">Mật khẩu mới:</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                <div class="error-message" id="passwordError"></div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                <div class="error-message" id="confirmError"></div>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                <a href="profile.jsp" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('passwordForm').addEventListener('submit', function(event) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            let hasError = false;
            
            // Reset error messages
            document.getElementById('passwordError').innerHTML = '';
            document.getElementById('confirmError').innerHTML = '';
            
            // Validate password length
            if (newPassword.length < 8) {
                document.getElementById('passwordError').innerHTML = 'Mật khẩu phải có ít nhất 8 ký tự';
                hasError = true;
            }
            
            // Validate password match
            if (newPassword !== confirmPassword) {
                document.getElementById('confirmError').innerHTML = 'Mật khẩu không khớp';
                hasError = true;
            }
            
            if (hasError) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>