// Order.java
package com.example.demo.model;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class Order {
    private Integer id;
    private Integer userId;
    private Long interfaceInfoId;
    private Integer orderStatus; // 0-待支付 1-已支付 2-已发货 3-已完成 4-已取消
    private BigDecimal totalAmount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}