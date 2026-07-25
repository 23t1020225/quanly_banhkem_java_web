package model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private String customerName;
    private Timestamp orderDate; // Dùng Timestamp để lưu cả ngày và giờ đặt bánh
    private double totalMoney;
    private String status;

    // Hàm tạo không tham số (Constructor mặc định)
    public Order() {
    }

    // Hàm tạo có đầy đủ tham số
    public Order(int id, String customerName, Timestamp orderDate, double totalMoney, String status) {
        this.id = id;
        this.customerName = customerName;
        this.orderDate = orderDate;
        this.totalMoney = totalMoney;
        this.status = status;
    }

    // Các hàm Getter và Setter để DAO và JSP có thể lấy/ghi dữ liệu
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}