<%-- 
    Document   : header
    Created on : Mar 10, 2025, 8:32:46 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <header class="header">
        <div class="container">
            <div class="top-link clearfix hidden-sm hidden-xs">
                <div class="row">
                    <div class="col-6 social_link">
                        <div class="social-title">Theo dõi: </div>
                        <a href="https://www.facebook.com/thuyen.an.0205/"><i class="fab fa-facebook" style="font-size: 24px; margin-right: 10px"></i></a>
                        <a href=""><i class="fab fa-instagram" style="font-size: 24px; margin-right: 10px;color: pink;"></i></a>
                        <a href=""><i class="fab fa-youtube" style="font-size: 24px; margin-right: 10px;color: red;"></i></a>
                        <a href=""><i class="fab fa-twitter" style="font-size: 24px; margin-right: 10px"></i></a>
                    </div>
                    <div class="col-6 login_link">
                        <ul class="header_link right m-auto">
                            <li>
                                <a href="/Shoes_Store/view/authen/login.jsp"><i class="fas fa-sign-in-alt mr-3"></i>Đăng nhập</a>
                            </li>
                            <li>
                                <a href="/Shoes_Store/view/authen/registration.jsp"><i class="fas fa-user-plus mr-3" style="margin-left: 10px;"></i>Đăng kí</a>
                            </li>
                        </ul>
                        <ul class="nav nav__first right">
                            <li class="nav-item nav-item__first nav-item__first-user">
                                <img src="/Shoes_Store/img/product/noavatar.png" alt="" class="nav-item__first-img">
                                <span class="nav-item__first-name">An Thuyen</span>
                                <ul class="nav-item__first-menu">
                                    <li class="nav-item__first-item">
                                        <a href="">Tài khoản của tôi</a>
                                    </li>
                                    <li class="nav-item__first-item">
                                        <a href="">Địa chỉ của tôi</a>
                                    </li>
                                    <li class="nav-item__first-item">
                                        <a href="">Đơn mua</a>
                                    </li>
                                    <li class="nav-item__first-item">
                                        <a href="">Đăng xuất</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="header-main clearfix">
                <div class="row">
                    <div class="col-lg-3 col-100-h">
                        <div id="trigger-mobile" class="visible-sm visible-xs"><i class="fas fa-bars"></i></div>
                        <div class="logo">
                            <a href="">
                                <img src="/Shoes_Store/img/logo/logo.png" alt="" width="120px" height="120px"
                                     style=" border: 1px solid #ddd; border-radius: 5px; margin-top: 10px;">
                            </a>
                        </div>
                        <div class="mobile_cart visible-sm visible-xs">
                            <a href="/Shoes_Store/view/cart.jsp" class="header__second__cart--icon">
                                <i class="fas fa-shopping-cart"></i>
                                <span id="header__second__cart--notice" class="header__second__cart--notice">3</span>
                            </a>
                            <a href="/Shoes_Store/view/listlike.jsp" class="header__second__like--icon">
                                <i class="far fa-heart"></i>
                                <span id="header__second__like--notice" class="header__second__like--notice">3</span>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6 m-auto pdt15">
                        <form class="example" action="/Shoes_Store/view/product.jsp">
                            <input type="text" class="input-search" placeholder="Tìm kiếm.." name="search">
                            <button type="submit" class="search-btn"><i class="fa fa-search"></i></button>
                        </form>
                    </div>
                    <div class="col-3 m-auto hidden-sm hidden-xs">
                        <div class="item-car clearfix">
                            <a href="/Shoes_Store/view/cart.jsp" class="header__second__cart--icon">
                                <i class="fas fa-shopping-cart"></i>
                                <span id="header__second__cart--notice" class="header__second__cart--notice">3</span>
                            </a>
                        </div>
                        <div class="item-like clearfix">
                            <a href="/Shoes_Store/view/listlike.jsp" class="header__second__like--icon">
                                <i class="far fa-heart"></i>
                                <span id="header__second__like--notice" class="header__second__like--notice">3</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <nav class="header_nav hidden-sm hidden-xs">
            <div class="container">
                <ul class="header_nav-list nav">
                    <li class="header_nav-list-item "><a href="/Shoes_Store/view/index.jsp" class="active">Trang chủ</a></li>
                    <li class="header_nav-list-item"><a href="/Shoes_Store/view/intro.jsp">Giới thiệu</a></li>
                    <li class="header_nav-list-item has-mega">
                        <a href="/Shoes_Store/view/product.jsp">Sản phẩm<i class="fas fa-angle-right" style="margin-left: 5px;"></i></a>
                        <div class="mega-content" style="overflow-x: hidden;">
                            <div class="row">
                                <ul class="col-8 no-padding level0">
                                    <li class="level1">
                                        <a class="hmega" href="/Shoes_Store/view/product.jsp">Tất cả sản phẩm</a>
                                        <!-- <ul class="level1">
                                            <li class="level2"><a href="">Bóng đá</a></li>
                                            <li class="level2"><a href="">Bóng đá</a></li>
                                            <li class="level2"><a href="">Bóng đá</a></li>
                                            <li class="level2"><a href="">Bóng đá</a></li>
                                          </ul> -->
                                    </li>
                                    <li class="level1">
                                        <a class="hmega">Giày, dép</a>
                                        <ul class="level1">
                                            <li class="level2"><a href="/Shoes_Store/view/product.jsp">Bóng đá</a></li>
                                            <li class="level2"><a href="/Shoes_Store/view/product.jsp">Chạy</a></li>
                                            <li class="level2"><a href="/Shoes_Store/view/product.jsp">Snakers</a></li>
                                        </ul>
                                    </li>
                                </ul>
                                <div class="col-4">
                                    <a href="">
                                        <picture>
                                            <img src="https://media.giphy.com/media/mj7HcKFq23oobJMcOG/giphy.gif" alt="" width="80%">
                                        </picture>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="header_nav-list-item"><a href="/Shoes_Store/view/news.jsp">Tin tức</a></li>
                    <li class="header_nav-list-item"><a href="/Shoes_Store/view/contact.jsp">Liên hệ</a></li>
                </ul>
            </div>
        </nav>
    </header>
</html>
