/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.DBconnection;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.OutputStream;
import java.util.Scanner;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.net.HttpURLConnection;
import java.net.URL;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;

import com.google.gson.JsonParser;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonSyntaxException;
import jakarta.servlet.ServletConfig;

import java.io.*;
import java.net.*;
import java.sql.*;


public class ChatBotServlet extends HttpServlet {
    private String GEMINI_API_KEY;

    @Override
    public void init() throws ServletException {
        ServletConfig config = getServletConfig();
        GEMINI_API_KEY = config.getServletContext().getInitParameter("GEMINI_API_KEY");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ✅ Cấu hình CORS để hỗ trợ frontend
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        BufferedReader reader = request.getReader();
        StringBuilder requestBody = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            requestBody.append(line);
        }

        System.out.println("📩 JSON Request từ client: " + requestBody);

        try {
            Gson gson = new Gson();
            JsonObject jsonRequest = gson.fromJson(requestBody.toString(), JsonObject.class);

            if (jsonRequest == null || !jsonRequest.has("message")) {
                throw new JsonSyntaxException("JSON không chứa key 'message'");
            }

            String userMessage = jsonRequest.get("message").getAsString();

            // 🔍 Tìm kiếm trong database
            String productInfo = getProductInfo(userMessage);

            // 🧠 Nếu không tìm thấy sản phẩm trong database, gọi AI
            boolean isFromAI = (productInfo == null);  // ✅ Kiểm tra null đúng cách
            String aiResponse = isFromAI ? getGeminiResponse(userMessage) : productInfo;

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("reply", aiResponse);
            jsonResponse.addProperty("source", isFromAI ? "AI" : "Database");

            System.out.println("📩 JSON Response gửi về client: " + jsonResponse);

            out.print(jsonResponse.toString());

        } catch (JsonSyntaxException e) {
            System.err.println("🚨 Lỗi JSON: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu JSON không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý yêu cầu");
        } finally {
            out.flush();
            out.close();
        }
    }

    /**
     * 🔍 Tìm kiếm thông tin sản phẩm trong database
     */
    
    private String getProductInfo(String userInput) {
        // Tách tên sản phẩm từ câu hỏi của người dùng
        String productName = extractProductName(userInput);
        if (productName.isEmpty()) {
            return "❌ Không xác định được sản phẩm trong câu hỏi.";
        }

        String query = "SELECT * FROM products WHERE Product_name LIKE ?";
        System.out.println("Executing Query: " + query.replace("?", "'%" + productName + "%'")); // Debug SQL

        StringBuilder result = new StringBuilder();
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, "%" + productName + "%");  
            ResultSet rs = stmt.executeQuery();

            boolean found = false;
            while (rs.next()) {
                found = true;
                String product = rs.getString("Product_name");
                double price = rs.getDouble("Price");
                int stock = rs.getInt("Stock_quantity");
                String stockStatus = stock > 0 ? "✅ **Còn hàng**" : "❌ **Hết hàng**";

                result.append("🔹 **Sản phẩm**: ").append(product).append("\n")
                      .append("💰 **Giá**: ").append(price).append(" USD\n")
                      .append(stockStatus).append("\n\n");
            }

            if (!found) {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "❌ Lỗi khi truy vấn cơ sở dữ liệu.";
        }
        return result.toString().trim();
    }

    // ✅ Hàm tách tên sản phẩm từ câu hỏi của người dùng
    private String extractProductName(String userInput) {
        // Danh sách từ khóa không liên quan cần loại bỏ
        String[] ignoreWords = {"còn hàng", "giá bao nhiêu", "có không", "hết hàng", "bao nhiêu tiền", "không", "chưa" ,"?", "!"};

        String result = userInput.toLowerCase();
        for (String word : ignoreWords) {
            result = result.replace(word, "").trim();
        }

        return result;
    }

    /**
     * 🤖 Gửi câu hỏi đến API Gemini
     */
    public String getGeminiResponse(String userMessage) throws IOException {
        if (GEMINI_API_KEY == null || GEMINI_API_KEY.isEmpty()) {
            return "❌ Lỗi: API Key không hợp lệ.";
        }

        URI uri = URI.create("https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro-002:generateContent?key=" + GEMINI_API_KEY);
        URL url = uri.toURL();
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);

        String jsonInputString = "{ \"contents\": [{ \"parts\": [{ \"text\": \"" + userMessage + "\" }] }] }";

        System.out.println("📤 JSON Request gửi đến Gemini: " + jsonInputString);

        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        int responseCode = connection.getResponseCode();
        BufferedReader in = (responseCode == HttpURLConnection.HTTP_OK)
                ? new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))
                : new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"));

        StringBuilder response = new StringBuilder();
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        System.out.println("📩 API Response từ Gemini: " + response.toString());

        Gson gson = new Gson();
        JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);

        if (jsonResponse.has("candidates")) {
            JsonArray candidates = jsonResponse.getAsJsonArray("candidates");
            if (candidates.size() > 0) {  // ✅ Sửa lỗi ở đây
                JsonObject firstCandidate = candidates.get(0).getAsJsonObject();
                if (firstCandidate.has("content")) {
                    JsonObject content = firstCandidate.getAsJsonObject("content");
                    if (content.has("parts")) {
                        JsonArray parts = content.getAsJsonArray("parts");
                        if (parts.size() > 0) {
                            return parts.get(0).getAsJsonObject().get("text").getAsString().trim();
                        }
                    }
                }
            }
        }

        return "❌ Lỗi: Không có phản hồi từ AI.";
    }
}
