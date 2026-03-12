package com.nazarukiv.easymarket.services;

import com.nazarukiv.easymarket.models.Product;
import com.nazarukiv.easymarket.repositories.ProductRepository;
import com.nazarukiv.easymarket.repositories.UserRepository;
import org.junit.jupiter.api.Test;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class ProductServiceTest {

    @Test
    void getProductById_returnsProduct() {
        ProductRepository productRepository = mock(ProductRepository.class);
        UserRepository userRepository = mock(UserRepository.class);

        ProductService productService = new ProductService(productRepository, userRepository);

        Product product = new Product();
        product.setId(1L);
        product.setTitle("PS5");

        when(productRepository.findById(1L)).thenReturn(Optional.of(product));

        Product result = productService.getProductById(1L);

        assertEquals("PS5", result.getTitle());
    }
}