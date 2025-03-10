<%-- 
    Document   : newDetail
    Created on : Mar 10, 2025, 9:28:52 AM
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
        <link rel="stylesheet" href="/Shoes_Store/css/login.css">
        <link rel="stylesheet" href="/Shoes_Store/css/reponsive1.css">
        <link rel="icon" href="/Shoes_Store/img/logo/icon.png" type="image/x-icon" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
                integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
        crossorigin="anonymous"></script>
    </head>
    <style>
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
            font-size: 12px;
        }
        .mapbox {
            border-top: 1px solid #e8e9f1;
            margin-top: 30px;
            height: 350px;
            overflow: hidden;
            border: 10px solid #e5e5e5;
            border-radius: 3px;
        }
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
        .content-page p{
            font-size: 16px;
            padding: 5px 0;
            word-wrap: break-word;
            text-align: center;
        }
        .content-page p img{
            width: auto;
            height: auto;
            max-width: 100%;
            vertical-align: middle;
            height: initial !important;
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
        .time {
            font-style: italic;

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
    <div class="content" style="margin-top: 30px">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                    <div class="page-title">
                        <h1 class="title-head" style="font-size: 30px">
                            <strong> Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?</strong>
                        </h1>
                    </div>
                    <div class="content-page">
                        <span class="time" style="font-size: 18px; color: #999;"><i class="far fa-clock" style="margin-right: 10px;"></i>13/11/2021</span>
                        <p>
                            Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt, lấy cảm hứng từ một
                            trong những đôi giày yêu thích của tiền đạo người Pháp Marcus Thuram,
                            đôi Jordan 1 Travis Scott x Fragment.
                        </p>
                        <p>
                            <img src="/Shoes_Store/img/product/new4.jpg" alt="">
                        </p>
                        <P>
                            Tiền đạo của Borussia Mönchengladbach là một fan cứng của những đôi giày thể thao đặc biệt là dòng sản phẩm Nike Jordan, cũng vì lý do đó mà khi thương hiệu footpack của Pháp đề nghị sẽ "custom" cho Marcus một đôi Nike Mercurial Vapors 14, thì đôi Jordan 1 Travis Scott x Fragment,
                            đã được chọn để trở thành nguồn cảm hứng cho phiên bản "custom" này, được tạo ra bởi nghệ sĩ thiết kế Soub.
                        </P>
                        <p>
                            <img src="/Shoes_Store/img/product/new5.jpg" alt="">
                        </p>
                        <P>
                            Nike Mercurial Travis Scott có tone màu chủ đạo toàn màu trắng và phủ lên nó
                            các tấm hình khối màu xanh tương đồng với Jordan 1 Travis Scott x Fragment.
                            Dấu Swoosh lớn màu đen ở mặt ngoài với một chữ ký của Travis Scott - phía má trong là dấu Swoosh nhỏ hơn
                            kiểu setup giống với bản phối "Recharge" được Nike cho ra mắt gần đây. 
                        </P>
                        <p>
                            <img src="/Shoes_Store/img/product/new6.jpg" alt="">
                        </p>
                        <p>
                            <img src="/Shoes_Store/img/product/new7.jpg" alt="">
                        </p>
                        <p>
                            Ở trung tâm phần gót giày, dòng "Marcus Jack" được thiết kế khá "nguệch ngoạc",
                            có lẽ để tạo dấu hiệu đặc trưng cho đôi giày.
                            Đặt bên cạnh là logo của footpack ở mặt ngoài và logo Joaquim Soub ở mặt bên trong.
                        </p>
                        <p>
                            <img src="/Shoes_Store/img/product/new8.jpg" alt="">
                        </p>
                        <p>
                            Theo dõi blog của P&T SHOP để biết được những thông tin mới nhất về
                            những đôi giày bóng đá chính hãng đã và sắp có mặt trên thị trường toàn thế giới nhé.
                            Ngoài ra các bạn có thể tham khảo thêm những đôi giày bóng đá chính hãng phiên bản
                            dành cho mặt sân cỏ nhân tạo và Futsal tại <a href="">đây</a>.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- footer -->
    <jsp:include page="common/footer.jsp"></jsp:include>

    <!-- end footer -->
</body>
<script src="/Shoes_Store/js/main.js"></script>
</html>
