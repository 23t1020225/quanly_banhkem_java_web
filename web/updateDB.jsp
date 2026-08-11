<%@page import="java.sql.*"%>
<%@page import="dal.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head><title>Update Database</title></head>
    <body style="font-family: Arial; padding: 20px;">
        <h2>Cập nhật cơ sở dữ liệu trên Render</h2>
        <div style="padding: 10px; border: 1px solid #ccc; background: #f9f9f9;">
        <%
            DBconnect db = new DBconnect();
            try (Connection conn = db.getcon1()) {
                if (conn != null) {
                    out.println("<p>✅ Đã kết nối tới Database Admin thành công.</p>");
                    Statement stmt = conn.createStatement();
                    
                    // Thêm cột status
                    try {
                        String sql = "ALTER TABLE Account ADD COLUMN status VARCHAR(20) DEFAULT 'Active'";
                        stmt.executeUpdate(sql);
                        out.println("<p style='color:green'>✅ Đã thêm cột 'status' vào bảng Account thành công!</p>");
                    } catch (Exception e) {
                        out.println("<p style='color:orange'>⚠️ Cột 'status' có thể đã tồn tại: " + e.getMessage() + "</p>");
                    }
                    
                    // Cập nhật dữ liệu cũ
                    try {
                        String updateSql = "UPDATE Account SET status = 'Active' WHERE status IS NULL";
                        int rows = stmt.executeUpdate(updateSql);
                        out.println("<p style='color:blue'>✅ Đã cập nhật " + rows + " tài khoản cũ sang trạng thái Active.</p>");
                    } catch (Exception e) {}
                } else {
                    out.println("<p style='color:red'>❌ Không thể kết nối tới Admin DB.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red'>❌ Lỗi hệ thống: " + e.getMessage() + "</p>");
            }
        %>
        </div>
        <br>
        <a href="login.jsp" style="padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 5px;">Quay lại Đăng nhập</a>
    </body>
</html>
