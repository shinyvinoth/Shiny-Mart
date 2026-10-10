package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.Order;
import com.shiny.shinymart.model.OrderItem;
import java.sql.SQLException;
import java.util.List;

public interface OrderDAO {
    Order createOrder(Order order, List<OrderItem> items) throws SQLException;
    List<Order> findByBuyer(Long buyerId) throws SQLException;
    List<Order> findAll() throws SQLException;
    void updateStatus(Long orderId, Order.Status status) throws SQLException;
}
