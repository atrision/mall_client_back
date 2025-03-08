package com.example.demo.service;

import com.example.demo.model.CartItem;
import com.example.demo.model.CartItemDTO;
import com.example.demo.model.Product;
import com.example.demo.repository.CartItemRepository;
import com.example.demo.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CartService {

    @Autowired
    private CartItemRepository cartItemRepository;

    @Autowired
    private ProductRepository productRepository;

    public CartItem addItem(int userId, int productId, int quantity) {
        return cartItemRepository.addItem(userId, productId, quantity);
    }

    public int getCartCount(int userId) {
        return cartItemRepository.getCartCount(userId);
    }

    public List<CartItem> getCartItemsByUserId(int userId) {
        return cartItemRepository.getCartItemsByUserId(userId);
    }

    @Transactional
    public void updateItemQuantity(int itemId, int quantity, int userId) {
        if (!cartItemRepository.validateItemOwnership(itemId, userId)) {
            throw new AccessDeniedException("无权操作该商品");
        }
        cartItemRepository.updateQuantity(itemId, quantity);
    }
    @Transactional
    public void removeItem(int itemId) {
        cartItemRepository.deleteItem(itemId);
    }

    @Transactional
    public void clearCart(int userId) {
        cartItemRepository.clearCart(userId);
    }

    public List<CartItemDTO> getCartItemsWithDetails(int userId) {
        return cartItemRepository.getCartItemsWithDetails(userId);
    }
}