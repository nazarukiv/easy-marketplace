package com.nazarukiv.easymarket.repositories;

import com.nazarukiv.easymarket.models.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {

    Category findByName(String name);

}