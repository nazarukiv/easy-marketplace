<!DOCTYPE html>
<html>
<head>
    <title>EasyMarket</title>
</head>

<body>
<h1>EasyMarket</h1><hr>
<h4>Registration</h4>

<form action="/registration" method="post">

    Username: <input type="text" name="name"><br><br>
    Email: <input type="text" name="email"><br><br>
    Phone number: <input type="text" name="phoneNumber"><br><br>
    Password: <input type="password" name="password"><br><br>

    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Register">

</form>
<#if errorMessage??>
    <h2 style="color: red">{errorMessage}</h2>
</#if>
</body>
</html>