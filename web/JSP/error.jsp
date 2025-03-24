<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi | ShoeStore</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .error-container {
            max-width: 600px;
            margin: 100px auto;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            padding: 2rem;
            text-align: center;
        }
        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }
        .error-title {
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #333;
        }
        .error-message {
            font-size: 1.1rem;
            color: #6c757d;
            margin-bottom: 2rem;
        }
        .btn-home {
            background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 2rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(106, 17, 203, 0.4);
        }
    </style>
</head>
<body>
    <!-- Include header -->
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <div class="error-container">
            <div class="error-icon">
                <i class="fas fa-exclamation-circle"></i>
            </div>
            <h1 class="error-title">Đã xảy ra lỗi</h1>
            <p class="error-message">
                <% 
                String errorMessage = (String)request.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
                    out.println(errorMessage);
                } else {
                %>
                    Rất tiếc, đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.
                    Vui lòng thử lại sau hoặc liên hệ với chúng tôi nếu vấn đề vẫn tiếp diễn.
                <% } %>
            </p>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-home">
                    <i class="fas fa-home me-2"></i>Về trang chủ
                </a>
            </div>
        </div>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>