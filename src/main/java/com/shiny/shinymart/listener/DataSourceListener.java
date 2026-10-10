package com.shiny.shinymart.listener;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Statement;

@WebListener
public class DataSourceListener implements ServletContextListener {

    private static HikariDataSource dataSource;
    public static final String ATTRIBUTE_NAME = "dataSource";

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            HikariConfig config = new HikariConfig();

            config.setJdbcUrl("jdbc:h2:mem:shinymart;DB_CLOSE_DELAY=-1");
            config.setDriverClassName("org.h2.Driver");
            config.setUsername("sa");
            config.setPassword("");
            config.setMaximumPoolSize(10);

            dataSource = new HikariDataSource(config);

            runSchema();

            sce.getServletContext().setAttribute(ATTRIBUTE_NAME, dataSource);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database initialization failed", e);
        }
    }

    private void runSchema() throws Exception {
        InputStream input = getClass()
                .getClassLoader()
                .getResourceAsStream("schema.sql");

        if (input == null) {
            throw new RuntimeException("schema.sql not found");
        }

        String sql = new String(
                input.readAllBytes(),
                StandardCharsets.UTF_8
        );

        try (Connection conn = dataSource.getConnection();
             Statement stmt = conn.createStatement()) {

            for (String command : sql.split(";")) {
                if (!command.trim().isEmpty()) {
                    stmt.execute(command.trim());
                }
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (dataSource != null) {
            dataSource.close();
        }
    }

    public static DataSource getDataSource() {
        return dataSource;
    }
}
