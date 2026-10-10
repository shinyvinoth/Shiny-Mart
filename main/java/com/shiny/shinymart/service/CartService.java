package com.shiny.shinymart.service;

import com.shiny.shinymart.dao.CartDAO;
import com.shiny.shinymart.model.CartItem;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class CartService {

    private final CartDAO cartDAO;

    public CartService(CartDAO cartDAO) {
        this.cartDAO = cartDAO;
    }

    public List<CartItem> viewCart(Long userId) throws SQLException {
        return cartDAO.findByUser(userId);
    }

    public void addItem(Long userId, Long productId, int quantity) throws SQLException {
        Optional<CartItem> existing = cartDAO.findByUserAndProduct(userId, productId);
        if (existing.isPresent()) {
            cartDAO.updateQuantity(existing.get().getId(), existing.get().getQuantity() + quantity);
        } else {
            CartItem item = new CartItem();
            item.setUserId(userId);
            item.setProductId(productId);
            item.setQuantity(quantity);
            cartDAO.save(item);
        }
    }

    public void updateItem(Long itemId, int quantity) throws SQLException {
        if (quantity <= 0) {
            cartDAO.delete(itemId);
        } else {
            cartDAO.updateQuantity(itemId, quantity);
        }
    }

    public void removeItem(Long itemId) throws SQLException {
        cartDAO.delete(itemId);
    }

    public void clearCart(Long userId) throws SQLException {
        cartDAO.clearForUser(userId);
    }
}
