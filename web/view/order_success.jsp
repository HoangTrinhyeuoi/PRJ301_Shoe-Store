<%-- 
    Document   : order_success
    Created on : Mar 10, 2025, 9:33:03 AM
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
        <link rel="icon" href="/Shoes_Store/img/logo/icon.png" type="image/x-icon"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous"></script>
    </head>
    <body>
        <!-- header -->
        <jsp:include page="common/header.jsp"></jsp:include>
            <!-- end header -->
            <!-- content -->
            <div class="container">
                <div class="content" style="height: 100px;box-shadow: 0 1px 6px 0 rgb(32 33 36 / 28%);margin-top: 200px;margin-bottom:200px;text-align:center">
                    <h1 style="margin-left: 20px;">Đặt hàng thành công !</h1>
                    <a style="margin-left: 20px;font-size: 16px;" href="index.html">Tiếp tục mua hàng</a>
                </div>
            </div>
            <!-- end content -->
            <!-- footer -->
        <jsp:include page="common/footer.jsp"></jsp:include>
        <!-- end footer -->
    </body>
</html>