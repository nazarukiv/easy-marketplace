<!DOCTYPE html>
<html>
<head>
    <title>EasyMarket</title>
</head>

<body>
<h1>EasyMarket</h1><hr>
<h4>Products</h4>

<form action="/" method="get">
    Search by title:
    <input type="text" name="title"><br>
    <input type="submit" value="Search">
</form>


<#list products as product>
    <div>
        <p>
            <b>${product.title}</b>
            ${product.price} £ |
            <a href="/product/${product.id}">More info...</a>
        </p>
    </div>
<#else>
    <h3>No products found</h3>
</#list>

<hr>

<h3>Create new product</h3>
<form action="/product/create" method="post">
    Title: <input type="text" name="title"/><br><br>
    Description: <input type="text" name="description"/><br><br>
    City: <input type="text" name="city"/><br><br>
    Price: <input type="number" name="price"/><br><br>
    Author: <input type="text" name="author"/><br><br>
    <input type="submit" value="Add product"/>
</form>

</body>
</html>