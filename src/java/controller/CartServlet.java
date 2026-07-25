package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Cart;
import model.Item;
import model.Product;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }

        if (action != null) {
            String idRaw = request.getParameter("id");
            if (idRaw != null) {
                try {
                    int id = Integer.parseInt(idRaw);
                    DAO dao = new DAO();
                    Product p = dao.getProductByID(id);

                    if (action.equals("add")) {
                        if (p != null) {
                            Item item = new Item(p, 1);
                            cart.addItem(item);
                        }
                    } else if (action.equals("remove")) {
                        cart.removeItem(id);
                    } else if (action.equals("increase")) {
                        if (p != null) {
                            Item item = new Item(p, 1);
                            cart.addItem(item);
                        }
                    } else if (action.equals("decrease")) {
                        Item item = cart.getItemById(id);
                        if (item != null) {
                            if (item.getQuantity() > 1) {
                                item.setQuantity(item.getQuantity() - 1);
                            } else {
                                cart.removeItem(id);
                            }
                        }
                    }
                } catch (NumberFormatException e) {
                }
            }
        }
        
        session.setAttribute("cart", cart);
        
        // Neu action = add tu index thi redirect ve trang chu
        if (action != null && action.equals("add") && request.getHeader("referer") != null && request.getHeader("referer").contains("index")) {
            response.sendRedirect("index");
        } else {
            // Lấy danh sách danh mục từ Database (SQL) để truyền sang giao diện (dropdown menu)
            DAO daoCat = new DAO();
            request.setAttribute("listCategories", daoCat.getAllCategories());
            
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
