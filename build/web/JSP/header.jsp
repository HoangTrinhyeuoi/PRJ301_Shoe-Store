<%@page import="DAO.CartDAO"%>
<%@page import="Model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <header>
        <style>
            /* Thêm style cho navbar */
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
        </style>
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
                            <a class="nav-link <%= request.getRequestURI().endsWith("index.jsp") ? "active" : ""%>" href="${pageContext.request.contextPath}/JSP/index.jsp">
                                <i class="fas fa-home me-1"></i>Trang chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= request.getRequestURI().endsWith("products.jsp") ? "active" : ""%>" href="${pageContext.request.contextPath}/JSP/products.jsp">
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
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile.jsp">
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
                        <% }%>
                    </ul>
                </div>
            </div>
        </nav>
    </header>



</html>
