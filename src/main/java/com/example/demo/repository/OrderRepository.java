// OrderRepository.java
package com.example.demo.repository;

import com.example.demo.model.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class OrderRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Order saveWithId(Order order) {
        String sql = "INSERT INTO orders (user_id, order_status, total_amount) VALUES (?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getOrderStatus());
            ps.setBigDecimal(3, order.getTotalAmount());
            return ps;
        }, keyHolder);

        order.setId(keyHolder.getKey().intValue());
        return order;
    }

/*    public Order save(Order order) {
        String sql = "INSERT INTO orders (user_id, order_status, total_amount) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql,
                order.getUserId(),
                order.getOrderStatus(),
                order.getTotalAmount()
        );
        return order;
    }*/

    public Order save(Order order) {
        String sql = "UPDATE orders SET order_status = ?, total_amount = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        jdbcTemplate.update(sql,
                order.getOrderStatus(),
                order.getTotalAmount(),
                order.getId());
        return order;
    }

    public Optional<Order> findById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Order.class), id)
                .stream()
                .findFirst();
    }

    public List<Order> findByUserId(int userId) {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Order.class), userId);
    }
}