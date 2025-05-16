<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi | Shoe Store</title>
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
        .order-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 20px;
            overflow: hidden;
        }
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        .order-header {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
        }
        .order-body {
            padding: 20px;
        }
        .order-footer {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-top: 1px solid #eee;
        }
        .product-item {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .product-item:last-child {
            border-bottom: none;
        }
        .badge-status {
            font-size: 0.85rem;
            padding: 0.35rem 0.65rem;
            border-radius: 30px;
        }
        .empty-orders {
            min-height: 300px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 40px 20px;
        }
        .timeline {
            list-style-type: none;
            position: relative;
            padding-left: 30px;
        }
        .timeline:before {
            content: ' ';
            background: #dee2e6;
            display: inline-block;
            position: absolute;
            left: 9px;
            top: 0;
            width: 2px;
            height: 100%;
        }
        .timeline > li {
            margin-bottom: 15px;
            position: relative;
        }
        .timeline > li:before {
            content: ' ';
            background: white;
            display: inline-block;
            position: absolute;
            border-radius: 50%;
            border: 2px solid #2575fc;
            left: -30px;
            top: 3px;
            width: 20px;
            height: 20px;
            z-index: 2;
        }
        .filter-section {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>
    <!-- Header include -->
    <jsp:include page="header.jsp" />
    
    <header class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi</h1>
                    <p class="text-white-50 mb-0">Quản lý và theo dõi tất cả đơn hàng của bạn</p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <a href="${pageContext.request.contextPath}/index.html" class="btn btn-outline-light">
                        <i class="fas fa-home me-2"></i>Trang chủ
                    </a>
                    <a href="${pageContext.request.contextPath}/JSP/products.jsp" class="btn btn-light ms-2">
                        <i class="fas fa-shopping-cart me-2"></i>Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        </div>
    </header>
    
    <div class="container mb-5">
        <!-- Thông báo thành công/lỗi nếu có -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i><c:out value="${successMessage}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i><c:out value="${errorMessage}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <!-- Phần lọc đơn hàng -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/orders" method="get" class="row align-items-end">
                <div class="col-md-4 mb-3 mb-md-0">
                    <label for="orderStatus" class="form-label">Trạng thái đơn hàng</label>
                    <select class="form-select" id="orderStatus" name="status">
                        <option value="" ${empty param.status ? 'selected' : ''}>Tất cả trạng thái</option>
                        <option value="PENDING" ${param.status eq 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                        <option value="PROCESSING" ${param.status eq 'PROCESSING' ? 'selected' : ''}>Đang xử lý</option>
                        <option value="SHIPPED" ${param.status eq 'SHIPPED' ? 'selected' : ''}>Đang vận chuyển</option>
                        <option value="DELIVERED" ${param.status eq 'DELIVERED' ? 'selected' : ''}>Đã giao hàng</option>
                        <option value="CANCELED" ${param.status eq 'CANCELED' ? 'selected' : ''}>Đã hủy</option>
                    </select>
                </div>
                <div class="col-md-4 mb-3 mb-md-0">
                    <label for="orderDate" class="form-label">Sắp xếp theo</label>
                    <select class="form-select" id="orderDate" name="sort">
                        <option value="newest" ${param.sort eq 'newest' or empty param.sort ? 'selected' : ''}>Mới nhất</option>
                        <option value="oldest" ${param.sort eq 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                        <option value="highPrice" ${param.sort eq 'highPrice' ? 'selected' : ''}>Giá cao nhất</option>
                        <option value="lowPrice" ${param.sort eq 'lowPrice' ? 'selected' : ''}>Giá thấp nhất</option>
                    </select>
                </div>
                <div class="col-md-4 mb-3 mb-md-0">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-filter me-2"></i>Lọc đơn hàng
                    </button>
                </div>
            </form>
        </div>
        
        <c:choose>
            <c:when test="${empty orders}">
                <div class="card">
                    <div class="card-body empty-orders">
                        <i class="fas fa-shopping-bag fa-5x text-muted mb-4"></i>
                        <h3>Bạn chưa có đơn hàng nào</h3>
                        <p class="text-muted mb-4">Hãy khám phá các sản phẩm của chúng tôi và đặt hàng ngay!</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                            <i class="fas fa-shopping-cart me-2"></i>Mua sắm ngay
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <div class="col-12">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3>Đơn hàng của bạn (${totalOrders})</h3>
                            <span class="text-muted">Trang ${currentPage} / ${totalPages}</span>
                        </div>
                    </div>
                </div>
                
                <c:forEach items="${orders}" var="order">
                    <div class="order-card">
                        <div class="order-header d-flex justify-content-between align-items-center flex-wrap">
                            <div>
                                <span class="fw-bold">Đơn hàng #${order.id}</span>
                                <span class="text-muted ms-3">
                                    <i class="far fa-calendar-alt me-1"></i>
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                </span>
                            </div>
                            <div class="mt-2 mt-sm-0">
                                <span class="badge bg-${order.status eq 'DELIVERED' ? 'success' : (order.status eq 'SHIPPED' ? 'info' : (order.status eq 'PROCESSING' ? 'primary' : (order.status eq 'CANCELED' ? 'danger' : 'warning')))} badge-status me-2">
                                    <i class="fas fa-${order.status eq 'DELIVERED' ? 'check-circle' : (order.status eq 'SHIPPED' ? 'truck' : (order.status eq 'PROCESSING' ? 'cog' : (order.status eq 'CANCELED' ? 'times-circle' : 'clock')))} me-1"></i>
                                    ${order.status eq 'DELIVERED' ? 'Đã giao hàng' : (order.status eq 'SHIPPED' ? 'Đang vận chuyển' : (order.status eq 'PROCESSING' ? 'Đang xử lý' : (order.status eq 'CANCELED' ? 'Đã hủy' : 'Chờ xử lý')))}
                                </span>
                                
                                <span class="badge bg-${order.paymentStatus eq 'PAID' ? 'success' : (order.paymentStatus eq 'PARTIAL' ? 'warning' : 'danger')} badge-status">
                                    <i class="fas fa-${order.paymentStatus eq 'PAID' ? 'check-circle' : (order.paymentStatus eq 'PARTIAL' ? 'clock' : 'times-circle')} me-1"></i>
                                    ${order.paymentStatus eq 'PAID' ? 'Đã thanh toán' : (order.paymentStatus eq 'PARTIAL' ? 'Thanh toán một phần' : 'Chưa thanh toán')}
                                </span>
                            </div>
                        </div>
                        
                        <div class="order-body">
                            <div class="row">
                                <div class="col-md-7">
                                    <h5 class="mb-3">Sản phẩm đã đặt</h5>
                                    
                                    <c:if test="${not empty order.orderItems}">
                                        <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                                            <c:if test="${status.index < 3}">
                                                <div class="product-item d-flex align-items-center">
                                                    <c:choose>
                                                        <c:when test="${not empty item.productImage}">
                                                            <img src="${item.productImage}" alt="${item.productName}" class="me-3" style="width: 50px; height: 50px; object-fit: contain;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="me-3 d-flex align-items-center justify-content-center bg-light" style="width: 50px; height: 50px;">
                                                                <i class="fas fa-image text-muted"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div class="flex-grow-1">
                                                        <h6 class="mb-0">${item.productName}</h6>
                                                        <small class="text-muted">
                                                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" /> x ${item.quantity}
                                                        </small>
                                                    </div>
                                                    <div class="ms-auto">
                                                        <span class="fw-bold">
                                                            <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                                        </span>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:if test="${order.orderItems.size() > 3}">
                                            <div class="text-center mt-2">
                                                <small class="text-muted">+ ${order.orderItems.size() - 3} sản phẩm khác</small>
                                            </div>
                                        </c:if>
                                    </c:if>
                                    
                                    <c:if test="${empty order.orderItems}">
                                        <p class="text-muted">Không có thông tin chi tiết về sản phẩm</p>
                                    </c:if>
                                </div>
                                
                                <div class="col-md-5 mt-4 mt-md-0">
                                    <h5 class="mb-3">Thông tin đơn hàng</h5>
                                    
                                    <div class="mb-2 d-flex justify-content-between">
                                        <span>Tổng sản phẩm:</span>
                                        <span>${order.totalItems} sản phẩm</span>
                                    </div>
                                    
                                    <div class="mb-2 d-flex justify-content-between">
                                        <span>Phương thức thanh toán:</span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${order.status eq 'PAID'}">
                                                    Thanh toán qua VNPAY
                                                </c:when>
                                                <c:otherwise>
                                                    Thanh toán khi nhận hàng (COD)
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    
                                    <div class="mb-2 d-flex justify-content-between">
                                        <span>Đã thanh toán:</span>
                                        <span><fmt:formatNumber value="${order.paidAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                                    </div>
                                    
                                    <div class="mb-2 d-flex justify-content-between fw-bold">
                                        <span>Tổng thanh toán:</span>
                                        <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                                    </div>
                                    
                                    <c:if test="${order.status ne 'CANCELED' && (order.status eq 'PENDING' || order.status eq 'PROCESSING' || order.status eq 'PAID')}">
                                        <div class="mt-3">
                                            <p class="text-muted mb-2"><i class="fas fa-truck me-2"></i>Trạng thái vận chuyển:</p>
                                            <ul class="timeline">
                                                <li>
                                                    <span class="fw-bold text-${order.status eq 'PENDING' || order.status eq 'PROCESSING' || order.status eq 'PAID' || order.status eq 'SHIPPED' || order.status eq 'DELIVERED' ? 'success' : 'muted'}">Đơn hàng đã được xác nhận</span><br>
                                                    <small class="text-muted">
                                                        <c:choose>
                                                            <c:when test="${order.status eq 'PENDING' || order.status eq 'PROCESSING' || order.status eq 'PAID' || order.status eq 'SHIPPED' || order.status eq 'DELIVERED'}">
                                                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                Đang chờ xác nhận
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </small>
                                                </li>
                                                <li>
                                                    <span class="fw-bold text-${order.status eq 'PROCESSING' || order.status eq 'PAID' || order.status eq 'SHIPPED' || order.status eq 'DELIVERED' ? 'success' : 'muted'}">Đang chuẩn bị hàng</span><br>
                                                    <small class="text-muted">${order.status eq 'PROCESSING' || order.status eq 'PAID' || order.status eq 'SHIPPED' || order.status eq 'DELIVERED' ? 'Đơn hàng đang được xử lý' : 'Chờ xử lý'}</small>
                                                </li>
                                                <li>
                                                    <span class="fw-bold text-${order.status eq 'SHIPPED' || order.status eq 'DELIVERED' ? 'success' : 'muted'}">Đang vận chuyển</span><br>
                                                    <small class="text-muted">${order.status eq 'SHIPPED' || order.status eq 'DELIVERED' ? 'Đơn hàng đang được vận chuyển' : 'Chờ vận chuyển'}</small>
                                                </li>
                                                <li>
                                                    <span class="fw-bold text-${order.status eq 'DELIVERED' ? 'success' : 'muted'}">Đã giao hàng</span><br>
                                                    <small class="text-muted">${order.status eq 'DELIVERED' ? 'Đơn hàng đã giao thành công' : 'Chờ giao hàng'}</small>
                                                </li>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        
                        <div class="order-footer d-flex justify-content-between align-items-center flex-wrap">
                            <div>
                                <c:if test="${order.status eq 'PAID'}">
                                    <button class="btn btn-sm btn-outline-danger me-2 btn-cancel-order" data-order-id="${order.id}">
                                        <i class="fas fa-times-circle me-1"></i>Hủy đơn hàng
                                    </button>
                                </c:if>
                                
                                <c:if test="${order.status eq 'DELIVERED' && not order.reviewed}">
                                    <a href="${pageContext.request.contextPath}/review?orderId=${order.id}" class="btn btn-sm btn-outline-primary me-2">
                                        <i class="fas fa-star me-1"></i>Đánh giá sản phẩm
                                    </a>
                                </c:if>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/order-detail?id=${order.id}" class="btn btn-primary btn-sm">
                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                            </a>
                        </div>
                    </div>
                </c:forEach>
                
                <!-- Phân trang -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/orders?page=${currentPage - 1}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage eq i}">
                                        <li class="page-item active">
                                            <span class="page-link">${i}</span>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/orders?page=${i}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}">${i}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/orders?page=${currentPage + 1}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
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
                        <input type="hidden" name="orderId" id="cancelOrderId">
                        
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
                const orderId = $(this).data('order-id');
                $('#cancelOrderId').val(orderId);
                
                // Reset form
                $('#cancelReason').val('');
                $('#otherReason').val('');
                $('#otherReasonGroup').hide();
                
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