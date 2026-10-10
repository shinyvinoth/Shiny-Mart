package com.shiny.shinymart.dao;

import com.shiny.shinymart.model.User;
import java.sql.SQLException;
import java.util.Optional;

public interface UserDAO {
    Optional<User> findByEmail(String email) throws SQLException;
    User save(User user) throws SQLException;
}
