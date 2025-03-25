<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng | Shoe Store</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <style>
        .cart-item {
            transition: all 0.3s ease;
        }
        .cart-item:hover {
            background-color: #f8f9fa;
        }
        .quantity-input {
            width: 70px;
            text-align: center;
        }
        .btn-quantity {
            width: 30px;
            height: 30px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-image {
            max-width: 100px;
            max-height: 100px;
            object-fit: contain;
        }
        .empty-cart {
            min-height: 300px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .cart-summary {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <!-- Header include -->
    <jsp:include page="header.jsp" />

    <div class="container my-5">
        <h2 class="mb-4">Giỏ hàng của bạn</h2>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="empty-cart text-center">
                    <i class="fas fa-shopping-cart fa-4x mb-3 text-muted"></i>
                    <h3>Giỏ hàng của bạn đang trống</h3>
                    <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng để tiếp tục.</p>
                    <a href="${pageContext.request.contextPath}/JSP/products.jsp" class="btn btn-primary mt-3">Tiếp tục mua sắm</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <!-- Danh sách sản phẩm trong giỏ hàng -->
                    <div class="col-lg-8">
                        <div class="table-responsive">
                            <table class="table align-middle" id="cartTable">
                                <thead>
                                    <tr>
                                        <th scope="col">Sản phẩm</th>
                                        <th scope="col" class="text-center">Đơn giá</th>
                                        <th scope="col" class="text-center">Số lượng</th>
                                        <th scope="col" class="text-end">Thành tiền</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${cartItems}">
                                        <tr class="cart-item" id="item-${item.productId}">
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <c:choose>
                                                        <c:when test="${not empty item.imageUrl}">
                                                            <img src="${item.imageUrl}" alt="${item.productName}" class="product-image me-3">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="product-image me-3 bg-light d-flex align-items-center justify-content-center">
                                                                <i class="fas fa-image text-muted"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div>
                                                        <h6 class="mb-0">${item.productName}</h6>
                                                        <c:if test="${not empty item.brandName}">
                                                            <small class="text-muted">${item.brandName}</small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                            </td>
                                            <td class="text-center">
                                                <div class="d-flex align-items-center justify-content-center">
                                                    <button class="btn btn-sm btn-outline-secondary btn-quantity me-2 btn-decrease"
                                                            data-product-id="${item.productId}"
                                                            ${item.quantity <= 1 ? 'disabled' : ''}>
                                                        <i class="fas fa-minus"></i>
                                                    </button>
                                                    <input type="number" class="form-control quantity-input"
                                                           value="${item.quantity}" min="1"
                                                           data-product-id="${item.productId}"
                                                           data-product-stock="${item.stockQuantity}">
                                                    <button class="btn btn-sm btn-outline-secondary btn-quantity ms-2 btn-increase"
                                                            data-product-id="${item.productId}"
                                                            ${item.quantity >= item.stockQuantity ? 'disabled' : ''}>
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </div>
                                            </td>
                                            <td class="text-end subtotal" data-product-id="${item.productId}">
                                                <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                            </td>
                                            <td class="text-end">
                                                <button class="btn btn-sm btn-outline-danger btn-remove" data-product-id="${item.productId}">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                           <a href="${pageContext.request.contextPath}/JSP/products.jsp" class="btn btn-outline-primary">
                                <i class="fas fa-arrow-left me-2"></i>Tiếp tục mua sắm
                            </a>
                            <button id="clearCart" class="btn btn-outline-danger">
                                <i class="fas fa-trash me-2"></i>Xóa giỏ hàng
                            </button>
                        </div>
                    </div>

                    <!-- Tổng tiền và nút thanh toán -->
                    <div class="col-lg-4 mt-4 mt-lg-0">
                        <div class="cart-summary sticky-top" style="top: 20px;">
                            <h4 class="mb-4">Thông tin đơn hàng</h4>

                            <div class="d-flex justify-content-between mb-2">
                                <span>Tạm tính:</span>
                                <span id="subtotal">
                                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                </span>
                            </div>

                            <div class="d-flex justify-content-between mb-2">
                                <span>Phí vận chuyển:</span>
                                <span id="shipping">
                                    <fmt:formatNumber value="30000" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                </span>
                            </div>

                            <hr>

                            <div class="d-flex justify-content-between mb-4">
                                <strong>Tổng cộng:</strong>
                                <strong id="total" class="text-danger fs-5">
                                    <fmt:formatNumber value="${totalAmount + 30000}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                </strong>
                            </div>

                            <!-- Thay đổi phần chọn phương thức thanh toán -->
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="codPayment" value="COD" checked>
                                    <label class="form-check-label" for="codPayment">
                                        Thanh toán khi nhận hàng (COD)
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="vnpayPayment" value="VNPAY">
                                    <label class="form-check-label" for="vnpayPayment">
                                        Thanh toán qua VNPay
                                    </label>
                                </div>
                            </div>

                            <!-- Nút thanh toán -->
                            <button id="checkout" class="btn btn-primary w-100 py-2">
                                Thanh toán ngay
                            </button>

                            <!-- Form ẩn để gửi dữ liệu đến VNPayServlet -->
                            <form id="vnpayForm" action="payment" method="post" style="display: none;">
                                <input type="hidden" name="amount" value="${totalAmount + 30000}" type="number" maxFractionDigits="0" />
                            </form>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Modal xác nhận xóa -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p id="modalMessage">Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger" id="confirmButton">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast thông báo -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="me-auto" id="toastTitle">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="toastMessage">
                Thao tác thành công!
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
        var toastEl = document.getElementById('liveToast');
        var toast = new bootstrap.Toast(toastEl);
        var confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));

        function showToast(title, message, isSuccess) {
            $('#toastTitle').text(title);
            $('#toastMessage').text(message);
            $('#liveToast').removeClass('bg-danger bg-success text-white')
                           .addClass(isSuccess ? 'bg-success text-white' : 'bg-danger text-white');
            toast.show();
        }

        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND', maximumFractionDigits: 0 }).format(amount);
        }

        function updateTotals() {
            let subtotal = 0;
            $('.subtotal').each(function() {
                let amount = parseInt($(this).text().replace(/[^\d]/g, '')) || 0;
                subtotal += amount;
            });

            const shipping = 30000;
            const total = subtotal + shipping;

            $('#subtotal').text(formatCurrency(subtotal));
            $('#total').text(formatCurrency(total));
        }

        function updateQuantity(productId, quantity) {
            $.ajax({
                url: 'cart',
                type: 'POST',
                data: { action: 'update', productId: productId, quantity: quantity },
                dataType: 'json',
                success: function(response) {
                    console.log(response); // Kiểm tra phản hồi từ server
                    if (response.status === 'success' && response.newQuantity !== undefined) {
                        const unitPrice = parseInt($(`tr#item-${productId} td:nth-child(2)`).text().replace(/[^\d]/g, '')) || 0;
                        const subtotal = unitPrice * response.newQuantity;
                        $(`.subtotal[data-product-id="${productId}"]`).text(formatCurrency(subtotal));
                        updateTotals();
                    } else {
                        showToast('Lỗi', response.message || 'Không thể cập nhật số lượng.', false);
                    }
                },
                error: function() {
                    showToast('Lỗi', 'Đã xảy ra lỗi khi cập nhật giỏ hàng.', false);
                }
            });
        }

        $('.btn-increase').click(function() {
            const productId = $(this).data('product-id');
            const inputElement = $(`.quantity-input[data-product-id="${productId}"]`);
            let currentValue = parseInt(inputElement.val()) || 1;
            const maxStock = parseInt(inputElement.data('product-stock')) || 1;

            if (currentValue < maxStock) {
                inputElement.val(currentValue + 1);
                updateQuantity(productId, currentValue + 1);
                $(this).prop('disabled', currentValue + 1 >= maxStock);
                $(`.btn-decrease[data-product-id="${productId}"]`).prop('disabled', false);
            }
        });

        $('.btn-decrease').click(function() {
            const productId = $(this).data('product-id');
            const inputElement = $(`.quantity-input[data-product-id="${productId}"]`);
            let currentValue = parseInt(inputElement.val()) || 1;

            if (currentValue > 1) {
                inputElement.val(currentValue - 1);
                updateQuantity(productId, currentValue - 1);
                $(this).prop('disabled', currentValue - 1 <= 1);
                $(`.btn-increase[data-product-id="${productId}"]`).prop('disabled', false);
            }
        });

        $('.quantity-input').change(function() {
            const productId = $(this).data('product-id');
            let newValue = parseInt($(this).val()) || 1;
            const maxStock = parseInt($(this).data('product-stock')) || 1;

            newValue = Math.max(1, Math.min(newValue, maxStock));
            $(this).val(newValue);
            updateQuantity(productId, newValue);

            $(`.btn-decrease[data-product-id="${productId}"]`).prop('disabled', newValue <= 1);
            $(`.btn-increase[data-product-id="${productId}"]`).prop('disabled', newValue >= maxStock);
        });

        $('.btn-remove').click(function() {
            const productId = $(this).data('product-id');
            $('#modalMessage').text('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?');
            $('#confirmButton').off('click').on('click', function() {
                removeFromCart(productId);
                confirmModal.hide();
            });
            confirmModal.show();
        });

        function removeFromCart(productId) {
            $.ajax({
                url: 'cart',
                type: 'POST',
                data: { action: 'remove', productId: productId },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        $(`#item-${productId}`).fadeOut(300, function() {
                            $(this).remove();
                            if ($('#cartTable tbody tr').length === 0) {
                                location.reload();
                            } else {
                                updateTotals();
                            }
                        });
                        showToast('Thành công', 'Đã xóa sản phẩm khỏi giỏ hàng.', true);
                    } else {
                        showToast('Lỗi', response.message, false);
                    }
                },
                error: function() {
                    showToast('Lỗi', 'Đã xảy ra lỗi khi xóa sản phẩm.', false);
                }
            });
        }

        $('#clearCart').click(function() {
            $('#modalMessage').text('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');
            $('#confirmButton').off('click').on('click', function() {
                clearCart();
                confirmModal.hide();
            });
            confirmModal.show();
        });

        function clearCart() {
            $.ajax({
                url: 'cart',
                type: 'POST',
                data: { action: 'clear' },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        location.reload();
                    } else {
                        showToast('Lỗi', response.message, false);
                    }
                },
                error: function() {
                    showToast('Lỗi', 'Đã xảy ra lỗi khi xóa giỏ hàng.', false);
                }
            });
        }

        $('#checkout').click(function () {
            const paymentMethod = $('input[name="paymentMethod"]:checked').val();
            $('#modalMessage').text('Xác nhận thanh toán đơn hàng?');

            $('#confirmButton').off('click').on('click', function () {
                if (paymentMethod === 'VNPAY') {
                    // Gọi AJAX để lấy URL thanh toán từ servlet
                    $.ajax({
                        url: 'payment', // Servlet xử lý VNPay
                        type: 'POST',
                        data: { amount: ${totalAmount + 30000} },
                        dataType: 'json',
                        success: function(response) {
                            if (response.code === "00") {
                                window.location.href = response.data; // Chuyển đến trang thanh toán VNPay
                            } else {
                                showToast('Lỗi', 'Không thể kết nối với VNPay', false);
                            }
                        },
                        error: function() {
                            showToast('Lỗi', 'Đã xảy ra lỗi khi gửi yêu cầu thanh toán.', false);
                        }
                    });
                } else {
                    // Xử lý thanh toán COD
                    processCheckout(paymentMethod);
                }
                confirmModal.hide();
            });

            confirmModal.show();
        });

        function processCheckout(paymentMethod) {
            $.ajax({
                url: 'cart',
                type: 'POST',
                data: { action: 'checkout', paymentMethod: paymentMethod },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        showToast('Thành công', response.message, true);
                        setTimeout(function() {
                            window.location.href = response.orderId ? 'order-detail?id=' + response.orderId : 'orders';
                        }, 2000);
                    } else {
                        showToast('Lỗi', response.message, false);
                    }
                },
                error: function() {
                    showToast('Lỗi', 'Đã xảy ra lỗi khi xử lý thanh toán.', false);
                }
            });
        }
    });
    </script>
</body>
</html>