<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Stored Users</title>
  <link rel="stylesheet" href="css/style.css" />
  <style>
    table.grid { width: 100%; border-collapse: collapse; margin-top: 10px; }
    table.grid td, table.grid th { border: 1px solid #ccc; padding: 8px; }
    table.grid th { background: #f2f2f2; }
  </style>
</head>
<body>
  <div class="pageWrap">
    <div class="title">Stored Users (SELECT)</div>
    <div class="hrLine"></div>

    <%
      @SuppressWarnings("unchecked")
      List<User> list = (List<User>) request.getAttribute("users");
      if (list == null) list = new ArrayList<>();
    %>

    <table class="grid">
      <tr>
        <th>ID</th><th>Username</th><th>Mobile</th><th>Email</th><th>About</th><th>Created</th>
      </tr>
      <% for (User u : list) { %>
        <tr>
          <td><%= u.getId() %></td>
          <td><%= u.getUsername() %></td>
          <td><%= u.getMobile() %></td>
          <td><%= u.getEmail() %></td>
          <td><%= u.getAbout() %></td>
          <td><%= u.getCreatedAt() %></td>
        </tr>
      <% } %>
    </table>

    <div class="note">
      <a href="index.jsp">Back</a>
    </div>
  </div>
</body>
</html>