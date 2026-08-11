import java.sql.*;

public class CheckAdminSchema {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5433/admin";
        String user = "postgres";
        String pass = "123456";
        
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            DatabaseMetaData meta = conn.getMetaData();
            
            ResultSet rs = meta.getColumns(null, null, "account", null);
            System.out.println("Account Table Columns (lowercase name):");
            while (rs.next()) {
                System.out.println(rs.getString("COLUMN_NAME") + " - " + rs.getString("TYPE_NAME"));
            }
            
            rs = meta.getColumns(null, null, "Account", null);
            System.out.println("Account Table Columns (capitalized name):");
            while (rs.next()) {
                System.out.println(rs.getString("COLUMN_NAME") + " - " + rs.getString("TYPE_NAME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
