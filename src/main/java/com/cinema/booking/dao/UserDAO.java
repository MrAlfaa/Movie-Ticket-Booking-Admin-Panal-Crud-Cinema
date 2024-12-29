package com.cinema.booking.dao;

import java.sql.*;
import com.cinema.booking.model.User;
import com.cinema.booking.util.DBConnection;
import com.cinema.booking.util.PasswordHasher;

public class UserDAO {
    private Connection connection;

    public UserDAO() {
        try {
            connection = DBConnection.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("Database connection failed", e);
        }
    }

    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, password, email, phone_number, nic, gender, role) VALUES (?, ?, ?, ?, ?, ?, 'USER')";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, PasswordHasher.hash(user.getPassword()));
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhoneNumber());
            stmt.setString(5, user.getNic());
            stmt.setString(6, user.getGender());

            return stmt.executeUpdate() > 0;
        }
    }

    public User authenticate(String username, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next() && PasswordHasher.verify(password, rs.getString("password"))) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setNic(rs.getString("nic"));
                user.setGender(rs.getString("gender"));
                user.setRole(rs.getString("role"));
                user.setProfileImageUrl(rs.getString("profile_image_url"));
                return user;
            }
        }
        return null;
    }

    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setNic(rs.getString("nic"));
                user.setGender(rs.getString("gender"));
                user.setRole(rs.getString("role"));
                user.setProfileImageUrl(rs.getString("profile_image_url"));
                return user;
            }
        }
        return null;
    }

    public boolean updateUserProfile(User user) throws SQLException {
        String sql = "UPDATE users SET email = ?, phone_number = ?, nic = ?, gender = ?, profile_image_url = ? WHERE user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPhoneNumber());
            stmt.setString(3, user.getNic());
            stmt.setString(4, user.getGender());
            stmt.setString(5, user.getProfileImageUrl());
            stmt.setInt(6, user.getUserId());

            return stmt.executeUpdate() > 0;
        }
    }
}
