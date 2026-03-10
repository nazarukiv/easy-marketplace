package com.nazarukiv.easymarket.models;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.logging.log4j.util.Lazy;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


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

    @Column(name = "title")
    private String title;

    @Column(name = "description", columnDefinition = "text")
    private String description;

    @Column(name = "city")
    private String city;

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


    @PrePersist
    private  void init(){
        dateCreated = LocalDateTime.now();
    }


    public void addImageToProduct(Image image){
        image.setProduct(this);
        images.add(image);
    }


}
