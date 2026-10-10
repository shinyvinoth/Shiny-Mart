package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.Order;
import com.shiny.shinymart.model.OrderItem;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    private final DataSource dataSource;

    public OrderDAOImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Order createOrder(Order order, List<OrderItem> items) throws SQLException {
        String orderSql = "INSERT INTO orders (buyer_id, status, total_amount, created_at) VALUES (?, ?, ?, ?)";
        String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setLong(1, order.getBuyerId());
                ps.setString(2, order.getStatus().name());
                ps.setBigDecimal(3, order.getTotalAmount());
                ps.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
                ps.executeUpdate();
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        order.setId(keys.getLong(1));
                    }
                }
            }

            try (PreparedStatement ps = conn.prepareStatement(itemSql)) {
                for (OrderItem item : items) {
                    ps.setLong(1, order.getId());
                    ps.setLong(2, item.getProductId());
                    ps.setInt(3, item.getQuantity());
                    ps.setBigDecimal(4, item.getUnitPrice());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            conn.commit();
            return order;
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    @Override
    public List<Order> findByBuyer(Long buyerId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE buyer_id = ? ORDER BY created_at DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, buyerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapRow(rs));
                }
            }
        }
        return orders;
    }

    @Override
    public List<Order> findAll() throws SQLException {
        String sql = "SELECT * FROM orders ORDER BY created_at DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                orders.add(mapRow(rs));
            }
        }
        return orders;
    }

    @Override
    public void updateStatus(Long orderId, Order.Status status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status.name());
            ps.setLong(2, orderId);
            ps.executeUpdate();
        }
    }

    private Order mapRow(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getLong("id"));
        o.setBuyerId(rs.getLong("buyer_id"));
        o.setStatus(Order.Status.valueOf(rs.getString("status")));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return o;
    }
          }
