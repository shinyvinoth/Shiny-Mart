package com.shiny.shinymart.controller;

import com.shiny.shinymart.dao.UserDAOImpl;
import com.shiny.shinymart.listener.DataSourceListener;
import com.shiny.shinymart.model.User;
import com.shiny.shinymart.service.AuthService;
import com.shiny.shinymart.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() {
        authService = new AuthService(
                new UserDAOImpl(DataSourceListener.getDataSource()));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("REGISTER POST REACHED");

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String roleParam = req.getParameter("role");

        System.out.println("REGISTER: checking form fields");

        if (!ValidationUtil.isNonEmpty(name)
                || !ValidationUtil.isValidEmail(email)
                || !ValidationUtil.isValidPassword(password)) {

            System.out.println("REGISTER: validation failed");

            req.setAttribute("error",
                    "Please fill all fields correctly (password min 8 chars).");

            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        System.out.println("REGISTER: validation passed");

        try {
            User.Role role = "SELLER".equalsIgnoreCase(roleParam)
                    ? User.Role.SELLER
                    : User.Role.BUYER;

            System.out.println("REGISTER: calling authService");

            authService.register(name, email, password, role);

            System.out.println("REGISTER: account created");

            resp.sendRedirect(req.getContextPath() + "/login");

        } catch (IllegalArgumentException e) {

            System.out.println("REGISTER: " + e.getMessage());

            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);

        } catch (SQLException e) {

            e.printStackTrace();

            throw new ServletException(
                    "Database error during registration", e);
        }
    }
            }
