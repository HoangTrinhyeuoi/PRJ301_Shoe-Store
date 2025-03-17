<%@page import="java.util.List"%>
<%@page import="dal.ProductDAO"%>
<%@page import="model.Product"%>
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
        /* Các style cũ giữ nguyên */
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
        footer {
            background-color: #343a40;
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
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
        .price-filter {
            margin-bottom: 2rem;
        }
        .price-slider {
            width: 100%;
            margin-bottom: 1rem;
        }
        .price-label {
            display: flex;
            justify-content: space-between;
            color: #6c757d;
            font-size: 0.875rem;
        }
        .filter-badge {
            display: inline-block;
            background-color: #f8f9fa;
            color: #495057;
            border-radius: 20px;
            padding: 0.3rem 0.8rem;
            margin: 0.25rem;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 0.875rem;
        }
        .filter-badge:hover {
            background-color: #e2e6ea;
        }
        .filter-badge.active {
            background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
            color: white;
        }
        .discount-toggle {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
        }
        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
            margin-right: 10px;
        }
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
        }
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        .rating-stars {
            color: #ffc107;
            cursor: pointer;
        }
        .rating-stars i {
            margin-right: 2px;
        }
    </style>
</head>
<body>
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
<!-- Categories -->
<!-- Categories -->
<div class="mb-4">
    <h5 class="fw-bold mb-3">Danh mục</h5>
    <ul class="category-list">
        <li><a href="products.jsp?category=all"><i class="fas fa-th-large"></i>Tất cả sản phẩm</a></li>
        
        <!-- Sneaker Category -->
        <li>
            <details>
                <summary><i class="fas fa-shoe-prints"></i>Sneaker</summary>
                <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                    <li><a href="products.jsp?category=1&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                    <li><a href="products.jsp?category=1&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                    <li><a href="products.jsp?category=1&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                    <li><a href="products.jsp?category=1"><i class="fas fa-angle-right"></i>Tất cả Sneaker</a></li>
                </ul>
            </details>
        </li>
        
        <!-- Football Category -->
        <li>
            <details>
                <summary><i class="fas fa-futbol"></i>Football</summary>
                <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                    <li><a href="products.jsp?category=2&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                    <li><a href="products.jsp?category=2&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                    <li><a href="products.jsp?category=2&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                    <li><a href="products.jsp?category=2"><i class="fas fa-angle-right"></i>Tất cả Football</a></li>
                </ul>
            </details>
        </li>
        
        <!-- Running Category -->
        <li>
            <details>
                <summary><i class="fas fa-running"></i>Running</summary>
                <ul class="category-list" style="margin-left: 20px; margin-top: 10px;">
                    <li><a href="products.jsp?category=3&brand=adidas"><i class="fas fa-angle-right"></i>Adidas</a></li>
                    <li><a href="products.jsp?category=3&brand=nike"><i class="fas fa-angle-right"></i>Nike</a></li>
                    <li><a href="products.jsp?category=3&brand=puma"><i class="fas fa-angle-right"></i>Puma</a></li>
                    <li><a href="products.jsp?category=3"><i class="fas fa-angle-right"></i>Tất cả Running</a></li>
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
                    <form action="products.jsp" method="GET">
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
                                        <img src="<%= p.getImageUrl() %>" class="card-img-top" alt="<%= p.getName() %>">
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title" title="<%= p.getName() %>"><%= p.getName() %></h5>
                                        <p class="card-text flex-grow-1"><%= p.getDescription() %></p>
                                        <div class="price text-danger">
                                            <i class="fas fa-tag me-2"></i><%= p.getPrice() %> VND
                                            <% if (p.getId() % 7 == 0) { %>
                                                <small class="text-decoration-line-through text-muted ms-2">
                                                    <%= (int)(p.getPrice() * 1.2) %> VND
                                                </small>
                                            <% } %>
                                        </div>
                                        <a href="productDetail.jsp?id=<%= p.getId() %>" class="btn btn-detail text-white">
                                            <i class="fas fa-eye me-2"></i>Xem chi tiết
                                        </a>
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

    <footer>
        <div class="container text-center">
            <p>&copy; 2025 Cửa hàng trực tuyến. Tất cả các quyền được bảo lưu.</p>
            <div>
                <i class="fab fa-facebook mx-2"></i>
                <i class="fab fa-instagram mx-2"></i>
                <i class="fab fa-twitter mx-2"></i>
                <i class="fab fa-youtube mx-2"></i>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Price range slider
        const priceRange = document.getElementById('priceRange');
        const selectedPrice = document.getElementById('selectedPrice');
        
        priceRange.addEventListener('input', function() {
            const value = this.value;
            const formattedValue = parseInt(value).toLocaleString('vi-VN');
            selectedPrice.textContent = `0 VND - ${formattedValue} VND`;
        });
        
        // Filter badges
        const filterBadges = document.querySelectorAll('.filter-badge');
        filterBadges.forEach(badge => {
            badge.addEventListener('click', function() {
                filterBadges.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });
    </script>
</body>
</html>