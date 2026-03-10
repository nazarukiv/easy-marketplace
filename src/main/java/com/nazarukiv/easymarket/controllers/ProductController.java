package com.nazarukiv.easymarket.controllers;


import com.nazarukiv.easymarket.models.Product;
import com.nazarukiv.easymarket.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;


    @GetMapping("/")
    public String products(@RequestParam(name = "title", required = false) String title,
                           @RequestParam(name = "page", defaultValue = "0") int page,
                           @RequestParam(name = "sort", defaultValue = "id") String sortField,
                           @RequestParam(name = "minPrice", required = false) Integer minPrice,
                           @RequestParam(name = "maxPrice", required = false) Integer maxPrice,
                           Principal principal,
                           Model model) {

        Sort sort;

        if (sortField.equals("price,desc")) {
            sort = Sort.by("price").descending();
        } else if (sortField.equals("dateCreated,desc")) {
            sort = Sort.by("dateCreated").descending();
        } else {
            sort = Sort.by(sortField);
        }

        Pageable pageable = PageRequest.of(page, 3, sort);
        Page<Product> productPage =
                productService.listProducts(title, minPrice, maxPrice, pageable);

        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("sortField", sortField);
        model.addAttribute("title", title);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("user", productService.getUserByPrincipal(principal));

        return "products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model){
        model.addAttribute("product", productService.getProductById(id));
        return  "product-info";
    }

    @PostMapping("/product/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1,
                                @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3, Product product, Principal principal) throws IOException {
        productService.saveProduct(principal, product, file1, file2, file3);
        return "redirect:/";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable Long id, Principal principal){

        System.out.println("DELETE CLICKED ID = " + id);

        if(productService.isProductOwner(id, principal)){
            productService.deleteProduct(id);
        }

        return "redirect:/";
    }

}
