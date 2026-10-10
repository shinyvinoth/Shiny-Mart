
package com.shiny.shinymart.service;

import com.shiny.shinymart.dao.ProductDAO;
import com.shiny.shinymart.model.Product;
import com.shiny.shinymart.util.ValidationUtil;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class ProductService {

    private final ProductDAO productDAO;

    public ProductService(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    // Browse / Search products
    public List<Product> browse(String keyword, String category)
            throws SQLException {

        return productDAO.search(keyword, category);
    }

    // Create product
    public Product create(Product product)
            throws SQLException {

        if (!ValidationUtil.isNonEmpty(product.getName())
                || !ValidationUtil.isPositive(product.getPrice())) {

            throw new IllegalArgumentException(
                    "Product name and a positive price are required"
            );
        }

        return productDAO.save(product);
    }

    // Find product by ID
    public Optional<Product> getById(Long id)
            throws SQLException {

        return productDAO.findById(id);
    }

    // Update product
    public void update(Product product)
            throws SQLException {

        productDAO.update(product);
    }

    // Delete product
    public void delete(Long id)
            throws SQLException {

        productDAO.delete(id);
    }

    // List products belonging to a seller
    public List<Product> listBySeller(Long sellerId)
            throws SQLException {

        return productDAO.findBySeller(sellerId);
    }
}
