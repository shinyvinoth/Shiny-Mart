package com.shiny.shinymart.controller;

import com.shiny.shinymart.dao.OrderDAOImpl;
import com.shiny.shinymart.dao.ProductDAOImpl;
import com.shiny.shinymart.listener.DataSourceListener;
import com.shiny.shinymart.model.User;
import com.shiny.shinymart.service.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    private AdminService adminService;

    @Override
    public void init() {
        adminService = new AdminService(
                new ProductDAOImpl(DataSourceListener.getDataSource()),
                new OrderDAOImpl(DataSourceListener.getDataSource())
        );
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user.getRole() != User.Role.ADMIN) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            req.setAttribute("products", adminService.allListings());
            req.setAttribute("orders", adminService.allOrders());
            req.getRequestDispatcher("/admin.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Database error loading admin panel", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user.getRole() != User.Role.ADMIN) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Long productId = Long.valueOf(req.getParameter("productId"));
        try {
            adminService.removeListing(productId);
            resp.sendRedirect(req.getContextPath() + "/admin");
        } catch (SQLException e) {
            throw new ServletException("Database error removing listing", e);
        }
    }
            }
