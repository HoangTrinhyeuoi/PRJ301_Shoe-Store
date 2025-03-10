<%-- 
    Document   : moible_menu
    Created on : Mar 10, 2025, 8:40:32 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <div class="mobile-main-menu">
            <div class="drawer-header">
                <a href="">
                    <div class="drawer-header--auth">
                        <div class="_object">
                            <img src="/Shoes_Store/img/product/giayxah2.jpg" alt="">
                        </div>
                        <div class="_body">Đăng nhập
                            <br>Nhận nhiều ưu đãi hơn
                        </div>
                    </div>
                </a>
            </div>
            <ul class="ul-first-menu">
                <li>
                    <a href="">Đăng nhập</a>
                </li>
                <li>
                    <a href="" class="abc">Đăng kí</a>
                </li>
            </ul>
            <!-- <ul class="ul-first-menu">
              <li>
                <a href="">Tài khoản của tôi</a>
              </li>
              <li>
                <a href="">Địạ chỉ của tôi</a>
              </li>
              <li>
                <a href="">Đơn mua</a>
              </li>
              <li>
                <a href="" class="list-like-noicte">Danh sách yêu thích</a>
                <span id="header__second__like--notice" class="header__second__like--notice">3</span>
              </li>
              <li>
                <a href="">Đăng xuất</a>
              </li> -->
        </ul>
        <div class="la-scroll-fix-infor-user">
            <div class="la-nav-menu-items">
                <div class="la-title-nav-items">
                    <strong>Danh mục</strong>
                </div>
                <ul class="la-nav-list-items">
                    <li class="ng-scope">
                        <a href="">Trang chủ</a>
                    </li>
                    <li class="ng-scope">
                        <a href="/Shoes_Store/view/intro.jsp">Giới thiệu</a>
                    </li>
                    <li class="ng-scope ng-has-child1">
                        <a href="/Shoes_Store/view/Product.jsp">Sản phẩm <i class="fas fa-plus cong"></i> <i class="fas fa-minus tru hidden"></i></a>
                        <ul class="ul-has-child1">
                            <li class="ng-scope ng-has-child2">
                                <a href="/Shoes_Store/view/Product.jsp">Tất cả sản phẩm <i class="fas fa-plus cong1" onclick="hienthi(1, `abc`)"></i> <i
                                        class="fas fa-minus tru1 hidden" onclick="hienthi(1, `abc`)"></i></a>
                                <ul class="ul-has-child2 hidden" id="abc">
                                    <li class="ng-scope">
                                        <a href="/Shoes_Store/view/Product.jsp">Bóng đá</a>
                                    </li>
                                    <li class="ng-scope">
                                        <a href="/Shoes_Store/view/Product.jsp">Chạy</a>
                                    </li>
                                    <li class="ng-scope">
                                        <a href="/Shoes_Store/view/Product.jsp">Snakers</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="ng-scope ng-has-child2">
                                <a href="/Shoes_Store/view/Product.jsp">Giày dép<i class="fas fa-plus cong3" onclick="hienthi(3, `abc3`)"></i> <i
                                        class="fas fa-minus tru3 hidden" onclick="hienthi(3, `abc3`)"></i></a>
                                <ul class="ul-has-child2 hidden" id="abc3">
                                    <li class="ng-scope">
                                        <a href="/Shoes_Store/view/Product.jsp">Bóng đá</a>
                                    </li>
                                    <li class="ng-scope">
                                        <a href="/Shoes_Store/view/Product.jsp">Chạy</a>
                                    </li>
                                    <li class="ng-scope">
                                        <a href="/Shoes_Store/view/Product.jsp">Snakers</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li class="ng-scope">
                        <a href="/Shoes_Store/view/news.jsp">Tin tức</a>
                    </li>
                    <li class="ng-scope">
                        <a href="/Shoes_Store/view/contact.jsp">Liên hệ</a>
                    </li>
                </ul>
            </div>
        </div>
        <ul class="mobile-support">
            <li>
                <div class="drawer-text-support">Hỗ trợ</div>
            </li>
            <li>
                <i class="fas fa-phone-square-alt footer__item-icon">HOTLINE: </i>
                <a href="tel:19006750">19006750</a>
            </li>
            <li>
                <i class="fas fa-envelope-square footer__item-icon">Email: </i>
                <a href="mailto:support@sapo.vn">support@gmail.vn</a>
            </li>
        </ul>
    </div>
</html>
