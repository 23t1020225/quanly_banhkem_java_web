package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/productDetail"})
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idRaw = request.getParameter("id");
        if (idRaw != null) {
            try {
                int id = Integer.parseInt(idRaw);
                DAO dao = new DAO();
                Product p = dao.getProductByID(id);
                if (p != null) {
                    request.setAttribute("product", p);
                    
                    // Fetch categories for the header menu
                    request.setAttribute("listCategories", dao.getAllCategories());
                    
                    request.getRequestDispatcher("productDetail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Ignore and redirect
            }
        }
        response.sendRedirect("index");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
