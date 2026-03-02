package com.nazarukiv.easymarket.models;


import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Product {
    private Long id;
    private String title;
    private String description;
    private String city;
    private int price;
    private String author; //for now, later will be changed for model.

    public Product() {
    }
}
