package com.shiny.shinymart.controller;

import com.shiny.shinymart.dao.CartDAOImpl;
import com.shiny.shinymart.dao.OrderDAOImpl;
import com.shiny.shinymart.listener.DataSourceListener;
import com.shiny.shinymart.model.Order;
import com.shiny.shinymart.model.User;
import com.shiny.shinymart.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService(
                new OrderDAOImpl(DataSourceListener.getDataSource()),
                new CartDAOImpl(DataSourceListener.getDataSource())
        );
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (req.getServletPath().equals("/checkout")) {
            try {
                Order order = orderService.checkout(user.getId());
                req.setAttribute("order", order);
                req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
            } catch (IllegalStateException e) {
                req.setAttribute("error", e.getMessage());
                resp.sendRedirect(req.getContextPath() + "/cart");
            } catch (SQLException e) {
                throw new ServletException("Database error during checkout", e);
            }
        } else {
            try {
                List<Order> orders = orderService.buyerHistory(user.getId());
                req.setAttribute("orders", orders);
                req.getRequestDispatcher("/orders.jsp").forward(req, resp);
            } catch (SQLException e) {
                throw new ServletException("Database error loading orders", e);
            }
        }
    }
}
