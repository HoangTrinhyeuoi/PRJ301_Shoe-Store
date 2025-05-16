<%@page import="DAO.ProductDAO"%>
<%@page import="Model.Product"%>
<%@page import="Model.Customer"%>
<%@page import="DAO.CartDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .product-detail {
                display: flex;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
                overflow: hidden;
                margin-top: 30px;
            }
            .product-image {
                flex: 1;
                padding: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #f9f9f9;
            }
            .product-image img {
                max-width: 100%;
                max-height: 500px;
                object-fit: contain;
            }
            .product-info {
                flex: 1;
                padding: 30px;
                border-left: 1px solid #eee;
            }
            .product-name {
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #333;
            }
            .product-price {
                font-size: 24px;
                color: #dc3545;
                margin-bottom: 20px;
                font-weight: 600;
            }
            .product-description {
                margin-bottom: 30px;
                line-height: 1.6;
                color: #555;
            }
            .stock-info {
                margin-bottom: 20px;
                color: #333;
                font-size: 16px;
            }
            .in-stock {
                color: #28a745;
                font-weight: bold;
            }
            .low-stock {
                color: #ffc107;
                font-weight: bold;
            }
            .out-of-stock {
                color: #dc3545;
                font-weight: bold;
            }
            .quantity-selector {
                display: flex;
                align-items: center;
                margin-bottom: 25px;
            }
            .quantity-selector button {
                width: 40px;
                height: 40px;
                background-color: #f0f0f0;
                border: 1px solid #ddd;
                cursor: pointer;
                font-size: 18px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
            }
            .quantity-selector button:hover {
                background-color: #e6e6e6;
            }
            .quantity-selector input {
                width: 70px;
                height: 40px;
                text-align: center;
                border: 1px solid #ddd;
                margin: 0 8px;
                font-size: 16px;
            }
            .add-to-cart {
                background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
                color: white;
                border: none;
                padding: 12px 25px;
                font-size: 16px;
                border-radius: 50px;
                cursor: pointer;
                margin-right: 15px;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
            }
            .add-to-cart:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(106, 17, 203, 0.4);
            }
            .add-to-cart:disabled {
                background: #adb5bd;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }
            .add-to-cart i {
                margin-right: 8px;
            }
            .back-button {
                background-color: #6c757d;
                color: white;
                border: none;
                padding: 12px 25px;
                font-size: 16px;
                border-radius: 50px;
                cursor: pointer;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
            }
            .back-button:hover {
                background-color: #5a6268;
                transform: translateY(-2px);
            }
            .back-button i {
                margin-right: 8px;
            }
            .related-products {
                margin-top: 50px;
            }
            .related-products h2 {
                margin-bottom: 20px;
                font-weight: 600;
                color: #333;
                position: relative;
                padding-bottom: 10px;
            }
            .related-products h2:after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 60px;
                height: 3px;
                background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
                border-radius: 3px;
            }
            .related-products-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
            }
            .related-product-card {
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .related-product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }
            .related-product-card a {
                text-decoration: none;
                color: inherit;
            }
            .related-product-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }
            .related-product-info {
                padding: 15px;
            }
            .related-product-name {
                font-weight: bold;
                margin-bottom: 5px;
                color: #333;
            }
            .related-product-price {
                color: #dc3545;
                font-weight: 600;
            }

            /* Review System Styles */
            .review-section {
                margin-top: 50px;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
                padding: 30px;
            }
            .review-title {
                font-size: 24px;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
                color: #333;
                font-weight: 600;
            }
            .review-form {
                margin-bottom: 30px;
                padding-bottom: 25px;
                border-bottom: 1px solid #eee;
            }
            .review-form h3 {
                margin-bottom: 15px;
                color: #333;
                font-weight: 500;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #444;
            }
            .form-control {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
                transition: border-color 0.3s;
            }
            .form-control:focus {
                border-color: #2575fc;
                outline: none;
            }
            textarea.form-control {
                height: 120px;
                resize: vertical;
            }
            .rating-stars {
                display: flex;
                margin-bottom: 15px;
                flex-direction: row-reverse;
                justify-content: flex-end;
            }
            .rating-stars input {
                display: none;
            }
            .rating-stars label {
                cursor: pointer;
                font-size: 28px;
                color: #ddd;
                margin-right: 8px;
                transition: color 0.2s;
            }
            .rating-stars label:hover,
            .rating-stars label:hover ~ label,
            .rating-stars input:checked ~ label {
                color: #ffc107;
            }
            .submit-review {
                background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
                color: white;
                border: none;
                padding: 12px 25px;
                font-size: 16px;
                border-radius: 50px;
                cursor: pointer;
                transition: all 0.3s;
            }
            .submit-review:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(106, 17, 203, 0.4);
            }
            .reviews-list {
                margin-top: 25px;
            }
            .reviews-list h3 {
                margin-bottom: 20px;
                color: #333;
                font-weight: 500;
            }
            .review-item {
                padding: 20px;
                border-bottom: 1px solid #eee;
                transition: background-color 0.3s;
            }
            .review-item:hover {
                background-color: #f9f9f9;
            }
            .review-item:last-child {
                border-bottom: none;
            }
            .review-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 12px;
            }
            .reviewer-name {
                font-weight: bold;
                color: #333;
            }
            .review-date {
                color: #888;
                font-size: 14px;
            }
            .review-rating {
                color: #ffc107;
                margin-bottom: 12px;
                font-size: 18px;
            }
            .review-content {
                line-height: 1.6;
                color: #555;
            }
            .no-reviews {
                text-align: center;
                padding: 30px;
                color: #888;
                font-style: italic;
            }

            /* Toast notification */
            .toast-container {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 1050;
            }
            .custom-toast {
                min-width: 250px;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
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

            /* Responsive design for smaller screens */
            @media (max-width: 768px) {
                .product-detail {
                    flex-direction: column;
                }
                .product-image, .product-info {
                    width: 100%;
                }
                .related-products-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            @media (max-width: 480px) {
                .related-products-grid {
                    grid-template-columns: 1fr;
                }
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/JSP/products.jsp">
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
                                    <span class="cart-badge"><%= cartCount%></span>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                            </a>
                        </li>

                        <% if (customer != null) {%>
                        <!-- Đã đăng nhập -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-circle me-1"></i><%= customer.getFullName()%>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                        <i class="fas fa-user me-2"></i>Tài khoản
                                    </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cart-page">
                                        <i class="fas fa-shopping-cart me-2"></i>Giỏ hàng
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

        <div class="container">
            <%
                // Get the product ID from the request parameter
                String productIdParam = request.getParameter("id");
                int productId = 0;
                Product product = null;
                int stockQuantity = 0;

                if (productIdParam != null && !productIdParam.isEmpty()) {
                    try {
                        productId = Integer.parseInt(productIdParam);

                        // This is a simplified way to get product details
                        // In a real application, you would need a method to get a specific product by ID
                        ProductDAO productDAO = new ProductDAO();
                        List<Product> products = productDAO.searchProducts("");

                        // Find the product with the matching ID
                        for (Product p : products) {
                            if (p.getId() == productId) {
                                product = p;
                                break;
                            }
                        }

                        // Get stock quantity
                        if (product != null) {
                            stockQuantity = productDAO.getStockQuantity(productId);
                        }

                    } catch (NumberFormatException e) {
                        // Handle invalid product ID
                    }
                }

                // Handle review submission
                if ("POST".equalsIgnoreCase(request.getMethod()) && product != null) {
                    String reviewerName = request.getParameter("reviewerName");
                    String reviewContent = request.getParameter("reviewContent");
                    int rating = Integer.parseInt(request.getParameter("rating"));

                    // Create a cookie to store the reviewer's name for future use
                    if (reviewerName != null && !reviewerName.isEmpty()) {
                        Cookie reviewerCookie = new Cookie("reviewerName", reviewerName);
                        reviewerCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                        response.addCookie(reviewerCookie);
                    }

                    // Save review to database (in a real application)
                    // For demonstration, we're using session to store reviews
                    List<Map<String, Object>> productReviews = (List<Map<String, Object>>) session.getAttribute("reviews_" + productId);
                    if (productReviews == null) {
                        productReviews = new ArrayList<>();
                    }

                    Map<String, Object> newReview = new HashMap<>();
                    newReview.put("name", reviewerName);
                    newReview.put("content", reviewContent);
                    newReview.put("rating", rating);
                    newReview.put("date", new Date());

                    productReviews.add(newReview);
                    session.setAttribute("reviews_" + productId, productReviews);

                    // Redirect to avoid form resubmission
                    response.sendRedirect("productDetail.jsp?id=" + productId + "#reviews");
                    return;
                }

                if (product != null) {
            %>
            <div class="product-detail">
                <div class="product-image">
                    <img src="../<%= product.getImageUrl()%>" alt="<%= product.getName()%>">
                </div>
                <div class="product-info">
                    <h1 class="product-name"><%= product.getName()%></h1>
                    <div class="product-price"><i class="fas fa-tag me-2"></i><%= String.format("%,.0f", product.getPrice())%> VND</div>
                    <div class="product-description"><%= product.getDescription()%></div>

                    <div class="stock-info">
                        <%
                            if (stockQuantity > 10) {
                        %>
                        <span class="in-stock"><i class="fas fa-check-circle"></i> Còn hàng (<%= stockQuantity%> sản phẩm)</span>
                        <%
                        } else if (stockQuantity > 0) {
                        %>
                        <span class="low-stock"><i class="fas fa-exclamation-circle"></i> Sắp hết hàng (Chỉ còn <%= stockQuantity%> sản phẩm)</span>
                        <%
                        } else {
                        %>
                        <span class="out-of-stock"><i class="fas fa-times-circle"></i> Hết hàng</span>
                        <%
                            }
                        %>
                    </div>

                    <div class="quantity-selector">
                        <button onclick="decreaseQuantity()"><i class="fas fa-minus"></i></button>
                        <input type="number" id="quantity" value="1" min="1" max="<%= stockQuantity%>">
                        <button onclick="increaseQuantity()"><i class="fas fa-plus"></i></button>
                    </div>

                    <button id="addToCartBtn" class="add-to-cart" onclick="addToCart(<%= productId%>)" <%= stockQuantity <= 0 ? "disabled" : ""%>>
                        <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
                    </button>
                    <button class="back-button" onclick="window.location.href = '${pageContext.request.contextPath}/JSP/products.jsp'">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </button>
                </div>
            </div>

            <!-- Review Section -->
            <div class="review-section" id="reviews">
                <h2 class="review-title">Đánh giá từ khách hàng</h2>

                <!-- Review Form -->
                <div class="review-form">
                    <h3>Viết đánh giá</h3>
                    <form action="productDetail.jsp?id=<%= productId%>#reviews" method="post">
                        <div class="form-group">
                            <label for="rating">Đánh giá:</label>
                            <div class="rating-stars">
                                <input type="radio" id="star5" name="rating" value="5" required>
                                <label for="star5" title="5 sao"><i class="fas fa-star"></i></label>
                                <input type="radio" id="star4" name="rating" value="4">
                                <label for="star4" title="4 sao"><i class="fas fa-star"></i></label>
                                <input type="radio" id="star3" name="rating" value="3">
                                <label for="star3" title="3 sao"><i class="fas fa-star"></i></label>
                                <input type="radio" id="star2" name="rating" value="2">
                                <label for="star2" title="2 sao"><i class="fas fa-star"></i></label>
                                <input type="radio" id="star1" name="rating" value="1">
                                <label for="star1" title="1 sao"><i class="fas fa-star"></i></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="reviewerName">Tên của bạn:</label>
                            <input type="text" class="form-control" id="reviewerName" name="reviewerName" required
                                   value="<%= getCookieValue(request, "reviewerName", "")%>">
                        </div>
                        <div class="form-group">
                            <label for="reviewContent">Đánh giá của bạn:</label>
                            <textarea class="form-control" id="reviewContent" name="reviewContent" required></textarea>
                        </div>
                        <button type="submit" class="submit-review">Gửi đánh giá</button>
                    </form>
                </div>

                <!-- Reviews List -->
                <div class="reviews-list">
                    <h3>Đánh giá từ khách hàng (<%= getReviewCount(session, productId)%>)</h3>

                    <%
                        List<Map<String, Object>> reviews = (List<Map<String, Object>>) session.getAttribute("reviews_" + productId);
                        if (reviews != null && !reviews.isEmpty()) {
                            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                            for (int i = reviews.size() - 1; i >= 0; i--) {
                                Map<String, Object> review = reviews.get(i);
                    %>
                    <div class="review-item">
                        <div class="review-header">
                            <span class="reviewer-name"><%= review.get("name")%></span>
                            <span class="review-date"><%= dateFormat.format((Date) review.get("date"))%></span>
                        </div>
                        <div class="review-rating">
                            <%
                                int stars = (Integer) review.get("rating");
                                for (int j = 0; j < stars; j++) {
                            %>
                            <i class="fas fa-star"></i>
                            <% } %>
                            <%
                                for (int j = stars; j < 5; j++) {
                            %>
                            <i class="far fa-star"></i>
                            <% }%>
                        </div>
                        <div class="review-content"><%= review.get("content")%></div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <div class="no-reviews">Chưa có đánh giá nào. Hãy là người đầu tiên đánh giá sản phẩm!</div>
                    <%
                        }
                    %>
                </div>
            </div>

            <!-- Related Products Section -->
            <div class="related-products">
                <h2>Sản phẩm tương tự</h2>
                <div class="related-products-grid">
                    <%
                        // Get some related products (simplified example)
                        ProductDAO dao = new ProductDAO();
                        List<Product> allProducts = dao.searchProducts("");
                        List<Product> relatedProducts = new ArrayList<>();

                        // Find products in the same category (assuming they have similar IDs)
                        int categoryStart = (productId / 3) * 3;
                        for (Product p : allProducts) {
                            if (p.getId() != productId && p.getId() >= categoryStart && p.getId() < categoryStart + 6) {
                                relatedProducts.add(p);
                            }
                        }

                        int count = 0;
                        for (Product related : relatedProducts) {
                            // Limit to 4 products
                            if (count < 4) {
                                count++;
                    %>
                    <div class="related-product-card">
                        <a href="productDetail.jsp?id=<%= related.getId()%>">
                            <img src="../<%= related.getImageUrl()%>" alt="<%= related.getName()%>">
                            <div class="related-product-info">
                                <div class="related-product-name"><%= related.getName()%></div>
                                <div class="related-product-price"><%= String.format("%,.0f", related.getPrice())%> VND</div>
                            </div>
                        </a>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
            <%
            } else {
            %>
            <div class="text-center py-5 my-5">
                <div class="py-5">
                    <i class="fas fa-exclamation-circle fa-4x text-danger mb-4"></i>
                    <h2>Không tìm thấy sản phẩm</h2>
                    <p class="lead">Xin lỗi, sản phẩm bạn đang tìm kiếm không tồn tại.</p>
                    <button class="back-button mt-3" onclick="goBack()">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </button>
                </div>
            </div>
            <%
                }
            %>
        </div>

        <!-- Toast notification -->
        <div class="toast-container">
            <div class="toast custom-toast" id="notificationToast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <strong class="me-auto" id="toastTitle">Thông báo</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="toastMessage"></div>
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

        <%!
            // Helper method to get cookie value
            private String getCookieValue(HttpServletRequest request, String name, String defaultValue) {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (name.equals(cookie.getName())) {
                            return cookie.getValue();
                        }
                    }
                }
                return defaultValue;
            }

            // Helper method to get review count
            private int getReviewCount(HttpSession session, int productId) {
                List<Map<String, Object>> reviews = (List<Map<String, Object>>) session.getAttribute("reviews_" + productId);
                return reviews != null ? reviews.size() : 0;
            }
        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            // Khởi tạo toast thông báo
                            let toastElement = document.getElementById('notificationToast');
                            let toast = new bootstrap.Toast(toastElement, {delay: 3000});

                            // Hàm hiển thị thông báo
                            function showNotification(title, message, isSuccess) {
                                document.getElementById('toastTitle').innerText = title;
                                document.getElementById('toastMessage').innerText = message;

                                // Thêm class tương ứng
                                toastElement.classList.remove('toast-success', 'toast-error');
                                if (isSuccess) {
                                    toastElement.classList.add('toast-success');
                                } else {
                                    toastElement.classList.add('toast-error');
                                }

                                toast.show();
                            }

                            function decreaseQuantity() {
                                var quantityInput = document.getElementById('quantity');
                                var currentValue = parseInt(quantityInput.value);
                                if (currentValue > 1) {
                                    quantityInput.value = currentValue - 1;
                                }
                            }

                            function increaseQuantity() {
                                var quantityInput = document.getElementById('quantity');
                                var currentValue = parseInt(quantityInput.value);
                                var maxValue = parseInt(quantityInput.getAttribute('max'));

                                if (currentValue < maxValue) {
                                    quantityInput.value = currentValue + 1;
                                }
                            }

                            function addToCart(productId) {
                                const quantity = document.getElementById('quantity').value;
                                const addToCartBtn = document.getElementById('addToCartBtn');

                                // Vô hiệu hóa nút trong khi đang xử lý
                                addToCartBtn.disabled = true;
                                addToCartBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';

            <% if (session.getAttribute("customer") == null) {%>
                                // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
                                window.location.href = "${pageContext.request.contextPath}/login?redirect=JSP/productDetail.jsp?id=<%= productIdParam%>";
            <% } else { %>
                                        console.log("Thêm sản phẩm vào giỏ: ID=" + productId + ", Quantity=" + quantity);

                                        // Sử dụng URLSearchParams thay vì FormData
                                        const params = new URLSearchParams();
                                        params.append('action', 'add');
                                        params.append('productId', productId);
                                        params.append('quantity', quantity);

                                        // Gửi yêu cầu thêm vào giỏ hàng
                                        fetch('${pageContext.request.contextPath}/cart', {
                                            method: 'POST',
                                            headers: {
                                                'Content-Type': 'application/x-www-form-urlencoded',
                                            },
                                            body: params
                                        })
                                                .then(response => {
                                                    console.log("Response status:", response.status);
                                                    return response.text().then(text => {
                                                        console.log("Raw response:", text);
                                                        try {
                                                            return JSON.parse(text);
                                                        } catch (e) {
                                                            console.error("Error parsing JSON:", e);
                                                            return {
                                                                status: "error",
                                                                message: "Lỗi khi xử lý phản hồi từ server: " + e.message
                                                            };
                                                        }
                                                    });
                                                })
                                                .then(data => {
                                                    console.log("Processed data:", data);
                                                    // Hiển thị thông báo
                                                    showNotification(
                                                            data.status === 'success' ? 'Thành công' : 'Lỗi',
                                                            data.message || "Không nhận được phản hồi chi tiết",
                                                            data.status === 'success'
                                                            );

                                                    // Kích hoạt lại nút
                                                    addToCartBtn.disabled = false;
                                                    addToCartBtn.innerHTML = '<i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng';

                                                    // Nếu thành công, cập nhật số lượng giỏ hàng trên navbar sau 1 giây
                                                    if (data.status === 'success') {
                                                        setTimeout(() => {
                                                            window.location.reload(); // Tải lại trang để cập nhật số lượng giỏ hàng
                                                        }, 1000);
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    showNotification('Lỗi', 'Đã xảy ra lỗi khi thêm vào giỏ hàng: ' + error.message, false);

                                                    // Kích hoạt lại nút
                                                    addToCartBtn.disabled = false;
                                                    addToCartBtn.innerHTML = '<i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng';
                                                });
            <% }%>
                                    }

                                    function goBack() {
                                        window.history.back();
                                    }
        </script>
    </body>
</html>