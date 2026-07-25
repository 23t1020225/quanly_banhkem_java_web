
/**
 *
 * @author tranv
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import model.Account;

/**
 *
 * @author tranv
 */
public class loginDAO extends DBconnect{
    // Hàm này trả về 1 tên hiển thị (fullname) nếu đăng nhập đúng, trả về null nếu sai
public Account checkLogin(String user, String pass) {
    try {
        String sql = "SELECT * FROM Account WHERE username = ? AND password = ?";
        PreparedStatement p = getcon1().prepareStatement(sql);
        p.setString(1, user);
        p.setString(2, pass);
        
        ResultSet rs = p.executeQuery();
        if (rs.next()) {
            Account ac=new Account();
            ac.setUsername(rs.getString("username"));
            ac.setFullname(rs.getString("fullname"));
            ac.setRole(rs.getInt("role"));
            return ac;
        }
    } catch (Exception e) {
        System.out.println("Lỗi đăng nhập: " + e.getMessage());
    }
    return null; // Sai tài khoản hoặc mật khẩu
}
}

