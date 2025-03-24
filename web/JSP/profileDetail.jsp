<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Chi tiết hồ sơ - Sneaker Space</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }
        .profile-container {
            width: 70%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .profile-container h1 {
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .profile-field {
            margin-bottom: 15px;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .profile-field label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .btn-secondary {
            background-color: #2196F3;
        }
        .btn-neutral {
            background-color: #555;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .error-message {
            color: red;
            text-align: center;
            margin: 20px 0;
            padding: 15px;
            background-color: #ffeeee;
            border-radius: 4px;
            border: 1px solid #ffcccc;
        }
        .action-buttons {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <%
        // Kiểm tra xem người dùng đã đăng nhập chưa
        String loggedInUsername = (String) session.getAttribute("username");
        
        if (loggedInUsername == null || loggedInUsername.isEmpty()) {
            // Nếu chưa đăng nhập, hiển thị thông báo
        %>
            <div class="error-message">
                <h2>Bạn cần đăng nhập để xem thông tin này</h2>
                <a href="login.jsp" class="btn">Đăng nhập</a>
            </div>
        <%
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                // Lấy ID từ tham số URL
                int requestedId = 0;
                try {
                    requestedId = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                    // Nếu không có ID được chỉ định, lấy ID của người dùng đang đăng nhập
                    requestedId = 0;
                }
                
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String connectionUrl = "jdbc:sqlserver://localhost:1433;databaseName=ShoeStore;user=sa;password=123;encrypt=true;trustServerCertificate=true";
                conn = DriverManager.getConnection(connectionUrl);
                
                // Trước tiên, lấy ID của người dùng đang đăng nhập
                String checkUserSql = "SELECT Customer_ID FROM [ShoeStore].[dbo].[Customers] WHERE User_name = ?";
                pstmt = conn.prepareStatement(checkUserSql);
                pstmt.setString(1, loggedInUsername);
                rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    int loggedInUserId = rs.getInt("Customer_ID");
                    
                    // Nếu không có ID được chỉ định hoặc ID = 0, sử dụng ID của người dùng đang đăng nhập
                    if (requestedId == 0) {
                        requestedId = loggedInUserId;
                    }
                    
                    // Chỉ cho phép xem thông tin nếu ID yêu cầu khớp với ID của người đang đăng nhập
                    if (requestedId == loggedInUserId) {
                        rs.close();
                        pstmt.close();
                        
                        // Lấy thông tin chi tiết của người dùng
                        String sql = "SELECT Customer_ID, User_name, Full_name, Email, Address, Phone_number FROM [ShoeStore].[dbo].[Customers] WHERE Customer_ID = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, requestedId);
                        rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            String username = rs.getString("User_name");
                            String fullName = rs.getString("Full_name") != null ? rs.getString("Full_name") : "";
                            String email = rs.getString("Email") != null ? rs.getString("Email") : "";
                            String address = rs.getString("Address") != null ? rs.getString("Address") : "";
                            String phone = rs.getString("Phone_number") != null ? rs.getString("Phone_number") : "";
        %>
                            <div class="header">
                                <h1>Chi tiết hồ sơ: <%= fullName %></h1>
                                <div>
                                    <a href="index.jsp" class="btn btn-neutral">Trang chủ</a>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>ID:</label>
                                <span><%= requestedId %></span>
                            </div>
                            
                            <div class="profile-field">
                                <label>Tên đăng nhập:</label>
                                <span><%= username %></span>
                            </div>
                            
                            <div class="profile-field">
                                <label>Họ tên:</label>
                                <span><%= fullName %></span>
                            </div>
                            
                            <div class="profile-field">
                                <label>Email:</label>
                                <span><%= email %></span>
                            </div>
                            
                            <div class="profile-field">
                                <label>Địa chỉ:</label>
                                <span><%= address %></span>
                            </div>
                            
                            <div class="profile-field">
                                <label>Số điện thoại:</label>
                                <span><%= phone %></span>
                            </div>
                            
                            <div class="action-buttons">
                                <a href="editProfile.jsp?id=<%= requestedId %>" class="btn">Chỉnh sửa hồ sơ</a>
                                <a href="changePassword.jsp" class="btn btn-secondary">Đổi mật khẩu</a>
                                <a href="orderHistory.jsp" class="btn btn-neutral">Lịch sử đơn hàng</a>
                            </div>
        <%
                        } else {
        %>
                            <div class="error-message">
                                <h2>Không tìm thấy thông tin hồ sơ</h2>
                                <p>Có thể tài khoản của bạn chưa được thiết lập đầy đủ.</p>
                                <div class="action-buttons">
                                    <a href="completeProfile.jsp" class="btn">Thiết lập hồ sơ</a>
                                    <a href="index.jsp" class="btn btn-neutral">Trang chủ</a>
                                </div>
                            </div>
        <%
                        }
                    } else {
                        // Nếu cố gắng xem thông tin của người khác
        %>
                        <div class="error-message">
                            <h2>Bạn không có quyền xem thông tin này</h2>
                            <p>Bạn chỉ có thể xem thông tin cá nhân của chính mình.</p>
                            <a href="profile.jsp" class="btn">Xem hồ sơ của bạn</a>
                            <a href="index.jsp" class="btn btn-neutral" style="margin-left: 10px;">Trang chủ</a>
                        </div>
        <%
                    }
                } else {
                    // Không tìm thấy người dùng đang đăng nhập trong cơ sở dữ liệu
        %>
                    <div class="error-message">
                        <h2>Không thể xác minh thông tin người dùng</h2>
                        <p>Tên đăng nhập: <%= loggedInUsername %></p>
                        <div class="action-buttons">
                            <a href="logout.jsp" class="btn">Đăng xuất và đăng nhập lại</a>
                            <a href="index.jsp" class="btn btn-neutral">Trang chủ</a>
                        </div>
                    </div>
        <%
                }
            } catch(Exception e) {
        %>
                <div class="error-message">
                    <h2>Đã xảy ra lỗi khi tải thông tin hồ sơ</h2>
                    <p>Chi tiết lỗi: <%= e.getMessage() %></p>
                    <p>Vui lòng thử lại sau hoặc liên hệ hỗ trợ.</p>
                    <a href="index.jsp" class="btn">Trang chủ</a>
                </div>
        <%
                e.printStackTrace();
            } finally {
                if(rs != null) try { rs.close(); } catch(Exception e) {}
                if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
                if(conn != null) try { conn.close(); } catch(Exception e) {}
            }
        }
        %>
    </div>
</body>
</html>