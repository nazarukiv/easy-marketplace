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

            <div class="gallery">

                <img id="mainImage" src="/images/${product.images[0].id}" width="350">

                <div style="margin-top:10px;">

                    <#list product.images as img>

                        <img src="/images/${img.id}"
                             width="70"
                             style="margin-right:6px; cursor:pointer;"
                             onclick="changeImage('/images/${img.id}')">

                    </#list>

                </div>

            </div>

        </#if>

        <p>
            Price: £${product.price}
        </p>

        <p>
            Category: ${(product.category.name)!'No category'}
        </p>

        <p>
            Views: ${product.views}
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


        <p>
            Posted:
            ${product.dateCreated?datetime("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")?string("yyyy-MM-dd HH:mm")}
        </p>

        <#if user?? && user.id?? && product.user.id == user.id>

            <p>
                <a href="/product/edit/${product.id}">
                    <button type="button">Edit product</button>
                </a>
            </p>

            <p>
                <a href="/product/delete-confirm/${product.id}">
                    <button type="button">Delete product</button>
                </a>
            </p>

        </#if>

    </#if>

</div>

<script>

    function changeImage(src){
        document.getElementById("mainImage").src = src;
    }

</script>

</body>
</html>