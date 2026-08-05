<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dal.DBconnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Test DB Connection</title>
    </head>
    <body>
        <h1>Kiểm tra kết nối CSDL</h1>
        <%
            try {
                DBconnect db = new DBconnect();
                Connection conn = db.getcon();
                if (conn != null) {
                    out.println("<p style='color:green;'>✅ Kết nối thành công tới Database 'cake'!</p>");
                    
                    // Thử truy vấn dữ liệu bảng Categories
                    out.println("<h3>Kiểm tra bảng Categories:</h3>");
                    try {
                        String sql = "SELECT * FROM Categories";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        int count = 0;
                        out.println("<ul>");
                        while (rs.next()) {
                            count++;
                            int id = rs.getInt("CategoryID"); // Phải khớp tên cột trong ResultSet
                            String name = rs.getString("CategoryName");
                            out.println("<li>ID: " + id + " - Name: " + name + "</li>");
                        }
                        out.println("</ul>");
                        if (count == 0) {
                            out.println("<p style='color:orange;'>Bảng Categories trống! (Không có dòng nào)</p>");
                        } else {
                            out.println("<p style='color:green;'>Đã tìm thấy " + count + " danh mục.</p>");
                        }
                    } catch (Exception ex) {
                        out.println("<p style='color:red;'>❌ Lỗi truy vấn bảng Categories: " + ex.getMessage() + "</p>");
                    }
                    
                    conn.close();
                } else {
                    out.println("<p style='color:red;'>❌ Kết nối tới Database 'cake' THẤT BẠI.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Exception: " + e.getMessage() + "</p>");
            }
        %>
    </body>
</html>
