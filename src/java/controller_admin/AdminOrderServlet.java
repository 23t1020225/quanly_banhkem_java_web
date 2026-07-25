package controller_admin;

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

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/orderManagerment"})
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Bước 1: Kiểm tra quyền Admin
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null || acc.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        DAO dao = new DAO();

        // Bước 2: Kiểm tra xem Admin có bấm nút cập nhật trạng thái không
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            String orderIdStr = request.getParameter("orderId");
            String newStatus = request.getParameter("status");
            if (orderIdStr != null && newStatus != null) {
                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    // Chỉ cho phép 2 giá trị hợp lệ
                    if ("Done".equals(newStatus) || "Cancel".equals(newStatus)) {
                        dao.updateOrderStatus(orderId, newStatus);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            // Redirect để tránh resubmit khi F5
            response.sendRedirect(request.getContextPath() + "/admin/orderManagement");
            return;
        }

        // Bước 3: Lấy dữ liệu thống kê
        request.setAttribute("totalOrders", dao.countAllOrders());
        request.setAttribute("pendingOrders", dao.countOrdersByStatus("Pending"));
        request.setAttribute("doneOrders", dao.countOrdersByStatus("Done"));
        request.setAttribute("cancelOrders", dao.countOrdersByStatus("Cancel"));
        request.setAttribute("totalRevenue", dao.getTotalRevenue());

        // Bước 4: Lấy danh sách đơn hàng
        // Hỗ trợ lọc theo trạng thái
        String filterStatus = request.getParameter("filter");
        List<Order> orders;
        if (filterStatus != null && !filterStatus.isEmpty() && !"all".equals(filterStatus)) {
            // TODO: có thể thêm hàm getOrdersByStatus nếu muốn, tạm thời lọc ở đây
            orders = dao.getAllOrders();
            orders.removeIf(o -> !o.getStatus().equals(filterStatus));
            request.setAttribute("currentFilter", filterStatus);
        } else {
            orders = dao.getAllOrders();
            request.setAttribute("currentFilter", "all");
        }
        
        request.setAttribute("orderList", orders);
        request.getRequestDispatcher("/admin/orderManagement.jsp").forward(request, response);
    }
}
