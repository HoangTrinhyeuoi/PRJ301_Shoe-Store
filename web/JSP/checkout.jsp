<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - ShoeStore</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <style>
        .checkout-item {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .checkout-item img {
            max-width: 70px;
            height: auto;
        }
        .order-summary {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
        }
        .order-summary h4 {
            margin-bottom: 20px;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 10px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .summary-total {
            font-size: 1.2rem;
            font-weight: bold;
            border-top: 1px solid #dee2e6;
            padding-top: 10px;
            margin-top: 10px;
        }
        .form-group label.required::after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>

<!-- Header -->
<jsp:include page="header.jsp" />

<!-- Main Content -->
<div class="container mt-5 mb-5">
    <h2 class="mb-4">Thanh toán</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    
    <div class="row">
        <!-- Shipping and Payment Form -->
        <div class="col-lg-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Thông tin giao hàng</h4>
                </div>
                <div class="card-body">
                    <form action="checkout" method="post" id="checkoutForm">
                        <!-- Thông tin khách hàng -->
                        <div class="form-group">
                            <label for="fullName" class="required">Họ và tên</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${customer.fullName}" required>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="email" class="required">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${customer.email}" readonly>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="phoneNumber" class="required">Số điện thoại</label>
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="${customer.phoneNumber}" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="address" class="required">Địa chỉ giao hàng</label>
                            <textarea class="form-control" id="address" name="address" rows="3" required>${customer.address}</textarea>
                        </div>
                        
                        <!-- Phương thức thanh toán -->
                        <div class="form-group mt-4">
                            <label>Phương thức thanh toán</label>
                            <div class="custom-control custom-radio">
                                <input type="radio" id="cod" name="paymentMethod" value="COD" class="custom-control-input" checked>
                                <label class="custom-control-label" for="cod">Thanh toán khi nhận hàng (COD)</label>
                            </div>
                            <div class="custom-control custom-radio">
                                <input type="radio" id="bankTransfer" name="paymentMethod" value="BankTransfer" class="custom-control-input">
                                <label class="custom-control-label" for="bankTransfer">Chuyển khoản ngân hàng</label>
                            </div>
                        </div>
                        
                        <!-- Ghi chú đơn hàng -->
                        <div class="form-group mt-4">
                            <label for="note">Ghi chú đơn hàng (tùy chọn)</label>
                            <textarea class="form-control" id="note" name="note" rows="3" placeholder="Ghi chú về đơn hàng của bạn, ví dụ: thời gian hay địa điểm giao hàng chi tiết."></textarea>
                        </div>
                        
                        <div class="form-group mt-4 text-right">
                            <a href="cart" class="btn btn-outline-secondary mr-2">Quay lại giỏ hàng</a>
                            <button type="submit" class="btn btn-primary">Đặt hàng</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Order Summary -->
        <div class="col-lg-4">
            <div class="order-summary">
                <h4>Tóm tắt đơn hàng</h4>
                
                <!-- Danh sách sản phẩm -->
                <div class="checkout-items">
                    <c:forEach items="${cart.items}" var="item">
                        <div class="checkout-item">
                            <div class="row">
                                <div class="col-3">
                                    <img src="${item.product.imageUrl}" alt="${item.product.productName}" class="img-fluid">
                                </div>
                                <div class="col-9">
                                    <div>${item.product.productName}</div>
                                    <div>Size: ${item.size}</div>
                                    <div>
                                        <span class="text-muted">Số lượng: ${item.quantity}</span>
                                        <span class="float-right">
                                            <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Tính toán -->
                <div class="mt-3">
                    <div class="summary-item">
                        <span>Tổng số sản phẩm:</span>
                        <span>${cart.totalItems}</span>
                    </div>
                    <div class="summary-item">
                        <span>Tổng tiền:</span>
                        <span><fmt:formatNumber value="${cart.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></span>
                    </div>
                    <div class="summary-item">
                        <span>Phí vận chuyển:</span>
                        <span>Miễn phí</span>
                    </div>
                    <div class="summary-total">
                        <span>Tổng thanh toán:</span>
                        <span><fmt:formatNumber value="${cart.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp" />

<!-- jQuery and Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script>
$(document).ready(function() {
    // Hiển thị thông tin thanh toán tùy theo phương thức thanh toán
    $('input[name="paymentMethod"]').change(function() {
        const method = $(this).val();
        
        if (method === 'BankTransfer') {
            if ($('#bankInfo').length === 0) {
                const bankInfoHTML = `
                    <div id="bankInfo" class="card mt-3">
                        <div class="card-body">
                            <h5 class="card-title">Thông tin chuyển khoản</h5>
                            <p class="card-text">Vui lòng chuyển khoản theo thông tin sau:</p>
                            <ul class="list-unstyled">
                                <li><strong>Ngân hàng:</strong> VietinBank</li>
                                <li><strong>Số tài khoản:</strong> 123456789</li>
                                <li><strong>Chủ tài khoản:</strong> ShoeStore</li>
                                <li><strong>Nội dung chuyển khoản:</strong> [Tên của bạn] - [Số điện thoại]</li>
                            </ul>
                        </div>
                    </div>
                `;
                $(this).closest('.form-group').append(bankInfoHTML);
            }
        } else {
            $('#bankInfo').remove();
        }
    });
    
    // Validate form trước khi submit
    $('#checkoutForm').submit(function(event) {
        let isValid = true;
        const requiredFields = $(this).find('[required]');
        
        requiredFields.each(function() {
            if (!$(this).val().trim()) {
                $(this).addClass('is-invalid');
                isValid = false;
            } else {
                $(this).removeClass('is-invalid');
            }
        });
        
        // Kiểm tra số điện thoại
        const phoneRegex = /^[0-9]{10,11}$/;
        const phoneNumber = $('#phoneNumber').val();
        
        if (!phoneRegex.test(phoneNumber)) {
            $('#phoneNumber').addClass('is-invalid');
            if (!$('#phoneError').length) {
                $('#phoneNumber').after('<div id="phoneError" class="invalid-feedback">Số điện thoại không hợp lệ (10-11 số)</div>');
            }
            isValid = false;
        } else {
            $('#phoneNumber').removeClass('is-invalid');
            $('#phoneError').remove();
        }
        
        if (!isValid) {
            event.preventDefault();
        }
    });
});
</script>

</body>
</html>