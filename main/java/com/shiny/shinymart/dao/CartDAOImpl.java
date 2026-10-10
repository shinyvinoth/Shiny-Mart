package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.CartItem;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CartDAOImpl implements CartDAO {

    private final DataSource dataSource;

    public CartDAOImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public List<CartItem> findByUser(Long userId) throws SQLException {
        String sql = "SELECT ci.id, ci.user_id, ci.product_id, ci.quantity, p.name, p.price " +
                "FROM cart_items ci JOIN products p ON ci.product_id = p.id WHERE ci.user_id = ?";
        List<CartItem> items = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapRow(rs));
                }
            }
        }
        return items;
    }

    @Override
    public Optional<CartItem> findByUserAndProduct(Long userId, Long productId) throws SQLException {
        String sql = "SELECT * FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getLong("id"));
                    item.setUserId(rs.getLong("user_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    return Optional.of(item);
                }
                return Optional.empty();
            }
        }
    }

    @Override
    public CartItem save(CartItem item) throws SQLException {
        String sql = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, item.getUserId());
            ps.setLong(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    item.setId(keys.getLong(1));
                }
            }
            return item;
        }
    }

    @Override
    public void updateQuantity(Long id, int quantity) throws SQLException {
        String sql = "UPDATE cart_items SET quantity = ? WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setLong(2, id);
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(Long id) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public void clearForUser(Long userId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.executeUpdate();
        }
    }

    private CartItem mapRow(ResultSet rs) throws SQLException {
        CartItem item = new CartItem();
        item.setId(rs.getLong("id"));
        item.setUserId(rs.getLong("user_id"));
        item.setProductId(rs.getLong("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setProductName(rs.getString("name"));
        item.setUnitPrice(rs.getBigDecimal("price"));
        return item;
    }
  }
