<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Registration Form</title>
  <link rel="stylesheet" href="css/style.css" />
  <script src="js/validate.js"></script>
</head>

<%
  // User from servlet (repopulating)
  User u = (User) request.getAttribute("user");

  String userId   = (u != null) ? u.getUserId() : "";
  String password = (u != null) ? u.getPassword() : "";
  String name     = (u != null) ? u.getName() : "";
  String address  = (u != null) ? u.getAddress() : "";
  String country  = (u != null) ? u.getCountry() : "";
  String zip      = (u != null) ? u.getZip() : "";
  String email    = (u != null) ? u.getEmail() : "";
  String sex      = (u != null) ? u.getSex() : "";
  String language = (u != null) ? u.getLanguage() : "";
  String about    = (u != null) ? u.getAbout() : "";

  boolean langEnglish = language != null && language.contains("English");
  boolean langNonEng  = language != null && language.contains("Non English");

  // Top DB error (optional)
  String dbError = (String) request.getAttribute("dbError");

  // Field errors from servlet
  String userIdError   = (String) request.getAttribute("userIdError");
  String passwordError = (String) request.getAttribute("passwordError");
  String nameError     = (String) request.getAttribute("nameError");
  String countryError  = (String) request.getAttribute("countryError");
  String zipError      = (String) request.getAttribute("zipError");
  String emailError    = (String) request.getAttribute("emailError");
  String sexError      = (String) request.getAttribute("sexError");
  String languageError = (String) request.getAttribute("languageError");
%>

<body onload="initForm(); updateZipRule();">
  <h1 class="title">Registration Form</h1>

  <% if (dbError != null && !dbError.trim().isEmpty()) { %>
    <div style="color:red; font-weight:bold; text-align:center; margin-bottom:12px;">
      <%= dbError %>
    </div>
  <% } %>

  <form action="register" method="post" onsubmit="return validateForm();">
    <table class="formTable">

      <tr>
        <td class="label">User id:</td>
        <td>
          <input type="text" id="userId" name="userId" class="smallInput"
                 value="<%= userId %>"
                 onkeyup="validateUserId(true);" />
        </td>
        <td>
          <span id="userIdMsg" class="error" style="visibility:<%= (userIdError!=null)?"visible":"hidden" %>;">
            <%= (userIdError!=null)?userIdError:"Required and must be of length 5 to 12." %>
          </span>
        </td>
      </tr>

      <tr>
        <td class="label">Password:</td>
        <td>
          <input type="password" id="password" name="password" class="smallInput"
                 value="<%= password %>"
                 onkeyup="validatePassword(true);" />
        </td>
        <td>
          <span id="passwordMsg" class="error" style="visibility:<%= (passwordError!=null)?"visible":"hidden" %>;">
            <%= (passwordError!=null)?passwordError:"Required and must be of length 7 to 12." %>
          </span>
        </td>
      </tr>

      <tr>
        <td class="label">Name:</td>
        <td>
          <input type="text" id="name" name="name" class="longInput"
                 value="<%= name %>"
                 onkeyup="validateName(true);" />
        </td>
        <td>
          <span id="nameMsg" class="error" style="visibility:<%= (nameError!=null)?"visible":"hidden" %>;">
            <%= (nameError!=null)?nameError:"Required and alphabates only." %>
          </span>
        </td>
      </tr>

      <tr>
        <td class="label">Address:</td>
        <td>
          <input type="text" id="address" name="address" class="longInput"
                 value="<%= address %>"
                 placeholder="Optional." />
        </td>
        <td></td>
      </tr>

      <tr>
        <td class="label">Country:</td>
        <td>
          <select id="country" name="country" class="countrySelect"
                  onchange="updateZipRule(); validateCountry(true);">
            <option value="" <%= (country == null || country.isEmpty()) ? "selected" : "" %>>(Please select a country)</option>
            <option value="USA" <%= "USA".equalsIgnoreCase(country) ? "selected" : "" %>>USA</option>
            <option value="India" <%= "India".equalsIgnoreCase(country) ? "selected" : "" %>>India</option>
            <option value="Canada" <%= "Canada".equalsIgnoreCase(country) ? "selected" : "" %>>Canada</option>
          </select>
        </td>
        <td>
          <span id="countryMsg" class="error" style="visibility:<%= (countryError!=null)?"visible":"hidden" %>;">
            <%= (countryError!=null)?countryError:"Required. Must select a country." %>
          </span>
        </td>
      </tr>

      <tr>
        <td class="label">ZIP Code:</td>
        <td>
          <input type="text" id="zip" name="zip" class="smallInput"
                 value="<%= zip %>"
                 onkeyup="validateZip(true);" />
        </td>
        <td>
          <span id="zipMsg" class="error" style="visibility:<%= (zipError!=null)?"visible":"hidden" %>;">
            <%= (zipError!=null)?zipError:"Required. Must be numeric only." %>
          </span>
        </td>
      </tr>

      <tr>
        <td class="label">Email:</td>
        <td>
          <input type="text" id="email" name="email" class="longInput"
                 value="<%= email %>"
                 onkeyup="validateEmail(true);" />
        </td>
        <td>
          <span id="emailMsg" class="error" style="visibility:<%= (emailError!=null)?"visible":"hidden" %>;">
            <%= (emailError!=null)?emailError:"Required. Must be a valid email." %>
          </span>
        </td>
      </tr>

      <tr>
        <td class="label">Sex:</td>
        <td class="inlineRow">
          <label>
            <input type="radio" id="male" name="sex" value="Male"
                   <%= "Male".equalsIgnoreCase(sex) ? "checked" : "" %>
                   onclick="validateSex(true);" /> Male
          </label>
          <label>
            <input type="radio" id="female" name="sex" value="Female"
                   <%= "Female".equalsIgnoreCase(sex) ? "checked" : "" %>
                   onclick="validateSex(true);" /> Female
          </label>
        </td>
        <td>
          <span id="sexMsg" class="error" style="visibility:<%= (sexError!=null)?"visible":"hidden" %>;">
            <%= (sexError!=null)?sexError:"Required." %>
          </span>
        </td>
      </tr>

      <tr>
        <td class="label">Language:</td>
        <td class="inlineRow">
          <label>
            <input type="checkbox" id="english" name="language" value="English"
                   <%= langEnglish ? "checked" : "" %>
                   onclick="validateLanguage(true);" /> English
          </label>
          <label>
            <input type="checkbox" id="nonEnglish" name="language" value="Non English"
                   <%= langNonEng ? "checked" : "" %>
                   onclick="validateLanguage(true);" /> Non English
          </label>
        </td>
        <td>
          <span id="languageMsg" class="error" style="visibility:<%= (languageError!=null)?"visible":"hidden" %>;">
            <%= (languageError!=null)?languageError:"Required." %>
          </span>
        </td>
      </tr>

      <tr>
        <td class="label aboutLabel">About:</td>
        <td>
          <textarea id="about" name="about" class="aboutBox"><%= about %></textarea>
        </td>
        <td></td>
      </tr>

      <tr>
        <td colspan="3" class="submitRow">
          <input type="submit" value="Submit" class="submitBtn" />
        </td>
      </tr>

    </table>
  </form>
</body>
</html>