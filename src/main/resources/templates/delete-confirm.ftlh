<!DOCTYPE html>
<html>
<head>
    <title>Delete product</title>
</head>

<body>

<h2>Are you sure you want to delete this product?</h2>

<p>
    <b>${product.title}</b>
</p>

<form action="/product/delete/${product.id}" method="post">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <button type="submit">Yes, delete</button>
</form>

<br>

<a href="/product/${product.id}">Cancel</a>

</body>
</html>