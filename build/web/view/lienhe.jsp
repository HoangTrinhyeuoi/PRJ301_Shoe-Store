<%-- 
    Document   : lienhe
    Created on : Mar 10, 2025, 9:23:15 AM
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
        <link rel='stylesheet'
              href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <!-- link css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
        <link rel="stylesheet" href="/Shoes_Store/css/base.css">
        <link rel="stylesheet" href="/Shoes_Store/css/main.css">
        <link rel="stylesheet" href="/Shoes_Store/css/login.css">
        <link rel="stylesheet" href="/Shoes_Store/css/reponsive1.css">
        <link rel="icon" href="/Shoes_Store/img/logo/main.png" type="image/x-icon" />
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

        .title-heading {
            margin: 0;
            color: #36424b;
            font-size: 18px;
            font-weight: 500;
            padding: 0;
            margin-top: 0;
            margin-bottom: 10px;
            position: relative;
            text-transform: uppercase;
        }

        .contact-info {
            padding: 0;
        }

        .contact-info li {
            display: table;
            margin-bottom: 7px;
            font-size: 14px;
        }

        .text-contact {
            font-style: italic;
            color: #707e89;
        }
        .mapbox {
            border-top: 1px solid #e8e9f1;
            margin-top: 30px;
            height: 350px;
            overflow: hidden;
            border: 10px solid #e5e5e5;
            border-radius: 3px;
        }
        /* Mobile & tablet  */
        @media (max-width: 1023px) {
        }

        /* tablet */
        @media (min-width: 740px) and (max-width: 1023px) {

            textarea {
                width: 100%;
            }

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
    <div class="container">
        <!-- slide show -->
        <div class="row">
            <section class="awe-section-1">
                <div class="mt-4 top-sliders col-md-12">
                    <div class="slideshow">
                        <div id="demo" class="carousel slide" data-ride="carousel">
                            <ul class="carousel-indicators">
                                <li data-target="#demo" data-slide-to="0" class="active"></li>
                                <li data-target="#demo" data-slide-to="1"></li>
                                <li data-target="#demo" data-slide-to="2"></li>
                            </ul>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="/Shoes_Store/img/slideshow/1.jpg" alt="Los Angeles" width="1100" height="500">
                                    <div class="carousel-caption">
                                        <a href="" class="click-slideshow">Xem chi tiết</a>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img src="/Shoes_Store/img/slideshow/2.jpg" alt="Chicago" width="1100" height="500">
                                    <div class="carousel-caption">
                                        <a href="" class="click-slideshow">Xem chi tiết</a>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img src="/Shoes_Store/img/slideshow/3.jpg" alt="New York" width="1100" height="500">
                                    <div class="carousel-caption">
                                        <a href="" class="click-slideshow">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                            <a class="carousel-control-prev" href="#demo" data-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </a>
                            <a class="carousel-control-next" href="#demo" data-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </a>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <!-- end slide show -->
    </div>
    <!-- content -->
    <div class="content" style="margin-top: 30px">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="info-shop">
                        <h3 class="title-heading">Thông tin liên hệ</h3>
                        <ul class="contact-info">
                            <li>P&T SHOP xin hân hạnh phục vụ quý khách với những bộ quần áo phục kiện rất nhiều khách
                                hàng
                                tại Việt Nam ưa thích và chọn lựa.</li>
                            <li class="footer__item">
                                <p><i class="fas fa-search-location footer__item-icon"></i> Ho Chi Minh, Viet Nam</p>
                            </li>
                            <li class="footer__item">
                                <p><i class="fas fa-phone-square-alt footer__item-icon"></i> Phone: <a
                                        href="tel:0123456789">0123456789</a></p>
                            </li>
                            <li class="footer__item">
                                <p><i class="fas fa-envelope-square footer__item-icon"></i> Email: <a
                                        href="mailto:abc@gmail.com">abc@gmail.com</a></p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="page-login">
                        <h3 class="title-heading">Gửi thông tin</h3>
                        <span class="text-contact">Bạn hãy điền nội dung tin nhắn vào form dưới đây
                            và gửi cho chúng tôi. Chúng tôi sẽ trả lời bạn sau khi nhận được.
                        </span>
                        <form action="" method="POST" class="form" id="form-1">
                            <div class="form-group">
                                <label for="fullname" class="form-label">Tên đầy đủ</label>
                                <input id="fullname" name="fullname" type="text" placeholder="VD: Sơn Đặng"
                                       class="form-control">
                                <span class="form-message"></span>
                            </div>
                            <div class="form-group">
                                <label for="email" class="form-label">Email</label>
                                <input id="email" name="email" type="text" placeholder="VD: email@domain.com"
                                       class="form-control">
                                <span class="form-message"></span>
                            </div>
                            <div class="form-group">
                                <label for="phone" class="form-label">Điện thoại</label>
                                <input id="phone" pattern="[0-9]{10}" name="phone" type="tel" placeholder="0912*******"
                                       class="form-control">
                                <span class="form-message"></span>
                            </div>
                            <label for="phone" class="form-label">Nội dung</label>
                            <div class="form-group">
                                <textarea name="noidung" id="noidung" cols="70" rows="10"></textarea>
                                <span class="form-message"></span>
                            </div>

                            <button class="form-submit btn-blocker">Gửi tin nhắn<i class="fas fa-arrow-right"
                                                                                   style="font-size: 16px;margin-left: 10px;"></i></button>
                        </form>
                    </div>
                </div>
                <div class="col-12">
                    <h3 style="text-align: center; margin-top:30px;border-top:1px solid #333;padding-top:10px">Bản đồ cửa hàng</h3>
                    <div class="mapbox">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.043789433826!2d106.70723641474923!3d10.807958192300143!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317528bd0e0d9399%3A0xf97b95c646431c71!2zODYgxJBpbmggQuG7mSBMxKluaCwgUGjGsOG7nW5nIDI2LCBCw6xuaCBUaOG6oW5oLCBUaMOgbmggcGjhu5EgSOG7kyBDaMOtIE1pbmgsIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1634136123250!5m2!1svi!2s" width="100%" height="450"  allowfullscreen="" loading="lazy"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- footer -->
    <jsp:include page="common/footer.jsp"></jsp:include>
    <!-- end footer -->
</body>
<script src="/Shoes_Store/js/validator.js"></script>
<script src="/Shoes_Store/js/main.js"></script>
<script>
                                            Validator({
                                                form: '#form-1',
                                                formGroupSelector: '.form-group',
                                                errorSelector: '.form-message',
                                                rules: [
                                                    Validator.isRequired('#fullname', 'Vui lòng nhập tên đầy đủ'),
                                                    Validator.isRequired('#email'),
                                                    Validator.isEmail('#email'),
                                                    Validator.minLength('#password', 6),
                                                    Validator.isRequired('#password_confirmation'),
                                                    Validator.isRequired('input[name="gender"]'),
                                                    Validator.isConfirmed('#password_confirmation', function () {
                                                        return document.querySelector('#form-1 #password').value;
                                                    }, 'Mật khẩu nhập lại không chính xác'),
                                                    Validator.isRequired('#noidung')
                                                ],
                                                onSubmit: function (data) {
                                                    // call api
                                                    console.log(data);
                                                }
                                            });
</script>

</html>
