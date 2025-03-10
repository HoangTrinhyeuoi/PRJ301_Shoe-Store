<%-- 
    Document   : registration
    Created on : Mar 10, 2025, 9:41:10 AM
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
    .custom-btn {
      margin: unset;
    }
  }

  /* tablet */
  @media (min-width: 740px) and (max-width: 1023px) {
    .btn-blocker {
      display: block;
      width: 100%;
    }

    .show-hide {
      top: 56px;
    }

    .show-hide-two {
      top: 56px;
    }
  }

  /* mobile */
  @media (max-width: 739px) {
    .btn-blocker {
      display: block;
      width: 100%;
    }

    .show-hide {
      top: 56px;
    }

    .show-hide-two {
      top: 56px;
    }
  }
</style>

<body>
  <div class="overlay hidden"></div>
  <!-- mobile menu -->
  <jsp:include page="../common/mobile_menu.jsp"></jsp:include>
  <!-- end mobile menu -->
  <!-- header -->
  <jsp:include page="../common/header.jsp"></jsp:include>
  <!-- end header -->
  <!-- registration form -->
  <div class="container">
    <div class="registration__form">
      <div class="row">
        <div class="col-sm-12 col-lg-6">
          <form action="" method="POST" class="form" id="form-1">
            <h3 class="heading">ĐĂNG KÍ</h3>
            <div class="form-group">
              <label for="fullname" class="form-label">Tên đầy đủ</label>
              <input id="fullname" name="fullname" type="text" placeholder="VD: Quốc Trung" class="form-control">
              <span class="form-message"></span>
            </div>
            <div class="form-group">
              <label for="email" class="form-label">Email</label>
              <input id="email" name="email" type="text" placeholder="VD: email@domain.com" class="form-control">
              <span class="form-message"></span>
            </div>
            <div class="form-group matkhau">
              <label for="password" class="form-label">Mật khẩu</label>
              <input id="password" name="password" type="password" placeholder="Nhập mật khẩu" class="form-control">
              <span class="show-hide"><i class="fas fa-eye"></i></span>
              <span class="form-message"></span>
            </div>

            <div class="form-group matkhau">
              <label for="password_confirmation" class="form-label">Nhập lại mật khẩu</label>
              <input id="password_confirmation" name="password_confirmation" placeholder="Nhập lại mật khẩu"
                type="password" class="form-control">
              <span class="show-hide-two"><i class="fas fa-eye fa-eye-2"></i></span>
              <span class="form-message"></span>
            </div>
            <div class="form-group">
              <label for="gender" class="form-label">Giới tính</label>
              <div>
                <div class="form-check-inline">
                  <input type="radio" class="form-check-input" name="gender" value="male">Nam
                </div>
                <div class="form-check-inline">
                  <input type="radio" class="form-check-input" name="gender" value="female">Nữ
                </div>
                <div class="form-check-inline">
                  <input type="radio" class="form-check-input" name="gender" value="order">Khác
                </div>
              </div>
              <span class="form-message"></span>
            </div>

            <button class="form-submit btn-blocker" style="border-radius: unset;">Đăng ký <i class="fas fa-arrow-right"
                style="font-size: 16px;margin-left: 10px;"></i></button>
            <p style="font-size: 16px;margin: 10px 0;">Bạn đã có tài khoản? <a href="./login.jsp"
                style="color: black; font-weight: bold">Đăng nhập</a></p>
          </form>
        </div>
        <div class="col-sm-12 col-lg-6">
          <h3 class="heading">TẠO MỘT TÀI KHOẢN</h3>
          <p class="text-login">Đăng nhập bằng tài khoản sẽ giúp bạn truy cập:</p>
          <ul>
            <li class="text-login-item"><i class="fas fa-check"></i>
              <p class="text-login">Một lần đăng nhập chung duy nhất để tương tác với các sản phẩm và dịch vụ của P&T
                shop
              </p>
            </li>
            <li class="text-login-item"><i class="fas fa-check"></i>
              <p class="text-login">Thanh toán nhanh hơn</p>
            </li>
            <li class="text-login-item"><i class="fas fa-check"></i>
              <p class="text-login">Xem lịch sử đặt hàng riêng của bạn</p>
            </li>
            <li class="text-login-item"><i class="fas fa-check"></i>
              <p class="text-login">Thêm hoặc thay đổi tùy chọn email</p>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <!-- end registration form -->
  <!-- footer -->
  <jsp:include page="../common/footer.jsp"></jsp:include>
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
      }, 'Mật khẩu nhập lại không chính xác')
    ],
    onSubmit: function (data) {
      // call api
      console.log(data);
    }
  });
</script>
<script>
  const pass_field = document.querySelector('#password');
  const show_btn = document.querySelector('.fa-eye')
  show_btn.addEventListener("click", function () {
    if (pass_field.type === "password") {
      pass_field.type = "text";
      show_btn.classList.add("hide");
    } else {
      pass_field.type = "password";
      show_btn.classList.remove("hide");
    }
  });
</script>
<script>
  const pass_field2 = document.querySelector('#password_confirmation');
  const show_btn2 = document.querySelector('.fa-eye-2')
  show_btn2.addEventListener("click", function () {
    if (pass_field2.type === "password") {
      pass_field2.type = "text";
      show_btn2.classList.add("hide");
    } else {
      pass_field2.type = "password";
      show_btn2.classList.remove("hide");
    }
  });
</script>

</html>