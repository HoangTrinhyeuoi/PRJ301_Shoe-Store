<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="LoginServlet" method="post">
        Email: <input type="text" name="email" required> <br>
        Password: <input type="password" name="password" required> <br>
        <input type="submit" value="Login">
    </form>
</body>
</html>
