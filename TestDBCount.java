import java.sql.*;

public class TestDBCount {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://dpg-d9pmnbe417fc73e8inl0-a.singapore-postgres.render.com:5432/cake_d544";
        String user = "sa";
        String pass = "TU8RL0EUfNv9vDiioLpbWqmMZ1hZLAie";
        
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            PreparedStatement ps = conn.prepareStatement("SELECT count(*) FROM pg_stat_activity");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Current active connections: " + rs.getInt(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
