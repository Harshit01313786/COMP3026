<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Success</title>
  <style>
    body { font-family: "Times New Roman", serif; padding: 30px; }
    h1 { font-size: 40px; margin-bottom: 10px; }
    table { border-collapse: collapse; margin-top: 15px; }
    td { padding: 8px 12px; border: 1px solid #ccc; vertical-align: top; }
    .k { font-weight: bold; width: 160px; }
  </style>
</head>
<body>

<%
  User u = (User) request.getAttribute("user");
  if (u == null) {
%>
    <h1>No Data Found</h1>
    <p>Session/Request data is missing. Please submit the form first.</p>
<%
    return;
  }

  // Mask password (optional but safer)
  String pw = u.getPassword();
  String masked = (pw == null) ? "" : "*".repeat(Math.min(pw.length(), 12));
%>

<h1>Registration Successful</h1>

<table>
  <tr><td class="k">User id</td><td><%= u.getUserId() %></td></tr>
  <tr><td class="k">Password</td><td><%= masked %></td></tr>
  <tr><td class="k">Name</td><td><%= u.getName() %></td></tr>
  <tr><td class="k">Address</td><td><%= u.getAddress() %></td></tr>
  <tr><td class="k">Country</td><td><%= u.getCountry() %></td></tr>
  <tr><td class="k">ZIP</td><td><%= u.getZip() %></td></tr>
  <tr><td class="k">Email</td><td><%= u.getEmail() %></td></tr>
  <tr><td class="k">Sex</td><td><%= u.getSex() %></td></tr>
  <tr><td class="k">Language</td><td><%= u.getLanguage() %></td></tr>
  <tr><td class="k">About</td><td><%= u.getAbout() %></td></tr>
</table>

</body>
</html>