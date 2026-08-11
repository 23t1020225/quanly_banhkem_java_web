import java.sql.*;

public class CheckProductsSchema {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://dpg-d9pmnbe417fc73e8inl0-a.singapore-postgres.render.com:5432/cake_d544";
        String user = "sa";
        String pass = "TU8RL0EUfNv9vDiioLpbWqmMZ1hZLAie";
        
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            DatabaseMetaData meta = conn.getMetaData();
            
            ResultSet rs = meta.getColumns(null, null, "products", null);
            System.out.println("Products Table Columns:");
            while (rs.next()) {
                System.out.println(rs.getString("COLUMN_NAME") + " - " + rs.getString("TYPE_NAME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
