package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

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

        String userId = safe(request.getParameter("userId"));
        String password = safe(request.getParameter("password"));
        String name = safe(request.getParameter("name"));
        String address = safe(request.getParameter("address"));
        String country = safe(request.getParameter("country"));
        String zip = safe(request.getParameter("zip"));
        String email = safe(request.getParameter("email"));
        String sex = safe(request.getParameter("sex"));
        String about = safe(request.getParameter("about"));

        // language checkbox can be multiple - but your form is single name "language"
        // in this setup you will get first checked; we’ll join if multiple.
        String[] langs = request.getParameterValues("language");
        String language = "";
        if (langs != null && langs.length > 0) {
            language = String.join(", ", langs);
        }

        User user = new User(userId, password, name, address, country, zip, email, sex, language, about);
        request.setAttribute("user", user);

        RequestDispatcher rd = request.getRequestDispatcher("/success.jsp");
        rd.forward(request, response);
    }
}