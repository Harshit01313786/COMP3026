package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;
import util.DBUtil;

public class UserDao {

    public boolean userIdExists(String userId) throws Exception {
        String sql = "SELECT 1 FROM registration WHERE user_id = ? LIMIT 1";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean emailExists(String email) throws Exception {
        String sql = "SELECT 1 FROM registration WHERE email = ? LIMIT 1";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public int insert(User u) throws Exception {
        String sql = "INSERT INTO registration " +
                "(user_id, password, name, address, country, zip, email, sex, language, about) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getUserId());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getName());
            ps.setString(4, u.getAddress());
            ps.setString(5, u.getCountry());
            ps.setString(6, u.getZip());
            ps.setString(7, u.getEmail());
            ps.setString(8, u.getSex());
            ps.setString(9, u.getLanguage());
            ps.setString(10, u.getAbout());

            return ps.executeUpdate(); // 1 = success
        }
    }
}