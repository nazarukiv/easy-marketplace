<!DOCTYPE html>
<html>
<head>
    <title>EasyMarket</title>
</head>

<body>
<h1>EasyMarket</h1><hr>
<h4>Login</h4>

<form action="/login" method="post">
    Email: <input type="text" name="username"><br><br>
    Password: <input type="password" name="password"><br><br>

    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Login">
</form>

<a href="/registration">Create account</a>

</body>
</html>