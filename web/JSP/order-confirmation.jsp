<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đơn hàng - ShoeStore</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .confirmation-box {
            max-width: 800px;
            margin: 0 auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .confirmation-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .confirmation-header i {
            font-size: 5rem;
            color: #28a745;
            margin-bottom: 20px;
            display: block;
        }
        .order-details {
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #dee2e6;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .next-steps {
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .btn-action {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<!-- Header -->
<jsp:include page="header.jsp" />

<!-- Main Content -->
<div class="container mt-5 mb-5">
    <div class="confirmation-box">
        <div class="confirmation-header">
            <i class="fas fa-check-circle"></i>
            <h2>Đặt hàng thành công!</h2>
            <p>${successMessage}</p>
        </div>
        
        <div class="order-details">
            <h4>Chi tiết đơn hàng</h4>
            
            <div class="detail-row">
                <span>Mã đơn hàng:</span>
                <span>#${orderId}</span>
            </div>
            
            <div class="detail-row">
                <span>Ngày đặt hàng:</span>
                <span><fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm" /></span>
            </div>
            
            <div class="detail-row">
                <span>Phương thức thanh toán:</span>
                <span>${paymentMethod eq 'COD' ? 'Thanh toán khi nhận hàng (COD)' : 'Chuyển khoản ngân hàng'}</span>
            </div>
            
            <div class="detail-row">
                <span>Tổng thanh toán:</span>
                <span class="font-weight-bold">
                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                </span>
            </div>
        </div>
        
        <div class="next-steps">
            <h4>Các bước tiếp theo</h4>
            <p>Chúng tôi đã gửi một email xác nhận đơn hàng đến địa chỉ email của bạn. Vui lòng kiểm tra email và giữ lại để tham khảo.</p>
            <p>Đơn hàng của bạn sẽ được xử lý và vận chuyển trong vòng 1-3 ngày làm việc. Bạn có thể kiểm tra trạng thái đơn hàng trong trang "Đơn hàng của tôi".</p>
            
            <div class="text-center btn-action">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary me-2">Tiếp tục mua sắm</a>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-secondary">Xem đơn hàng của tôi</a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp" />

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</body>
</html>