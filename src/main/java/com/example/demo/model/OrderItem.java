// OrderItem.java
package com.example.demo.model;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class OrderItem {
    private Integer id;
    private Integer orderId;
    private Integer productId;
    private Integer quantity;
    private BigDecimal unitPrice;
}