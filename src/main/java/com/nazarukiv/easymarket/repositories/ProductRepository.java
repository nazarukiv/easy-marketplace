package com.nazarukiv.easymarket.repositories;

import com.nazarukiv.easymarket.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {

    Page<Product> findByTitleContainingIgnoreCaseAndCityContainingIgnoreCaseAndPriceBetween(
            String title,
            String city,
            int minPrice,
            int maxPrice,
            Pageable pageable
    );

    Page<Product> findByCategoryIdAndTitleContainingIgnoreCaseAndCityContainingIgnoreCaseAndPriceBetween(
            Long categoryId,
            String title,
            String city,
            int minPrice,
            int maxPrice,
            Pageable pageable
    );

    @Modifying
    @Query("update Product p set p.views = p.views + 1 where p.id = :id")
    void incrementViews(Long id);

}
