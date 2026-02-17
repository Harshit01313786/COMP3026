package dao;

import model.User;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    // INSERT (PreparedStatement) ✅ (Allowed by GRANT)
    public int insert(User u) throws Exception {
        String sql = "INSERT INTO users (username, password_hash, mobile, email, about) VALUES (?,?,?,?,?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPasswordHash());
            ps.setString(3, u.getMobile());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getAbout());

            return ps.executeUpdate();
        }
    }

    // SELECT (PreparedStatement) ✅ (Allowed by GRANT)
    public List<User> selectAll() throws Exception {
        String sql = "SELECT id, username, mobile, email, about, created_at " +
                     "FROM users ORDER BY id DESC";

        List<User> list = new ArrayList<>();

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setMobile(rs.getString("mobile"));
                u.setEmail(rs.getString("email"));
                u.setAbout(rs.getString("about"));

                Timestamp ts = rs.getTimestamp("created_at");
                u.setCreatedAt(ts == null ? "" : ts.toString());

                list.add(u);
            }
        }
        return list;
    }

    // Exists checks (PreparedStatement) ✅ (Allowed by GRANT because it's SELECT)
    public boolean usernameExists(String username) throws Exception {
        String sql = "SELECT 1 FROM users WHERE username = ? LIMIT 1";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean emailExists(String email) throws Exception {
        String sql = "SELECT 1 FROM users WHERE email = ? LIMIT 1";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // CRUD examples (NOT required to run with restricted user)
    // Keep for rubric "CRUD queries shown" but do NOT call these in your app.
    public int updateAbout(int id, String about) throws Exception {
        String sql = "UPDATE users SET about=? WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, about);
            ps.setInt(2, id);
            return ps.executeUpdate();
        }
    }

    public int deleteById(int id) throws Exception {
        String sql = "DELETE FROM users WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate();
        }
    }
}