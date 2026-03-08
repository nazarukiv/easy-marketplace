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

    <h3>User profile</h3>

    <div class="meta">
        <strong>Name</strong> ${user.name}
    </div>

    <div class="meta">
        <strong>Email</strong> ${user.email}
    </div>

    <div class="meta">
        <strong>Phone</strong> ${user.phoneNumber}
    </div>

    <h3>Products</h3>

    <#list products as product>

        <div class="product">

            <div class="product-title">
                ${product.title}
            </div>

            <#if product.previewImageId??>
                <img src="/images/${product.previewImageId}">
            </#if>

            <div class="meta">
                <strong>Price</strong> £${product.price}
            </div>

            <div class="meta">
                <a href="/product/${product.id}">Open product</a>
            </div>

        </div>

    <#else>

        <div class="notice">
            No products
        </div>

    </#list>

</div>

</body>
</html>