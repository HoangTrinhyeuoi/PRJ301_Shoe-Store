<%-- 
    Document   : ProductDetail
    Created on : Mar 10, 2025, 9:39:13 AM
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
        .sale-off-2 {
            top: 14px;
            right: 14px;
        }
        /* Mobile & tablet  */
        @media (max-width: 1023px) {
            .sale-off-2 {
                top: 1px;
            }
        }
        /* tablet */
        @media (min-width: 740px) and (max-width: 1023px) {
            .daonguoc {
                display: flex;
                flex-direction: column-reverse;
            }
            #main-img {
                max-width: unset;
            }
            #main-img img {
                width: 100%;
                margin-left: 0;
                margin-top: 0;
                background-size: cover;
                background-position: center;
                margin-bottom: 10px;
            }
            .all-img > li {
                display: inline-block;
            }
            .all-img {
                padding: unset;
            }
            .img-item img {
                width: 150px;
                cursor: pointer;
                margin: 5px 10px;
            }
            textarea {
                width: 100%;
            }
            .btn-comment {
                display: block;
                width: 100%;
                padding: 25px 0 35px 0;
                font-size: small;
            }
        }
        /* mobile */
        @media (max-width: 739px) {
            .daonguoc {
                display: flex;
                flex-direction: column-reverse;
            }
            #main-img img {
                width: 100%;
                margin-left: 0;
                margin-top: 0;
                background-size: cover;
                background-position: center;
                margin-bottom: 10px;
            }
            .all-img > li {
                display: inline-block;
            }
            .all-img {
                padding: unset;
            }
            .img-item img {
                width: 80px;
                margin: 5px 2px;
            }
            .product__price {
                margin: 15px 0;
            }
            .product__wrap {
                display: block;
                margin: 15px 0;
            }
            .add-cart {
                width: 100%;
                padding: 10px 0;
                margin: 15px 0;
            }
            .product__shopnow {
                display: block;
            }
            .shopnow {
                width: 100%;
                margin-bottom: 15px;
            }
            .likenow {
                width: 100%;
            }
            .btn-comment {
                width: 100%;
            }
            .sale-off-2 {
                top: 1px;
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
    <!-- product detail -->
    <div class="container">
        <div class="product__detail">
            <div class="row product__detail-row">
                <div class="col-lg-6 col-12 daonguoc">
                    <div class="img-product">
                        <ul class="all-img">
                            <li class="img-item">
                                <img src="/Shoes_Store/img/product/ult1.jpg" class="small-img" alt="anh 1" onclick="changeImg('one')" id="one">
                            </li>
                            <li class="img-item">
                                <img src="/Shoes_Store/img/product/addidas1.jpg" class="small-img" alt="anh 2" onclick="changeImg('two')" id="two">
                            </li>
                            <li class="img-item">
                                <img src="/Shoes_Store/img/product/giayxanh.jpg" class="small-img" alt="anh 3" onclick="changeImg('three')" id="three">
                            </li>
                            <li class="img-item">
                                <img src="/Shoes_Store/img/product/giayxah2.jpg" class="small-img" alt="anh 4" onclick="changeImg('four')" id="four">
                            </li>

                        </ul>
                    </div>
                    <div id="main-img" style="cursor: pointer;" >
                        <img src="/Shoes_Store/img/product/ult1.jpg" class="big-img" alt="ảnh chính" id="img-main" xoriginal="/Shoes_Store/img/product/ult1.jpg">
                        <div class="sale-off sale-off-2">
                            <span class="sale-off-percent">20%</span>
                            <span class="sale-off-label">GIẢM</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-12">
                    <div class="product__name">
                        <h2>NIKE MERCURIAL SUPERFLY 8 ACADEMY TF – CV0953-107 - TRẮNG/BẠC SAFARI</h2>
                    </div>
                    <div class="status-product">
                        Trạng thái: <b>Còn hàng</b>
                    </div>
                    <div class="infor-oder">
                        Loại sản phẩm: <b>Giày dép</b>
                    </div>
                    <div class="product__price">
                        <h2>550.000đ</h2>
                    </div>

                    <div class="price-old">
                        Giá gốc: 
                        <del>650.000đ</del>
                        <span class="discount">(-20%)</span>
                    </div>
                    <!-- <div class="product__color">
                      <div class="select-swap">
                        <div class="circlecheck">
                          <input type="radio" id="f-option" class="circle-1" name="selector" checked>
                          <label for="f-option">Radio Mint Color</label>
                          
                          <div class="outer-circle"></div>
                        </div>
                        <div class="circlecheck">
                          <input type="radio" id="g-option" class="circle-2" name="selector">
                          <label for="g-option">Radio Orange Color</label>
                          
                          <div class="outer-circle"></div>
                        </div>
                        <div class="circlecheck">
                          <input type="radio" id="h-option" class="circle-3" name="selector">
                          <label for="h-option">Radio Purple Color</label>
                          
                          <div class="outer-circle"></div>
                        </div>
                        
                      </div>
                    </div> -->
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
                            <input type="button" value="-" class="control" onclick="tru()" id="cong">
                            <input type="text" value="1" class="text-input" id="text_so_luong" onkeypress='validate(event)'> 
                            <input type="button" value="+" class="control" onclick="cong()">
                        </div>
                        <button class="add-cart" onclick="fadeInModal()">Thêm vào giỏ</button>
                    </div>
                    <div class="product__shopnow">
                        <button class="shopnow">Mua ngay</button>
                        <span class="home-product-item__like home-product-item__like--liked">
                            <i class="home-product-item__like-icon-empty far fa-heart" style="font-size: 24px;margin-top: 7px;"></i>
                            <i class="home-product-item__like-icon-fill fas fa-heart" style="font-size: 24px;margin-top: 7px;"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="product__describe">
        <div class="container">
            <h2 class="product__describe-heading">Mô tả</h2>
            <div class="row">
                <div class="col-1"></div>
                <div class="col-11">
                    <h3 class="name__product">NIKE MERCURIAL SUPERFLY 8 ACADEMY TF</h3>
                    <h3>Thông số kĩ thuật: </h3>
                    <p>Phân khúc: Academy (tầm trung).</p>
                    <p>Upper: Synthetic - Da tổng hợp cao cấp.</p>
                    <p>Thiết kế đinh giày: Các đinh cao su hình chữ nhật, xếp chồng chéo với nhau. Theo đánh giá của nhiều người chơi thì những đinh TF hình chữ nhật lần này giúp đôi giày có thể trụ vững hơn trên sân.</p>
                    <p>Độ ôm chân: Cao</p>
                    <p>Bộ sưu tập: SAFARI PACK - Ra mắt tháng 4/2021</p>
                    <p>PTrên chân các cầu thủ nổi tiếng như: Cristiano Ronaldo, Kylian Mbappé, Erling Haaland, Jadon Sancho, Leroy Sané, Romelu Lukaku...</p>  
                </div>
            </div>
        </div>
    </div>
    <div class="product__comment">
        <div class="container">
            <h2 class="product__describe-heading">Bình luận</h2>
            <div class="row">
                <div class="col-lg-4 col-12 mb-4">
                    <div class="home-product-item__rating" style="font-size: 24px;transform-origin: left;margin-bottom: 5px">
                        <i class="home-product-item__star--gold fas fa-star"></i>
                        <i class="home-product-item__star--gold fas fa-star"></i>
                        <i class="home-product-item__star--gold fas fa-star"></i>
                        <i class="home-product-item__star--gold fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <textarea name="" id="" cols="70" rows="10"></textarea>
                    <button type="submit" class="btn btn-comment">Gửi</button>
                </div>
                <div class="col-lg-8 col-12">
                    <div class="body__comment">
                        <div class="comment" style="align-items: center;">
                            <img class="comment-img" src="/Shoes_Store/img/product/noavatar.png" alt="" >
                            <div class="comment__content">
                                <div class="comment__content-heding">
                                    <h4 class="comment__content-name">Nguyễn Quốc Trung</h4>
                                    <span class="comment__content-time">2021-11-12</span>
                                </div>
                                <div class="home-product-item__rating" style="font-size: 14px;transform-origin: left;margin-bottom: 5px">
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="comment__content-content">
                                    <span>Đẹp quá</span>
                                </div>
                            </div>
                        </div>
                        <div class="comment">
                            <img class="comment-img" src="/Shoes_Store/img/product/noavatar.png" alt="" >
                            <div class="comment__content">
                                <div class="comment__content-heding">
                                    <h4 class="comment__content-name">Nguyễn Quốc Trung</h4>
                                    <span class="comment__content-time">2021-11-12</span>
                                </div>
                                <div class="home-product-item__rating" style="font-size: 14px;transform-origin: left;margin-bottom: 5px">
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="comment__content-content">
                                    <span>Quá đẹp</span>
                                </div>
                            </div>
                        </div>
                        <div class="comment">
                            <img class="comment-img" src="/Shoes_Store/img/product/noavatar.png" alt="" >
                            <div class="comment__content">
                                <div class="comment__content-heding">
                                    <h4 class="comment__content-name">Nguyễn Quốc Trung</h4>
                                    <span class="comment__content-time">2021-11-12</span>
                                </div>
                                <div class="home-product-item__rating" style="font-size: 14px;transform-origin: left;margin-bottom: 5px">
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="comment__content-content">
                                    <span>Đẹp quá</span>
                                </div>
                            </div>
                        </div>
                        <div class="comment">
                            <img class="comment-img" src="/Shoes_Store/img/product/noavatar.png" alt="" >
                            <div class="comment__content">
                                <div class="comment__content-heding">
                                    <h4 class="comment__content-name">Nguyễn Quốc Trung</h4>
                                    <span class="comment__content-time">2021-11-12</span>
                                </div>
                                <div class="home-product-item__rating" style="font-size: 14px;transform-origin: left;margin-bottom: 5px">
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="home-product-item__star--gold fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="comment__content-content">
                                    <span>Sản phẩm tốt</span>
                                </div>
                            </div>
                        </div>
                        <!-- <div class="comment">
                          <img class="comment-img" src="/Shoes_Store/img/product/noavatar.png" alt="" >
                          <div class="comment__content">
                            <div class="comment__content-heding">
                              <h4 class="comment__content-name">Nguyễn Quốc Trung</h4>
                              <span class="comment__content-time">2021-11-12</span>
                            </div>
                            <div class="home-product-item__rating" style="font-size: 14px;transform-origin: left;margin-bottom: 5px">
                              <i class="home-product-item__star--gold fas fa-star"></i>
                              <i class="home-product-item__star--gold fas fa-star"></i>
                              <i class="home-product-item__star--gold fas fa-star"></i>
                              <i class="home-product-item__star--gold fas fa-star"></i>
                              <i class="fas fa-star"></i>
                            </div>
                            <div class="comment__content-content">
                              <span>Sản phẩm tốt</span>
                            </div>
                          </div>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end product detail -->
    <!-- product relate to -->
    <div class="product__relateto">
        <div class="container">
            <h3 class="product__relateto-heading">Sản phẩm liên quan</h3>
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-12 mb-20">
                    <a href="./ProductDetail.html" class="product__new-item">
                        <div class="card" style="width: 100%">
                            <div>
                                <img class="card-img-top" src="/Shoes_Store/img/product/aohoodie1.jpg" alt="Card image cap">
                                <!-- <form action="" class="hover-icon hidden-sm hidden-xs">
                                  <input type="hidden">
                                  <a href="./pay.html" class="btn-add-to-cart" title="Mua ngay">
                                    <i class="fas fa-cart-plus"></i>
                                  </a>
                                  <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                                    <i class="fas fa-search"></i>
                                  </a>
                                </form> -->
                            </div>
                            <div class="card-body">
                                <h5 class="card-title custom__name-product">
                                    Hoodie Adidas
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
                                <img class="card-img-top" src="/Shoes_Store/img/product/aohoodie1.jpg" alt="Card image cap">
                                <!-- <form action="" class="hover-icon hidden-sm hidden-xs">
                                  <input type="hidden">
                                  <a href="./pay.html" class="btn-add-to-cart" title="Mua ngay">
                                    <i class="fas fa-cart-plus"></i>
                                  </a>
                                  <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                                    <i class="fas fa-search"></i>
                                  </a>
                                </form> -->
                            </div>
                            <div class="card-body">
                                <h5 class="card-title custom__name-product">
                                    Hoodie Adidas
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
                                <img class="card-img-top" src="/Shoes_Store/img/product/aohoodie1.jpg" alt="Card image cap">
                                <!-- <form action="" class="hover-icon hidden-sm hidden-xs">
                                  <input type="hidden">
                                  <a href="./pay.html" class="btn-add-to-cart" title="Mua ngay">
                                    <i class="fas fa-cart-plus"></i>
                                  </a>
                                  <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                                    <i class="fas fa-search"></i>
                                  </a>
                                </form> -->
                            </div>
                            <div class="card-body">
                                <h5 class="card-title custom__name-product">
                                    Hoodie Adidas
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
                                <img class="card-img-top" src="/Shoes_Store/img/product/aohoodie1.jpg" alt="Card image cap">
                                <!-- <form action="" class="hover-icon hidden-sm hidden-xs">
                                  <input type="hidden">
                                  <a href="./pay.html" class="btn-add-to-cart" title="Mua ngay">
                                    <i class="fas fa-cart-plus"></i>
                                  </a>
                                  <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                                    <i class="fas fa-search"></i>
                                  </a>
                                </form> -->
                            </div>
                            <div class="card-body">
                                <h5 class="card-title custom__name-product">
                                    Hoodie Adidas
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
            <div class="seemore">
                <a href="./Product.html">Xem thêm</a>
            </div>
        </div>
    </div>
    <!-- end  product relate to-->
    <!-- footer -->
    <jsp:include page="common/footer.jsp"></jsp:include>
    <!-- end footer -->

    <div id="alert-cart" class="alert" style="display:none">
        <div class="alert__heading">
            <h4>Thêm vào giỏ hàng</h4>
        </div>
        <div class="alert__body">
            <img src="/Shoes_Store/img/product/addidas1.jpg" alt="" class="alert__body-img">
            <div>
                <h5 class="alert__body-name"></h5>

                <span class="alert__body-amount">Số lượng: 1</span>
                <h6 class="alert__body-price">2.000.000 VNĐ</h6>
            </div>
        </div>
        <div class="alert__footer">
            <a class="click__cart" style="border-radius: 4px">Xem giỏ hàng</a>
        </div>
    </div>
    <div class="overlay1" style="display: none" onclick="fadeout()">

    </div>  
</body>
<script src="/Shoes_Store/js/main.js"></script>
<script src="/Shoes_Store/js/zoomsl.js"></script>
<script>
    $(document).ready(function () {
        $(".big-img").imagezoomsl({
            zoomrange: [3, 3]

        });
    });
</script>
<script>
    function fadeInModal()
    {
        $('.alert').fadeIn();
        $('.overlay1').fadeIn();
    }
    function fadeOutModal()
    {
        $('.alert').fadeOut();
        $('.overlay1').fadeOut();
    }
    function fadeout()
    {
        $('.overlay1').fadeOut();
        $('.alert').fadeOut();
    }
    setInterval(fadeOutModal, 7000);
</script>
</html>
