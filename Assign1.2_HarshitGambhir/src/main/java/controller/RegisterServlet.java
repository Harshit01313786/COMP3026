package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import dao.UserDao;
import model.User;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String safe(String v) {
        return v == null ? "" : v.trim();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String userId   = safe(request.getParameter("userId"));
        String password = safe(request.getParameter("password"));
        String name     = safe(request.getParameter("name"));
        String address  = safe(request.getParameter("address"));
        String country  = safe(request.getParameter("country"));
        String zip      = safe(request.getParameter("zip"));
        String email    = safe(request.getParameter("email"));
        String sex      = safe(request.getParameter("sex"));
        String about    = safe(request.getParameter("about"));

        String[] langs = request.getParameterValues("language");
        String language = (langs == null) ? "" : String.join(", ", langs);

        // Build user object (for repopulating the form)
        User user = new User(userId, password, name, address, country, zip, email, sex, language, about);

        // IMPORTANT: index.jsp expects "formUser"
        request.setAttribute("formUser", user);

        // ---- Server-side validation ----
        boolean hasError = false;

        if (userId.length() < 5 || userId.length() > 12) {
            request.setAttribute("userIdError", "User id must be 5 to 12 characters.");
            hasError = true;
        }

        if (password.length() < 7 || password.length() > 12) {
            request.setAttribute("passwordError", "Password must be 7 to 12 characters.");
            hasError = true;
        }

        if (name.isEmpty() || !name.matches("[A-Za-z ]+")) {
            request.setAttribute("nameError", "Name must contain alphabets only.");
            hasError = true;
        }

        if (country.isEmpty()) {
            request.setAttribute("countryError", "Please select a country.");
            hasError = true;
        }

        if (zip.isEmpty()) {
            request.setAttribute("zipError", "ZIP is required.");
            hasError = true;
        } else {
            // Country based ZIP rule
            if ("Canada".equalsIgnoreCase(country)) {
                // A1A 1A1 (space optional)
                if (!zip.matches("^[A-Za-z]\\d[A-Za-z][ ]?\\d[A-Za-z]\\d$")) {
                    request.setAttribute("zipError", "For Canada, ZIP must be alphanumeric (e.g., A1A 1A1).");
                    hasError = true;
                }
            } else {
                if (!zip.matches("^\\d+$")) {
                    request.setAttribute("zipError", "ZIP must be numeric only.");
                    hasError = true;
                }
            }
        }

        if (email.isEmpty() || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            request.setAttribute("emailError", "Enter a valid email.");
            hasError = true;
        }

        if (sex.isEmpty()) {
            request.setAttribute("sexError", "Please select sex.");
            hasError = true;
        }

        if (language.isEmpty()) {
            request.setAttribute("languageError", "Please select language.");
            hasError = true;
        }

        // If validation fails -> back to index.jsp (with values filled)
        if (hasError) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // ---- DB validation + Insert ----
        try {
            UserDao dao = new UserDao();

            if (dao.userIdExists(userId)) {
                request.setAttribute("error", "User ID already exists. Please choose a different User ID.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            if (dao.emailExists(email)) {
                request.setAttribute("error", "Email already exists. Please use a different Email address.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            int rows = dao.insert(user);

            if (rows == 1) {
                // success.jsp expects "user"
                request.setAttribute("user", user);
                request.getRequestDispatcher("/success.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}