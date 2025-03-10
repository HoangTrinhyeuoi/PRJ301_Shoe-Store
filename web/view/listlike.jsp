<%-- 
    Document   : lislike
    Created on : Mar 10, 2025, 9:26:32 AM
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
        <link rel="stylesheet" href="/Shoes_Store/css/productdetail.css">
        <link rel="stylesheet" href="/Shoes_Store/css/reponsive1.css">
        <link rel="icon" href="/Shoes_Store/img/logo/icon.png" type="image/x-icon" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
                integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
        crossorigin="anonymous"></script>
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
    <div class="listlike">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-12 mb-20">
                    <a href="./ProductDetail.html" class="product__new-item">
                        <div class="card" style="width: 100%">
                            <div>
                                <img class="card-img-top" src="/Shoes_Store/img/product/ambush1.jpg" alt="Card image cap">
                                <form action="" class="hover-icon hidden-sm hidden-xs">
                                    <input type="hidden">
                                    <a href="./pay.html" class="btn-add-to-cart" title="Mua ngay">
                                        <i class="fas fa-cart-plus"></i>
                                    </a>
                                    <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                                        <i class="fas fa-search"></i>
                                    </a>
                                </form>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title custom__name-product">
                                    Áo bloolyn
                                </h5>
                                <div class="product__price">
                                    <p class="card-text price-color product__price-old">1,000,000 đ</p>
                                    <p class="card-text price-color product__price-new">1,000,000 đ</p>
                                </div>
                                <div class="home-product-item__action">
                                    <span class="home-product-item__like home-product-item__like--liked">
                                        <i class="home-product-item__like-icon-empty far fa-heart"></i>
                                        <i class="home-product-item__like-icon-fill fas fa-heart"></i>
                                    </span>
                                    <div class="home-product-item__rating">
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="home-product-item__sold">79 đã bán</span>
                                </div>
                                <div class="sale-off">
                                    <span class="sale-off-percent">20%</span>
                                    <span class="sale-off-label">GIẢM</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-20">
                    <a href="./ProductDetail.html" class="product__new-item">
                        <div class="card" style="width: 100%">
                            <div>
                                <img class="card-img-top" src="/Shoes_Store/img/product/ambush1.jpg" alt="Card image cap">
                                <form action="" class="hover-icon hidden-sm hidden-xs">
                                    <input type="hidden">
                                    <a href="./pay.html" class="btn-add-to-cart" title="Mua ngay">
                                        <i class="fas fa-cart-plus"></i>
                                    </a>
                                    <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                                        <i class="fas fa-search"></i>
                                    </a>
                                </form>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title custom__name-product">
                                    Áo bloolyn
                                </h5>
                                <div class="product__price">
                                    <p class="card-text price-color product__price-old">1,000,000 đ</p>
                                    <p class="card-text price-color product__price-new">1,000,000 đ</p>
                                </div>
                                <div class="home-product-item__action">
                                    <span class="home-product-item__like home-product-item__like--liked">
                                        <i class="home-product-item__like-icon-empty far fa-heart"></i>
                                        <i class="home-product-item__like-icon-fill fas fa-heart"></i>
                                    </span>
                                    <div class="home-product-item__rating">
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="home-product-item__sold">79 đã bán</span>
                                </div>
                                <div class="sale-off">
                                    <span class="sale-off-percent">20%</span>
                                    <span class="sale-off-label">GIẢM</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-20">
                    <a href="./ProductDetail.html" class="product__new-item">
                        <div class="card" style="width: 100%">
                            <div>
                                <img class="card-img-top" src="/Shoes_Store/img/product/ambush1.jpg" alt="Card image cap">
                                <form action="" class="hover-icon hidden-sm hidden-xs">
                                    <input type="hidden">
                                    <a href="./pay.html" class="btn-add-to-cart" title="Mua ngay">
                                        <i class="fas fa-cart-plus"></i>
                                    </a>
                                    <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                                        <i class="fas fa-search"></i>
                                    </a>
                                </form>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title custom__name-product">
                                    Áo bloolyn
                                </h5>
                                <div class="product__price">
                                    <p class="card-text price-color product__price-old">1,000,000 đ</p>
                                    <p class="card-text price-color product__price-new">1,000,000 đ</p>
                                </div>
                                <div class="home-product-item__action">
                                    <span class="home-product-item__like home-product-item__like--liked">
                                        <i class="home-product-item__like-icon-empty far fa-heart"></i>
                                        <i class="home-product-item__like-icon-fill fas fa-heart"></i>
                                    </span>
                                    <div class="home-product-item__rating">
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="home-product-item__sold">79 đã bán</span>
                                </div>
                                <div class="sale-off">
                                    <span class="sale-off-percent">20%</span>
                                    <span class="sale-off-label">GIẢM</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-20">
                    <a href="./ProductDetail.html" class="product__new-item">
                        <div class="card" style="width: 100%">
                            <div>
                                <img class="card-img-top" src="/Shoes_Store/img/product/ambush1.jpg" alt="Card image cap">
                                <form action="" class="hover-icon hidden-sm hidden-xs">
                                    <input type="hidden">
                                    <a href="./pay.html" class="btn-add-to-cart" title="Mua ngay">
                                        <i class="fas fa-cart-plus"></i>
                                    </a>
                                    <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                                        <i class="fas fa-search"></i>
                                    </a>
                                </form>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title custom__name-product">
                                    Áo bloolyn
                                </h5>
                                <div class="product__price">
                                    <p class="card-text price-color product__price-old">1,000,000 đ</p>
                                    <p class="card-text price-color product__price-new">1,000,000 đ</p>
                                </div>
                                <div class="home-product-item__action">
                                    <span class="home-product-item__like home-product-item__like--liked">
                                        <i class="home-product-item__like-icon-empty far fa-heart"></i>
                                        <i class="home-product-item__like-icon-fill fas fa-heart"></i>
                                    </span>
                                    <div class="home-product-item__rating">
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="home-product-item__star--gold fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="home-product-item__sold">79 đã bán</span>
                                </div>
                                <div class="sale-off">
                                    <span class="sale-off-percent">20%</span>
                                    <span class="sale-off-label">GIẢM</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- end content -->
    <!-- footer -->
    <jsp:include page="common/footer.jsp"></jsp:include>
    <!-- end footer -->
    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content ">

                <!-- Modal Header -->
                <!-- <div class="modal-header">
                  <h4 class="modal-title">Giày ADIDAS</h4>
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div> -->

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="mb-2 main-img-2">
                                <img src="/Shoes_Store/img/product/ars1.jpg" alt="" id="img-main" xoriginal="/Shoes_Store/img/product/ars1.jpg">
                            </div>
                            <ul class="all-img-2">
                                <li class="img-item-2">
                                    <img src="/Shoes_Store/img/product/ars1.jpg" alt="" onclick="changeImg('one')" id="one">
                                </li>
                                <li class="img-item-2">
                                    <img src="/Shoes_Store/img/product/ars2.jpg" alt="" onclick="changeImg('two')" id="two">
                                </li>
                                <li class="img-item-2">
                                    <img src="/Shoes_Store/img/product/ars3.jpg" alt="" onclick="changeImg('three')" id="three"> 
                                </li>
                                <li class="img-item-2">
                                    <img src="/Shoes_Store/img/product/ars4.jpg" alt="" onclick="changeImg('four')" id="four">
                                </li>
                            </ul>
                        </div>
                        <div class="col-6">
                            <div class="info-product">
                                <h3 class="product-name">
                                    <a href="" title="">Giày ADIDAS</a>
                                </h3>
                                <div class="status-product">
                                    Trạng thái: <b>Còn hàng</b>
                                </div>
                                <div class="infor-oder">
                                    Loại sản phẩm: <b>Giày dép</b>
                                </div>
                                <div class="price-product">
                                    <div class="special-price">
                                        <span>540.000đ</span>
                                    </div>
                                    <div class="price-old">
                                        Giá gốc: 
                                        <del>650.000đ</del>
                                        <span class="discount">(-20%)</span>
                                    </div>
                                </div>
                                <div class="product-description">
                                    Đầu tháng /2021, Nike chính thức trình
                                    làng thế hệ tiếp theo của dòng giày đá bóng huyền thoại
                                    thuộc nhà Swoosh là Tiempo Legend 9. Được mệnh danh là
                                    thế hệ nhẹ nhất từ trước đến nay của dòng giày đá bóng Tiempo,
                                    Legend 9 đã có những thay đổi đáng kể
                                    về mặt thiết kế lẫn công nghệ nhằm giúp người chơi có thể tự 
                                    tin và phát huy tối đa khả năng khi chơi bóng.
                                </div>

                                <div class="product__color d-flex" style="align-items: center;">
                                    <div class="title" style="font-size: 16px; margin-right: 10px;">
                                        Màu: 
                                    </div>
                                    <div class="select-swap d-flex">

                                        <div class="circlecheck">
                                            <input type="radio" id="f-option" class="circle-1" name="selector" checked>
                                            <label for="f-option"></label>
                                            <div class="outer-circle"></div>
                                        </div>
                                        <div class="circlecheck">
                                            <input type="radio" id="g-option" class="circle-2" name="selector">
                                            <label for="g-option"></label>
                                            <div class="outer-circle"></div>
                                        </div>
                                        <div class="circlecheck">
                                            <input type="radio" id="h-option" class="circle-3" name="selector">
                                            <label for="h-option"></label>
                                            <div class="outer-circle"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="product__size d-flex" style="align-items: center;">
                                    <div class="title" style="font-size: 16px; margin-right: 10px;">
                                        Kích thước: 
                                    </div>
                                    <div class="select-swap">
                                        <div class="swatch-element" data-value="38">
                                            <input type="radio" class="variant-1" id="swatch-1-38" name="mau" value="trung" onclick="check()">
                                            <label for="swatch-1-38" class="sd"><span>38</span></label>
                                        </div>
                                        <div class="swatch-element" data-value="39">
                                            <input type="radio" class="variant-1" id="swatch-1-39" name="mau" value="thanh" onclick="check()">
                                            <label for="swatch-1-39" class="sd"><span>39</span></label>
                                        </div>
                                        <div class="swatch-element" data-value="40" >
                                            <input type="radio" class="variant-1" id="swatch-1-40" name="mau" value="hieu" onclick="check()">
                                            <label for="swatch-1-40" class="sd"><span>40</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="product__wrap">
                                    <div class="product__amount">
                                        <label for="">Số lượng: </label>
                                        <input type="button" value="-" class="control" onclick="tru()">
                                        <input type="text" value="1" class="text-input" id="text_so_luong" onkeypress='validate(event)'> 
                                        <input type="button" value="+" class="control" onclick="cong()">
                                    </div>
                                </div>
                                <div class="product__shopnow">
                                    <button class="shopnow2">Mua ngay</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="btn-default btn-close" data-dismiss="modal">
                    <i class="fas fa-times-circle"></i>
                </button>
                <!-- Modal footer -->
                <!-- <div class="modal-footer">
                  <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div> -->

            </div>
        </div>
    </div>
    <!-- end modal -->
</body>
<script src="/Shoes_Store/js/main.js"></script>
</html>