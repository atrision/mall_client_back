package com.example.demo.controller;

import com.example.demo.model.Order;
import com.example.demo.model.OrderDetailDTO;
import com.example.demo.model.OrderItemDTO;
import com.example.demo.service.CartService;
import com.example.demo.service.OrderService;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private com.example.demo.utils.JwtUtil jwtUtil;
    @Autowired
    private CartService cartService;

    @Autowired
    private UserService userService;

    @PostMapping
    public ResponseEntity<?> createOrder(@RequestHeader("Authorization") String authHeader) {
        try {
            Integer userId = getUserIdFromToken(authHeader); // Token解析方法需实现
            Order order = orderService.createOrderFromCart(userId);
            return ResponseEntity.status(201).body(order);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{orderId}")
    public ResponseEntity<?> getOrderDetail(
            @PathVariable Integer orderId,
            @RequestHeader("Authorization") String authHeader
    ) {
        try {
            Integer userId = getUserIdFromToken(authHeader);
            OrderDetailDTO detail = orderService.getOrderDetail(orderId, userId);
            return ResponseEntity.ok(detail);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 实现Token解析逻辑（参考之前的代码）
    private Integer getUserIdFromToken(String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return null;
        }

        String token = authHeader.substring(7);
        try {
            if (!jwtUtil.isTokenValid(token, jwtUtil.extractUsername(token))) {
                return null;
            }

            String username = jwtUtil.extractUsername(token);
            return userService.getUserByUsername(username)
                    .map(user -> user.getId())
                    .orElse(null);

        } catch (Exception e) {
            return null;
        }
    }
}