package controller;

import dal.DAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Account;
import model.Category;
import model.Product;

@WebServlet(name = "ProductManagementServlet", urlPatterns = {"/productManagement"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ProductManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null || acc.getRole() != 1) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        DAO dao = new DAO();
        
        if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    if (dao.deleteProduct(id)) {
                        session.setAttribute("msgSuccess", "Đã xóa bánh thành công!");
                    } else {
                        session.setAttribute("msgError", "Không thể xóa bánh (có thể bánh này đã được mua).");
                    }
                } catch (Exception e) {
                    session.setAttribute("msgError", "Lỗi ID không hợp lệ.");
                }
            }
            response.sendRedirect("productManagement");
            return;
        }
        
        List<Product> products = dao.getAllProducts();
        List<Category> categories = dao.getAllCategories();
        
        request.setAttribute("productList", products);
        request.setAttribute("categoryList", categories);
        
        request.getRequestDispatcher("admin/productManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null || acc.getRole() != 1) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String desc = request.getParameter("description");
        String categoryIdStr = request.getParameter("categoryId");

        try {
            double price = Double.parseDouble(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Xử lý upload ảnh
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
            
            if (fileName != null && !fileName.isEmpty()) {
                // Đường dẫn lưu file tĩnh trong thư mục web/image của project
                String uploadPath = getServletContext().getRealPath("") + File.separator + "image";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                
                String savePath = uploadPath + File.separator + fileName;
                
                // Copy file stream vào đường dẫn
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, Paths.get(savePath), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                }
            } else {
                // Nếu không upload, có thể dùng ảnh mặc định
                fileName = "default-cake.jpg";
            }

            DAO dao = new DAO();
            dao.insertProduct(name, price, fileName, desc, categoryId);
            
            // Set thông báo thành công
            session.setAttribute("msgSuccess", "Đã thêm bánh mới thành công!");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Có lỗi xảy ra khi thêm bánh mới.");
        }
        
        response.sendRedirect("productManagement");
    }
}
