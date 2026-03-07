<!DOCTYPE html>
<html>
<head>
    <title>EasyMarket</title>
</head>

<body>
<h1>EasyMarket</h1><hr>
<h3>User Details ${user.name}</h3>
<b>Phone number: </b> ${user.phoneNumber}
<b>Email: </b> ${user.email}

<h4>User products ${user.name} </h4>
<#list products as product>
    <div>
        <p>
            <b>${product.title}</b>
            ${product.price} £ |
            <a href="/product/${product.id}">More info...</a>
        </p>
    </div>
    <#else>
    <h3>No products</h3>
</#list>

<#if errorMessage??>
    <h2 style="color: red">{errorMessage}</h2>
</#if>
</body>
</html>