package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.CartItem;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface CartDAO {
    List<CartItem> findByUser(Long userId) throws SQLException;
    Optional<CartItem> findByUserAndProduct(Long userId, Long productId) throws SQLException;
    CartItem save(CartItem item) throws SQLException;
    void updateQuantity(Long id, int quantity) throws SQLException;
    void delete(Long id) throws SQLException;
    void clearForUser(Long userId) throws SQLException;
}
