import java.sql.*;

public class TestDB {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://dpg-d9pmnbe417fc73e8inl0-a.singapore-postgres.render.com:5432/cake_d544";
        String user = "sa";
        String pass = "TU8RL0EUfNv9vDiioLpbWqmMZ1hZLAie";
        
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            System.out.println("Connected to PostgreSQL!");
            
            String sqlOrder = "INSERT INTO Orders (customerName, orderDate, totalMoney, status) VALUES (?, CURRENT_TIMESTAMP, ?, 'Pending')";
            PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, "staff");
            psOrder.setDouble(2, 150000.0);
            psOrder.executeUpdate();
            
            ResultSet rs = psOrder.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);
                System.out.println("Generated Order ID: " + orderId);
                
                String sqlDetail = "INSERT INTO OrderDetails (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
                PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, 1);
                psDetail.setInt(3, 1);
                psDetail.setDouble(4, 150000.0);
                psDetail.executeUpdate();
                System.out.println("Inserted OrderDetail!");
            } else {
                System.out.println("No generated keys returned!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
