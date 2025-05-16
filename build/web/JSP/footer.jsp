<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        footer {
            background-color: #343a40;
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
    </style>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5 class="mb-3">Về chúng tôi</h5>
                    <p>ShoeStore - Cửa hàng giày chính hãng với đa dạng mẫu mã, phong cách và thương hiệu hàng đầu.</p>
                </div>
                <div class="col-md-4 mb-4">
                    <h5 class="mb-3">Liên hệ</h5>
                    <p><i class="fas fa-map-marker-alt me-2"></i>123 Đường ABC, Quận XYZ, TP. HCM</p>
                    <p><i class="fas fa-phone me-2"></i>(+84) 123 456 789</p>
                    <p><i class="fas fa-envelope me-2"></i>contact@shoestore.com</p>
                </div>
                <div class="col-md-4 mb-4">
                    <h5 class="mb-3">Liên kết nhanh</h5>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-white text-decoration-none">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp" class="text-white text-decoration-none">Sản phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart-page" class="text-white text-decoration-none">Giỏ hàng</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Chính sách</a></li>
                    </ul>
                </div>
            </div>
            <hr class="my-4 bg-light">
            <div class="text-center">
                <p class="mb-2">&copy; 2025 ShoeStore. Tất cả quyền được bảo lưu.</p>
                <div>
                    <i class="fab fa-facebook mx-2"></i>
                    <i class="fab fa-instagram mx-2"></i>
                    <i class="fab fa-twitter mx-2"></i>
                    <i class="fab fa-youtube mx-2"></i>
                </div>
            </div>
        </div>
    </footer>



</html>
