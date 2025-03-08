package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.service.UserService;
import com.example.demo.utils.JwtUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/user")
@Slf4j
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    @GetMapping
    public ResponseEntity<User> getUser(@RequestHeader("Authorization") String authHeader) {
        // 从Authorization头中提取Token
        String token = extractToken(authHeader);

        if (token == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        try {
            // 验证并解析Token
            if (!jwtUtil.isTokenValid(token, jwtUtil.extractUsername(token))) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
            }

            // 从Token中获取用户名
            String username = jwtUtil.extractUsername(token);

            // 查询用户信息
            User user = userService.getUserByUsername(username)
                    .orElseThrow(() -> new RuntimeException("用户不存在"));

            return ResponseEntity.ok(user);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    private String extractToken(String authHeader) {
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.substring(7);
        }
        return null;
    }
}