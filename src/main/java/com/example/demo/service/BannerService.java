package com.example.demo.service;

import com.example.demo.model.Banner;
import com.example.demo.repository.BannerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BannerService {

    @Autowired
    private BannerRepository bannerRepository;

    public List<Banner> getAllBanners() {
        return bannerRepository.getAllBanners();
    }

    public Banner getBannerById(int id) {
        return bannerRepository.getBannerById(id);
    }

    public int addBanner(Banner banner) {
        return bannerRepository.addBanner(banner);
    }

    public int updateBanner(Banner banner) {
        return bannerRepository.updateBanner(banner);
    }

    public int deleteBanner(int id) {
        return bannerRepository.deleteBanner(id);
    }
}