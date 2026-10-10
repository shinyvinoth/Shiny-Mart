package com.shiny.shinymart.controller;

import com.shiny.shinymart.dao.UserDAOImpl;
import com.shiny.shinymart.listener.DataSourceListener;
import com.shiny.shinymart.model.User;
import com.shiny.shinymart.service.AuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet(urlPatterns = {"/login"})
public class AuthServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() {
        authService = new AuthService(new UserDAOImpl(DataSourceListener.getDataSource()));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Optional<User> userOpt = authService.login(email, password);
            System.out.println("LOGIN EMAIL: " + email);
            System.out.println("LOGIN USER FOUND: " + userOpt.isPresent());
            if (userOpt.isPresent()) {
                req.getSession().invalidate();
                HttpSession session = req.getSession(true);
                session.setAttribute("user", userOpt.get());
                session.setMaxInactiveInterval(30 * 60);
                resp.sendRedirect(req.getContextPath() + "/home.jsp");
            } else {
                req.setAttribute("error", "Invalid email or password");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error during login", e);
        }
    }
}
