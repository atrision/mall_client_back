package com.example.demo.repository;

import com.example.demo.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class ProductRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 查询所有商品
    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM products";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class));
    }

    // 根据 ID 查询商品
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Product.class), id);
    }

    // 添加商品
    public int addProduct(Product product) {
        String sql = "INSERT INTO products (category_id, title, image_url, price, status, rate) VALUES (?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, product.getCategoryId(), product.getTitle(), product.getImageUrl(),
                product.getPrice(), product.getStatus(), product.getRate());
    }

    // 更新商品
    public int updateProduct(Product product) {
        String sql = "UPDATE products SET category_id = ?, title = ?, image_url = ?, price = ?, status = ?, rate = ? WHERE id = ?";
        return jdbcTemplate.update(sql, product.getCategoryId(), product.getTitle(), product.getImageUrl(),
                product.getPrice(), product.getStatus(), product.getRate(), product.getId());
    }

    // 删除商品
    public int deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }

    // 查询评分最高的前四个商品
    public List<Product> getTopRatedProducts() {
        String sql = "SELECT * FROM products " +
                "WHERE rate IS NOT NULL " + // 确保有销量
                "ORDER BY (rate * 0.6) + " +          // 销量权重60%
                "(100 / (price + 1)) * 0.3 + " +      // 价格越低分越高（价格权重30%）
                "(DATEDIFF(NOW(), created_at) < 30) * 0.1 " + // 30天内新品额外加10%
                "DESC LIMIT 4";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class));
    }
    public Optional<Product> findById(int id) {
        try {
            String sql = "SELECT * FROM products WHERE id = ?";
            Product product = jdbcTemplate.queryForObject(
                    sql,
                    new BeanPropertyRowMapper<>(Product.class),
                    id
            );
            return Optional.ofNullable(product);
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        }
    }
}