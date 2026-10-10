package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.Review;
import java.sql.SQLException;
import java.util.List;

public interface ReviewDAO {
    List<Review> findByProduct(Long productId) throws SQLException;
    Review save(Review review) throws SQLException;
}
