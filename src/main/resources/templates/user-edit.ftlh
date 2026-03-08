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
            <a href="/admin">Admin</a>
        </div>
    </div>

    <h3>Edit user ${user.name}</h3>

    <form action="/admin/user/edit" method="post">

        <#list roles as role>

            <div class="field">

                <label>

                    <input type="checkbox"
                           name="${role}"
                            ${user.roles?seq_contains(role)?string("checked","")}>

                    ${role}

                </label>

            </div>

        </#list>

        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">

        <input type="submit" value="Save">

    </form>

</div>

</body>
</html>