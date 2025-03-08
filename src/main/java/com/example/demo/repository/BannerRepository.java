package com.example.demo.repository;

import com.example.demo.model.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BannerRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 查询所有轮播图
    public List<Banner> getAllBanners() {
        String sql = "SELECT * FROM banners";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Banner.class));
    }

    // 根据 ID 查询轮播图
    public Banner getBannerById(int id) {
        String sql = "SELECT * FROM banners WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Banner.class), id);
    }

    // 添加轮播图
    public int addBanner(Banner banner) {
        String sql = "INSERT INTO banners (image_url, title, link_url, sort_order, status) VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, banner.getImageUrl(), banner.getTitle(), banner.getLinkUrl(),
                banner.getSortOrder(), banner.getStatus());
    }

    // 更新轮播图
    public int updateBanner(Banner banner) {
        String sql = "UPDATE banners SET image_url = ?, title = ?, link_url = ?, sort_order = ?, status = ? WHERE id = ?";
        return jdbcTemplate.update(sql, banner.getImageUrl(), banner.getTitle(), banner.getLinkUrl(),
                banner.getSortOrder(), banner.getStatus(), banner.getId());
    }

    // 删除轮播图
    public int deleteBanner(int id) {
        String sql = "DELETE FROM banners WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}