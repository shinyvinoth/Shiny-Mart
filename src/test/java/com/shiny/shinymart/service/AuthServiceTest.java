package com.shiny.shinymart.service;

import com.shiny.shinymart.dao.UserDAO;
import com.shiny.shinymart.model.User;
import com.shiny.shinymart.util.PasswordUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class AuthServiceTest {

    private UserDAO userDAO;
    private AuthService authService;

    @BeforeEach
    void setUp() {
        userDAO = mock(UserDAO.class);
        authService = new AuthService(userDAO);
    }

    @Test
    void loginSucceedsWithCorrectPassword() throws Exception {
        User user = new User();
        user.setEmail("a@b.com");
        user.setPasswordHash(PasswordUtil.hash("password123"));
        when(userDAO.findByEmail("a@b.com")).thenReturn(Optional.of(user));

        Optional<User> result = authService.login("a@b.com", "password123");
        assertTrue(result.isPresent());
    }

    @Test
    void loginFailsWithWrongPassword() throws Exception {
        User user = new User();
        user.setEmail("a@b.com");
        user.setPasswordHash(PasswordUtil.hash("password123"));
        when(userDAO.findByEmail("a@b.com")).thenReturn(Optional.of(user));

        Optional<User> result = authService.login("a@b.com", "wrongpass");
        assertFalse(result.isPresent());
    }

    @Test
    void registerThrowsWhenEmailAlreadyExists() throws Exception {
        when(userDAO.findByEmail("a@b.com")).thenReturn(Optional.of(new User()));

        assertThrows(IllegalArgumentException.class, () ->
                authService.register("Name", "a@b.com", "password123", User.Role.BUYER));
    }
  }
