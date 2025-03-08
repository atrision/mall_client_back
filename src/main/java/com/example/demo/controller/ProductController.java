package com.example.demo.controller;

import com.example.demo.model.Product;
import com.example.demo.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    // 获取所有商品
    @GetMapping
    public List<Product> getAllProducts() {
        List<Product> products = productService.getAllProducts();
        products.forEach(product -> System.out.println(product.toString()));
        return products;
    }

    // 根据 ID 获取商品
    @GetMapping("/{id}")
    public Product getProductById(@PathVariable int id) {
        Product product = productService.getProductById(id);
        System.out.println(product.toString());
        return product;
    }

    // 添加商品
    @PostMapping
    public int addProduct(@RequestBody Product product) {
        int result = productService.addProduct(product);
        System.out.println("Product added with result: " + result);
        return result;
    }

    // 更新商品
    @PutMapping("/{id}")
    public int updateProduct(@PathVariable int id, @RequestBody Product product) {
        product.setId(id);
        int result = productService.updateProduct(product);
        System.out.println("Product updated with result: " + result);
        return result;
    }

    // 删除商品
    @DeleteMapping("/{id}")
    public int deleteProduct(@PathVariable int id) {
        int result = productService.deleteProduct(id);
        System.out.println("Product deleted with result: " + result);
        return result;
    }

    // 获取评分最高的前四个商品
    @GetMapping("/top-rated")
    public List<Product> getTopRatedProducts() {
        List<Product> products = productService.getTopRatedProducts();
        products.forEach(product -> System.out.println(product.toString()));
        return products;
    }
}