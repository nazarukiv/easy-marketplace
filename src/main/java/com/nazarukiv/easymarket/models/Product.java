package com.nazarukiv.easymarket.models;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@JsonIgnoreProperties({"user", "images"})
@Entity
@Table(name = "products")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @NotBlank(message = "Title cannot be empty")
    @Column(name = "title")
    private String title;

    @NotBlank(message = "Description cannot be empty")
    @Column(name = "description", columnDefinition = "text")
    private String description;

    @NotBlank(message = "City cannot be empty")
    @Column(name = "city")
    private String city;


    @Min(value = 1, message = "Price must be greater than 0")
    @Column(name = "price")
    private int price;


    @OneToMany(
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY,
            mappedBy = "product",
            orphanRemoval = true
    )
    private List<Image> images = new ArrayList<>();


    private  Long previewImageId;

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private User user;

    private LocalDateTime dateCreated; //to know when specific product was created

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    private int views;

    @PrePersist
    private void init(){
        dateCreated = LocalDateTime.now();
        views = 0;
    }


    public void addImageToProduct(Image image){
        image.setProduct(this);
        images.add(image);
    }


}
