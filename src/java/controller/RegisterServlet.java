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

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (fullname == null || username == null || password == null ||
            fullname.trim().isEmpty() || username.trim().isEmpty() || password.trim().isEmpty()) {
            
            request.setAttribute("error_register", "Vui lòng nhập đầy đủ thông tin!");
            request.setAttribute("activeTab", "register");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        DAO dao = new DAO();
        
        // Kiểm tra xem tài khoản đã tồn tại chưa
        if (dao.checkAccountExist(username)) {
            request.setAttribute("error_register", "Tài khoản đã tồn tại!");
            request.setAttribute("activeTab", "register"); // Để lúc chuyển trang vẫn mở form Register
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Đăng ký tài khoản
            boolean isRegistered = dao.registerAccount(username, password, fullname);
            
            if (isRegistered) {
                // Tạo session đăng nhập ngay lập tức (Role = 0)
                HttpSession session = request.getSession();
                Account newAcc = new Account(username, password, fullname, 0);
                session.setAttribute("account", newAcc);
                
                // Chuyển hướng về trang chủ
                response.sendRedirect("index");
            } else {
                request.setAttribute("error_register", "Lỗi hệ thống! Không thể đăng ký.");
                request.setAttribute("activeTab", "register");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}
