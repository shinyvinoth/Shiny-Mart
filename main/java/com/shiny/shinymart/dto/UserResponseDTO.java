package com.shiny.shinymart.dto;

import com.shiny.shinymart.model.User;

/** Never includes passwordHash — see Section 13, rule 4. */
public class UserResponseDTO {
    private Long id;
    private String name;
    private String email;
    private String role;

    public UserResponseDTO(User user) {
        this.id = user.getId();
        this.name = user.getName();
        this.email = user.getEmail();
        this.role = user.getRole().name();
    }

    public Long getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getRole() { return role; }
}
