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
        </div>
    </div>

    <h3>Admin Panel</h3>

    <table class="admin-table">

        <tr>
            <th>Email</th>
            <th>Phone</th>
            <th>Status</th>
            <th>Roles</th>
            <th>Ban</th>
            <th>Edit</th>
            <th>Details</th>
        </tr>

        <#list users as user>

            <tr>

                <td>${user.email}</td>

                <td>${user.phoneNumber}</td>

                <td>
                    ${user.active?string("Active","Banned")}
                </td>

                <td>
                    <#list user.roles as role>
                        ${role}<#sep>,
                    </#list>
                </td>

                <td>
                    <form action="/admin/user/ban/${user.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Toggle">
                    </form>
                </td>

                <td>
                    <a href="/admin/user/edit/${user.id}">Edit</a>
                </td>

                <td>
                    <a href="/user/${user.id}">View</a>
                </td>

            </tr>

        <#else>

            <tr>
                <td colspan="7">No users</td>
            </tr>

        </#list>

    </table>

</div>

</body>
</html>