package com.shiny.shinymart.controller;

import com.shiny.shinymart.dao.ProductDAOImpl;
import com.shiny.shinymart.listener.DataSourceListener;
import com.shiny.shinymart.model.Product;
import com.shiny.shinymart.model.User;
import com.shiny.shinymart.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService(
                new ProductDAOImpl(
                        DataSourceListener.getDataSource()
                )
        );
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("user") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );
            return;
        }

        User user =
                (User) session.getAttribute("user");

        // Only seller
        if (user.getRole() != User.Role.SELLER) {

            resp.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only sellers can edit products."
            );
            return;
        }

        String idParameter = req.getParameter("id");

        if (idParameter == null ||
                idParameter.isEmpty()) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Product ID is missing."
            );
            return;
        }

        try {

            Long productId =
                    Long.parseLong(idParameter);

            Optional<Product> result =
                    productService
                            .getById(productId);

            if (!result.isPresent()) {

                resp.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found."
                );
                return;
            }

            Product product = result.get();

            // Seller can edit only own product
            if (!product.getSellerId()
                    .equals(user.getId())) {

                resp.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "You can edit only your own products."
                );
                return;
            }

            req.setAttribute("product", product);

            req.getRequestDispatcher(
                    "/edit-product.jsp"
            ).forward(req, resp);

        } catch (NumberFormatException e) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID."
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Database error loading product.",
                    e
            );
        }
    }
  }
