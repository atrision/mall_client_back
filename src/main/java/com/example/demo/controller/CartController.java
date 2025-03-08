package com.example.demo.controller;

import com.example.demo.model.CartItem;
import com.example.demo.model.CartItemDTO;
import com.example.demo.model.CartRequest;
import com.example.demo.service.CartService;
import com.example.demo.service.UserService;
import com.example.demo.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserService userService;

    // 公共方法：从Authorization头获取用户ID
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

    // 添加商品到购物车
    @PostMapping
    public ResponseEntity<?> addToCart(
            @RequestBody CartRequest request,
            @RequestHeader("Authorization") String authHeader
    ) {
        Integer userId = getUserIdFromToken(authHeader);
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        CartItem item = cartService.addItem(userId, request.getProductId(), request.getQuantity());
        return ResponseEntity.status(HttpStatus.CREATED).body(item);
    }

    // 获取购物车中商品的数量
    @GetMapping("/count")
    public ResponseEntity<?> getCartCount(@RequestHeader("Authorization") String authHeader) {
        Integer userId = getUserIdFromToken(authHeader);
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        int count = cartService.getCartCount(userId);
        return ResponseEntity.ok(Collections.singletonMap("count", count));
    }

    // 更新商品数量
    @PutMapping("/{itemId}")
    public ResponseEntity<?> updateCartItem(
            @PathVariable int itemId,
            @RequestBody Map<String, Integer> request,
            @RequestHeader("Authorization") String authHeader
    ) {
        Integer userId = getUserIdFromToken(authHeader);
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        cartService.updateItemQuantity(itemId, request.get("quantity"),userId);
        return ResponseEntity.ok().build();
    }

    // 删除单个商品
    @DeleteMapping("/{itemId}")
    public ResponseEntity<?> removeCartItem(
            @PathVariable int itemId,
            @RequestHeader("Authorization") String authHeader
    ) {
        Integer userId = getUserIdFromToken(authHeader);
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        cartService.removeItem(itemId);
        return ResponseEntity.noContent().build();
    }

    // 清空购物车
    @DeleteMapping
    public ResponseEntity<?> clearCart(@RequestHeader("Authorization") String authHeader) {
        Integer userId = getUserIdFromToken(authHeader);
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        cartService.clearCart(userId);
        return ResponseEntity.noContent().build();
    }

    // 获取购物车详情
    @GetMapping
    public ResponseEntity<?> getCartItems(@RequestHeader("Authorization") String authHeader) {
        Integer userId = getUserIdFromToken(authHeader);
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        List<CartItemDTO> items = cartService.getCartItemsWithDetails(userId);
        return ResponseEntity.ok(items);
    }
}