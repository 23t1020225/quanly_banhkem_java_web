package dal;

// ĐÃ SỬA: Đổi từ java.beans.Statement thành java.sql.Statement
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;
// ĐÃ THÊM: Import 2 thư viện còn thiếu
import model.Item;
import model.Order;

public class DAO extends DBconnect {
    
    // Hàm lấy danh sách Danh mục
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        
        try {
            Connection conn = getcon();
            if (conn == null) {
                System.out.println("❌ LỖI: Không thể kết nối Database!");
                return list;
            }
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("CategoryID");
                String name = rs.getString("CategoryName");
                list.add(new Category(id, name));
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI TRUY VẤN SQL BẢNG CATEGORIES:");
            e.printStackTrace(); 
        }
        return list;
    }

    // Hàm lấy danh sách Sản phẩm
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        
        try {
            Connection conn = getcon();
            if (conn == null) {
                return list;
            }
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("ProductID");
                String name = rs.getString("ProductName");
                double price = rs.getDouble("Price");
                String image = rs.getString("ImageURL");
                String description = rs.getString("Description");
                int categoryId = rs.getInt("CategoryID");
                
                list.add(new Product(id, name, price, image, description, categoryId));
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI TRUY VẤN SQL BẢNG PRODUCTS:");
            e.printStackTrace(); 
        }
        return list;
    }

    public List<Product> getProductsByCategoryId(int cid) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE CategoryID = ?";
        
        try {
            Connection conn = getcon();
            if (conn == null) return list;
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("ProductID"), rs.getString("ProductName"),
                    rs.getDouble("Price"), rs.getString("ImageURL"),
                    rs.getString("Description"), rs.getInt("CategoryID")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return list;
    }

    // Hàm lấy 1 sản phẩm bằng ID để phục vụ Giỏ hàng
    public Product getProductByID(int id) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        
        try {
            Connection conn = getcon();
            if (conn == null) return null;
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new Product(
                    rs.getInt("ProductID"), 
                    rs.getString("ProductName"),
                    rs.getDouble("Price"), 
                    rs.getString("ImageURL"),
                    rs.getString("Description"), 
                    rs.getInt("CategoryID")
                );
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI LẤY SẢN PHẨM THEO ID:");
            e.printStackTrace();
        }
        return null;
    }

    // 1. Hàm lưu đơn hàng vào DB khi khách nhấn "Xác nhận đặt hàng"
    public boolean addOrder(model.Account account, model.Cart cart) {
        try {
            Connection conn = getcon();
            if (conn == null) return false;
            
            // 1. Thêm vào bảng Orders
            String sqlOrder = "INSERT INTO Orders (customerName, orderDate, totalMoney, status) VALUES (?, CURRENT_TIMESTAMP, ?, 'Pending')";
            PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, account.getUsername());
            psOrder.setDouble(2, cart.getTotalMoney());
            psOrder.executeUpdate();
            
            // Lấy OrderID vừa tạo
            ResultSet rs = psOrder.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);
                
                // 2. Thêm vào bảng OrderDetails
                for (model.Item item : cart.getItems()) {
                    String sqlDetail = "INSERT INTO OrderDetails (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
                    PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, item.getProduct().getId());
                    psDetail.setInt(3, item.getQuantity());
                    psDetail.setDouble(4, item.getProduct().getPrice());
                    psDetail.executeUpdate();
                }
            }
            return true;
        } catch (Exception e) {
            System.out.println("❌ LỖI LƯU ĐƠN HÀNG VÀO CSDL:");
            e.printStackTrace();
            return false;
        }
    }

    // Hàm tìm kiếm sản phẩm theo tên (hỗ trợ Suggestion)
    public List<Product> searchProductsByName(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE ProductName LIKE ?";
        
        try {
            Connection conn = getcon(); 
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + keyword + "%");
                ResultSet rs = ps.executeQuery();
                
                while (rs.next()) {
                    int id = rs.getInt("ProductID");
                    String name = rs.getString("ProductName");
                    double price = rs.getDouble("Price");
                    String img = rs.getString("ImageURL");
                    String desc = rs.getString("Description");
                    int catId = rs.getInt("CategoryID");
                    
                    list.add(new Product(id, name, price, img, desc, catId));
                }
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI TRUY VẤN TÌM KIẾM SẢN PHẨM:");
            e.printStackTrace();
        }
        return list;
    }

    // Kiểm tra tài khoản có tồn tại chưa (Dùng cho đăng ký)
    public boolean checkAccountExist(String username) {
        String sql = "SELECT * FROM Account WHERE username = ?";
        try {
            Connection conn = getcon1(); // Kết nối vào DB admin
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return true; // Đã tồn tại
                }
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI KIỂM TRA TÀI KHOẢN:");
            e.printStackTrace();
        }
        return false;
    }

    // Thêm tài khoản mới vào hệ thống
    public boolean registerAccount(String username, String password, String fullname) {
        String sql = "INSERT INTO Account (username, password, fullname, role) VALUES (?, ?, ?, 0)";
        try {
            Connection conn = getcon1(); // Kết nối vào DB admin
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, fullname);
                int result = ps.executeUpdate();
                return result > 0; // Trả về true nếu insert thành công
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI ĐĂNG KÝ TÀI KHOẢN:");
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách đơn hàng của 1 khách hàng theo username
    public List<Order> getOrdersByUsername(String username) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE customerName = ? ORDER BY orderDate DESC";
        try {
            Connection conn = getcon();
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("customerName"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalMoney"),
                        rs.getString("status")
                    );
                    list.add(o);
                }
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI LẤY LỊCH SỬ ĐƠN HÀNG:");
            e.printStackTrace();
        }
        return list;
    }

    // Khách hàng tự huỷ đơn (chỉ huỷ được khi đang Pending)
    public boolean cancelOrder(int orderId, String username) {
        String sql = "UPDATE Orders SET status = 'Cancel' WHERE id = ? AND customerName = ? AND status = 'Pending'";
        try {
            Connection conn = getcon();
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, orderId);
                ps.setString(2, username);
                int result = ps.executeUpdate();
                return result > 0;
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI HUỶ ĐƠN HÀNG:");
            e.printStackTrace();
        }
        return false;
    }

    // ===================== ADMIN FUNCTIONS =====================

    // [ADMIN] Lấy toàn bộ đơn hàng của tất cả khách
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY orderDate DESC";
        try {
            Connection conn = getcon();
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Order o = new Order(
                        rs.getInt("id"),
                        rs.getString("customerName"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalMoney"),
                        rs.getString("status")
                    );
                    list.add(o);
                }
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI LẤY TẤT CẢ ĐƠN HÀNG (ADMIN):");
            e.printStackTrace();
        }
        return list;
    }

    // [ADMIN] Cập nhật trạng thái đơn hàng (Pending -> Done hoặc Cancel)
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE Orders SET status = ? WHERE id = ?";
        try {
            Connection conn = getcon();
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, newStatus);
                ps.setInt(2, orderId);
                int result = ps.executeUpdate();
                return result > 0;
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI CẬP NHẬT TRẠNG THÁI ĐƠN (ADMIN):");
            e.printStackTrace();
        }
        return false;
    }

    // [ADMIN] Đếm tổng số đơn hàng
    public int countAllOrders() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try {
            Connection conn = getcon();
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // [ADMIN] Đếm số đơn theo trạng thái
    public int countOrdersByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM Orders WHERE status = ?";
        try {
            Connection conn = getcon();
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, status);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // [ADMIN] Tính tổng doanh thu (chỉ tính đơn Done)
    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(totalMoney), 0) FROM Orders WHERE status = 'Done'";
        try {
            Connection conn = getcon();
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) return rs.getDouble(1);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // [ADMIN] Thêm sản phẩm mới
    public boolean insertProduct(String name, double price, String image, String description, int categoryId) {
        String sql = "INSERT INTO Products (ProductName, Price, ImageURL, Description, CategoryID) VALUES (?, ?, ?, ?, ?)";
        try {
            Connection conn = getcon();
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setDouble(2, price);
                ps.setString(3, image);
                ps.setString(4, description);
                ps.setInt(5, categoryId);
                
                int result = ps.executeUpdate();
                return result > 0;
            }
        } catch (Exception e) {
            System.out.println("❌ LỖI THÊM SẢN PHẨM (ADMIN):");
            e.printStackTrace();
        }
        return false;
    }
}