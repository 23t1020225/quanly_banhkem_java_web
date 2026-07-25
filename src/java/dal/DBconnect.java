/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author tranv
 */
import java.sql.Connection;
import java.sql.DriverManager;
public class DBconnect {

    public Connection getcon() {
        try {
            // 1. Dòng này BẮT BUỘC CÓ trong Java Web để nạp Driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // 2. Chú ý: SQL Server dùng 'databaseName' chứ không phải 'database'
            Connection con = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;"
                + "databaseName=cake;"
                + "user=sa;"
                + "password=123;encrypt=true;trustServerCertificate=true"
            );
            return con;
        } catch (ClassNotFoundException e) {
            System.out.println("❌ LỖI: CHƯA THÊM THƯ VIỆN JDBC (mssql-jdbc.jar) VÀO DỰ ÁN!");
        } catch (Exception e) {
            System.out.println("❌ LỖI KẾT NỐI SQL SERVER: " + e.getMessage());
        }
        return null;
    }
    public Connection getcon1() {
        try {
            // 1. Dòng này BẮT BUỘC CÓ trong Java Web để nạp Driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // 2. Chú ý: SQL Server dùng 'databaseName' chứ không phải 'database'
            Connection con = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;"
                + "databaseName=admin;"
                + "user=sa;"
                + "password=123;encrypt=true;trustServerCertificate=true"
            );
            return con;
        } catch (ClassNotFoundException e) {
            System.out.println("❌ LỖI: CHƯA THÊM THƯ VIỆN JDBC (mssql-jdbc.jar) VÀO DỰ ÁN!");
        } catch (Exception e) {
            System.out.println("❌ LỖI KẾT NỐI SQL SERVER: " + e.getMessage());
        }
        return null;
    }

    
    
}

