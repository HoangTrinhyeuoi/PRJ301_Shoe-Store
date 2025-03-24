/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import DAO.DBconnection;
import Model.Customer;
import Model.UserGoogleDto;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
/**
 *
 * @author ASUS
 */
public class GoogleLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Servlet GoogleLogin processRequest() đã được gọi!");

        String code = request.getParameter("code");
        // Kiểm tra có tham số redirect từ state không
        String redirectURL = null;
        String state = request.getParameter("state");
        if (state != null && !state.isEmpty()) {
            redirectURL = state;
        }
        
        try {
            String accessToken = getToken(code);
            UserGoogleDto user = getUserInfo(accessToken);
            System.out.println("Google user info: " + user);

            // Kiểm tra và lưu thông tin người dùng vào database
            CustomerDAO customerDAO = new CustomerDAO();
            if (!customerDAO.isUserExists(user.getEmail())) {
                customerDAO.saveUser(user);
            }

            // Lấy thông tin khách hàng từ database - quan trọng để có thông tin đầy đủ
            Customer customer = customerDAO.getCustomerByEmail(user.getEmail());
            
            if (customer == null) {
                request.setAttribute("errorMessage", "Không thể tải thông tin người dùng. Vui lòng thử lại sau.");
                request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
                return;
            }

            // Lưu thông tin vào session - đảm bảo dùng "customer" như LoginServlet
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);

            // Kiểm tra nếu thiếu thông tin thì chuyển đến updateInfo.jsp
            if (customer.getPhoneNumber() == null || customer.getPhoneNumber().isEmpty() || 
                customer.getAddress() == null || customer.getAddress().isEmpty()) {
                // Lưu URL redirect để sử dụng sau khi cập nhật thông tin
                if (redirectURL != null) {
                    session.setAttribute("redirect", redirectURL);
                }
                request.getRequestDispatcher("/JSP/updateInfo.jsp").forward(request, response);
            } else {
                // Đã có đầy đủ thông tin
                if (redirectURL != null) {
                    // Xóa thông tin redirect khỏi session để tránh sử dụng lại
                    session.removeAttribute("redirect");
                    response.sendRedirect(request.getContextPath() + "/" + redirectURL);
                } else {
                    request.getRequestDispatcher("/JSP/index.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi đăng nhập bằng Google: " + e.getMessage());
            request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
        }
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE)
                        .build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, UserGoogleDto.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Google Login Servlet";
    }
}