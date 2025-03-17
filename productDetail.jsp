<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%@ page import="dal.ProductDAO" %>
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
    <title>Product Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .product-detail {
            display: flex;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-top: 30px;
        }
        .product-image {
            flex: 1;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
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
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .product-price {
            font-size: 22px;
            color: #e63946;
            margin-bottom: 20px;
        }
        .product-description {
            margin-bottom: 30px;
            line-height: 1.6;
            color: #555;
        }
        .stock-info {
            margin-bottom: 20px;
            color: #333;
        }
        .in-stock {
            color: #2a9d8f;
            font-weight: bold;
        }
        .low-stock {
            color: #e76f51;
            font-weight: bold;
        }
        .out-of-stock {
            color: #e63946;
            font-weight: bold;
        }
        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .quantity-selector button {
            width: 30px;
            height: 30px;
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            cursor: pointer;
        }
        .quantity-selector input {
            width: 50px;
            height: 30px;
            text-align: center;
            border: 1px solid #ddd;
            margin: 0 5px;
        }
        .add-to-cart {
            background-color: #2a9d8f;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s;
        }
        .add-to-cart:hover {
            background-color: #238b7e;
        }
        .back-button {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #5a6268;
        }
        .related-products {
            margin-top: 40px;
        }
        .related-products h2 {
            margin-bottom: 20px;
        }
        .related-products-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .related-product-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
        }
        .related-product-price {
            color: #e63946;
        }
        
        /* Review System Styles */
        .review-section {
            margin-top: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .review-title {
            font-size: 22px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .review-form {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        textarea.form-control {
            height: 100px;
            resize: vertical;
        }
        .rating-stars {
            display: flex;
            margin-bottom: 10px;
            flex-direction: row-reverse;
            justify-content: flex-end;
        }
        .rating-stars input {
            display: none;
        }
        .rating-stars label {
            cursor: pointer;
            font-size: 25px;
            color: #ddd;
            margin-right: 5px;
        }
        .rating-stars label:hover,
        .rating-stars label:hover ~ label,
        .rating-stars input:checked ~ label {
            color: #ffc107;
        }
        .submit-review {
            background-color: #2a9d8f;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .submit-review:hover {
            background-color: #238b7e;
        }
        .reviews-list {
            margin-top: 20px;
        }
        .review-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        .review-item:last-child {
            border-bottom: none;
        }
        .review-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .reviewer-name {
            font-weight: bold;
        }
        .review-date {
            color: #888;
            font-size: 14px;
        }
        .review-rating {
            color: #ffc107;
            margin-bottom: 10px;
        }
        .review-content {
            line-height: 1.5;
        }
        .no-reviews {
            text-align: center;
            padding: 20px;
            color: #888;
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
                <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
            </div>
            <div class="product-info">
                <h1 class="product-name"><%= product.getName() %></h1>
                <div class="product-price">$<%= String.format("%.2f", product.getPrice()) %></div>
                <div class="product-description"><%= product.getDescription() %></div>
                
                <div class="stock-info">
                    <%
                        if (stockQuantity > 10) {
                    %>
                        <span class="in-stock"><i class="fas fa-check-circle"></i> In Stock (<%= stockQuantity %> available)</span>
                    <%
                        } else if (stockQuantity > 0) {
                    %>
                        <span class="low-stock"><i class="fas fa-exclamation-circle"></i> Low Stock (Only <%= stockQuantity %> left)</span>
                    <%
                        } else {
                    %>
                        <span class="out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</span>
                    <%
                        }
                    %>
                </div>
                
                <div class="quantity-selector">
                    <button onclick="decreaseQuantity()">-</button>
                    <input type="number" id="quantity" value="1" min="1" max="<%= stockQuantity %>">
                    <button onclick="increaseQuantity()">+</button>
                </div>
                
                <button class="add-to-cart" onclick="addToCart(<%= productId %>)" <%= stockQuantity <= 0 ? "disabled" : "" %>>
                    <i class="fas fa-shopping-cart"></i> Add to Cart
                </button>
                <button class="back-button" onclick="goBack()">
                    <i class="fas fa-arrow-left"></i> Back to Products
                </button>
            </div>
        </div>
        
        <!-- Review Section -->
        <div class="review-section" id="reviews">
            <h2 class="review-title">Customer Reviews</h2>
            
            <!-- Review Form -->
            <div class="review-form">
                <h3>Write a Review</h3>
                <form action="productDetail.jsp?id=<%= productId %>#reviews" method="post">
                    <div class="form-group">
                        <label for="rating">Rating:</label>
                        <div class="rating-stars">
                            <input type="radio" id="star5" name="rating" value="5" required>
                            <label for="star5" title="5 stars"><i class="fas fa-star"></i></label>
                            <input type="radio" id="star4" name="rating" value="4">
                            <label for="star4" title="4 stars"><i class="fas fa-star"></i></label>
                            <input type="radio" id="star3" name="rating" value="3">
                            <label for="star3" title="3 stars"><i class="fas fa-star"></i></label>
                            <input type="radio" id="star2" name="rating" value="2">
                            <label for="star2" title="2 stars"><i class="fas fa-star"></i></label>
                            <input type="radio" id="star1" name="rating" value="1">
                            <label for="star1" title="1 star"><i class="fas fa-star"></i></label>
                        </div>
                    </div>
                    <div class="form-group
                         <!-- Phần tiếp theo của form đánh giá -->
                    <div class="form-group">
                        <label for="reviewerName">Tên của bạn:</label>
                        <input type="text" class="form-control" id="reviewerName" name="reviewerName" required
                            value="<%= getCookieValue(request, "reviewerName", "") %>">
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
                <h3>Đánh giá từ khách hàng (<%= getReviewCount(session, productId) %>)</h3>
                
                <%
                    List<Map<String, Object>> reviews = (List<Map<String, Object>>) session.getAttribute("reviews_" + productId);
                    if (reviews != null && !reviews.isEmpty()) {
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                        for (int i = reviews.size() - 1; i >= 0; i--) {
                            Map<String, Object> review = reviews.get(i);
                %>
                <div class="review-item">
                    <div class="review-header">
                        <span class="reviewer-name"><%= review.get("name") %></span>
                        <span class="review-date"><%= dateFormat.format((Date)review.get("date")) %></span>
                    </div>
                    <div class="review-rating">
                        <% 
                        int stars = (Integer)review.get("rating");
                        for (int j = 0; j < stars; j++) { 
                        %>
                            <i class="fas fa-star"></i>
                        <% } %>
                        <% 
                        for (int j = stars; j < 5; j++) { 
                        %>
                            <i class="far fa-star"></i>
                        <% } %>
                    </div>
                    <div class="review-content"><%= review.get("content") %></div>
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
                    List<Product> relatedProducts = dao.filterProductsByBrand("Nike");
                    int count = 0;
                    
                    for (Product related : relatedProducts) {
                        // Skip the current product and limit to 4 products
                        if (related.getId() != productId && count < 4) {
                            count++;
                %>
                <div class="related-product-card">
                    <a href="productDetail.jsp?id=<%= related.getId() %>">
                        <img src="<%= related.getImageUrl() %>" alt="<%= related.getName() %>">
                        <div class="related-product-info">
                            <div class="related-product-name"><%= related.getName() %></div>
                            <div class="related-product-price">$<%= String.format("%.2f", related.getPrice()) %></div>
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
        <div style="text-align: center; margin-top: 100px;">
            <h2>Không tìm thấy sản phẩm</h2>
            <p>Xin lỗi, sản phẩm bạn đang tìm kiếm không tồn tại.</p>
            <button class="back-button" onclick="goBack()">
                <i class="fas fa-arrow-left"></i> Quay lại
            </button>
        </div>
        <%
            }
        %>
    </div>
    
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
    
    <script>
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
            var quantity = document.getElementById('quantity').value;
            // Add to cart functionality would be implemented here
            alert('Đã thêm ' + quantity + ' sản phẩm vào giỏ hàng (ID: ' + productId + ')');
        }
        
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>