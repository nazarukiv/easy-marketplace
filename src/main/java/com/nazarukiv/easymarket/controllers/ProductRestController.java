package com.nazarukiv.easymarket.controllers;

import com.nazarukiv.easymarket.models.Product;
import com.nazarukiv.easymarket.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/products")
public class ProductRestController {

    private final ProductService productService;

    //GET all products
    @GetMapping
    public Page<Product> getAllProducts(Pageable pageable) {
        return productService.getProductsPage(pageable);
    }

    //GET one product
    @GetMapping("/{id}")
    public Product getProduct(@PathVariable Long id) {
        return productService.getProductById(id);
    }
}