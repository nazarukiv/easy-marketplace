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

    <#if product??>

        <h2>${product.title}</h2>

        <#if product.images?size gt 0>
            <img src="/images/${product.images[0].id}">
        </#if>

        <p>
            Price: £${product.price}
        </p>

        <p>
            City: ${product.city}
        </p>

        <p>
            ${product.description}
        </p>

        <p>
            Seller:
            <a href="/user/${product.user.id}">
                ${product.user.name}
            </a>
        </p>

    </#if>

</div>

</body>
</html>