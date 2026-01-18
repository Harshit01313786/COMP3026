<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Registration Form</title>
  <link rel="stylesheet" href="css/style.css" />
  <script src="js/validate.js"></script>
</head>

<body onload="initForm();">
  <h1 class="title">Registration Form</h1>

  <form action="register" method="post" onsubmit="return validateForm();">
    <table class="formTable">
      <tr>
        <td class="label">User id:</td>
        <td><input type="text" id="userId" name="userId" class="smallInput" onkeyup="validateUserId(true);" /></td>
        <td><span id="userIdMsg" class="error">Required and must be of length 5 to 12.</span></td>
      </tr>

      <tr>
        <td class="label">Password:</td>
        <td><input type="password" id="password" name="password" class="smallInput" onkeyup="validatePassword(true);" /></td>
        <td><span id="passwordMsg" class="error">Required and must be of length 7 to 12.</span></td>
      </tr>

      <tr>
        <td class="label">Name:</td>
        <td><input type="text" id="name" name="name" class="longInput" onkeyup="validateName(true);" /></td>
        <td><span id="nameMsg" class="error">Required and alphabates only.</span></td>
      </tr>

      <tr>
        <td class="label">Address:</td>
        <td>
          <input type="text" id="address" name="address" class="longInput" placeholder="Optional." />
        </td>
        <td></td>
      </tr>

      <tr>
        <td class="label">Country:</td>
        <td>
          <select id="country" name="country" class="countrySelect"
                  onchange="updateZipRule(); validateCountry(true);">
            <option value="">(Please select a country)</option>
            <option value="USA">USA</option>
            <option value="India">India</option>
            <option value="Canada">Canada</option>
          </select>
        </td>
        <td><span id="countryMsg" class="error">Required. Must select a country.</span></td>
      </tr>

      <tr>
        <td class="label">ZIP Code:</td>
        <td><input type="text" id="zip" name="zip" class="smallInput" onkeyup="validateZip(true);" /></td>
        <td><span id="zipMsg" class="error">Required. Must be numeric only.</span></td>
      </tr>

      <tr>
        <td class="label">Email:</td>
        <td><input type="text" id="email" name="email" class="longInput" onkeyup="validateEmail(true);" /></td>
        <td><span id="emailMsg" class="error">Required. Must be a valid email.</span></td>
      </tr>

      <tr>
        <td class="label">Sex:</td>
        <td class="inlineRow">
          <label><input type="radio" id="male" name="sex" value="Male" onclick="validateSex(true);" /> Male</label>
          <label><input type="radio" id="female" name="sex" value="Female" onclick="validateSex(true);" /> Female</label>
        </td>
        <td><span id="sexMsg" class="error">Required.</span></td>
      </tr>

      <tr>
        <td class="label">Language:</td>
        <td class="inlineRow">
          <label><input type="checkbox" id="english" name="language" value="English" onclick="validateLanguage(true);" /> English</label>
          <label><input type="checkbox" id="nonEnglish" name="language" value="Non English" onclick="validateLanguage(true);" /> Non English</label>
        </td>
        <td><span id="languageMsg" class="error">Required.</span></td>
      </tr>

      <tr>
        <td class="label aboutLabel">About:</td>
        <td><textarea id="about" name="about" class="aboutBox"></textarea></td>
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