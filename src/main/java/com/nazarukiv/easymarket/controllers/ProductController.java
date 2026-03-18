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
import com.nazarukiv.easymarket.repositories.CategoryRepository;

import java.io.IOException;
import java.security.Principal;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    private final CategoryRepository categoryRepository;

    @GetMapping("/")
    public String products(@RequestParam(name = "title", required = false) String title,
                           @RequestParam(name = "city", required = false) String city,
                           @RequestParam(name = "page", defaultValue = "0") int page,
                           @RequestParam(name = "sort", defaultValue = "dateCreated,desc") String sortField,
                           @RequestParam(name = "minPrice", required = false) Integer minPrice,
                           @RequestParam(name = "maxPrice", required = false) Integer maxPrice,
                           @RequestParam(required = false) Long categoryId,
                           Principal principal,
                           Model model) {

        Sort sort;

        switch (sortField) {
            case "price,asc":
                sort = Sort.by("price").ascending();
                break;
            case "price,desc":
                sort = Sort.by("price").descending();
                break;
            case "dateCreated,asc":
                sort = Sort.by("dateCreated").ascending();
                break;
            case "dateCreated,desc":
                sort = Sort.by("dateCreated").descending();
                break;
            case "title,asc":
                sort = Sort.by("title").ascending();
                break;
            case "title,desc":
                sort = Sort.by("title").descending();
                break;
            default:
                sort = Sort.by("dateCreated").descending();
        }

        Pageable pageable = PageRequest.of(page, 3, sort);
        Page<Product> productPage =
                productService.listProducts(title, city, minPrice, maxPrice, categoryId, pageable);

        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("sortField", sortField);
        model.addAttribute("title", title);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("city", city);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("categories", categoryRepository.findAll());
        model.addAttribute("categoryId", categoryId);

        return "products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Principal principal, Model model){
        productService.incrementViews(id);

        model.addAttribute("product", productService.getProductById(id));
        model.addAttribute("user", productService.getUserByPrincipal(principal));

        return "product-info";
    }

    @PostMapping("/product/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1,
                                @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3,
                                @RequestParam("categoryId") Long categoryId,
                                @Valid Product product,
                                BindingResult bindingResult,
                                Principal principal,
                                RedirectAttributes redirectAttributes) throws IOException {

        if(bindingResult.hasErrors()){
            redirectAttributes.addFlashAttribute("errorMessage",
                    "PLEASE FILL ALL FIELDS CORRECTLY!");
            return "redirect:/";
        }

        productService.saveProduct(principal, product, categoryId, file1, file2, file3);
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

    @GetMapping("/product/edit/{id}")
    public String editProductForm(@PathVariable Long id, Principal principal, Model model) {

        if (!productService.isProductOwner(id, principal)) {
            return "redirect:/";
        }

        Product product = productService.getProductById(id);
        model.addAttribute("product", product);

        return "product-edit";
    }


    @PostMapping("/product/edit/{id}")
    public String updateProduct(@PathVariable Long id,
                                @RequestParam("title") String title,
                                @RequestParam("description") String description,
                                @RequestParam("city") String city,
                                @RequestParam("price") int price,
                                Principal principal) {

        if (!productService.isProductOwner(id, principal)) {
            return "redirect:/";
        }

        productService.updateProduct(id, title, description, city, price);

        return "redirect:/product/" + id;
    }

}
