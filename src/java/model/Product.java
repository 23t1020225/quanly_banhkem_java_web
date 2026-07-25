/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tranv
 */
public class Product {
   private int id;
    private String name;
    private double price;
    private String image;
    private String description;
    private int categoryId;

    public Product() {
    }

    public Product(int id, String name, double price, String image, String description, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.description = description;
        this.categoryId = categoryId;
    }

    public int getId() {
        return id;
    }

    public String getImage() {
        return image;
    }

    public String getName() {
        return name;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
}
