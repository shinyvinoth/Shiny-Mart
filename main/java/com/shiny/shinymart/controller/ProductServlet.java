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
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService(
                new ProductDAOImpl(
                        DataSourceListener.getDataSource()
                )
        );
    }

    // =========================
    // GET - VIEW PRODUCTS
    // =========================
    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");

        try {

            List<Product> products =
                    productService.browse(keyword, category);

            req.setAttribute("products", products);

            req.getRequestDispatcher("/products.jsp")
                    .forward(req, resp);

        } catch (SQLException e) {

            throw new ServletException(
                    "Database error loading products", e);
        }
    }

    // =========================
    // POST - ADD / EDIT / DELETE
    // =========================
    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

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

        // Only SELLER can modify products
        if (user.getRole() != User.Role.SELLER) {

            resp.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only sellers can manage products."
            );
            return;
        }

        String action = req.getParameter("action");

        try {

            // =========================
            // ADD PRODUCT
            // =========================
            if ("add".equals(action)) {

                Product product = new Product();

                product.setSellerId(user.getId());
                product.setName(
                        req.getParameter("name")
                );
                product.setDescription(
                        req.getParameter("description")
                );
                product.setPrice(
                        new BigDecimal(
                                req.getParameter("price")
                        )
                );
                product.setStockQty(
                        Integer.parseInt(
                                req.getParameter("stockQty")
                        )
                );
                product.setCategory(
                        req.getParameter("category")
                );

                productService.create(product);

            }

            // =========================
            // EDIT PRODUCT
            // =========================
            else if ("edit".equals(action)) {

                Long productId =
                        Long.parseLong(
                                req.getParameter("id")
                        );

                Product product =
                        productService
                                .listBySeller(user.getId())
                                .stream()
                                .filter(p ->
                                        p.getId()
                                                .equals(productId))
                                .findFirst()
                                .orElse(null);

                // Product does not belong to this seller
                if (product == null) {

                    resp.sendError(
                            HttpServletResponse.SC_FORBIDDEN,
                            "You can edit only your own products."
                    );
                    return;
                }

                product.setName(
                        req.getParameter("name")
                );

                product.setDescription(
                        req.getParameter("description")
                );

                product.setPrice(
                        new BigDecimal(
                                req.getParameter("price")
                        )
                );

                product.setStockQty(
                        Integer.parseInt(
                                req.getParameter("stockQty")
                        )
                );

                product.setCategory(
                        req.getParameter("category")
                );

                productService.update(product);
            }

            // =========================
            // DELETE PRODUCT
            // =========================
            else if ("delete".equals(action)) {

                Long productId =
                        Long.parseLong(
                                req.getParameter("id")
                        );

                Product product =
                        productService
                                .listBySeller(user.getId())
                                .stream()
                                .filter(p ->
                                        p.getId()
                                                .equals(productId))
                                .findFirst()
                                .orElse(null);

                // Product does not belong to this seller
                if (product == null) {

                    resp.sendError(
                            HttpServletResponse.SC_FORBIDDEN,
                            "You can delete only your own products."
                    );
                    return;
                }

                productService.delete(productId);
            }

            else {

                resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product action."
                );
                return;
            }

            // Back to products
            resp.sendRedirect(
                    req.getContextPath() + "/products"
            );

        } catch (NumberFormatException e) {

            throw new ServletException(
                    "Invalid product ID, price or stock quantity.",
                    e
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Database error managing product.",
                    e
            );
        }
    }
            }
