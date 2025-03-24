<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán Đơn Hàng</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background-color: #f4f4f4; }
        .total { font-weight: bold; }
        button { padding: 10px 15px; background-color: #28a745; color: white; border: none; cursor: pointer; margin-top: 20px; }
        button:hover { background-color: #218838; }
    </style>
</head>
<body>
    <h2>Danh Sách Sản Phẩm Thanh Toán</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên Sản Phẩm</th>
                <th>Thương Hiệu</th>
                <th>Giá</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Nike Air Force 1</td>
                <td>Nike</td>
                <td>2,990,000 VND</td>
            </tr>
            <tr>
                <td>2</td>
                <td>Adidas Ultraboost</td>
                <td>Adidas</td>
                <td>3,550,000 VND</td>
            </tr>
            <tr>
                <td>3</td>
                <td>Puma RS-X</td>
                <td>Puma</td>
                <td>2,100,000 VND</td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="3" class="total">Tổng Tiền:</td>
                <td class="total">8,640,000 VND</td>
            </tr>
        </tfoot>
    </table>

    <form action="VnpayServlet" method="post">
        <input type="hidden" name="totalBill" value="8640000">
        <button type="submit">Thanh Toán VNPay</button>
    </form>

    <%-- Hiển thị mã QR nếu có --%>
    <c:if test="${not empty qrCode}">
        <h3>Quét mã QR để thanh toán</h3>
        <img src="data:image/png;base64,${qrCode}" alt="QR Code Thanh Toán">
    </c:if>
</body>
</html>
