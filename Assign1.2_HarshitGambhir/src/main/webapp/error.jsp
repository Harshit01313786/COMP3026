<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Error</title>

    <style>
        body {
            font-family: "Times New Roman", serif;
            background: #ffffff;
            padding: 40px;
        }
        h1 {
            color: #b00000;
            font-size: 42px;
        }
        .box {
            margin-top: 25px;
            padding: 20px;
            border: 2px solid #b00000;
            background: #fff5f5;
            width: 600px;
        }
        .msg {
            font-size: 20px;
            font-weight: bold;
            color: #000;
            margin-bottom: 20px;
        }
        a {
            font-size: 18px;
            text-decoration: none;
            color: #0044cc;
        }
    </style>
</head>

<body>

<h1>Registration Failed</h1>

<div class="box">
    <div class="msg">
        <%
            String error = (String) request.getAttribute("error");
            if (error != null && !error.trim().isEmpty()) {
                out.print(error);
            } else {
                out.print("User already exists in the database.");
            }
        %>
    </div>

    <a href="index.jsp">← Go back to Registration Form</a>
</div>

</body>
</html>