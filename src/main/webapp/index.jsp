<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Registration Page</title>
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>

<%
  User u = (User) request.getAttribute("formUser");
  if (u == null) u = new User();

  String usernameError = (String) request.getAttribute("usernameError");
  String passwordError = (String) request.getAttribute("passwordError");
  String mobileError   = (String) request.getAttribute("mobileError");
  String emailError    = (String) request.getAttribute("emailError");
  String generalError  = (String) request.getAttribute("generalError");
%>

<div class="pageWrap">
  <div class="title">Registration Page</div>
  <div class="hrLine"></div>

  <% if (generalError != null) { %>
    <div class="err"><%= generalError %></div>
  <% } %>

  <form method="post" action="register">
    <table class="formTable">
      <tr>
        <td class="label">UserName</td>
        <td class="inputCell">
          <input class="textInput" type="text" name="username"
                 value="<%= u.getUsername() == null ? "" : u.getUsername() %>" />
        </td>
        <td class="errorCell err"><%= (usernameError != null ? usernameError : "") %></td>
      </tr>

      <tr>
        <td class="label">Password</td>
        <td class="inputCell">
          <input class="textInput" type="password" name="password" />
        </td>
        <td class="errorCell err"><%= (passwordError != null ? passwordError : "") %></td>
      </tr>

      <tr>
        <td class="label">Mobile Number</td>
        <td class="inputCell">
          <input class="textInput" type="text" name="mobile"
                 value="<%= u.getMobile() == null ? "" : u.getMobile() %>" />
        </td>
        <td class="errorCell err"><%= (mobileError != null ? mobileError : "") %></td>
      </tr>

      <tr>
        <td class="label">Email Id</td>
        <td class="inputCell">
          <input class="textInput" type="text" name="email"
                 value="<%= u.getEmail() == null ? "" : u.getEmail() %>" />
        </td>
        <td class="errorCell err"><%= (emailError != null ? emailError : "") %></td>
      </tr>

      <tr>
        <td class="label">About</td>
        <td class="inputCell">
          <textarea class="bigTextArea" name="about"><%= u.getAbout() == null ? "" : u.getAbout() %></textarea>
        </td>
        <td class="errorCell"></td>
      </tr>

      <tr>
        <td></td>
        <td class="submitRow">
          <button type="submit" class="submitBtn">Submit</button>
        </td>
        <td></td>
      </tr>
    </table>
  </form>

  <div class="note">
    <a href="list">View Stored Data</a>
  </div>
</div>

</body>
</html>