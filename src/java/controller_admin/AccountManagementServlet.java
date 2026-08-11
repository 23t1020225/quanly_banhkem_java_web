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

@WebServlet(name = "AccountManagementServlet", urlPatterns = {"/accountManagement"})
public class AccountManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        // Bắt buộc phải là admin (role = 1)
        if (acc == null || acc.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String username = request.getParameter("username");
        
        DAO dao = new DAO();
        
        if (action != null && username != null) {
            // Không cho phép admin tự khóa chính mình
            if (!username.equals(acc.getUsername())) {
                if (action.equals("lock")) {
                    dao.updateAccountStatus(username, "Locked");
                    session.setAttribute("msgSuccess", "Đã khóa tài khoản " + username);
                } else if (action.equals("unlock")) {
                    dao.updateAccountStatus(username, "Active");
                    session.setAttribute("msgSuccess", "Đã mở khóa tài khoản " + username);
                }
            } else {
                session.setAttribute("msgError", "Bạn không thể khóa tài khoản của chính mình!");
            }
            response.sendRedirect("accountManagement");
            return;
        }

        List<Account> accounts = dao.getAllAccounts();
        request.setAttribute("accountList", accounts);
        
        request.getRequestDispatcher("/admin/accountManagement.jsp").forward(request, response);
    }
}
