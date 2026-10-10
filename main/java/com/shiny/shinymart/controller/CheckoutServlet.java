package com.shiny.shinymart.controller;

import com.shiny.shinymart.dao.CartDAOImpl;
import com.shiny.shinymart.dao.OrderDAOImpl;
import com.shiny.shinymart.listener.DataSourceListener;
import com.shiny.shinymart.model.CartItem;
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

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderService orderService;
    private CartDAOImpl cartDAO;

    @Override
    public void init() {

        cartDAO = new CartDAOImpl(
                DataSourceListener.getDataSource()
        );

        orderService = new OrderService(
                new OrderDAOImpl(
                        DataSourceListener.getDataSource()
                ),
                cartDAO
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        User user = (User) session.getAttribute("user");

        try {

            List<CartItem> items =
                    cartDAO.findByUser(user.getId());

            if (items.isEmpty()) {
                response.sendRedirect(
                        request.getContextPath() + "/cart"
                );
                return;
            }

            request.setAttribute("items", items);

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to load checkout details", e
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        User user = (User) session.getAttribute("user");

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String address =
                request.getParameter("address");

        String paymentMethod =
                request.getParameter("paymentMethod");

        if (isBlank(fullName)
                || isBlank(email)
                || isBlank(phone)
                || isBlank(address)
                || isBlank(paymentMethod)) {

            request.setAttribute(
                    "error",
                    "Please fill in all checkout fields."
            );

            showCheckout(request, response, user);
            return;
        }

        if (!phone.matches("[0-9]{10}")) {

            request.setAttribute(
                    "error",
                    "Enter a valid 10-digit phone number."
            );

            showCheckout(request, response, user);
            return;
        }

        if (!email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {

            request.setAttribute(
                    "error",
                    "Enter a valid email address."
            );

            showCheckout(request, response, user);
            return;
        }

        if (!"COD".equals(paymentMethod)
                && !"ONLINE".equals(paymentMethod)) {

            request.setAttribute(
                    "error",
                    "Please select a valid payment method."
            );

            showCheckout(request, response, user);
            return;
        }

        try {

            Order savedOrder =
                    orderService.checkout(user.getId());

            session.setAttribute(
                    "lastOrderId",
                    savedOrder.getId()
            );

            response.sendRedirect(
                    request.getContextPath() + "/orders"
            );

        } catch (IllegalStateException e) {

            request.setAttribute("error", e.getMessage());

            showCheckout(request, response, user);

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to save your order", e
            );
        }
    }

    private void showCheckout(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws ServletException, IOException {

        try {

            List<CartItem> items =
                    cartDAO.findByUser(user.getId());

            request.setAttribute("items", items);

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to reload checkout page", e
            );
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
