<%-- 
    Document   : intro
    Created on : Mar 10, 2025, 8:45:52 AM
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
            <div class="content" style="margin-top: 30px">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <div class="page-title">
                                <h1 class="title-head">
                                    Giới thiệu
                                </h1>
                            </div>
                            <div class="content-page">
                                <h2>
                                    <strong>I/ Tầm nhìn</strong>
                                </h2>
                                <p>
                                    Tại FUDN SHOP, chúng tôi luôn hướng đến việc cải tiến chất lượng
                                    trải nghiệm của khách hàng thông qua việc đa dạng hóa các loại sản phẩm,
                                    đầu tư nghiên cứu để đưa ra những tư vấn phù hợp với từng khách hàng một.
                                    Và với định hướng trở thành một trong những cửa hàng cung cấp các sản
                                    phẩm giày đá bóng chính hãng tốt nhất Việt Nam,
                                    FUDN SHOP luôn hướng đến những giá trị cốt lõi cho khách hàng bao gồm:
                                </p>
                                <h3>
                                    <strong>1. Trải nghiệm hoàn hảo</strong>
                                </h3>
                                <P>
                                    Thông qua việc tư vấn, hỗ trợ khách hàng tận tâm và nhanh nhất có thể. 
                                </P>
                                <h3>
                                    <strong>2. Sản phẩm chính hãng</strong>
                                </h3>
                                <P>
                                    Sản phẩm được FUDN SHOP mua trực tiếp từ công ty và các trang web
                                    uy tín của Nike, adidas,
                                    Puma v.v… nên các bạn có thể yên tâm về nguồn gốc sản phẩm. 
                                </P>
                                <h3>
                                    <strong>3. Chế độ dịch vụ</strong>
                                </h3>
                                <P>
                                    Những sản phẩm giày đá banh tại FUDN SHOP được bảo hành 3 tháng,
                                    hỗ trợ trả góp 0% lãi suất qua Fundiin, Freeship toàn quốc
                                    khi khách hàng thanh toán chuyển khoản trước, tặng vớ & balo khi mua giày.
                                </P>
                                <h2>
                                    <strong>II/ Sứ mệnh</strong>
                                </h2>
                                <p>
                                    Đặt khách hàng làm trung tâm. Đáp ứng hiệu quả nhất mọi nhu cầu vì lợi ích khách hàng và chất lượng dịch vụ
                                    Đặt nhân sự là yếu tố quyết định và là nền tảng của sự phát triển. Không ngừng đào tạo và xây dựng đội ngũ kế thừa.
                                    Chia sẽ các quyền lợi với các thành viên trong công ty, cùng xây dựng và phát triển vì mục tiêu chung của công ty.
                                </p>
                                <h2>
                                    <strong>III/ Cửa hàng của FUDN SHOP</strong>
                                </h2>
                                <p>
                                    <b>FUDN</b>
                                    Hoạt động từ 9h tới 21h hàng ngày và cả 7 ngày trong tuần. Rất vui được đón tiếp các bạn.

                                    <br>
                                    Xin cảm ơn các bạn đã tin tưởng và ủng hộ FUDN SHOP.
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
