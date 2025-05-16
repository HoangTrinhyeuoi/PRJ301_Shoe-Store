<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${order.id} | Shoe Store</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .page-header {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 20px 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .order-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .order-header {
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
        .order-detail-item {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }
        .order-detail-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .product-image {
            max-width: 80px;
            max-height: 80px;
            object-fit: contain;
        }
        .order-summary {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            position: sticky;
            top: 20px;
        }
        .payment-pending {
            color: #856404;
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .payment-completed {
            color: #155724;
            background-color: #d4edda;
            border-left: 4px solid #28a745;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .badge-payment {
            font-size: 0.9rem;
            padding: 0.5rem 0.8rem;
            border-radius: 30px;
        }
        .payment-amount {
            font-size: 1.8rem;
            font-weight: bold;
            color: #dc3545;
        }
    </style>
</head>
<body>
    <!-- Navbar include -->
    <jsp:include page="header.jsp" />
    
    <header class="page-header">
        <div class="container">
            <h1 class="text-center mb-0"><i class="fas fa-file-invoice me-2"></i>Chi tiết đơn hàng #${order.id}</h1>
        </div>
    </header>
    
    <div class="container mb-5">
        <!-- Thông báo thành công/lỗi nếu có -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <div class="row">
            <!-- Thông tin đơn hàng và sản phẩm -->
            <div class="col-lg-8">
                <div class="order-container">
                    <div class="order-header d-flex justify-content-between align-items-center flex-wrap">
                        <div>
                            <h3 class="mb-2">Đơn hàng #${order.id}</h3>
                            <p class="text-muted mb-0">
                                <i class="fas fa-calendar-alt me-2"></i>
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                            </p>
                        </div>
                        <div class="mt-2 mt-sm-0">
                            
                            <span class="badge bg-${order.paymentStatus eq 'PAID' ? 'success' : (order.paymentStatus eq 'PARTIAL' ? 'warning' : 'danger')} p-2 ms-2">
                                <i class="fas fa-${order.paymentStatus eq 'PAID' ? 'check-circle' : (order.paymentStatus eq 'PARTIAL' ? 'clock' : 'times-circle')} me-1"></i>
                                ${order.paymentStatus eq 'PAID' ? 'Đã thanh toán' : (order.paymentStatus eq 'PARTIAL' ? 'Thanh toán một phần' : 'Chưa thanh toán')}
                            </span>
                        </div>
                    </div>
                    
                    <!-- Thông tin người nhận -->
                    <div class="mb-4">
                        <h5><i class="fas fa-user me-2"></i>Thông tin người nhận</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Họ tên:</strong> ${order.customerName}</p>
                                <p><strong>Email:</strong> ${order.customerEmail}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Điện thoại:</strong> ${order.customerPhone}</p>
                                <p><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Danh sách sản phẩm -->
                    <h5><i class="fas fa-shopping-basket me-2"></i>Sản phẩm đã đặt</h5>
                    <c:forEach var="item" items="${orderDetails}">
                        <div class="order-detail-item">
                            <div class="row align-items-center">
                                <div class="col-md-2 col-sm-3 text-center">
                                    <c:choose>
                                        <c:when test="${not empty item.productImage}">
                                            <img src="${item.productImage}" alt="${item.productName}" class="product-image">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-image d-flex align-items-center justify-content-center bg-light">
                                                <i class="fas fa-image text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-md-4 col-sm-9">
                                    <h6 class="mb-1">${item.productName}</h6>
                                    <small class="text-muted">Mã sản phẩm: #${item.productId}</small>
                                </div>
                                <div class="col-md-2 col-6 text-center mt-3 mt-md-0">
                                    <span class="d-block text-muted small">Đơn giá</span>
                                    <span><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                                </div>
                                <div class="col-md-2 col-6 text-center mt-3 mt-md-0">
                                    <span class="d-block text-muted small">Số lượng</span>
                                    <span>${item.quantity}</span>
                                </div>
                                <div class="col-md-2 text-end mt-3 mt-md-0">
                                    <span class="d-block text-muted small">Thành tiền</span>
                                    <span class="fw-bold"><fmt:formatNumber value="${item.getSubtotal()}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            
            <!-- Tổng quan đơn hàng và phương thức thanh toán -->
            <div class="col-lg-4">
                <div class="order-summary">
                    <h4 class="mb-4">Tổng quan đơn hàng</h4>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${order.totalAmount - 30}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                    </div>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <span>Phí vận chuyển:</span>
                        <span><fmt:formatNumber value="30" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                    </div>
                    
                    <hr>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <strong>Tổng cộng:</strong>
                        <strong><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></strong>
                    </div>
                    
                    <div class="d-flex justify-content-between mb-4">
                        <span>Đã thanh toán:</span>
                        <span class="text-${order.paidAmount >= order.totalAmount ? 'success' : 'danger'}">
                            <fmt:formatNumber value="${order.paidAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                        </span>
                    </div>
                    
                    <div class="mb-3">
                        <h5>Phương thức thanh toán</h5>
                        <p>
                            <c:choose>
                                <c:when test="${order.paymentStatus eq 'PAID'}">
                                    <i class="fas fa-university me-2"></i>Thanh toán qua VNPAY
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-money-bill-wave me-2"></i>Thanh toán khi nhận hàng (COD)
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <!-- Trạng thái thanh toán -->
                    <c:choose>
                        <c:when test="${order.paymentStatus eq 'PAID'}">
                            <div class="payment-completed">
                                <i class="fas fa-check-circle me-2"></i>
                                <strong>Đã thanh toán</strong>
                                <p class="mb-0 mt-1">Đơn hàng của bạn đã được thanh toán thành công.</p>
                            </div>
                        </c:when>
                        <c:when test="${order.paymentStatus eq 'UNPAID' || order.paymentStatus eq 'PARTIAL'}">
                            <div class="payment-pending">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <strong>${order.paymentStatus eq 'PARTIAL' ? 'Đã thanh toán một phần' : 'Chưa thanh toán'}</strong>
                                <p class="mb-0 mt-1">Vui lòng hoàn tất thanh toán để đơn hàng của bạn được xử lý nhanh chóng.</p>
                            </div>
                        </c:when>
                    </c:choose>
                    
                    <!-- Nút hủy đơn hàng nếu đơn hàng đang chờ xử lý -->
                    <c:if test="${order.status eq 'PENDING'}">
                        <div class="mt-4">
                            <button class="btn btn-outline-danger w-100 btn-cancel-order" data-order-id="${order.id}">
                                <i class="fas fa-times-circle me-2"></i>Hủy đơn hàng
                            </button>
                        </div>
                    </c:if>
                    
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary w-100">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách đơn hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Modal xác nhận hủy đơn hàng -->
    <div class="modal fade" id="cancelOrderModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận hủy đơn hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn hủy đơn hàng này?</p>
                    <p class="text-danger"><small>Lưu ý: Hành động này không thể hoàn tác.</small></p>
                    
                    <form id="cancelOrderForm" action="${pageContext.request.contextPath}/order-detail" method="post">
                        <input type="hidden" name="action" value="cancelOrder">
                        <input type="hidden" name="orderId" id="cancelOrderId" value="${order.id}">
                        
                        <div class="mb-3">
                            <label for="cancelReason" class="form-label">Lý do hủy đơn</label>
                            <select class="form-select" id="cancelReason" name="reason" required>
                                <option value="">-- Chọn lý do --</option>
                                <option value="CHANGE_MIND">Tôi đổi ý, không muốn mua nữa</option>
                                <option value="DUPLICATE_ORDER">Đã đặt trùng đơn hàng</option>
                                <option value="WRONG_ITEM">Đặt nhầm sản phẩm/kích cỡ</option>
                                <option value="DELIVERY_TIME">Thời gian giao hàng quá lâu</option>
                                <option value="PAYMENT_ISSUE">Vấn đề về thanh toán</option>
                                <option value="OTHER">Lý do khác</option>
                            </select>
                        </div>
                        
                        <div class="mb-3" id="otherReasonGroup" style="display: none;">
                            <label for="otherReason" class="form-label">Lý do cụ thể</label>
                            <textarea class="form-control" id="otherReason" name="otherReason" rows="3" placeholder="Vui lòng nêu lý do cụ thể"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-danger" id="confirmCancelButton">Xác nhận hủy</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer include -->
    <jsp:include page="footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Xử lý hiển thị trường lý do khác
            $('#cancelReason').change(function() {
                if ($(this).val() === 'OTHER') {
                    $('#otherReasonGroup').show();
                    $('#otherReason').attr('required', true);
                } else {
                    $('#otherReasonGroup').hide();
                    $('#otherReason').attr('required', false);
                }
            });
            
            // Xử lý khi click nút hủy đơn hàng
            $('.btn-cancel-order').click(function() {
                // Hiển thị modal
                new bootstrap.Modal(document.getElementById('cancelOrderModal')).show();
            });
            
            // Xử lý khi xác nhận hủy đơn hàng
            $('#confirmCancelButton').click(function() {
                // Kiểm tra form hợp lệ
                if ($('#cancelReason').val() === '') {
                    alert('Vui lòng chọn lý do hủy đơn hàng');
                    return;
                }
                
                if ($('#cancelReason').val() === 'OTHER' && $('#otherReason').val().trim() === '') {
                    alert('Vui lòng nhập lý do cụ thể');
                    return;
                }
                
                // Submit form
                $('#cancelOrderForm').submit();
            });
            
            // Tự động ẩn thông báo sau 5 giây
            setTimeout(function() {
                $('.alert').alert('close');
            }, 5000);
        });
    </script>
</body>
</html>