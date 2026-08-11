import java.sql.*;

public class MigrateAdminDB {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5433/admin";
        String user = "postgres";
        String pass = "123456";
        
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            System.out.println("Connected to admin database.");
            Statement stmt = conn.createStatement();
            
            // Try to add the status column. If it exists, an exception will be caught.
            try {
                String sql = "ALTER TABLE Account ADD COLUMN status VARCHAR(20) DEFAULT 'Active'";
                stmt.executeUpdate(sql);
                System.out.println("Successfully added 'status' column to 'Account' table.");
            } catch (SQLException e) {
                System.out.println("Column might already exist or error occurred: " + e.getMessage());
            }
            
            // Set all existing null statuses to 'Active'
            try {
                String updateSql = "UPDATE Account SET status = 'Active' WHERE status IS NULL";
                int rows = stmt.executeUpdate(updateSql);
                System.out.println("Updated " + rows + " existing accounts to 'Active' status.");
            } catch (SQLException e) {
                System.out.println("Error updating existing rows: " + e.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
