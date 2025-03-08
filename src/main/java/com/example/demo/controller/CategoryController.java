package com.example.demo.controller;

import com.example.demo.model.Category;
import com.example.demo.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    // 获取所有分类
    @GetMapping
    public List<Category> getAllCategories() {
        List<Category> categories = categoryService.getAllCategories();
        categories.forEach(category -> System.out.println(category.toString()));
        return categories;
    }

    // 根据 ID 获取分类
    @GetMapping("/{id}")
    public Category getCategoryById(@PathVariable int id) {
        Category category = categoryService.getCategoryById(id);
        System.out.println(category.toString());
        return category;
    }
}