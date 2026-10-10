package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.Product;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductDAOImpl implements ProductDAO {

    private final DataSource dataSource;

    public ProductDAOImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public List<Product> findAll() throws SQLException {
        String sql = "SELECT * FROM products ORDER BY created_at DESC";
        List<Product> products = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                products.add(mapRow(rs));
            }
        }
        return products;
    }

    @Override
    public List<Product> search(String keyword, String category) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND LOWER(name) LIKE ?");
        }
        if (category != null && !category.isEmpty()) {
            sql.append(" AND category = ?");
        }
        List<Product> products = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(idx++, "%" + keyword.toLowerCase() + "%");
            }
            if (category != null && !category.isEmpty()) {
                ps.setString(idx++, category);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRow(rs));
                }
            }
        }
        return products;
    }

    @Override
    public Optional<Product> findById(Long id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
                return Optional.empty();
            }
        }
    }

    @Override
    public List<Product> findBySeller(Long sellerId) throws SQLException {
        String sql = "SELECT * FROM products WHERE seller_id = ? ORDER BY created_at DESC";
        List<Product> products = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRow(rs));
                }
            }
        }
        return products;
    }

    @Override
    public Product save(Product product) throws SQLException {
        String sql = "INSERT INTO products (seller_id, name, description, price, stock_qty, category, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, product.getSellerId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());
            ps.setBigDecimal(4, product.getPrice());
            ps.setInt(5, product.getStockQty());
            ps.setString(6, product.getCategory());
            ps.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    product.setId(keys.getLong(1));
                }
            }
            return product;
        }
    }

    @Override
    public void update(Product product) throws SQLException {
        String sql = "UPDATE products SET name=?, description=?, price=?, stock_qty=?, category=? WHERE id=?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStockQty());
            ps.setString(5, product.getCategory());
            ps.setLong(6, product.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(Long id) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }

    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getLong("id"));
        p.setSellerId(rs.getLong("seller_id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setStockQty(rs.getInt("stock_qty"));
        p.setCategory(rs.getString("category"));
        p.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return p;
    }
}
