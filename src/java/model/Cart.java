package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public List<Item> getItems() {
        return items;
    }

    // Lấy số lượng của một sản phẩm trong giỏ
    public int getQuantityById(int id) {
        if(getItemById(id) != null)
            return getItemById(id).getQuantity();
        return 0;
    }

    // Tìm kiếm Item theo ID
    public Item getItemById(int id) {
        for (Item i : items) {
            if (i.getProduct().getId() == id) {
                return i;
            }
        }
        return null;
    }

    // Thêm sản phẩm vào giỏ
    public void addItem(Item t) {
        if (getItemById(t.getProduct().getId()) != null) {
            Item m = getItemById(t.getProduct().getId());
            m.setQuantity(m.getQuantity() + t.getQuantity());
        } else {
            items.add(t);
        }
    }

    // Xoá sản phẩm khỏi giỏ
    public void removeItem(int id) {
        if (getItemById(id) != null) {
            items.remove(getItemById(id));
        }
    }

    // Lấy tổng tiền của cả giỏ
    public double getTotalMoney() {
        double t = 0;
        for (Item i : items) {
            t += (i.getQuantity() * i.getProduct().getPrice());
        }
        return t;
    }
    
    // Lấy tổng số lượng các sản phẩm
    public int getTotalQuantity() {
        int total = 0;
        for (Item i : items) {
            total += i.getQuantity();
        }
        return total;
    }
}
