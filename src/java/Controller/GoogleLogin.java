<<<<<<< HEAD
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
=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import Model.Customer;
import Model.UserGoogleDto;
import java.io.IOException;
import java.io.PrintWriter;
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
/**
 *
 * @author ASUS
 */
public class GoogleLogin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    System.out.println("Servlet processRequest() đã được gọi!");
    String code = request.getParameter("code");
    String accessToken = getToken(code);
    UserGoogleDto user = getUserInfo(accessToken);
    System.out.println(user);
    
    // Kiểm tra và lưu thông tin người dùng vào database
    CustomerDAO userDao = new CustomerDAO();
    if (!userDao.isUserExists(user.getEmail())) {
        userDao.saveUser(user);
    }
    
    // Kiểm tra xem người dùng đã có thông tin đầy đủ chưa
    if (!userDao.hasCompleteInfo(user.getEmail())) {
        // Chuyển hướng đến trang bổ sung thông tin
        request.setAttribute("email", user.getEmail());
        request.setAttribute("name", user.getName());
        request.getRequestDispatcher("/JSP/additionalInfo.jsp").forward(request, response);
        return;
    }
    
    // Lấy thông tin đầy đủ của người dùng
    Customer customer = userDao.getCustomerByEmail(user.getEmail());
    
    // Lưu thông tin người dùng vào session
    HttpSession session = request.getSession();
    session.setAttribute("customer", customer);
    
    // Chuyển hướng đến trang index.jsp
    response.sendRedirect(request.getContextPath() + "/JSP/index.jsp");
}
    
    public static String getToken(String code) throws ClientProtocolException, IOException {
		// call api to get token
		String response;
        response = Request
                .Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

		JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
		String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
		return accessToken;
	}

	public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
		String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
		String response = Request.Get(link).execute().returnContent().asString();

		UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);

		return googlePojo;
	}
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
>>>>>>> d8588f6ade129e270110de5d78b08c013d418d41
