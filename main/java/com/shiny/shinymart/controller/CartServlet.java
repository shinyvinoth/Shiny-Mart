package com.shiny.shinymart.controller;

import com.shiny.shinymart.dao.CartDAOImpl;
import com.shiny.shinymart.listener.DataSourceListener;
import com.shiny.shinymart.model.CartItem;
import com.shiny.shinymart.model.User;
import com.shiny.shinymart.service.CartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private CartService cartService;

    @Override
    public void init() {
        cartService = new CartService(new CartDAOImpl(DataSourceListener.getDataSource()));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        try {
            List<CartItem> items = cartService.viewCart(user.getId());
            req.setAttribute("items", items);
            req.getRequestDispatcher("/cart.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Database error loading cart", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Long productId = Long.valueOf(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        try {
            cartService.addItem(user.getId(), productId, quantity);
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (SQLException e) {
            throw new ServletException("Database error updating cart", e);
        }
    }
}
