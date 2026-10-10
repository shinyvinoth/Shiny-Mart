package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.Product;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface ProductDAO {
    List<Product> findAll() throws SQLException;
    List<Product> search(String keyword, String category) throws SQLException;
    Optional<Product> findById(Long id) throws SQLException;
    List<Product> findBySeller(Long sellerId) throws SQLException;
    Product save(Product product) throws SQLException;
    void update(Product product) throws SQLException;
    void delete(Long id) throws SQLException;
}
