<%-- 
    Document   : cart
    Created on : Mar 10, 2025, 9:12:23 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>P&T Shop</title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <!-- Popper JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- link font chữ -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap">
        <!-- link icon -->
        <link rel="stylesheet" href="https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <!-- link css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
        <link rel="stylesheet" href="/Shoes_Store/css/base.css">
        <link rel="stylesheet" href="/Shoes_Store/css/main.css">
        <link rel="stylesheet" href="/Shoes_Store/css/cart.css">
        <link rel="stylesheet" href="/Shoes_Store/css/reponsive1.css">
        <link rel="icon" href="/Shoes_Store/img/logo/icon.png" type="image/x-icon"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous"></script>
    </head>
    <style>
        form.example input[type=text] {
            padding: 10px;
            font-size: 17px;
            border: 1px solid grey;
            float: left;
            width: 80%;
            background: #f1f1f1;
        }

        form.example button {
            float: left;
            width: 20%;
            padding: 10px;
            background: #2196F3;
            color: white;
            font-size: 17px;
            border: 1px solid grey;
            border-left: none;
            cursor: pointer;
        }

        form.example button:hover {
            background: #0b7dda;
        }

        form.example::after {
            content: "";
            clear: both;
            display: table;
        }
        /* Mobile & tablet  */
        @media (max-width: 1023px) {
        }
        /* tablet */
        @media (min-width: 740px) and (max-width: 1023px) {
            .cart-wrap {
                padding-top: 8px;
                padding-bottom: 46px
            }
            .cart-body-left {
                width: 100%;
            }
            .cart-body-right {
                margin-top: 8px;
                width: 100%;
                padding: 16px;
            }
        }
        /* mobile */
        @media (max-width: 739px) {
            .cart-wrap {
                padding-top:8px;
                padding-bottom: 46px;
            }
            .cart-body-left {
                width: 100%;
            }
            .cart-body-right {
                margin-top: 8px;
                width: 100%;
                padding: 16px;
            }
            .cart-body-row {
                flex-direction: row;
                /* margin-left: -12px;
                margin-right: -12px; */
            }
            .card-info {
                display: grid;
                grid-template-columns: 1fr 1fr;
            }
            .card-info-img {
                grid-row: span 3;
            }
            .cart-quantity {
                margin-top: 5px;
            }
        }
    </style>
    <body>
        <div class="overlay hidden"></div>
        <!-- mobile menu -->
        <jsp:include page="common/mobile_menu.jsp"></jsp:include>
    <!-- end mobile menu -->
    <!-- header -->
    <jsp:include page="common/header.jsp"></jsp:include>
    <!-- end header -->
    <!-- content -->
    <div class="cart">
        <div class="container">
            <div class="cart-wrap">
                <div class="cart-content">
                    <form action="" class="form-cart">
                        <div class="cart-body-left">
                            <div class="cart-heding hidden-xs">
                                <div class="row cart-row"> 
                                    <div class="col-11" style="text-align: center;">
                                        <div class="row">
                                            <div class="col-5">Sản phẩm</div>
                                            <div class="col-2">Đơn giá</div>
                                            <div class="col-3">Số lượng</div>
                                            <div class="col-2">Thành tiền</div>
                                        </div>
                                    </div>
                                    <div class="col-1"></div>
                                </div>
                            </div>
                            <div class="cart-body">
                                <div class="row cart-body-row cart-body-row-1" style="align-items: center;">
                                    <div class="col-md-11 col-10" style="text-align: center;">
                                        <div class="row card-info" style="align-items: center;">
                                            <div class="col-md-2 col-12 card-info-img">
                                                <a href=""><img class="cart-img" src="/Shoes_Store/img/product/addidas1.jpg" alt=""></a>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <a href="" class="cart-name" ><h5>ÁO THỦ MÔN ĐTVN 2021 GRAND SPORT - 038-322 - VÀNG CAM</h5></a>
                                            </div>
                                            <div class="col-md-2 col-12" style="font-size: 16px;">
                                                <span>625,000₫</span>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="cart-quantity">
                                                    <input type="button" value="-" class="control" onclick="tru(1)">
                                                    <input type="text" value="1" class="text-input" id="text_so_luong-1" onkeypress='validate(event)'> 
                                                    <input type="button" value="+" class="control" onclick="cong(1)">
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-12 hidden-xs" style="font-size: 16px;">
                                                <span>625,000₫</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-1 col-2 text-right">
                                        <a onclick="xoa(1)"><i class="fas fa-trash"></i></a>
                                    </div>
                                </div>
                                <div class="row cart-body-row cart-body-row-2" style="align-items: center;">
                                    <div class="col-md-11 col-10" style="text-align: center;">
                                        <div class="row card-info" style="align-items: center;">
                                            <div class="col-md-2 col-12 card-info-img">
                                                <a href=""><img class="cart-img" src="/Shoes_Store/img/product/addidas1.jpg" alt=""></a>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <a href="" class="cart-name" ><h5>ÁO THỦ MÔN ĐTVN 2021 GRAND SPORT - 038-322 - VÀNG CAM</h5></a>
                                            </div>
                                            <div class="col-md-2 col-12" style="font-size: 16px;">
                                                <span>625,000₫</span>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="cart-quantity">
                                                    <input type="button" value="-" class="control" onclick="tru(2)">
                                                    <input type="text" value="1" class="text-input" id="text_so_luong-2" onkeypress='validate(event)'> 
                                                    <input type="button" value="+" class="control" onclick="cong(2)">
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-12 hidden-xs" style="font-size: 16px;">
                                                <span>625,000₫</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-1 col-2 text-right">
                                        <a  onclick="xoa(2)"><i class="fas fa-trash"></i></a>
                                    </div>
                                </div>
                                <div class="row cart-body-row cart-body-row-3" style="align-items: center;">
                                    <div class="col-md-11 col-10" style="text-align: center;">
                                        <div class="row card-info" style="align-items: center;">
                                            <div class="col-md-2 col-12 card-info-img">
                                                <a href=""><img class="cart-img" src="/Shoes_Store/img/product/addidas1.jpg" alt=""></a>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <a href="" class="cart-name" ><h5>ÁO THỦ MÔN ĐTVN 2021 GRAND SPORT - 038-322 - VÀNG CAM</h5></a>
                                            </div>
                                            <div class="col-md-2 col-12" style="font-size: 16px;">
                                                <span>625,000₫</span>
                                            </div>
                                            <div class="col-md-3 col-12">
                                                <div class="cart-quantity">
                                                    <input type="button" value="-" class="control" onclick="tru(3)">
                                                    <input type="text" value="1" class="text-input" id="text_so_luong-3" onkeypress='validate(event)'> 
                                                    <input type="button" value="+" class="control" onclick="cong(3)">
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-12 hidden-xs" style="font-size: 16px;">
                                                <span>625,000₫</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-1 col-2 text-right">
                                        <a onclick="xoa(3)" class="xoa"><i class="fas fa-trash"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="cart-footer">
                                <div class="row cart-footer-row">
                                    <div class="col-1"></div>
                                    <div class="col-11 continue">
                                        <a href="./Product.html">
                                            <i class="fas fa-chevron-left"></i>
                                            Tiếp tục mua sắm
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="cart-body-right">
                            <div class="cart-total">
                                <label for="">Thành tiền:</label>
                                <span class="total__price">1,415,000₫</span>
                            </div>
                            <div class="cart-buttons">
                                <a style="display: block; text-align: center;" href="./pay.html" class="chekout">THANH TOÁN</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- end content -->
    <!-- end content -->
    <!-- footer -->
    <jsp:include page="common/footer.jsp"></jsp:include>
    <!-- end footer -->
</body>
<script src="/Shoes_Store/js/main.js"></script>
</html>
