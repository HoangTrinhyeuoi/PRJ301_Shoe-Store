/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;


import Model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import DAO.DBconnection;
import Model.UserGoogleDto;

public class CustomerDAO {
   
        // Phương thức đăng nhập
        public Customer login(String email, String password) {
        String sql = "SELECT * FROM Customers WHERE Email = ? AND Password = ?";

        try {
            Connection connection = DBconnection.getConnection();

            // Kiểm tra nếu connection bị null
            if (connection == null) {
                System.out.println("❌ Kết nối database thất bại!");
                return null;
            }

            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                System.out.println("🔍 Đang thực hiện truy vấn với Email: " + email);
                stmt.setString(1, email);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    System.out.println("✅ Đăng nhập thành công: " + rs.getString("User_name"));
                    return new Customer(
                        rs.getInt("Customer_ID"),
                        rs.getString("User_name"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getString("Full_name"),
                        rs.getString("Address"),
                        rs.getString("Phone_number")
                    );
                } else {
                    System.out.println("❌ Không tìm thấy user nào khớp!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
        }
        
<<<<<<< HEAD
      public Customer getCustomerByEmail(String email) {
    String sql = "SELECT * FROM Customers WHERE Email = ?";
    try (Connection conn = DBconnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            Customer customer = new Customer();
            customer.setCustomerId(rs.getInt("Customer_ID"));
            customer.setUserName(rs.getString("User_name"));
            customer.setFullName(rs.getString("Full_name"));
            customer.setEmail(rs.getString("Email"));
            customer.setAddress(rs.getString("Address"));
            customer.setPhoneNumber(rs.getString("Phone_number"));
            return customer;
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi lấy thông tin khách hàng theo email: " + e.getMessage());
        e.printStackTrace();
    }
    return null;
}
    // Phương thức để lưu thông tin người dùng vào database
=======
        // Phương thức để lưu thông tin người dùng vào database
>>>>>>> d8588f6ade129e270110de5d78b08c013d418d41
    public void saveUser(UserGoogleDto user) {
        String query = "INSERT INTO Customers (User_name, Password, Email, Full_name, Address, Phone_number) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            System.out.println("Đang thực hiện INSERT cho user: " + user.getEmail());
            
            // User_name: Sử dụng email làm tên người dùng
            pstmt.setString(1, user.getName());
            // Password: Để trống hoặc tạo mật khẩu mặc định
            pstmt.setString(2, ""); // Hoặc tạo mật khẩu ngẫu nhiên
            // Email: Lấy từ Google
            pstmt.setString(3, user.getEmail());
            // Full_name: Lấy từ Google
            pstmt.setString(4, user.getName());
            // Address: Để trống
            pstmt.setString(5, "");
            // Phone_number: Để trống
            pstmt.setString(6, "");
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức kiểm tra xem người dùng đã tồn tại trong database chưa
    public boolean isUserExists(String email) {
        String query = "SELECT COUNT(*) FROM Customers WHERE Email = ?";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Kiểm tra user " + email + " - Tồn tại: " + (count > 0));
                return count > 0;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi kiểm tra user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
<<<<<<< HEAD
    
    public void updateCustomer(Customer customer) {
        String sql = "UPDATE Customers SET Full_name = ?, Address = ?, Phone_number = ? WHERE Email = ?";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getPhoneNumber());
            stmt.setString(4, customer.getEmail());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("✅ Cập nhật thông tin người dùng thành công: " + customer.getEmail());
            } else {
                System.out.println("❌ Không có dữ liệu nào được cập nhật!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean checkPassword(String email, String password) {
        String sql = "SELECT password FROM Customers WHERE email = ?";
        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return storedPassword.equals(password); // Bạn có thể mã hóa mật khẩu nếu cần
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE Customers SET password = ? WHERE email = ?";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword); // Nếu dùng mã hóa, hãy băm mật khẩu trước khi lưu
            stmt.setString(2, email);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    

=======
>>>>>>> d8588f6ade129e270110de5d78b08c013d418d41
}
