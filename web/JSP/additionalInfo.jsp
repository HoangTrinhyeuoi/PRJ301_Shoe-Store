<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sneaker Space - Thông tin bổ sung</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Sneaker Space</a>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h4 class="text-center">Thông tin bổ sung</h4>
                    </div>
                    <div class="card-body">
                        <p class="text-center">Vui lòng cung cấp thêm thông tin để hoàn tất đăng nhập</p>
                        
                        <form action="CompleteGoogleLogin" method="post">
                            <input type="hidden" name="email" value="${email}">
                            <input type="hidden" name="name" value="${name}">
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ:</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="phone" class="form-label">Số điện thoại:</label>
                                <input type="tel" class="form-control" id="phone" name="phone" required>
                            </div>
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Hoàn tất</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>