<!DOCTYPE html>
<html>
<head>
    <title>EasyMarket</title>
    <link rel="stylesheet" href="/style.css">
</head>

<body>

<div class="wrapper">

    <div class="header">
        <h1>EasyMarket</h1>
        <div class="nav">
            <a href="/">Home</a>
            <a href="/login">Login</a>
        </div>
    </div>

    <h3>Create account</h3>

    <form action="/registration" method="post">

        <div class="field">
            <span class="label">Username</span>
            <input type="text" name="name">
        </div>

        <div class="field">
            <span class="label">Email</span>
            <input type="text" name="email">
        </div>

        <div class="field">
            <span class="label">Phone number</span>
            <input type="text" name="phoneNumber">
        </div>

        <div class="field">
            <span class="label">Password</span>
            <input type="password" name="password">
        </div>

        <input type="hidden" name="_csrf" value="${_csrf.token}">

        <input type="submit" value="Register">

    </form>

    <#if errorMessage??>
        <div class="notice">
            ${errorMessage}
        </div>
    </#if>

</div>

</body>
</html>