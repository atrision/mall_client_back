package com.example.demo.repository;

import com.example.demo.model.CartItem;
import com.example.demo.model.CartItemDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class CartItemRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 添加商品到购物车
    public CartItem addItem(int userId, int productId, int quantity) {
        String sql = "INSERT INTO cart_items (user_id, product_id, quantity, selected) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, userId, productId, quantity, 1);
        return getCartItemByUserIdAndProductId(userId, productId);
    }

    // 在更新/删除操作前验证用户所有权
    public boolean validateItemOwnership(int itemId, int userId) {
        String sql = "SELECT COUNT(*) FROM cart_items WHERE id = ? AND user_id = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, itemId, userId) > 0;
    }

    // 根据用户ID和商品ID获取购物车项
    public CartItem getCartItemByUserIdAndProductId(int userId, int productId) {
        String sql = "SELECT * FROM cart_items WHERE user_id = ? AND product_id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(CartItem.class), userId, productId);
    }

    // 获取购物车中商品的数量
    public int getCartCount(int userId) {
        String sql = "SELECT COUNT(*) FROM cart_items WHERE user_id = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, userId);
    }

    // 获取购物车中所有商品
    public List<CartItem> getCartItemsByUserId(int userId) {
        String sql = "SELECT * FROM cart_items WHERE user_id = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(CartItem.class), userId);
    }

    // 更新数量
    public void updateQuantity(int itemId, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE id = ?";
        jdbcTemplate.update(sql, quantity, itemId);
    }

    // 删除单个商品
    public void deleteItem(int itemId) {
        String sql = "DELETE FROM cart_items WHERE id = ?";
        jdbcTemplate.update(sql, itemId);
    }

    // 清空购物车
    public void clearCart(int userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        jdbcTemplate.update(sql, userId);
    }

    // 联表查询获取商品详情
    public List<CartItemDTO> getCartItemsWithDetails(int userId) {
        String sql = "SELECT ci.*, p.title, p.price, p.image_url as imageUrl " +
                "FROM cart_items ci " +
                "JOIN products p ON ci.product_id = p.id " +
                "WHERE ci.user_id = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(CartItemDTO.class), userId);
    }

}