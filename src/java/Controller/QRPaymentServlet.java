package Controller;

import Util.QRCodeGenerator;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class QRPaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy nội dung thanh toán từ request (ví dụ: URL thanh toán)
            String paymentInfo = request.getParameter("paymentUrl");
            if (paymentInfo == null || paymentInfo.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin thanh toán");
                return;
            }

            // Tạo mã QR từ nội dung
            String qrCodeBase64 = QRCodeGenerator.generateQRCodeBase64(paymentInfo, 200, 200);
            
            // Gửi mã QR về JSP
            request.setAttribute("qrCode", qrCodeBase64);
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Lỗi khi tạo mã QR", e);
        }
    }
}
