<%-- 
    Document   : index
    Created on : Mar 15, 2025, 4:09:45 PM
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
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Sneaker Space</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto me-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/products.jsp">Sản Phẩm</a></li>
<<<<<<< HEAD
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/JSP/cart.jsp">Giỏ hàng</a></li>
=======
                    <li class="nav-item"><a class="nav-link" href="cart.jsp">Giỏ hàng</a></li>
>>>>>>> d8588f6ade129e270110de5d78b08c013d418d41
                </ul>
                <!-- Thanh tìm kiếm -->
                <form class="d-flex" action="${pageContext.request.contextPath}/JSP/products.jsp" method="GET">
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
                <ul class="navbar-nav ms-auto">
                    <% if (isLoggedIn) { %>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <%= (user != null) ? user.getUserName() : (googleUser != null) ? googleUser.getName() : "" %>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
<<<<<<< HEAD
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/profile.jsp">Hồ sơ</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JSP/logout.jsp">Đăng xuất</a></li>
=======
                                <li><a class="dropdown-item" href="profile.jsp">Hồ sơ</a></li>
                                <li><a class="dropdown-item" href="logout.jsp">Đăng xuất</a></li>
>>>>>>> d8588f6ade129e270110de5d78b08c013d418d41
                            </ul>
                        </li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Đăng nhập</a></li>
                    <% } %>
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
            <p class="lead">Mua sắm những đôi giày phong cách nhất!</p>
            <a href="${pageContext.request.contextPath}/JSP/products.jsp" class="btn btn-primary btn-lg">Mua ngay</a>
        </div>
    </header>

    <!-- Danh sách sản phẩm -->
    <section class="container my-5" id="products">
        <h2 class="text-center mb-4">Sản phẩm nổi bật</h2>
        <div class="row">
            <!-- Sản phẩm mẫu -->
            <div class="col-md-4">
                <div class="card">
<<<<<<< HEAD
                    <img src="../img/OIP (2).jpeg" class="card-img-top" alt="Giày 1">
=======
                    <img src="img/OIP (2).jpeg" class="card-img-top" alt="Giày 1">
>>>>>>> d8588f6ade129e270110de5d78b08c013d418d41
                    <div class="card-body text-center">
                        <h5 class="card-title">Nike Air Max</h5>
                        <p class="card-text">2,500,000 VND</p>
                        
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
<<<<<<< HEAD
                    <img src="../img/OIP (1).jpeg" class="card-img-top" alt="Giày 2">
=======
                    <img src="img/OIP (1).jpeg" class="card-img-top" alt="Giày 2">
>>>>>>> d8588f6ade129e270110de5d78b08c013d418d41
                    <div class="card-body text-center">
                        <h5 class="card-title">Adidas Ultraboost</h5>
                        <p class="card-text">3,000,000 VND</p>
                        
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
<<<<<<< HEAD
                    <img src="../img/OIP.jpeg" class="card-img-top" alt="Giày 3">
=======
                    <img src="img/OIP.jpeg" class="card-img-top" alt="Giày 3">
>>>>>>> d8588f6ade129e270110de5d78b08c013d418d41
                    <div class="card-body text-center">
                        <h5 class="card-title">Puma RS-X</h5>
                        <p class="card-text">2,200,000 VND</p>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3">
        <p>&copy; 2025 Sneaker Space. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>