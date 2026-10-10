package com.shiny.shinymart.service;

import com.shiny.shinymart.dao.ReviewDAO;
import com.shiny.shinymart.model.Review;

import java.sql.SQLException;
import java.util.List;

public class ReviewService {

    private final ReviewDAO reviewDAO;

    public ReviewService(ReviewDAO reviewDAO) {
        this.reviewDAO = reviewDAO;
    }

    public List<Review> getReviews(Long productId) throws SQLException {
        return reviewDAO.findByProduct(productId);
    }

    public Review addReview(Long productId, Long userId, int rating, String comment) throws SQLException {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
        Review review = new Review();
        review.setProductId(productId);
        review.setUserId(userId);
        review.setRating(rating);
        review.setComment(comment);
        return reviewDAO.save(review);
    }
}
