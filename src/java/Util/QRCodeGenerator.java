package Util;

import java.io.ByteArrayOutputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

/**
 * Lớp tiện ích để tạo mã QR
 * Lưu ý: Cần thêm thư viện zxing vào project
 * - com.google.zxing:core:3.5.1
 * - com.google.zxing:javase:3.5.1
 */
public class QRCodeGenerator {
    
    /**
     * Tạo mã QR dạng base64 string từ nội dung cung cấp
     * @param content Nội dung để mã hóa vào QR code
     * @param width Chiều rộng QR code
     * @param height Chiều cao QR code
     * @return Chuỗi base64 của hình ảnh QR code
     * @throws Exception Nếu có lỗi khi tạo QR code
     */
    public static String generateQRCodeBase64(String content, int width, int height) throws Exception {
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.MARGIN, 2);
        
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, width, height, hints);
        
        ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);
        byte[] pngData = pngOutputStream.toByteArray(); 
        
        return Base64.getEncoder().encodeToString(pngData);
    }
    
    /**
     * Phương thức tạo mã QR với kích thước mặc định (250x250)
     * @param content Nội dung để mã hóa vào QR code
     * @return Chuỗi base64 của hình ảnh QR code
     * @throws Exception Nếu có lỗi khi tạo QR code
     */
    public static String generateQRCodeBase64(String content) throws Exception {
        return generateQRCodeBase64(content, 250, 250);
    }
}