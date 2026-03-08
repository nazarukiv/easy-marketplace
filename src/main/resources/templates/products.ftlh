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

            <#if user?? && user.email??>
                <a href="/user/${user.id}">Profile</a>

                <form action="/logout" method="post" class="inline-form">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Logout">
                </form>

            <#else>
                <a href="/login">Login</a>
                <a href="/registration">Register</a>
            </#if>

        </div>
    </div>


    <h3>Search</h3>

    <form action="/" method="get">

        <div class="field">
            <span class="label">Title</span>
            <input type="text" name="title">
        </div>

        <input type="submit" value="Search">

    </form>


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
                <strong>City</strong> ${product.city}
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


    <#if user.email??>

        <div class="form-block">

            <h3>Create product</h3>

            <form action="/product/create" method="post" enctype="multipart/form-data">

                <div class="field">
                    <span class="label">Title</span>
                    <input type="text" name="title">
                </div>

                <div class="field">
                    <span class="label">Description</span>
                    <input type="text" name="description">
                </div>

                <div class="field">
                    <span class="label">City</span>
                    <input type="text" name="city">
                </div>

                <div class="field">
                    <span class="label">Price</span>
                    <input type="number" name="price">
                </div>

                <div class="field">
                    <span class="label">Photo 1</span>
                    <input type="file" name="file1">
                </div>

                <div class="field">
                    <span class="label">Photo 2</span>
                    <input type="file" name="file2">
                </div>

                <div class="field">
                    <span class="label">Photo 3</span>
                    <input type="file" name="file3">
                </div>

                <input type="hidden" name="_csrf" value="${_csrf.token}">

                <input type="submit" value="Add product">

            </form>

        </div>

    </#if>

</div>

</body>
</html>