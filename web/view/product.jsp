<%-- 
    Document   : product
    Created on : Mar 10, 2025, 9:37:22 AM
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
        <link rel="stylesheet" href="/Shoes_Store/css/product.css">
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
        /* Mobile & tablet  */
        @media (max-width: 1023px) {
            .sortby {
                float: left;
            }
            .sortby label {
                display: none;
            }
            .sort-left {
                margin-bottom: 20px;
            }
            .sortby2 {
                display: block;
            }
            .sortby {
                float: left;
            }
        }

        /* tablet */
        @media (min-width: 740px) and (max-width: 1023px) {

        }

        /* mobile */
        @media (max-width: 739px) {

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
    <!-- product -->
    <div class="product">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-12 hidden-xs hidden-sm">
                    <div class="product__filter">
                        <div class="product__filter-price">
                            <h4 class="product__filter-heading">Khoảng giá <i class="fi-rs-minus"
                                                                              onclick="khonghienthidanhsach(1, `khoanggia`)" id="minus-1"></i> <i class="fi-rs-plus hidden"
                                                                              id="plus-1" onclick="khonghienthidanhsach(1, `khoanggia`)"></i></h4>
                            <ul id = "khoanggia" class="product__filter-ckeckbox">
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="kg1">
                                        <input type="radio" class="form-check-input checkGia" id="kg1" name="optradio" value="0-1000000" onclick="checkgia(1)"><span>Dưới 1,000,000đ</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="kg2">
                                        <input type="radio" class="form-check-input checkGia" id="kg2" name="optradio" value="1000000-2000000" onclick="checkgia(2)"><span>1,000,000đ->2,000,000đ</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="kg3">
                                        <input type="radio" class="form-check-input checkGia" id="kg3" name="optradio" value="2000000-3000000" onclick="checkgia(3)"><span>2,000,000đ->3,000,000đ</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="kg4">
                                        <input type="radio" class="form-check-input checkGia" id="kg4" name="optradio" value="3000000-4000000" onclick="checkgia(4)"><span>3,000,000đ->4,000,000đ</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="kg5">
                                        <input type="radio" class="form-check-input checkGia" id="kg5" name="optradio" value="4000000-100000000" onclick="checkgia(5)"><span>Trên 4,000,000đ</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                        <div class="product__filter-trademark">
                            <h4 class="product__filter-heading">Thương hiệu <i class="fi-rs-minus"
                                                                               onclick="khonghienthidanhsach(2, `thuonghieu`)" id="minus-2"></i> <i class="fi-rs-plus hidden"
                                                                               onclick="khonghienthidanhsach(2, `thuonghieu`)" id="plus-2"></i></h4>
                            <ul id="thuonghieu" class="product__filter-ckeckbox">
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="th1">
                                        <input type="checkbox" class="form-check-input checkthuonghieu checkthuonghieu" id="th1" name="option2"
                                               value="something"><span>Adidas</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="th2">
                                        <input type="checkbox" class="form-check-input checkthuonghieu" id="th2" name="option2"
                                               value="something"><span>Nike</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="th3">
                                        <input type="checkbox" class="form-check-input checkthuonghieu" id="th3" name="option2"
                                               value="something"><span>Puma</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                        <div class="product__filter-size">
                            <h4 class="product__filter-heading">Size <i class="fi-rs-minus" onclick="khonghienthidanhsach(3, `size`)"
                                                                        id="minus-3"></i> <i class="fi-rs-plus hidden" onclick="khonghienthidanhsach(3, `size`)"
                                                                        id="plus-3"></i></h4>
                            <ul id="size" class="product__filter-ckeckbox">
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="size1">
                                        <input type="checkbox" class="form-check-input checksize" id="size1" name="option2"
                                               value="something"><span>37.5</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="size2">
                                        <input type="checkbox" class="form-check-input checksize" id="size2" name="option2"
                                               value="something"><span>38</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="size3">
                                        <input type="checkbox" class="form-check-input checksize" id="size3" name="option2"
                                               value="something"><span>38.5</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="size4">
                                        <input type="checkbox" class="form-check-input checksize" id="size4" name="option2"
                                               value="something"><span>x</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="size5">
                                        <input type="checkbox" class="form-check-input checksize" id="size5" name="option2"
                                               value="something"><span>xl</span>
                                    </label>
                                </li>
                                <li class="product__filter-item">
                                    <label class="form-check-label" for="size6">
                                        <input type="checkbox" class="form-check-input checksize" id="size6" name="option2"
                                               value="something"><span>l</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-12">
                    <div class="sort-wrap row">
                        <div class="sort-left col-12 col-lg-6">
                            <h1 class="coll-name">Tất cả sản phẩm</h1>
                        </div>
                        <div class="sort-right col-12 col-lg-6">
                            <div class="sortby">
                                <label for="">Sắp xếp theo:</label>
                                <div class="dropdown">
                                    <button type="button" class="btn btn-dark dropdown-toggle" data-toggle="dropdown">
                                        Sản phẩm nổi bật
                                    </button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" id="sort1">Giá: Tăng dần</a>
                                        <a class="dropdown-item" id="sort2">Giá: giảm dần</a>
                                        <a class="dropdown-item" id="sort3">Tên A->Z</a>
                                        <a class="dropdown-item" id="sort4">Tên Z->A</a>
                                        <a class="dropdown-item" id="sort5">Cũ nhất</a>
                                        <a class="dropdown-item" id="sort6">Mới nhất</a>
                                        <a class="dropdown-item" id="sort7">Bán chạy nhất</a>
                                    </div>
                                </div>
                            </div>
                            <div class="sortby2 hidden" style="float: right;">
                                <div class="dropdown">
                                    <button class="btn btn-dark dropdown-toggle" id="filter">
                                        Lọc sản phẩm
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row row-product" id="products">
                    </div>
                    <div class="loadmore">
                        <a style="cursor: pointer;" class="loadmore-btn">Tải thêm</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- bộ lọc mobile -->
    <div class="overlay2 hidden"></div>
    <div class="filter-mobile">
        <div class="product__filter">
            <div class="product__filter-price">
                <h4 class="product__filter-heading">Khoảng giá <i class="fi-rs-minus"
                                                                  onclick="khonghienthidanhsach(4, `khoanggia1`)" id="minus-4"></i> <i class="fi-rs-plus hidden"
                                                                  id="plus-4" onclick="khonghienthidanhsach(4, `khoanggia1`)"></i></h4>
                <ul id="khoanggia1" class="product__filter-ckeckbox">
                    <li class="product__filter-item">
                        <label class="form-check-label" for="radio2">
                            <input type="radio" class="form-check-input" id="radio2" name="optradio" value="option2"><span>Tất
                                cả</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="radio2">
                            <input type="radio" class="form-check-input" id="radio2" name="optradio" value="option2"><span>Dưới
                                1,000,000đ</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="radio2">
                            <input type="radio" class="form-check-input" id="radio2" name="optradio"
                                   value="option2"><span>1,000,000đ->2,000,000đ</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="radio2">
                            <input type="radio" class="form-check-input" id="radio2" name="optradio"
                                   value="option2"><span>2,000,000đ->3,000,000đ</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="radio2">
                            <input type="radio" class="form-check-input" id="radio2" name="optradio"
                                   value="option2"><span>3,000,000đ->4,000,000đ</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="radio2">
                            <input type="radio" class="form-check-input" id="radio2" name="optradio" value="option2"><span>Trên
                                4,000,000đ</span>
                        </label>
                    </li>
                </ul>
            </div>
            <div class="product__filter-trademark">
                <h4 class="product__filter-heading">Thương hiệu <i class="fi-rs-minus"
                                                                   onclick="khonghienthidanhsach(5, `thuonghieu2`)" id="minus-5"></i> <i class="fi-rs-plus hidden"
                                                                   onclick="khonghienthidanhsach(5, `thuonghieu2`)" id="plus-5"></i></h4>
                <ul id="thuonghieu2" class="product__filter-ckeckbox">
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>Adidas</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>Nike</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>Puma</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>DESPORTE</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>X-MUNICH</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>GRAND SPORT</span>
                        </label>
                    </li>
                </ul>
            </div>
            <div class="product__filter-size">
                <h4 class="product__filter-heading">Size <i class="fi-rs-minus" onclick="khonghienthidanhsach(6, `size3`)"
                                                            id="minus-6"></i> <i class="fi-rs-plus hidden" onclick="khonghienthidanhsach(6, `size3`)"
                                                            id="plus-6"></i></h4>
                <ul id="size3" class="product__filter-ckeckbox">
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>37.5</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>38</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>38.5</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>x</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>xl</span>
                        </label>
                    </li>
                    <li class="product__filter-item">
                        <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="option2"
                                   value="something"><span>l</span>
                        </label>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- end bộ lộc mobile -->
    <!-- end product -->
    <!-- footer -->
    <jsp:include page="common/footer.jsp"></jsp:include>
    <div id="go-to-top">
        <a class="btn-gototop"><i class="fas fa-arrow-up"></i></a>
    </div>
    <!-- end footer -->
    <!-- modal -->
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
                                        <input type="button" value="-" class="control" onclick="tru()" id="cong">
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
<script src="/Shoes_Store/js/product.js"></script>
<script>
                        var page = 1;

                        var apiProducts = [
                            {
                                id: 1,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/nikedrifit1.jpg',
                                page: 1,
                                idsort: 'sort3',
                                idkg: 'kg1',
                                idth: 'th1',
                                idsize: 'size1'
                            },
                            {
                                id: 2,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/stansmithgolf1.jpg',
                                page: 1,
                                idsort: 'sort3',
                                idkg: 'kg1',
                                idth: 'th1',
                                idsize: 'size1'
                            },
                            {
                                id: 3,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/stansmithgolf2.jpg',
                                page: 1,
                                idsort: 'sort3',
                                idkg: 'kg2',
                                idth: 'th2',
                                idsize: 'size2'
                            },
                            {
                                id: 4,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/stansmithgolf3.jpg',
                                page: 1,
                                idsort: 'sort2',
                                idkg: 'kg2',
                                idth: 'th2',
                                idsize: 'size2'
                            },
                            {
                                id: 5,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/stansmithgolf4.jpg',
                                page: 1,
                                idsort: 'sort2',
                                idkg: 'kg3',
                                idth: 'th3',
                                idsize: 'size3'
                            },
                            {
                                id: 6,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/superfly1.jpg',
                                page: 1,
                                idsort: 'sort3',
                                idkg: 'kg4',
                                idth: 'th4',
                                idsize: 'size4'
                            },
                            {
                                id: 7,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/superfly2.png',
                                page: 1,
                                idsort: 'sort3',
                                idkg: 'kg1',
                                idth: 'th1',
                                idsize: 'size1'
                            },
                            {
                                id: 8,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/superfly3.png',
                                page: 1,
                                idsort: 'sort4',
                                idkg: 'kg2',
                                idth: 'th2',
                                idsize: 'size2'
                            },
                            {
                                id: 9,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/superfly4.png',
                                page: 1,
                                idsort: 'sort3',
                                idkg: 'kg3',
                                idth: 'th3',
                                idsize: 'size3'
                            },
                            {
                                id: 10,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/tuicheo1.jpg',
                                page: 2,
                                idsort: 'sort2',
                                idkg: 'kg4',
                                idth: 'th4',
                                idsize: 'size4'
                            },
                            {
                                id: 11,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/tuicheo2.jpg',
                                page: 2,
                                idsort: 'sort3',
                                idkg: 'kg1',
                                idth: 'th1',
                                idsize: 'size1'
                            },
                            {
                                id: 12,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/tuicheo3.jpg',
                                page: 2,
                                idsort: 'sort3',
                                idkg: 'kg2',
                                idth: 'th2',
                                idsize: 'size2'
                            },
                            {
                                id: 13,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/tuicheo4.jpg',
                                page: 2,
                                idsort: 'sort4',
                                idkg: 'kg2',
                                idth: 'th2',
                                idsize: 'size2'
                            },
                            {
                                id: 14,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/ambush1.jpg',
                                page: 2,
                                idsort: 'sort5',
                                idkg: 'kg3',
                                idth: 'th3',
                                idsize: 'size3'
                            },
                            {
                                id: 15,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/ambush2.png',
                                page: 2,
                                idsort: 'sort2',
                                idkg: 'kg3',
                                idth: 'th3',
                                idsize: 'size3'
                            },
                            {
                                id: 16,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/ambush3.png',
                                page: 2,
                                idsort: 'sort4',
                                idkg: 'kg1',
                                dthh: 'kg1',
                            },
                            {
                                id: 17,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/ambush4.png',
                                page: 2,
                                idsort: 'sort5',
                                idkg: 'kg4',
                                idth: 'th4',
                                idsize: 'size4'
                            },
                            {
                                id: 18,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/tuiprimegreen1.jpg',
                                page: 2,
                                idsort: 'sort2',
                                idkg: 'kg2',
                                idth: 'th2',
                                idsize: 'size2'
                            },
                            {
                                id: 19,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/tuiprimegreen2.jpg',
                                page: 3,
                                idsort: 'sort3',
                                idkg: 'kg1',
                                idth: 'th1',
                                idsize: 'size1'
                            },
                            {
                                id: 20,
                                name: 'Nike Mercurial',
                                description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                img: '/Shoes_Store/img/product/tuiprimegreen3.jpg',
                                page: 3,
                                idsort: 'sort2',
                                idkg: 'kg3',
                                idth: 'th3',
                                idsize: 'size3'
                            },
                        ]
                        var listItems = document.querySelector('#products');
                        function initRender() {
                            var listProducts = apiProducts.map(function (apiProduct) {
                                if (apiProduct.page == page) {
                                    return `<div class="col-lg-4 col-md-6 col-12 mb-20" style="margin-bottom: 20px">
              <a href="./ProductDetail.html" class="product__new-item">
                <div class="card" style="width: 100%">
                  <div>
                    <img class="card-img-top" src="${apiProduct.img}" alt="Card image cap">
                    <form action="" class="hover-icon hidden-sm hidden-xs hidden-sm hidden-xs">
                      <input type="hidden">
                      <a href="" class="btn-add-to-cart" title="Mua ngay">
                        <i class="fas fa-cart-plus"></i>
                      </a>
                      <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                        <i class="fas fa-search"></i>
                      </a>
                    </form>
                  </div>
                  <div class="card-body">
                    <h5 class="card-title custom__name-product">
    ${apiProduct.name}
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
            </div>`
                                }
                            })
                            var renderList = listProducts.join('');
                            listItems.innerHTML = renderList;
                        }
                        initRender();

                        function render() {
                            var listProducts = apiProducts.map(function (apiProduct) {
                                if (apiProduct.page == page) {
                                    return `<div class="col-lg-4 col-md-6 col-12 mb-20" style="margin-bottom: 20px">
              <a href="./ProductDetail.html" class="product__new-item">
                <div class="card" style="width: 100%">
                  <div>
                    <img class="card-img-top" src="${apiProduct.img}" alt="Card image cap">
                    <form action="" class="hover-icon hidden-sm hidden-xs hidden-sm hidden-xs">
                      <input type="hidden">
                      <a href="" class="btn-add-to-cart" title="Mua ngay">
                        <i class="fas fa-cart-plus"></i>
                      </a>
                      <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                        <i class="fas fa-search"></i>
                      </a>
                    </form>
                  </div>
                  <div class="card-body">
                    <h5 class="card-title custom__name-product">
    ${apiProduct.name}
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
            </div>`
                                }
                            })
                            var renderList = listProducts.join('');
                            $('#products').append(listProducts);
                        }
                        var btnLoadMore = document.querySelector('.loadmore-btn');
                        $(btnLoadMore).click(function () {
                            page++;
                            render();
                            if (page > 3)
                            {
                                $(btnLoadMore).fadeOut();
                            }

                        })

// logic này random điên khùng chưa đúng



                        function getSapXep(idSort) {
                            var listProducts = apiProducts.map(function (apiProduct) {
                                if (apiProduct.idsort == idSort) {
                                    return `<div class="col-lg-4 col-md-6 col-12 mb-20" style="margin-bottom: 20px">
              <a href="./ProductDetail.html" class="product__new-item">
                <div class="card" style="width: 100%">
                  <div>
                    <img class="card-img-top" src="${apiProduct.img}" alt="Card image cap">
                    <form action="" class="hover-icon hidden-sm hidden-xs hidden-sm hidden-xs">
                      <input type="hidden">
                      <a href="" class="btn-add-to-cart" title="Mua ngay">
                        <i class="fas fa-cart-plus"></i>
                      </a>
                      <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                        <i class="fas fa-search"></i>
                      </a>
                    </form>
                  </div>
                  <div class="card-body">
                    <h5 class="card-title custom__name-product">
    ${apiProduct.name}
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
            </div>`
                                }
                            })
                            var renderList = listProducts.join('');
                            listItems.innerHTML = renderList;
                        }
                        $('.dropdown-item').click(function () {
                            var dataSort = $(this).attr('value');
                            var idSort = $(this).attr('id');
                            console.log(idSort)
                            getSapXep(idSort);
                        })

                        function getKhoangGia(idkg) {
                            var listProducts = apiProducts.map(function (apiProduct) {
                                if (apiProduct.idkg == idkg) {
                                    return `<div class="col-lg-4 col-md-6 col-12 mb-20" style="margin-bottom: 20px">
              <a href="./ProductDetail.html" class="product__new-item">
                <div class="card" style="width: 100%">
                  <div>
                    <img class="card-img-top" src="${apiProduct.img}" alt="Card image cap">
                    <form action="" class="hover-icon hidden-sm hidden-xs hidden-sm hidden-xs">
                      <input type="hidden">
                      <a href="" class="btn-add-to-cart" title="Mua ngay">
                        <i class="fas fa-cart-plus"></i>
                      </a>
                      <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                        <i class="fas fa-search"></i>
                      </a>
                    </form>
                  </div>
                  <div class="card-body">
                    <h5 class="card-title custom__name-product">
    ${apiProduct.name}
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
            </div>`
                                }
                            })
                            var renderList = listProducts.join('');
                            listItems.innerHTML = renderList;
                        }
                        //  // lấy dữ liệu của khoảng giá
                        $('.checkGia').click(function () {
                            var idkg = $(this).attr('id');
                            getKhoangGia(idkg);
                        })
                        function getThuongHieu(idth) {
                            var listProducts = apiProducts.map(function (apiProduct) {
                                if (apiProduct.idth == idth) {
                                    return `<div class="col-lg-4 col-md-6 col-12 mb-20" style="margin-bottom: 20px">
              <a href="./ProductDetail.html" class="product__new-item">
                <div class="card" style="width: 100%">
                  <div>
                    <img class="card-img-top" src="${apiProduct.img}" alt="Card image cap">
                    <form action="" class="hover-icon hidden-sm hidden-xs hidden-sm hidden-xs">
                      <input type="hidden">
                      <a href="" class="btn-add-to-cart" title="Mua ngay">
                        <i class="fas fa-cart-plus"></i>
                      </a>
                      <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                        <i class="fas fa-search"></i>
                      </a>
                    </form>
                  </div>
                  <div class="card-body">
                    <h5 class="card-title custom__name-product">
    ${apiProduct.name}
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
            </div>`
                                }
                            })
                            var renderList = listProducts.join('');
                            listItems.innerHTML = renderList;
                        }
                        $('.checkthuonghieu').click(function () {
                            var idth = $(this).attr('id');
                            getThuongHieu(idth);
                        })
                        function getSize(idsize) {
                            var listProducts = apiProducts.map(function (apiProduct) {
                                if (apiProduct.idsize == idsize) {
                                    return `<div class="col-lg-4 col-md-6 col-12 mb-20" style="margin-bottom: 20px">
              <a href="./ProductDetail.html" class="product__new-item">
                <div class="card" style="width: 100%">
                  <div>
                    <img class="card-img-top" src="${apiProduct.img}" alt="Card image cap">
                    <form action="" class="hover-icon hidden-sm hidden-xs hidden-sm hidden-xs">
                      <input type="hidden">
                      <a href="" class="btn-add-to-cart" title="Mua ngay">
                        <i class="fas fa-cart-plus"></i>
                      </a>
                      <a data-toggle="modal" data-target="#myModal" class="quickview" title="Xem nhanh">
                        <i class="fas fa-search"></i>
                      </a>
                    </form>
                  </div>
                  <div class="card-body">
                    <h5 class="card-title custom__name-product">
    ${apiProduct.name}
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
            </div>`
                                }
                            })
                            var renderList = listProducts.join('');
                            listItems.innerHTML = renderList;
                        }
                        $('.checksize').click(function () {
                            var idsize = $(this).attr('id');
                            getSize(idsize);
                        })
</script>
</html>
