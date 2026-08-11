package controller_admin;

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

@WebServlet(name = "ProductEditServlet", urlPatterns = {"/editProduct"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ProductEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null || acc.getRole() != 1) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("productManagement");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            DAO dao = new DAO();
            Product p = dao.getProductByID(id);
            if (p != null) {
                List<Category> categories = dao.getAllCategories();
                request.setAttribute("product", p);
                request.setAttribute("categoryList", categories);
                request.getRequestDispatcher("admin/productEdit.jsp").forward(request, response);
            } else {
                session.setAttribute("msgError", "Không tìm thấy bánh để sửa.");
                response.sendRedirect("productManagement");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("productManagement");
        }
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
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String desc = request.getParameter("description");
        String categoryIdStr = request.getParameter("categoryId");

        try {
            int id = Integer.parseInt(idStr);
            double price = Double.parseDouble(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Xử lý upload ảnh nếu có
            Part filePart = request.getPart("image");
            String fileName = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
                String uploadPath = getServletContext().getRealPath("") + File.separator + "image";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                
                String savePath = uploadPath + File.separator + fileName;
                
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, Paths.get(savePath), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                }
            }

            DAO dao = new DAO();
            boolean success = dao.updateProduct(id, name, price, fileName, desc, categoryId);
            
            if (success) {
                session.setAttribute("msgSuccess", "Cập nhật bánh thành công!");
            } else {
                session.setAttribute("msgError", "Có lỗi xảy ra khi cập nhật bánh.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Dữ liệu không hợp lệ.");
        }
        
        response.sendRedirect("productManagement");
    }
}
