package Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import DAO.CategoryDAO;
import DAO.ProductDAO;
import Model.Category;
import Model.Product;
import java.io.IOException;
import java.io.File;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;

@MultipartConfig
public class ProductAdminServlet extends HttpServlet {

    ProductDAO prodao = new ProductDAO();
    CategoryDAO cateDAO = new CategoryDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        switch (action) {
            case "add" -> {
                try {
                    addProduct(request);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "edit" -> {
                try {
                    editProduct(request);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "delete" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                prodao.deleteProduct(id);
            }
        }

        // Redirect to the dashboard product page
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<Product> listProduct = prodao.getAllProducts();
        List<Category> listCategory = cateDAO.getAllCategories();

        session.setAttribute("listProduct", listProduct);
        session.setAttribute("listCategory", listCategory);

        req.getRequestDispatcher("JSP/admin/dashboard_product.jsp").forward(req, resp);
    }

    private void addProduct(HttpServletRequest request) throws SQLException {
        try {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("category"));

            Part part = request.getPart("image");
            String imagePath = null;
            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String path = request.getServletContext().getRealPath("/images");
                File dir = new File(path);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File image = new File(dir, part.getSubmittedFileName());
                part.write(image.getAbsolutePath());
                imagePath = request.getContextPath() + "/images/" + image.getName();
            } else {
                // If no file uploaded, use the image URL provided in text field
                imagePath = request.getParameter("image");
            }

            Product product = new Product();
            product.setName(name);
            product.setPrice(price);
            product.setStock(quantity);
            product.setCategoryId(categoryId);
            product.setDescription(description);
            product.setImageUrl(imagePath);

            prodao.insertProduct(product);

        } catch (NumberFormatException | IOException | ServletException ex) {
            ex.printStackTrace();
        }
    }

    private void editProduct(HttpServletRequest request) throws SQLException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("category"));

            Part part = request.getPart("image");
            String imagePath = request.getParameter("currentImage");
            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String path = request.getServletContext().getRealPath("/images");
                File dir = new File(path);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File image = new File(dir, part.getSubmittedFileName());
                part.write(image.getAbsolutePath());
                imagePath = request.getContextPath() + "/images/" + image.getName();
            }

            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setPrice(price);
            product.setStock(quantity);
            product.setCategoryId(categoryId);
            product.setDescription(description);
            product.setImageUrl(imagePath);

            prodao.updateProduct(product);

        } catch (NumberFormatException | IOException | ServletException ex) {
            ex.printStackTrace();
        }
    }
}
