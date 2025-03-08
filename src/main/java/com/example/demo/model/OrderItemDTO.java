package com.example.demo.model;

import lombok.Data;

import java.math.BigDecimal;

// OrderItemDTO.java
@Data
public class OrderItemDTO {
    private Integer id;         // 订单项ID
    private Integer productId;  // 商品ID
    private String productTitle;// 商品标题
    private String imageUrl;    // 商品图片
    private Integer quantity;   // 购买数量
    private BigDecimal unitPrice; // 下单时单价
}