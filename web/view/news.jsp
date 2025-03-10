<%-- 
    Document   : news
    Created on : Mar 10, 2025, 9:30:40 AM
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
        <link rel="stylesheet" href="/Shoes_Store/css/news.css">
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
            .owl-item {
                width: 396px;
                padding: 16px 0;
            }
        }
        /* mobile */
        @media (max-width: 739px) {
            .owl-item {
                float: unset;
                padding: 16px 0;
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
    <div class="">
        <div class="container">
            <div class="row mb-20" style="margin: 20px 0;" id="news">

            </div>
        </div>
    </div>
    <div class="loadmore">
        <a class="loadmore-btn" style="cursor: pointer;">Tải thêm</a>
    </div>
</div>
</div>

</div>

<!-- end content -->
<!-- footer -->

<jsp:include page="common/footer.jsp"></jsp:include>
<!-- end footer -->
</body>
<script src="/Shoes_Store/js/main.js"></script>
<script>
                                            var page = 1;
                                            var apiNews = [
                                                {
                                                    id: 1,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/nikedrifit1.jpg',
                                                    page: 1
                                                },
                                                {
                                                    id: 2,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/stansmithgolf1.jpg',
                                                    page: 1
                                                },
                                                {
                                                    id: 3,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/stansmithgolf2.jpg',
                                                    page: 1
                                                },
                                                {
                                                    id: 4,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/stansmithgolf3.jpg',
                                                    page: 1
                                                },
                                                {
                                                    id: 5,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/stansmithgolf4.jpg',
                                                    page: 1
                                                },
                                                {
                                                    id: 6,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/superfly1.jpg',
                                                    page: 1
                                                },
                                                {
                                                    id: 7,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/superfly2.png',
                                                    page: 1
                                                },
                                                {
                                                    id: 8,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/superfly3.png',
                                                    page: 1
                                                },
                                                {
                                                    id: 9,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/superfly4.png',
                                                    page: 2
                                                },
                                                {
                                                    id: 10,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/tuicheo1.jpg',
                                                    page: 2
                                                },
                                                {
                                                    id: 11,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/tuicheo2.jpg',
                                                    page: 2
                                                },
                                                {
                                                    id: 12,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/tuicheo3.jpg',
                                                    page: 2
                                                },
                                                {
                                                    id: 13,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/tuicheo4.jpg',
                                                    page: 2
                                                },
                                                {
                                                    id: 14,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/ambush1.jpg',
                                                    page: 2
                                                },
                                                {
                                                    id: 15,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/ambush2.png',
                                                    page: 2
                                                },
                                                {
                                                    id: 16,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/ambush3.png',
                                                    page: 2
                                                },
                                                {
                                                    id: 17,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/ambush4.png',
                                                    page: 3
                                                },
                                                {
                                                    id: 18,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/tuiprimegreen1.jpg',
                                                    page: 3
                                                },
                                                {
                                                    id: 19,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/tuiprimegreen2.jpg',
                                                    page: 3
                                                },
                                                {
                                                    id: 20,
                                                    name: 'Nike Mercurial Vapor 14 theo phong cách của Nike Jordan 1 sẽ trông như nào?',
                                                    description: 'Mới đây Footpack và Soub đã hợp tác với nhau để tạo ra một phiên bản Nike Mercurial Vapor 14 được tùy chỉnh đặc biệt',
                                                    img: '/Shoes_Store/img/product/tuiprimegreen3.jpg',
                                                    page: 3
                                                },
                                            ]
                                            var listItem = document.querySelector('#news');
                                            console.log(listItem);
                                            function initRender() {
                                                var listNews = apiNews.map(function (apiNew) {
                                                    if (apiNew.page == page) {
                                                        return `<div class="col-lg-3 col-md-6 col-sm-12 mb-20" style="margin-bottom: 20px">
                    <a href="" class="product__new-item">
                      <div class="card" style="width: 100%">
                        <img class="card-img-top" src="${apiNew.img}" alt="Card image cap">
                        <div class="card-body">
                          <h5 class="card-title custom__name-product title-news">
    ${apiNew.name}
                          </h5>
                          <p class="card-text custom__name-product" style="font-weight: 400;">${apiNew.description}</p>
                        </div>
                    </div>
                    </a>
                  </div>`
                                                    }
                                                })
                                                var renderList = listNews.join('');
                                                listItem.innerHTML = renderList;
                                            }
                                            initRender();
                                            var btnLoadMore = document.querySelector('.loadmore-btn');
                                            function render() {
                                                var listNews = apiNews.map(function (apiNew) {
                                                    if (apiNew.page == page) {
                                                        return `<div class="col-lg-3 col-md-6 col-sm-12 mb-20" style="margin-bottom: 20px">
                    <a href="" class="product__new-item">
                      <div class="card" style="width: 100%">
                        <img class="card-img-top" src="${apiNew.img}" alt="Card image cap">
                        <div class="card-body">
                          <h5 class="card-title custom__name-product title-news">
    ${apiNew.name}
                          </h5>
                          <p class="card-text custom__name-product" style="font-weight: 400;">${apiNew.description}</p>
                        </div>
                    </div>
                    </a>
                  </div>`
                                                    }
                                                })
                                                var renderList = listNews.join('');
                                                $('#news').append(listNews);
                                            }

                                            $(btnLoadMore).click(function () {
                                                page++;
                                                render();
                                                if (page > 3)
                                                {
                                                    $(btnLoadMore).fadeOut();
                                                }

                                            })
</script>
</html>
