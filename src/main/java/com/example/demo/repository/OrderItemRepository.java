// OrderItemRepository.java
package com.example.demo.repository;

import com.example.demo.model.OrderItem;
import com.example.demo.model.OrderItemDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OrderItemRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void save(OrderItem orderItem) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                orderItem.getOrderId(),
                orderItem.getProductId(),
                orderItem.getQuantity(),
                orderItem.getUnitPrice()
        );
    }

    public List<OrderItem> findByOrderId(int orderId) {
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(OrderItem.class), orderId);
    }

    public List<OrderItemDTO> findWithProductDetails(Integer orderId) {
        String sql = "SELECT " +
                "  oi.id, " +
                "  oi.product_id AS productId, " +
                "  oi.quantity, " +
                "  oi.unit_price AS unitPrice, " +
                "  p.title AS productTitle, " +
                "  p.image_url AS imageUrl " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE oi.order_id = ?";

        return jdbcTemplate.query(
                sql,
                new BeanPropertyRowMapper<>(OrderItemDTO.class),
                orderId
        );
    }
}