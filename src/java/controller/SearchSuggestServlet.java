package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet(name = "SearchSuggestServlet", urlPatterns = {"/search-suggest"})
public class SearchSuggestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String keyword = request.getParameter("keyword");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            DAO dao = new DAO();
            List<Product> products = dao.searchProductsByName(keyword.trim());
            
            try (PrintWriter out = response.getWriter()) {
                if (products.isEmpty()) {
                    out.println("<div class='suggest-item'>Không tìm thấy bánh nào</div>");
                } else {
                    DecimalFormat df = new DecimalFormat("#,###");
                    for (Product p : products) {
                        out.println("<a href='#Category_" + p.getCategoryId() + "' class='suggest-item' onclick='document.getElementById(\"searchInput\").value=\"" + p.getName() + "\"; document.getElementById(\"searchSuggestions\").style.display=\"none\";'>");
                        out.println("<img src='image/" + p.getImage() + "' alt='" + p.getName() + "'/>");
                        out.println("<div class='suggest-info'>");
                        out.println("<h4>" + p.getName() + "</h4>");
                        out.println("<span>" + df.format(p.getPrice()) + "đ</span>");
                        out.println("</div>");
                        out.println("</a>");
                    }
                }
            }
        }
    }
}
