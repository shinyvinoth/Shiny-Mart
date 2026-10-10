package com.shiny.shinymart.service;

import com.shiny.shinymart.dao.OrderDAO;
import com.shiny.shinymart.dao.ProductDAO;
import com.shiny.shinymart.model.Order;
import com.shiny.shinymart.model.Product;

import java.sql.SQLException;
import java.util.List;

public class AdminService {

    private final ProductDAO productDAO;
    private final OrderDAO orderDAO;

    public AdminService(ProductDAO productDAO, OrderDAO orderDAO) {
        this.productDAO = productDAO;
        this.orderDAO = orderDAO;
    }

    public List<Product> allListings() throws SQLException {
        return productDAO.findAll();
    }

    public List<Order> allOrders() throws SQLException {
        return orderDAO.findAll();
    }

    public void removeListing(Long productId) throws SQLException {
        productDAO.delete(productId);
    }
}
