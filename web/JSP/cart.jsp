<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <a href="products" class="btn btn-primary mt-3">Tiếp tục mua sắm</a>
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
                                                            <img src="img/${item.imageUrl}" alt="${item.productName}" class="product-image me-3">
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
                           <a href="products" class="btn btn-outline-primary">
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
                                    <fmt:formatNumber value="300" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                </span>
                            </div>

                            <hr>

                            <div class="d-flex justify-content-between mb-4">
                                <strong>Tổng cộng:</strong>
                                <strong id="total" class="text-danger fs-5">
                                    <fmt:formatNumber value="${totalAmount + 300}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                </strong>
                            </div>

                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="codPayment" value="COD" checked>
                                    <label class="form-check-label" for="codPayment">
                                        Thanh toán khi nhận hàng (COD)
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="BANK">
                                    <label class="form-check-label" for="bankTransfer">
                                        Chuyển khoản ngân hàng
                                    </label>
                                </div>
                            </div>

                            <button id="checkout" class="btn btn-primary w-100 py-2">
                                Thanh toán ngay
                            </button>
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
            // Khởi tạo các thành phần Bootstrap
            var toastEl = document.getElementById('liveToast');
            var toast = new bootstrap.Toast(toastEl);
            var confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));

            // Hiển thị thông báo
            function showToast(title, message, isSuccess) {
                $('#toastTitle').text(title);
                $('#toastMessage').text(message);

                // Màu nền cho toast thành công hoặc lỗi
                if (isSuccess) {
                    $('#liveToast').removeClass('bg-danger text-white').addClass('bg-success text-white');
                } else {
                    $('#liveToast').removeClass('bg-success text-white').addClass('bg-danger text-white');
                }

                toast.show();
            }

            // Format số tiền VND
            function formatCurrency(amount) {
                return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND', maximumFractionDigits: 0 }).format(amount);
            }

            // Cập nhật tổng tiền
            function updateTotals() {
                let subtotal = 0;
                $('.subtotal').each(function() {
                    let text = $(this).text().trim();
                    let amount = parseInt(text.replace(/[^\d]/g, ''));
                    subtotal += amount;
                });

                const shipping = 300;
                const total = subtotal + shipping;

                $('#subtotal').text(formatCurrency(subtotal));
                $('#total').text(formatCurrency(total));
            }

            // Xử lý khi click nút tăng số lượng
            $('.btn-increase').click(function() {
                const productId = $(this).data('product-id');
                const inputElement = $(`.quantity-input[data-product-id="${productId}"]`);
                const currentValue = parseInt(inputElement.val());
                const maxStock = parseInt(inputElement.data('product-stock'));

                if (currentValue < maxStock) {
                    inputElement.val(currentValue + 1);
                    updateQuantity(productId, currentValue + 1);

                    // Kiểm tra nếu đã đạt max stock
                    if (currentValue + 1 >= maxStock) {
                        $(this).prop('disabled', true);
                    }

                    // Kích hoạt nút giảm nếu cần
                    $(`.btn-decrease[data-product-id="${productId}"]`).prop('disabled', false);
                }
            });

            // Xử lý khi click nút giảm số lượng
            $('.btn-decrease').click(function() {
                const productId = $(this).data('product-id');
                const inputElement = $(`.quantity-input[data-product-id="${productId}"]`);
                const currentValue = parseInt(inputElement.val());

                if (currentValue > 1) {
                    inputElement.val(currentValue - 1);
                    updateQuantity(productId, currentValue - 1);

                    // Kiểm tra nếu số lượng về 1
                    if (currentValue - 1 <= 1) {
                        $(this).prop('disabled', true);
                    }

                    // Kích hoạt nút tăng nếu cần
                    $(`.btn-increase[data-product-id="${productId}"]`).prop('disabled', false);
                }
            });

            // Xử lý khi thay đổi giá trị trong ô input
            $('.quantity-input').change(function() {
                const productId = $(this).data('product-id');
                let newValue = parseInt($(this).val());
                const maxStock = parseInt($(this).data('product-stock'));

                // Đảm bảo giá trị trong phạm vi hợp lệ
                if (isNaN(newValue) || newValue < 1) {
                    newValue = 1;
                    $(this).val(1);
                } else if (newValue > maxStock) {
                    newValue = maxStock;
                    $(this).val(maxStock);
                }

                // Cập nhật trạng thái nút tăng/giảm
                $(`.btn-decrease[data-product-id="${productId}"]`).prop('disabled', newValue <= 1);
                $(`.btn-increase[data-product-id="${productId}"]`).prop('disabled', newValue >= maxStock);

                // Gửi yêu cầu cập nhật
                updateQuantity(productId, newValue);
            });

            // Hàm gửi request cập nhật số lượng sản phẩm
            function updateQuantity(productId, quantity) {
                $.ajax({
                    url: 'cart',
                    type: 'POST',
                    data: {
                        action: 'update',
                        productId: productId,
                        quantity: quantity
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            // Cập nhật thành tiền cho sản phẩm
                            const unitPrice = parseFloat($(`tr#item-${productId} td:nth-child(2)`).text().replace(/[^\d]/g, ''));
                            const subtotal = unitPrice * quantity;
                            $(`.subtotal[data-product-id="${productId}"]`).text(formatCurrency(subtotal));

                            // Cập nhật tổng tiền
                            updateTotals();
                        } else {
                            showToast('Lỗi', response.message, false);
                        }
                    },
                    error: function() {
                        showToast('Lỗi', 'Đã xảy ra lỗi khi cập nhật giỏ hàng.', false);
                    }
                });
            }

            // Xử lý xóa sản phẩm
            $('.btn-remove').click(function() {
                const productId = $(this).data('product-id');
                $('#modalMessage').text('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?');

                $('#confirmButton').off('click').on('click', function() {
                    removeFromCart(productId);
                    confirmModal.hide();
                });

                confirmModal.show();
            });

            // Hàm gửi request xóa sản phẩm khỏi giỏ hàng
            function removeFromCart(productId) {
                $.ajax({
                    url: 'cart',
                    type: 'POST',
                    data: {
                        action: 'remove',
                        productId: productId
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            // Xóa hàng từ bảng
                            $(`#item-${productId}`).fadeOut(300, function() {
                                $(this).remove();

                                // Kiểm tra nếu giỏ hàng trống
                                if ($('#cartTable tbody tr').length === 0) {
                                    location.reload(); // Tải lại trang để hiển thị giỏ hàng trống
                                } else {
                                    // Cập nhật tổng tiền
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

            // Xử lý xóa toàn bộ giỏ hàng
            $('#clearCart').click(function() {
                $('#modalMessage').text('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');

                $('#confirmButton').off('click').on('click', function() {
                    clearCart();
                    confirmModal.hide();
                });

                confirmModal.show();
            });

            // Hàm gửi request xóa toàn bộ giỏ hàng
            function clearCart() {
                $.ajax({
                    url: 'cart',
                    type: 'POST',
                    data: {
                        action: 'clear'
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            location.reload(); // Tải lại trang
                        } else {
                            showToast('Lỗi', response.message, false);
                        }
                    },
                    error: function() {
                        showToast('Lỗi', 'Đã xảy ra lỗi khi xóa giỏ hàng.', false);
                    }
                });
            }

            // Xử lý thanh toán
            $('#checkout').click(function() {
                const paymentMethod = $('input[name="paymentMethod"]:checked').val();

                $('#modalMessage').text('Xác nhận thanh toán đơn hàng?');

                $('#confirmButton').off('click').on('click', function() {
                    processCheckout(paymentMethod);
                    confirmModal.hide();
                });

                confirmModal.show();
            });

            // Hàm gửi request thanh toán
            function processCheckout(paymentMethod) {
                $.ajax({
                    url: 'cart',
                    type: 'POST',
                    data: {
                        action: 'checkout',
                        paymentMethod: paymentMethod
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {
                            showToast('Thành công', response.message, true);

                            // Chuyển hướng đến trang đơn hàng sau 2 giây
                            setTimeout(function() {
                                if (response.orderId) {
                                    window.location.href = 'order-detail?id=' + response.orderId;
                                } else {
                                    window.location.href = 'orders';
                                }
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