<!DOCTYPE html>
<html>
<head>
    <title>
        EasyMarket
    </title>
</head>

<body>
<h1>EasyMarket</h1><hr>
<h4>Detailed information about product:</h4>
<#if product??>
    <#if product.images?size gt 0>
        <img src="/images/${product.images[0].id}" height="60px"><br><br>
    </#if>

    <#if product.images?size gt 1>
        <img src="/images/${product.images[1].id}" height="60px"><br><br>
    </#if>

    <#if product.images?size gt 2>
        <img src="/images/${product.images[2].id}" height="60px"><br><br>
    </#if>

    <b>Title: </b> ${product.title}<br>
    <b>Description: </b> ${product.description}<br>
    <b>City: </b> ${product.city}<br>
    <b>Price: </b> ${product.price}<br>
    <b>Author: </b> ${product.author}<br>
</#if>

<h3>Create new product</h3>
<form action="/product/delete/${product.id}" method="post">
    <input type="submit" value="Delete product"/>
</form>
</body>
</html>
