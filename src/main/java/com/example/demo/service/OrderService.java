// OrderService.java
package com.example.demo.service;

import com.example.demo.model.*;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private CartService cartService;

    @Autowired
    private ProductRepository productRepository;

    @Transactional
    public Order createOrderFromCart(Integer userId) {
        List<CartItemDTO> cartItems = cartService.getCartItemsWithDetails(userId);

        if (cartItems.isEmpty()) {
            throw new RuntimeException("购物车为空");
        }

        // 创建订单主记录
        Order order = new Order();
        order.setUserId(userId);
        order.setOrderStatus(0);
        order.setTotalAmount(calculateTotal(cartItems));
        order=orderRepository.saveWithId(order);

        // 创建订单项
        Order finalOrder = order;
        cartItems.forEach(cartItem -> {
            Product product = productRepository.findById(cartItem.getProductId())
                    .orElseThrow(() -> new RuntimeException("商品不存在"));

            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(finalOrder.getId());
            orderItem.setProductId(cartItem.getProductId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setUnitPrice(product.getPrice());
            orderItemRepository.save(orderItem);
        });

        // 清空购物车
        cartService.clearCart(userId);
        return order;
    }

    public OrderDetailDTO getOrderDetail(Integer orderId, Integer userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("订单不存在"));

        // 验证订单归属
        if (!order.getUserId().equals(userId)) {
            throw new RuntimeException("无权查看此订单");
        }

        List<OrderItemDTO> items = orderItemRepository.findWithProductDetails(orderId);
        return new OrderDetailDTO(order, items);
    }

    private BigDecimal calculateTotal(List<CartItemDTO> items) {
        return items.stream()
                .map(cartItem -> {
                    // 使用 BigDecimal 的构造方法，避免精度问题
                    BigDecimal price = new BigDecimal(cartItem.getPrice());
                    BigDecimal quantity = BigDecimal.valueOf(cartItem.getQuantity());
                    return price.multiply(quantity);
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public Order getOrderById(Integer orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("订单不存在"));
    }
}