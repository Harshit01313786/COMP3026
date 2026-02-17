<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Success</title>
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>
  <div class="pageWrap">
    <div class="title">Registration Successful</div>
    <div class="hrLine"></div>

    <%
      User u = (User) request.getAttribute("savedUser");
      if (u == null) {
        response.sendRedirect("error.jsp");
        return;
      }
    %>

    <table class="formTable">
      <tr><td class="label">UserName</td><td class="inputCell"><%= u.getUsername() %></td><td></td></tr>
      <tr><td class="label">Mobile</td><td class="inputCell"><%= u.getMobile() %></td><td></td></tr>
      <tr><td class="label">Email</td><td class="inputCell"><%= u.getEmail() %></td><td></td></tr>
      <tr><td class="label">About</td><td class="inputCell"><%= u.getAbout() %></td><td></td></tr>
      <tr><td class="label">Stored As</td><td class="inputCell">Password saved as SHA-256 hash</td><td></td></tr>
    </table>

    <div class="note">
      <a href="index.jsp">Back</a> | <a href="list">View DB Records</a>
    </div>
  </div>
</body>
</html>