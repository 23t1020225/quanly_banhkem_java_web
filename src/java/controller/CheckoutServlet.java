package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Cart;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login");
            return;
        }
        
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (account != null && cart != null && !cart.getItems().isEmpty()) {
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            
            // In a real app we'd save address and phone in Orders table too, but for now we follow the existing DAO layout.
            DAO dao = new DAO();
            boolean isSuccess = dao.addOrder(account, cart);
            
            response.setContentType("text/html;charset=UTF-8");
            if (isSuccess) {
                // Xóa giỏ hàng sau khi thanh toán thành công
                session.removeAttribute("cart");
                response.getWriter().println("<script>alert('Đặt hàng thành công!'); window.location.href='index';</script>");
            } else {
                response.getWriter().println("<script>alert('Lỗi đặt hàng! Chi tiết: " + dao.lastError.replace("'", "\\'") + "'); window.history.back();</script>");
            }
        } else {
            response.sendRedirect("index");
        }
    }
}
