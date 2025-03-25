<%@page import="java.util.List"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="Model.Product"%>
<%@page import="DAO.CartDAO"%>
<%@page import="Model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        #chatbot-wrapper {
            position: fixed;
            bottom: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        /* Nút mở chatbot */
        #toggle-chatbot {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 20px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Hộp chatbot */
        #chatbot-container {
            width: 300px;
            background: white;
            border: 1px solid #ccc;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            margin-top: 10px;
            transition: transform 0.3s ease-in-out, opacity 0.3s;
        }

        /* Ẩn ban đầu */
        .hidden {
            transform: translateY(20px);
            opacity: 0;
            pointer-events: none;
        }

        /* Hiện chatbot */
        .show {
            transform: translateY(0);
            opacity: 1;
            pointer-events: auto;
        }

        #chatbot-header {
            padding: 10px;
            background: blue;
            color: white;
            border-radius: 10px 10px 0 0;
            text-align: center;
        }

        #chatbot-messages {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
            max-height: 350px;
            word-wrap: break-word;
            background: #f9f9f9;
            border-radius: 5px;
            margin: 5px;
            
        }

        #chatbot-messages div {
            margin-bottom: 10px;
            padding: 8px;
            border-radius: 5px;
            background: #e1e1e1;
        }

        #chatbot-messages div b {
            color: blue;
        }

        #chatbot-input {
            width: calc(100% - 60px);
            padding: 8px;
            border: none;
            border-top: 1px solid #ccc;
        }

        #chatbot-container button {
            padding: 8px;
            border: none;
            background: blue;
            color: white;
            cursor: pointer;
        }
        /* CSS giữ nguyên */
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
        .search-container {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }
        .card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.12);
        }
        .card-img-container {
            height: 200px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f5f5f5;
        }
        .card-img-top {
            object-fit: cover;
            height: 100%;
            width: 100%;
            transition: transform 0.3s ease;
        }
        .card:hover .card-img-top {
            transform: scale(1.05);
        }
        .card-body {
            padding: 1.5rem;
        }
        .card-title {
            font-weight: 600;
            margin-bottom: 0.75rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .card-text {
            color: #6c757d;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin-bottom: 1rem;
        }
        .price {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .btn-detail {
            background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
            border: none;
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            transition: all 0.3s ease;
        }
        .btn-detail:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(106, 17, 203, 0.4);
        }
        .search-btn {
            background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
            border: none;
            padding: 0.5rem 2rem;
            border-radius: 0 50px 50px 0;
        }
        .search-input {
            border-radius: 50px 0 0 50px;
            padding: 0.5rem 1.5rem;
            border: 1px solid #ced4da;
        }
        .empty-result {
            background-color: #fff3f3;
            border-left: 4px solid #dc3545;
            padding: 1rem 1.5rem;
            border-radius: 5px;
            font-size: 1.1rem;
        }
        .result-count {
            color: #6c757d;
            margin-bottom: 1.5rem;
            font-style: italic;
        }
        .badge {
            position: absolute;
            top: 10px;
            right: 10px;
            border-radius: 20px;
            padding: 0.5rem 1rem;
            font-weight: 500;
        }
        .badge-new {
            background-color: #28a745;
        }
        .badge-sale {
            background-color: #dc3545;
        }
        
        /* Sidebar styles */
        .sidebar {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            height: 100%;
            position: sticky;
            top: 20px;
        }
        .sidebar h4 {
            position: relative;
            padding-bottom: 0.75rem;
            margin-bottom: 1rem;
            font-weight: 600;
        }
        .sidebar h4:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            border-radius: 3px;
        }
        .category-list {
            list-style: none;
            padding-left: 0;
            margin-bottom: 2rem;
        }
        .category-list li {
            margin-bottom: 0.5rem;
        }
        .category-list li a {
            color: #495057;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: all 0.2s ease;
            padding: 0.5rem;
            border-radius: 5px;
        }
        .category-list li a:hover {
            background-color: #f8f9fa;
            color: #2575fc;
            transform: translateX(5px);
        }
        .category-list li a i {
            margin-right: 10px;
            color: #6a11cb;
        }
        
        /* CSS cho toast thông báo */
        .toast-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1050;
        }
        .custom-toast {
            min-width: 250px;
        }
        .toast-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        .toast-error {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
        
        /* Navbar styles */
        .main-navbar {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            padding: 0.7rem 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: white !important;
        }
        .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
            font-weight: 500;
            margin: 0 0.5rem;
            transition: all 0.3s ease;
        }
        .nav-link:hover, .nav-link:focus, .nav-link.active {
            color: white !important;
            transform: translateY(-2px);
        }
        .navbar-toggler {
            border: none;
            padding: 0.5rem;
        }
        .cart-icon {
            position: relative;
            font-size: 1.3rem;
        }
        .cart-badge {
            position: absolute;
            top: -8px;
            right: -10px;
            background-color: #ff5252;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: 700;
        }
        
        /* Footer styles */
        footer {
            background-color: #343a40;
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg main-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/JSP/index.jsp">
                <i class="fas fa-shoe-prints me-2"></i>ShoeStore
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/JSP/index.jsp">
                            <i class="fas fa-home me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/JSP/products.jsp">
                            <i class="fas fa-store me-1"></i>Sản phẩm
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-list me-1"></i>Danh mục
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/products.jsp?category=1">Sneakers</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/products.jsp?category=2">Football</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/products.jsp?category=3">Running</a></li>
                        </ul>
                    </li>
                </ul>
                
                <ul class="navbar-nav ms-auto">
                    <!-- Giỏ hàng -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart-page">
                            <div class="cart-icon">
                                <i class="fas fa-shopping-cart"></i>
                                <% 
                                    // Lấy số lượng sản phẩm trong giỏ hàng nếu đã đăng nhập
                                    Customer customer = (Customer) session.getAttribute("customer");
                                    if (customer != null) {
                                        CartDAO cartDAO = new CartDAO();
                                        int cartCount = cartDAO.getCartItemCount(customer.getCustomerId());
                                        if (cartCount > 0) {
                                %>
                                    <span class="cart-badge"><%= cartCount %></span>
                                <% 
                                        }
                                    }
                                %>
                            </div>
                        </a>
                    </li>
                    
                   <% if (customer != null) { %>
                        <!-- Đã đăng nhập -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-circle me-1"></i><%= customer.getFullName() %>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/profile.jsp">
                                    <i class="fas fa-user me-2"></i>Tài khoản
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cart-page">
                                    <i class="fas fa-shopping-cart me-2"></i>Giỏ hàng
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                                    <i class="fas fa-file-invoice me-2"></i>Đơn hàng
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                </a></li>
                            </ul>
                        </li>
                    <% } else { %>
                        <!-- Chưa đăng nhập -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                <i class="fas fa-user-plus me-1"></i>Đăng ký
                            </a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="page-header">
        <div class="container">
            <h1 class="text-center mb-0"><i class="fas fa-store me-2"></i>Danh Sách Sản Phẩm</h1>
        </div>
    </header>

    <div class="container">
        <div class="row">
            <!-- Left Sidebar -->
            <div class="col-lg-3 mb-4">
                <div class="sidebar">
                    <h4><i class="fas fa-filter me-2"></i>Bộ lọc</h4>
                    
                    <!-- Categories -->
                    <div class="mb-4">
                        <h5 class="fw-bold mb-3">Danh mục</h5>
                        <ul class="category-list">
                            <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=all"><i class="fas fa-th-large"></i>Tất cả sản phẩm</a></li>
                            
                            <!-- Sneaker Category -->
                            <li>
                                <details>
                                    <summary><i class="fas fa-shoe-prints"></i>Sneaker</summary>
                                    <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=1&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=1&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=1&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=1"><i class="fas fa-angle-right"></i>Tất cả Sneaker</a></li>
                                    </ul>
                                </details>
                            </li>
                            
                            <!-- Football Category -->
                            <li>
                                <details>
                                    <summary><i class="fas fa-futbol"></i>Football</summary>
                                    <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=2&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=2&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=2&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=2"><i class="fas fa-angle-right"></i>Tất cả Football</a></li>
                                    </ul>
                                </details>
                            </li>
                            
                            <!-- Running Category -->
                            <li>
                                <details>
                                    <summary><i class="fas fa-running"></i>Running</summary>
                                    <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=3&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=3&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=3&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                                        <li><a href="${pageContext.request.contextPath}/JSP/products.jsp?category=3"><i class="fas fa-angle-right"></i>Tất cả Running</a></li>
                                    </ul>
                                </details>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-9">
                <!-- Search Container -->
                <div class="search-container">
                    <h2 class="text-center mb-4">Tìm kiếm sản phẩm</h2>
                    <form action="${pageContext.request.contextPath}/JSP/products.jsp" method="GET">
                        <div class="input-group">
                            <% 
                                String keyword = request.getParameter("keyword");
                                String searchValue = (keyword != null) ? keyword.trim() : "";
                            %>
                            <input type="text" name="keyword" class="form-control search-input" 
                                   placeholder="Nhập tên sản phẩm cần tìm..." 
                                   value="<%= searchValue %>">
                            <button type="submit" class="btn search-btn text-white">
                                <i class="fas fa-search me-2"></i>Tìm kiếm
                            </button>
                        </div>
                    </form>
                </div>

                <%
                    ProductDAO productDAO = new ProductDAO();
                    List<Product> products;

                    String category = request.getParameter("category");
                    String brand = request.getParameter("brand");


                    if (keyword != null && !keyword.trim().isEmpty()) {
                        // Tìm kiếm theo từ khóa
                        products = productDAO.searchProducts(keyword);
                    } else if (category != null && !category.equals("all") && brand != null) {
                        // Lọc theo cả thể loại và thương hiệu
                        products = productDAO.filterProductsByCategoryAndBrand(category, brand);
                    } else if (category != null && !category.equals("all")) {
                        // Lọc chỉ theo thể loại
                        products = productDAO.filterProductsByCategory(category);
                    } else if (brand != null) {
                        // Lọc chỉ theo thương hiệu
                        products = productDAO.filterProductsByBrand(brand);
                    } else {
                        // Hiển thị tất cả sản phẩm
                        products = productDAO.searchProducts("");
                    }
                %>
                <% if (products != null && !products.isEmpty()) { %>
                    <div class="result-count">
                        <i class="fas fa-info-circle me-2"></i>
                        <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                            Tìm thấy <%= products.size() %> sản phẩm cho từ khóa "<%= keyword %>"
                        <% } else { %>
                            Hiển thị tất cả <%= products.size() %> sản phẩm
                        <% } %>
                    </div>
                    
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                        <% for (Product p : products) { %>
                            <div class="col">
                                <div class="card h-100 position-relative">
                                    <% if (p.getId() % 5 == 0) { %>
                                        <span class="badge badge-new text-white">Mới</span>
                                    <% } else if (p.getId() % 7 == 0) { %>
                                        <span class="badge badge-sale text-white">Giảm giá</span>
                                    <% } %>
                                    
                                    <div class="card-img-container">
                                        <img src="../<%= p.getImageUrl() %>" class="card-img-top" alt="<%= p.getName() %>">
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title" title="<%= p.getName() %>"><%= p.getName() %></h5>
                                        <p class="card-text flex-grow-1"><%= p.getDescription() %></p>
                                        <div class="price text-danger">
                                            <i class="fas fa-tag me-2"></i><%= String.format("%,.0f", p.getPrice()) %> VND
                                            <% if (p.getId() % 7 == 0) { %>
                                                <small class="text-decoration-line-through text-muted ms-2">
                                                    <%= String.format("%,.0f", p.getPrice() * 1.2) %> VND
                                                </small>
                                            <% } %>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <a href="${pageContext.request.contextPath}/JSP/productDetail.jsp?id=<%= p.getId() %>" class="btn btn-detail text-white">
                                                <i class="fas fa-eye me-2"></i>Xem chi tiết
                                            </a>
                                            <!-- Sửa đổi ở đây: Thay đổi nút thêm vào giỏ hàng -->
                                            <% if (session.getAttribute("customer") == null) { %>
                                                <!-- Nếu chưa đăng nhập, chuyển trực tiếp đến trang đăng nhập -->
                                                <a href="${pageContext.request.contextPath}/login?redirect=JSP/products.jsp" class="btn btn-success rounded-circle">
                                                    <i class="fas fa-cart-plus"></i>
                                                </a>
                                            <% } else { %>
                                                <!-- Nếu đã đăng nhập, sử dụng JavaScript để thêm vào giỏ hàng -->
                                                <button onclick="addToCart(<%= p.getId() %>)" class="btn btn-success rounded-circle">
                                                    <i class="fas fa-cart-plus"></i>
                                                </button>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="empty-result">
                        <i class="fas fa-exclamation-circle me-2"></i>Không tìm thấy sản phẩm nào phù hợp.
                        <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                            Vui lòng thử lại với từ khóa khác hoặc <a href="products.jsp">xem tất cả sản phẩm</a>.
                        <% } %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
            <div id="chatbot-wrapper">
            <button id="toggle-chatbot">Trợ Lý</button>
            <div id="chatbot-container" class="hidden">
                <div id="chatbot-messages"></div>
                <input type="text" id="chatbot-input" placeholder="Nhập tin nhắn..." />
            </div>
    </div>

    <!-- Footer -->
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
    
    <!-- Toast thông báo -->
    <div class="toast-container">
        <div class="toast custom-toast" id="notificationToast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="me-auto" id="toastTitle">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="toastMessage"></div>
        </div>
    </div>
    <script>
        document.getElementById("toggle-chatbot").addEventListener("click", function () {
            let chatbot = document.getElementById("chatbot-container");
            chatbot.classList.toggle("hidden");
            chatbot.classList.toggle("show");
        });
    function sendMessage() {
        let inputField = document.getElementById("chatbot-input");
        let chatbox = document.getElementById("chatbot-messages");
        console.log("Chatbox element:", chatbox);
        let input = inputField.value.trim();

        if (!input) return; // Nếu input rỗng thì không gửi

        // Hiển thị tin nhắn của người dùng
        let userMessageDiv = document.createElement("div");
        userMessageDiv.innerHTML = `<b>Bạn: </b>`;
        userMessageDiv.appendChild(document.createTextNode(input));
        chatbox.appendChild(userMessageDiv);

        // Xóa nội dung input sau khi gửi
        inputField.value = "";

        // Gọi API
        fetch("/Group_Assignment/chatbot", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ message: input })
        })
        .then(response => {
            console.log("Raw API Response:", response);
            return response.json();
        })
        .then(data => {
            console.log("Parsed API Data:", data);
            if (data.reply) {
                console.log("Bot Reply:", data.reply);
                let botMessageDiv = document.createElement("div");
                botMessageDiv.innerHTML = `<b>Bot: </b>`;
                botMessageDiv.appendChild(document.createTextNode(data.reply));
                chatbox.appendChild(botMessageDiv);
            } else {
                console.error("No reply found in API response");
                let botErrorMessageDiv = document.createElement("div");
                botErrorMessageDiv.innerHTML = `<b>Bot: </b>Không nhận được phản hồi từ AI.`;
                chatbox.appendChild(botErrorMessageDiv);
            }
            // Tự động cuộn xuống cuối hộp thoại
            chatbox.scrollTop = chatbox.scrollHeight;
        })
        .catch(error => {
            console.error("Lỗi:", error);
            let botErrorMessageDiv = document.createElement("div");
            botErrorMessageDiv.innerHTML = `<b>Bot: </b>Đã xảy ra lỗi khi kết nối với AI.`;
            chatbox.appendChild(botErrorMessageDiv);
            chatbox.scrollTop = chatbox.scrollHeight;
        });
    }

    // Thêm sự kiện nhấn Enter
    document.getElementById("chatbot-input").addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            sendMessage();
        }
    });
    </script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khai báo biến toast global để tránh khởi tạo lại
    let toastElement;
    let toast;

    document.addEventListener('DOMContentLoaded', function() {
        // Khởi tạo toast thông báo
        toastElement = document.getElementById('notificationToast');
        if (toastElement) {
            toast = new bootstrap.Toast(toastElement, { delay: 3000 });
        }
        
        // Lưu trạng thái đăng nhập vào biến JavaScript
        window.isLoggedIn = <%= (session.getAttribute("customer") != null) ? "true" : "false" %>;
    });

    // Hàm hiển thị thông báo
    function showNotification(title, message, isSuccess) {
        if (!toastElement) {
            toastElement = document.getElementById('notificationToast');
            toast = new bootstrap.Toast(toastElement, { delay: 3000 });
        }
        
        document.getElementById('toastTitle').innerText = title;
        document.getElementById('toastMessage').innerText = message;
        
        // Thêm class tương ứng
        toastElement.classList.remove('toast-success', 'toast-error');
        if (isSuccess) {
            toastElement.classList.add('toast-success');
        } else {
            toastElement.classList.add('toast-error');
        }
     </script>  