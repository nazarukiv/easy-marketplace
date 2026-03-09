package com.nazarukiv.easymarket.services;


import com.nazarukiv.easymarket.models.Image;
import com.nazarukiv.easymarket.models.Product;
import com.nazarukiv.easymarket.models.User;
import com.nazarukiv.easymarket.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.Nullable;
import org.springframework.stereotype.Service;
import com.nazarukiv.easymarket.repositories.ProductRepository;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public Page<Product> listProducts(String title, Pageable pageable){
        if (title != null && !title.isEmpty()){
            return productRepository.findByTitleContainingIgnoreCase(title, pageable);
        }
        return productRepository.findAll(pageable);
    }

    public void saveProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3)throws IOException
    {
        product.setUser(getUserByPrincipal(principal));
        Image image1;
        Image image2;
        Image image3;

        if (file1.getSize() !=0){
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            product.addImageToProduct(image1);
        }

        if (file2.getSize() !=0){
            image2 = toImageEntity(file2);
            product.addImageToProduct(image2);
        }

        if (file3.getSize() !=0){
            image3 = toImageEntity(file3);
            product.addImageToProduct(image3);
        }

        log.info("Save new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());

        Product productFromDb = productRepository.save(product);

        if (!productFromDb.getImages().isEmpty()) {
            productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
        }

        productRepository.save(productFromDb);
    }

    public User getUserByPrincipal(Principal principal) {
        if(principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();

        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());

        return image;
    }

    public void deleteProduct(Long id){
        productRepository.deleteById(id);

    }

    public @Nullable Object getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}
