package com.example.demo.model;// OrderDetailDTO.java


import com.example.demo.model.Order;
import com.example.demo.model.OrderItemDTO;
import lombok.Data;
import java.util.List;

@Data
public class OrderDetailDTO {
    private Order order;
    private List<OrderItemDTO> items;

    public OrderDetailDTO(Order order, List<OrderItemDTO> items) {
        this.order = order;
        this.items = items;
    }
}