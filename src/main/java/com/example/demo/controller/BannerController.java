package com.example.demo.controller;

import com.example.demo.model.Banner;
import com.example.demo.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/banners")
public class BannerController {

    @Autowired
    private BannerService bannerService;

    @GetMapping
    public List<Banner> getAllBanners() {
        List<Banner> banners = bannerService.getAllBanners();
        banners.forEach(banner -> System.out.println(banner.toString()));
        return banners;
    }

    @GetMapping("/{id}")
    public Banner getBannerById(@PathVariable int id) {
        Banner banner = bannerService.getBannerById(id);
        System.out.println(banner.toString());
        return banner;
    }

    @PostMapping
    public int addBanner(@RequestBody Banner banner) {
        int result = bannerService.addBanner(banner);
        System.out.println("Banner added with result: " + result);
        return result;
    }

    @PutMapping("/{id}")
    public int updateBanner(@PathVariable int id, @RequestBody Banner banner) {
        banner.setId(id);
        int result = bannerService.updateBanner(banner);
        System.out.println("Banner updated with result: " + result);
        return result;
    }

    @DeleteMapping("/{id}")
    public int deleteBanner(@PathVariable int id) {
        int result = bannerService.deleteBanner(id);
        System.out.println("Banner deleted with result: " + result);
        return result;
    }
}