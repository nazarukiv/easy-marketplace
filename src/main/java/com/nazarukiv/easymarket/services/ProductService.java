package com.nazarukiv.easymarket.services;


import com.nazarukiv.easymarket.models.Product;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.Nullable;
import org.springframework.stereotype.Service;
import com.nazarukiv.easymarket.repositories.ProductRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductService {
    private final ProductRepository productRepository;

    public List<Product> listProducts(String title){
        if (title != null && !title.isEmpty()){
            return productRepository.findByTitle(title);
        }
        return productRepository.findAll();
    }

    public void saveProduct(Product product){
        log.info("Save new {}", product);
       productRepository.save(product);
    }

    public void deleteProduct(Long id){
        productRepository.deleteById(id);

    }

    public @Nullable Object getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}
