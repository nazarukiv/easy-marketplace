<!DOCTYPE html>
<html>
<head>
    <title>Edit product</title>
    <link rel="stylesheet" href="/style.css">
</head>

<body>

<div class="wrapper">

    <div class="header">
        <h1>EasyMarket</h1>
        <div class="nav">
            <a href="/">Home</a>
            <a href="/product/${product.id}">Back</a>
        </div>
    </div>

    <h3>Edit product</h3>

    <form action="/product/edit/${product.id}" method="post">

        <div class="field">
            <span class="label">Title</span>
            <input type="text" name="title" value="${product.title}">
        </div>

        <div class="field">
            <span class="label">Description</span>
            <input type="text" name="description" value="${product.description}">
        </div>

        <div class="field">
            <span class="label">City</span>
            <input type="text" name="city" value="${product.city}">
        </div>

        <div class="field">
            <span class="label">Price</span>
            <input type="number" name="price" value="${product.price}">
        </div>

        <input type="hidden" name="_csrf" value="${_csrf.token}">

        <input type="submit" value="Save changes">

    </form>

</div>

</body>
</html>