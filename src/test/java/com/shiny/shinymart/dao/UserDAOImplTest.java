package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.User;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.Statement;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

class UserDAOImplTest {

    private HikariDataSource dataSource;
    private UserDAO userDAO;

    @BeforeEach
    void setUp() throws Exception {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:h2:mem:test;DB_CLOSE_DELAY=-1");
        config.setDriverClassName("org.h2.Driver");
        dataSource = new HikariDataSource(config);

        try (Connection conn = dataSource.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute("CREATE TABLE IF NOT EXISTS users (id BIGINT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(100), email VARCHAR(150) UNIQUE, password_hash VARCHAR(255), " +
                    "role VARCHAR(10), created_at TIMESTAMP)");
        }
        userDAO = new UserDAOImpl(dataSource);
    }

    @AfterEach
    void tearDown() {
        dataSource.close();
    }

    @Test
    void savesAndFindsUserByEmail() throws Exception {
        User user = new User();
        user.setName("Test User");
        user.setEmail("test@shinymart.com");
        user.setPasswordHash("hashed");
        user.setRole(User.Role.BUYER);

        userDAO.save(user);

        Optional<User> found = userDAO.findByEmail("test@shinymart.com");
        assertTrue(found.isPresent());
        assertEquals("Test User", found.get().getName());
    }

    @Test
    void returnsEmptyWhenEmailNotFound() throws Exception {
        Optional<User> found = userDAO.findByEmail("nobody@shinymart.com");
        assertFalse(found.isPresent());
    }
}
