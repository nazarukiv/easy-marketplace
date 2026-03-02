package com.nazarukiv.easymarket.services;


import com.nazarukiv.easymarket.models.Product;
import org.jspecify.annotations.Nullable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductService {
    private List<Product> products = new ArrayList<>();
    private long ID = 0;

    {
        products.add(new Product(++ID,"PlayStation 5", "used-good condition", "South London", 350, "Ivan"));
        products.add(new Product(++ID,"iPhone 17 pro max", "used-perfect condition","West London", 1150, "Tom"));
    }

    public List<Product> listProducts(){return products;}

    public void saveProduct(Product product){
        product.setId(++ID);
        products.add(product);
    }

    public void deleteProduct(Long id){
        products.removeIf(product -> product.getId().equals(id));
    }

    public @Nullable Object getProductById(Long id) {
        for (Product product: products){
            if (product.getId().equals(id))
                return product;
        }
        return null;
    }
}
