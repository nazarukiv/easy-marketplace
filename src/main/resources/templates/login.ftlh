<!DOCTYPE html>
<html>
<head>
    <title>EasyMarket</title>
    <link rel="stylesheet" href="/style.css">
</head>

<body>

<div class="wrapper">

    <h1>EasyMarket</h1>

    <h3>Login</h3>

    <form action="/login" method="post">

        Email<br>
        <input type="text" name="username"><br><br>

        Password<br>
        <input type="password" name="password"><br><br>

        <input type="hidden" name="_csrf" value="${_csrf.token}">

        <input type="submit" value="Login">

    </form>

    <a href="/registration">Create account</a>

</div>

</body>
</html>