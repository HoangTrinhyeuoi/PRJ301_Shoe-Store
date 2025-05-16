<%-- 
    Document   : index
    Created on : Mar 15, 2025, 4:09:45 PM
    Author     : ASUS
--%>

<%@page import="Model.UserGoogleDto"%>
<%@page import="Model.Customer"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Object userObj = session.getAttribute("customer");
    Object googleUserObj = session.getAttribute("user");

    Customer user = null;
    UserGoogleDto googleUser = null;

    if (userObj instanceof Customer) {
        user = (Customer) userObj;
    }
    if (googleUserObj instanceof UserGoogleDto) {
        googleUser = (UserGoogleDto) googleUserObj;
    }

    boolean isLoggedIn = (user != null) || (googleUser != null);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Sneaker Space</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <style>
        /* Global Styles */
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #4ecdc4;
            --dark-color: #1a1a2e;
            --light-color: #f7f7f7;
            --transition: all 0.3s ease;
        }

        body {
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: var(--light-color);
        }

        /* Navigation Bar Styling */
        .navbar {
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--primary-color) !important;
            letter-spacing: 1px;
        }

        .nav-link {
            font-weight: 500;
            margin: 0 0.5rem;
            position: relative;
            transition: var(--transition);
        }

        .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: var(--primary-color);
            transition: var(--transition);
        }

        .nav-link:hover:after {
            width: 100%;
        }

        .search-input {
            border-radius: 20px 0 0 20px;
            padding-left: 15px;
            border: none;
        }

        .search-btn {
            border-radius: 0 20px 20px 0;
            background-color: var(--primary-color);
            border: none;
            padding: 0 20px;
            transition: var(--transition);
        }

        .search-btn:hover {
            background-color: var(--dark-color);
        }

        .dropdown-menu {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .dropdown-item {
            padding: 10px 20px;
            transition: var(--transition);
        }

        .dropdown-item:hover {
            background-color: rgba(255, 107, 107, 0.1);
            color: var(--primary-color);
        }

        /* Banner Styling */
        .banner {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('${pageContext.request.contextPath}/img/adidas_predator.jpg');
            background-size: cover;
            background-position: center;
            height: 80vh;
            position: relative;
            margin-bottom: 50px;
        }

        .banner .container {
            z-index: 1;
        }

        .banner h1 {
            font-weight: 800;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            margin-bottom: 1.5rem;
        }

        .banner p {
            font-size: 1.3rem;
            max-width: 600px;
            margin: 0 auto 2rem;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
        }

        .banner .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 30px;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .banner .btn-primary:hover {
            background-color: #ff5252;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
        }

        /* Products Section */
        #products h2, .section-title {
            position: relative;
            font-weight: 700;
            color: var(--dark-color);
            padding-bottom: 15px;
            margin-bottom: 40px;
        }

        #products h2:after, .section-title:after {
            content: '';
            position: absolute;
            width: 80px;
            height: 3px;
            background-color: var(--primary-color);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }

        .card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: var(--transition);
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .card-img-top {
            height: 240px;
            object-fit: cover;
            transition: var(--transition);
        }

        .card:hover .card-img-top {
            transform: scale(1.05);
        }

        .card-body {
            padding: 1.5rem;
        }

        .card-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .card-text {
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1.2rem;
        }

        .btn-action-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .btn-view {
            flex-grow: 1;
            background-color: var(--dark-color);
            border-color: var(--dark-color);
            color: white;
            border-radius: 30px;
            transition: var(--transition);
            padding: 8px 15px;
        }

        .btn-view:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .btn-cart {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: var(--light-color);
            border: 1px solid #ddd;
            transition: var(--transition);
        }

        .btn-cart:hover {
            background-color: var(--primary-color);
            color: white;
        }

        /* Categories Section */
        .category-section {
            padding: 40px 0;
            background-color: #f8f9fa;
            margin: 40px 0;
        }

        .category-item {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            margin-bottom: 30px;
            height: 200px;
            cursor: pointer;
        }

        .category-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .category-item:hover img {
            transform: scale(1.1);
        }

        .category-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
            display: flex;
            align-items: flex-end;
            padding: 20px;
        }

        .category-title {
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
            margin: 0;
        }

        /* Features Section */
        .features-section {
            background-color: #fff;
            padding: 60px 0;
            margin: 50px 0;
        }

        .feature-box {
            text-align: center;
            padding: 30px 20px;
            transition: var(--transition);
            border-radius: 10px;
        }

        .feature-box:hover {
            background-color: #f8f9fa;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            transform: translateY(-5px);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .feature-title {
            font-weight: 600;
            margin-bottom: 1rem;
        }

        /* Newsletter Section */
        .newsletter-section {
            background-color: var(--primary-color);
            padding: 40px 0;
            color: white;
            margin-top: 60px;
        }

        .newsletter-title {
            font-weight: 700;
            margin-bottom: 10px;
        }

        .newsletter-form .form-control {
            height: 50px;
            border-radius: 30px 0 0 30px;
            border: none;
            padding-left: 20px;
        }

        .newsletter-form .btn {
            border-radius: 0 30px 30px 0;
            background-color: var(--dark-color);
            border-color: var(--dark-color);
            height: 50px;
            padding: 0 30px;
            font-weight: 600;
        }

        /* Enhanced Footer */
        footer {
            background-color: var(--dark-color);
            padding: 60px 0 20px;
            color: rgba(255, 255, 255, 0.8);
        }

        .footer-heading {
            color: white;
            font-weight: 600;
            margin-bottom: 20px;
            font-size: 1.2rem;
        }

        .footer-link {
            color: rgba(255, 255, 255, 0.7);
            transition: var(--transition);
            display: block;
            margin-bottom: 10px;
            text-decoration: none;
        }

        .footer-link:hover {
            color: white;
            transform: translateX(5px);
        }

        .footer-contact {
            margin-bottom: 10px;
        }

        .footer-contact i {
            margin-right: 10px;
        }

        .social-links {
            margin-top: 20px;
        }

        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            color: white;
            margin-right: 10px;
            transition: var(--transition);
        }

        .social-links a:hover {
            background-color: var(--primary-color);
            transform: translateY(-3px);
        }

        .copyright {
            padding-top: 20px;
            margin-top: 40px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .banner {
                height: 60vh;
            }
            
            .banner h1 {
                font-size: 2.2rem;
            }
            
            .banner p {
                font-size: 1.1rem;
            }
            
            .card-img-top {
                height: 200px;
            }
            
            .category-item {
                height: 150px;
            }
        }

        /* Animation for page load */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card, .banner .container, #products h2, .feature-box, .category-item {
            animation: fadeIn 0.8s ease forwards;
        }

        /* Custom animation delays for staggered effect */
        #products .card:nth-child(1) {
            animation-delay: 0.2s;
        }

        #products .card:nth-child(2) {
            animation-delay: 0.4s;
        }

        #products .card:nth-child(3) {
            animation-delay: 0.6s;
        }

        .feature-box:nth-child(1) {
            animation-delay: 0.3s;
        }

        .feature-box:nth-child(2) {
            animation-delay: 0.5s;
        }

        .feature-box:nth-child(3) {
            animation-delay: 0.7s;
        }

        .feature-box:nth-child(4) {
            animation-delay: 0.9s;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">Sneaker Space</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto me-auto">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/products.jsp">Sản Phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/cart.jsp">Giỏ hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/about.jsp">Giới thiệu</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/contact.jsp">Liên hệ</a></li>
                </ul>
                <!-- Thanh tìm kiếm -->
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/JSP/products.jsp" method="GET">
                    <div class="input-group">
                        <% 
                            String keyword = request.getParameter("keyword");
                            String searchValue = (keyword != null) ? keyword.trim() : "";
                        %>
                        <input type="text" name="keyword" class="form-control search-input" 
                               placeholder="Tìm kiếm giày..." 
                               value="<%= searchValue %>">
                        <button type="submit" class="btn search-btn text-white">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
                <ul class="navbar-nav">
                    <% if (isLoggedIn) { %>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user me-1"></i> <%= (user != null) ? user.getUserName() : (googleUser != null) ? googleUser.getName() : "" %>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/profile.jsp"><i class="fas fa-user-circle me-2"></i>Hồ sơ</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders?status=&sort=newest"><i class="fas fa-shopping-bag me-2"></i>Đơn hàng</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/logout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/login.jsp"><i class="fas fa-sign-in-alt me-1"></i> Đăng nhập</a></li>
                    <% } %>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/JSP/cart.jsp">
                            <i class="fas fa-shopping-cart"></i>
                            <span class="badge rounded-pill bg-danger ms-1">0</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Banner -->
    <header class="banner text-center text-white d-flex align-items-center">
        <div class="container">
            <h1 class="display-4">
            <% if (user != null) { %>
                Chào mừng trở lại, <%= user.getFullName() %>!
            <% } else if (googleUser != null) { %>
                Chào mừng trở lại, <%= googleUser.getName() %>!
            <% } else { %>
                Chào mừng đến với Sneaker Space
            <% } %>
            </h1>
            <p class="lead">Mua sắm những đôi giày phong cách nhất với giá tốt nhất!</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/JSP/products.jsp" class="btn btn-primary btn-lg">Mua ngay</a>
                <a href="${pageContext.request.contextPath}/JSP/about.jsp" class="btn btn-outline-light btn-lg">Tìm hiểu thêm</a>
            </div>
        </div>
    </header>

    <!-- Danh mục sản phẩm -->
    <section class="category-section">
        <div class="container">
            <h2 class="text-center section-title">Danh mục sản phẩm</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="category-item">
                        <img src="${pageContext.request.contextPath}/img/adidas_ultraboost.jpg" alt="Giày thể thao">
                        <div class="category-overlay">
                            <h4 class="category-title">Giày Thể Thao</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-item">
                        <img src="${pageContext.request.contextPath}/img/nike_airmax.jpg" alt="Giày chạy bộ">
                        <div class="category-overlay">
                            <h4 class="category-title">Giày Chạy Bộ</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-item">
                        <img src="${pageContext.request.contextPath}/img/puma_deviate_nitro.jpg" alt="Giày thời trang">
                        <div class="category-overlay">
                            <h4 class="category-title">Giày Thời Trang</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Danh sách sản phẩm -->
    <section class="container my-5" id="products">
        <h2 class="text-center mb-4">Sản phẩm nổi bật</h2>
        <div class="row">
            <!-- Sản phẩm mẫu -->
            <div class="col-md-3">
                <div class="card">
                    <div class="position-absolute top-0 start-0 m-3 badge bg-danger">-15%</div>
                    <img src="${pageContext.request.contextPath}/img/nike_airmax.jpg" class="card-img-top" alt="Giày 1">
                    <div class="card-body text-center">
                        <h5 class="card-title">Nike Air Max</h5>
                        <p class="card-text">
                            <span class="text-decoration-line-through text-muted me-2">2,950,000 VND</span>
                            2,500,000 VND
                        </p>
                        <div class="btn-action-group">
                            <a href="${pageContext.request.contextPath}/JSP/product-detail.jsp?id=1" class="btn btn-view">Xem chi tiết</a>
                            <button class="btn btn-cart"><i class="fas fa-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <img src="${pageContext.request.contextPath}/img/adidas_ultraboost.jpg" class="card-img-top" alt="Giày 2">
                    <div class="card-body text-center">
                        <h5 class="card-title">Adidas Ultraboost</h5>
                        <p class="card-text">3,000,000 VND</p>
                        <div class="btn-action-group">
                            <a href="${pageContext.request.contextPath}/JSP/product-detail.jsp?id=2" class="btn btn-view">Xem chi tiết</a>
                            <button class="btn btn-cart"><i class="fas fa-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="position-absolute top-0 start-0 m-3 badge bg-success">Mới</div>
                    <img src="${pageContext.request.contextPath}/img/puma_deviate_nitro.jpg" class="card-img-top" alt="Giày 3">
                    <div class="card-body text-center">
                        <h5 class="card-title">Puma Deviate Nitro</h5>
                        <p class="card-text">2,200,000 VND</p>
                        <div class="btn-action-group">
                            <a href="${pageContext.request.contextPath}/JSP/product-detail.jsp?id=3" class="btn btn-view">Xem chi tiết</a>
                            <button class="btn btn-cart"><i class="fas fa-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <img src="${pageContext.request.contextPath}/img/nike_pegasus.jpg" class="card-img-top" alt="Giày 4">
                    <div class="card-body text-center">
                        <h5 class="card-title">Nike Pegasus</h5>
                        <p class="card-text">1,950,000 VND</p>
                        <div class="btn-action-group">
                            <a href="${pageContext.request.contextPath}/JSP/product-detail.jsp?id=4" class="btn btn-view">Xem chi tiết</a>
                            <button class="btn btn-cart"><i class="fas fa-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/JSP/products.jsp" class="btn btn-outline-dark btn-lg">Xem tất cả sản phẩm</a>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <h2 class="text-center section-title">Tại sao chọn Sneaker Space?</h2>
            <div class="row">
                <div class="col-md-3">
                    <div class="feature-box">
                        <i class="fas fa-truck feature-icon"></i>
                        <h4 class="feature-title">Giao hàng miễn phí</h4>
                        <p>Đơn hàng trên 1 triệu đồng sẽ được giao hàng miễn phí toàn quốc</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-box">
                        <i class="fas fa-shield-alt feature-icon"></i>
                        <h4 class="feature-title">Hàng chính hãng 100%</h4>
                        <p>Cam kết chỉ bán hàng chính hãng với tem nhãn đầy đủ</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-box">
                        <i class="fas fa-undo-alt feature-icon"></i>
                        <h4 class="feature-title">Đổi trả trong 30 ngày</h4>
                        <p>Đổi trả sản phẩm miễn phí nếu có lỗi từ nhà sản xuất</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-box">
                        <i class="fas fa-headset feature-icon"></i>
                        <h4 class="feature-title">Hỗ trợ 24/7</h4>
                        <p>Đội ngũ tư vấn viên luôn sẵn sàng hỗ trợ mọi lúc</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="newsletter-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h3 class="newsletter-title">Đăng ký nhận tin khuyến mãi</h3>
                    <p>Đăng ký để nhận thông tin về sản phẩm mới và các chương trình khuyến mãi đặc biệt.</p>
                </div>
                <div class="col-md-6">
                    <form class="newsletter-form d-flex">
                        <input type="email" class="form-control" placeholder="Nhập email của bạn">
                        <button type="submit" class="btn">Đăng ký</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Enhanced Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <h5 class="footer-heading">Sneaker Space</h5>
                    <p>Cung cấp những đôi giày chính hãng chất lượng cao với giá tốt nhất thị trường.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <h5 class="footer-heading">Liên kết nhanh</h5>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="footer-link">Trang chủ</a>
                    <a href="${pageContext.request.contextPath}/JSP/products.jsp" class="footer-link">Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/JSP/about.jsp" class="footer-link">Giới thiệu</a>
                    <a href="${pageContext.request.contextPath}/JSP/contact.jsp" class="footer-link">Liên hệ</a>
                    <a href="${pageContext.request.contextPath}/JSP/blog.jsp" class="footer-link">Blog</a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <h5 class="footer-heading">Hỗ trợ</h5>
                    <a href="${pageContext.request.contextPath}/JSP/purchase-guide.jsp" class="footer-link">Hướng dẫn mua hàng</a>
                    <a href="${pageContext.request.contextPath}/JSP/return-policy.jsp" class="footer-link">Chính sách đổi trả</a>
                    <a href="${pageContext.request.contextPath}/JSP/warranty.jsp" class="footer-link">Chính sách bảo hành</a>
                    <a href="${pageContext.request.contextPath}/JSP/payment.jsp" class="footer-link">Phương thức thanh toán</a>
                    <a href="${pageContext.request.contextPath}/JSP/faq.jsp" class="footer-link">Câu hỏi thường gặp</a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <h5 class="footer-heading">Liên hệ</h5>
                    <p class="footer-contact"><i class="fas fa-map-marker-alt"></i> 123 Đường ABC, Quận 1, TP. HCM</p>
                    <p class="footer-contact"><i class="fas fa-phone"></i> (028) 1234 5678</p>
                    <p class="footer-contact"><i class="fas fa-envelope"></i> info@sneakerspace.com</p>
                    <p class="footer-contact"><i class="fas fa-clock"></i> Thứ 2 - Chủ nhật: 8h - 22h</p>
                </div>
            </div>
            <div class="text-center copyright">
                <p>&copy; 2025 Sneaker Space. Tất cả các quyền được bảo lưu.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Script để cập nhật số lượng sản phẩm trong giỏ hàng
        document.addEventListener('DOMContentLoaded', function() {
            // Mã JavaScript để lấy số lượng sản phẩm trong giỏ hàng từ session
            // và cập nhật badge trên biểu tượng giỏ hàng
            
            // Thêm hiệu ứng cho nút thêm vào giỏ hàng
            const cartButtons = document.querySelectorAll('.btn-cart');
            cartButtons.forEach(button => {
                button.addEventListener('click', function() {
                    this.innerHTML = '<i class="fas fa-check"></i>';
                    setTimeout(() => {
                        this.innerHTML = '<i class="fas fa-cart-plus"></i>';
                        
                        // Tăng số lượng sản phẩm trong giỏ hàng
                        const cartBadge = document.querySelector('.badge');
                        const currentCount = parseInt(cartBadge.textContent);
                        cartBadge.textContent = currentCount + 1;
                    }, 1000);
                });
            });
        });
    </script>
</body>
</html>