import java.sql.*;

public class FixSequences {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://dpg-d9pmnbe417fc73e8inl0-a.singapore-postgres.render.com:5432/cake_d544";
        String user = "sa";
        String pass = "TU8RL0EUfNv9vDiioLpbWqmMZ1hZLAie";
        
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement stmt = conn.createStatement()) {
            
            stmt.execute("SELECT setval('products_productid_seq', COALESCE((SELECT MAX(ProductID) FROM Products), 1))");
            System.out.println("Fixed Products sequence.");
            
            stmt.execute("SELECT setval('categories_categoryid_seq', COALESCE((SELECT MAX(CategoryID) FROM Categories), 1))");
            System.out.println("Fixed Categories sequence.");
            
            stmt.execute("SELECT setval('orders_id_seq', COALESCE((SELECT MAX(id) FROM Orders), 1))");
            System.out.println("Fixed Orders sequence.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
