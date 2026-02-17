package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    
    private static final String URL =
        "jdbc:mysql://localhost:3306/comp3026_w2026_hg"
        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    // restricted GRANT user (NOT root)
    private static final String USER = "comp3026_w2026_hg";

    
    private static final String PASS = "Test@123";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver missing", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}