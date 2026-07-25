package controller;

import dal.DAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Order;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/orderHistory"})
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        // Nếu chưa đăng nhập thì đá về trang login
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if ("cancel".equals(action)) {
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr != null) {
                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    DAO daoCancel = new DAO();
                    daoCancel.cancelOrder(orderId, acc.getUsername());
                } catch (Exception e) {}
            }
            // Tránh resubmit khi F5
            response.sendRedirect("orderHistory");
            return;
        }

        DAO dao = new DAO();
        List<Order> orders = dao.getOrdersByUsername(acc.getUsername());
        request.setAttribute("orderList", orders);
        request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
    }
}
