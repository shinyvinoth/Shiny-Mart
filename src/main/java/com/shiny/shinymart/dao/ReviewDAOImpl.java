package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.Review;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAOImpl implements ReviewDAO {

    private final DataSource dataSource;

    public ReviewDAOImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public List<Review> findByProduct(Long productId) throws SQLException {
        String sql = "SELECT * FROM reviews WHERE product_id = ? ORDER BY created_at DESC";
        List<Review> reviews = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapRow(rs));
                }
            }
        }
        return reviews;
    }

    @Override
    public Review save(Review review) throws SQLException {
        String sql = "INSERT INTO reviews (product_id, user_id, rating, comment, created_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, review.getProductId());
            ps.setLong(2, review.getUserId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            ps.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    review.setId(keys.getLong(1));
                }
            }
            return review;
        }
    }

    private Review mapRow(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setId(rs.getLong("id"));
        r.setProductId(rs.getLong("product_id"));
        r.setUserId(rs.getLong("user_id"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        r.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return r;
    }
}
