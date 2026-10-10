package com.shiny.shinymart.controller;

import com.shiny.shinymart.dao.ReviewDAOImpl;
import com.shiny.shinymart.listener.DataSourceListener;
import com.shiny.shinymart.model.Review;
import com.shiny.shinymart.model.User;
import com.shiny.shinymart.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {

    private ReviewService reviewService;

    @Override
    public void init() {
        reviewService = new ReviewService(
                new ReviewDAOImpl(
                        DataSourceListener.getDataSource()
                )
        );
    }

    // Open review page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Check login
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String productIdParameter = req.getParameter("productId");

        if (productIdParameter == null || productIdParameter.isEmpty()) {
            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Product ID is missing."
            );
            return;
        }

        try {

            Long productId = Long.parseLong(productIdParameter);

            // Get existing reviews
            List<Review> reviews =
                    reviewService.getReviews(productId);

            // Send data to JSP
            req.setAttribute("productId", productId);
            req.setAttribute("reviews", reviews);

            // Open review.jsp
            req.getRequestDispatcher("/review.jsp")
                    .forward(req, resp);

        } catch (NumberFormatException e) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID."
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Database error loading reviews.",
                    e
            );
        }
    }

    // Submit review
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Check login
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String productIdParameter = req.getParameter("productId");
        String ratingParameter = req.getParameter("rating");
        String comment = req.getParameter("comment");

        try {

            if (productIdParameter == null || ratingParameter == null) {
                resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Product ID and rating are required."
                );
                return;
            }

            Long productId = Long.parseLong(productIdParameter);
            int rating = Integer.parseInt(ratingParameter);

            // Save review
            reviewService.addReview(
                    productId,
                    user.getId(),
                    rating,
                    comment
            );

            // Return to review page
            resp.sendRedirect(
                    req.getContextPath()
                            + "/reviews?productId="
                            + productId
            );

        } catch (NumberFormatException e) {

            req.setAttribute(
                    "error",
                    "Invalid product ID or rating."
            );

            req.setAttribute(
                    "productId",
                    productIdParameter
            );

            req.getRequestDispatcher("/review.jsp")
                    .forward(req, resp);

        } catch (IllegalArgumentException e) {

            req.setAttribute(
                    "error",
                    e.getMessage()
            );

            req.setAttribute(
                    "productId",
                    productIdParameter
            );

            req.getRequestDispatcher("/review.jsp")
                    .forward(req, resp);

        } catch (SQLException e) {

            throw new ServletException(
                    "Database error saving review.",
                    e
            );
        }
    }
                }
