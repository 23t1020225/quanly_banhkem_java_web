package dal;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnect {

    private Connection connect(String jdbcUrl, String username, String password) throws Exception {
        // 1. Khai báo Driver của PostgreSQL
        Class.forName("org.postgresql.Driver");
        return DriverManager.getConnection(jdbcUrl, username, password);
    }

    private String getEnvOrDefault(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.isBlank()) ? value : defaultValue;
    }

    // Kết nối tới database 'cake'
    public Connection getcon() {
        try {
            // 2. Đổi chuỗi URL sang chuẩn PostgreSQL (cổng 5433)
            String defaultUrl = "jdbc:postgresql://localhost:5433/cake";
            String jdbcUrl = getEnvOrDefault("CAKE_DB_URL", defaultUrl);
            String username = getEnvOrDefault("DB_USER", "postgres"); // Tài khoản mặc định của PostgreSQL thường là 'postgres'
            String password = getEnvOrDefault("DB_PASSWORD", "123456");
            
            return connect(jdbcUrl, username, password);
        } catch (Exception e) {
            System.out.println("❌ LỖI KẾT NỐI POSTGRESQL (cake): " + e.getMessage());
        }
        return null;
    }

    // Kết nối tới database 'admin'
    public Connection getcon1() {
        try {
            String defaultUrl = "jdbc:postgresql://localhost:5433/admin";
            String jdbcUrl = getEnvOrDefault("ADMIN_DB_URL", defaultUrl);
            String username = getEnvOrDefault("DB_USER", "postgres");
            String password = getEnvOrDefault("DB_PASSWORD", "123456");
            
            return connect(jdbcUrl, username, password);
        } catch (Exception e) {
            System.out.println("❌ LỖI KẾT NỐI POSTGRESQL (admin): " + e.getMessage());
        }
        return null;
    }
}