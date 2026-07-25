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

// Đổi tên thành orderManagement để user gọi link ngắn gọn
@WebServlet(name = "OrderManagementServlet", urlPatterns = {"/orderManagement"})
public class OrderManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null || acc.getRole() != 1) {
            response.sendRedirect("login.jsp");
            return;
        }

        DAO dao = new DAO();

        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            String orderIdStr = request.getParameter("orderId");
            String newStatus = request.getParameter("status");
            if (orderIdStr != null && newStatus != null) {
                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    if ("Done".equals(newStatus) || "Cancel".equals(newStatus)) {
                        dao.updateOrderStatus(orderId, newStatus);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            // Trả về đúng link orderManagement
            response.sendRedirect("orderManagement");
            return;
        }

        request.setAttribute("totalOrders", dao.countAllOrders());
        request.setAttribute("pendingOrders", dao.countOrdersByStatus("Pending"));
        request.setAttribute("doneOrders", dao.countOrdersByStatus("Done"));
        request.setAttribute("cancelOrders", dao.countOrdersByStatus("Cancel"));
        request.setAttribute("totalRevenue", dao.getTotalRevenue());

        String filterStatus = request.getParameter("filter");
        List<Order> orders;
        if (filterStatus != null && !filterStatus.isEmpty() && !"all".equals(filterStatus)) {
            orders = dao.getAllOrders();
            orders.removeIf(o -> !o.getStatus().equals(filterStatus));
            request.setAttribute("currentFilter", filterStatus);
        } else {
            orders = dao.getAllOrders();
            request.setAttribute("currentFilter", "all");
        }
        
        request.setAttribute("orderList", orders);
        request.getRequestDispatcher("admin/orderManagement.jsp").forward(request, response);
    }
}
