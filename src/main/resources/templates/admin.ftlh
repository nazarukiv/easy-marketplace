<!DOCTYPE html>
<html>
<head>
    <title>EasyMarket</title>
</head>

<body>
<h1>EasyMarket</h1>
<hr>

<h4>Admin Panel</h4>

<table border="1">
    <tr>
        <th>Email</th>
        <th>Phone</th>
        <th>Active</th>
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
                    <input type="submit" value="Toggle ban">
                </form>
            </td>

            <td>
                <a href="/admin/user/edit/${user.id}">Edit</a>
            </td>

            <td>
                <a href="/user/${user.id}">Details</a>
            </td>

        </tr>
    <#else>
        <h3>No users found</h3>
    </#list>
</table>

</body>
</html>