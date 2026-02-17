package controller;

import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.HashUtil;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String safe(String v) { return v == null ? "" : v.trim(); }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Optional: keep for testing
        System.out.println("✅ RegisterServlet HIT");

        request.setCharacterEncoding("UTF-8");

        String username = safe(request.getParameter("username"));
        String password = safe(request.getParameter("password"));
        String mobile   = safe(request.getParameter("mobile"));
        String email    = safe(request.getParameter("email"));
        String about    = safe(request.getParameter("about"));

        // keep filled values (except password)
        User formUser = new User();
        formUser.setUsername(username);
        formUser.setMobile(mobile);
        formUser.setEmail(email);
        formUser.setAbout(about);
        request.setAttribute("formUser", formUser);

        boolean hasError = false;

        if (username.isEmpty()) {
            request.setAttribute("usernameError", "UserName can not be Blank");
            hasError = true;
        }

        if (password.isEmpty()) {
            request.setAttribute("passwordError", "password should not be Blank");
            hasError = true;
        }

        if (mobile.isEmpty()) {
            request.setAttribute("mobileError", "Mobile Number can not be Blank");
            hasError = true;
        } else if (!mobile.matches("^\\d{10,15}$")) {
            request.setAttribute("mobileError", "Enter Valid Number");
            hasError = true;
        }

        if (email.isEmpty()) {
            request.setAttribute("emailError", "Email Field can not be Blank");
            hasError = true;
        } else if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            request.setAttribute("emailError", "Enter valid Email Id");
            hasError = true;
        }

        if (hasError) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        try {
            UserDao dao = new UserDao();

            if (dao.usernameExists(username)) {
                request.setAttribute("usernameError", "User already exists");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            if (dao.emailExists(email)) {
                request.setAttribute("emailError", "Email already exists");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            User saved = new User();
            saved.setUsername(username);
            saved.setMobile(mobile);
            saved.setEmail(email);
            saved.setAbout(about);

            // store hash only
            saved.setPasswordHash(HashUtil.sha256(password));

            int rows = dao.insert(saved);

            if (rows == 1) {
                request.setAttribute("savedUser", saved);
                request.getRequestDispatcher("/success.jsp").forward(request, response);
            } else {
                request.setAttribute("generalError", "Insert failed. Try again.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("generalError", "DB Error: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}