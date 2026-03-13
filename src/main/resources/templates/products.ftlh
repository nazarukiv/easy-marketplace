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
            <input type="text" name="title" value="${title!}">
        </div>

        <div class="field">
            <span class="label">Min price</span>
            <input type="number" name="minPrice" value="${minPrice!}">
        </div>

        <div class="field">
            <span class="label">Max price</span>
            <input type="number" name="maxPrice" value="${maxPrice!}">
        </div>

        <div class="field">
            <span class="label">City</span>
            <input type="text" name="city" value="${city!}">
        </div>

        <input type="submit" value="Search">

    </form>

    <h3>Sort</h3>

    <div class="meta">
        <a href="/?sort=dateCreated,desc<#if title??>&title=${title}</#if><#if city??>&city=${city}</#if><#if minPrice??>&minPrice=${minPrice}</#if><#if maxPrice??>&maxPrice=${maxPrice}</#if>">Newest</a> |
        <a href="/?sort=dateCreated,asc<#if title??>&title=${title}</#if><#if city??>&city=${city}</#if><#if minPrice??>&minPrice=${minPrice}</#if><#if maxPrice??>&maxPrice=${maxPrice}</#if>">Oldest</a> |
        <a href="/?sort=price,asc<#if title??>&title=${title}</#if><#if city??>&city=${city}</#if><#if minPrice??>&minPrice=${minPrice}</#if><#if maxPrice??>&maxPrice=${maxPrice}</#if>">Price ↑</a> |
        <a href="/?sort=price,desc<#if title??>&title=${title}</#if><#if city??>&city=${city}</#if><#if minPrice??>&minPrice=${minPrice}</#if><#if maxPrice??>&maxPrice=${maxPrice}</#if>">Price ↓</a> |
    </div>


    <h3>Products</h3>

    <#list products as product>

        <div class="product">

            <div class="product-title">
                ${product.title}
            </div>

            <#if product.images?size gt 0>

                <div class="slider">

                    <button class="left" onclick="prevImage(${product.id})">&lt;</button>

                    <div class="slider-image">
                        <img id="img-${product.id}" src="/images/${product.images[0].id}">
                    </div>

                    <button class="right" onclick="nextImage(${product.id})">&gt;</button>

                </div>

            </#if>

            <script>

                window['images${product.id}'] = [
                    <#list product.images as img>
                    "/images/${img.id}"<#if img_has_next>,</#if>
                    </#list>
                ];

                window['index${product.id}'] = 0;

            </script>

            <div class="meta">
                <strong>Price</strong> £${product.price}
            </div>

            <div class="meta">
                <strong>City</strong> ${product.city}
            </div>

            <div class="meta">
                <strong>Posted</strong>
                ${product.dateCreated?datetime("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")?string("yyyy-MM-dd HH:mm")}
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

    <div style="margin-top:20px;">

        <#if totalPages?? && totalPages gt 1>

            <#list 0..(totalPages-1) as i>

                <a href="/?page=${i}&sort=${sortField}<#if title??>&title=${title}</#if><#if city??>&city=${city}</#if><#if minPrice??>&minPrice=${minPrice}</#if><#if maxPrice??>&maxPrice=${maxPrice}</#if>"
                   style="margin-right:8px;">

                    <#if i == currentPage>
                        <strong>${i + 1}</strong>
                    <#else>
                        ${i + 1}
                    </#if>

                </a>

            </#list>

        </#if>

    </div>


    <#if user.email??>

        <div class="form-block">

            <h3>Create product</h3>

            <#if errorMessage??>
                <div class="error-box">
                    ${errorMessage}
                </div>
            </#if>

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
                    <input type="file" name="file1" onchange="previewImage(event,'preview1')">
                    <img id="preview1" style="max-width:120px;margin-top:5px;display:none;">
                </div>

                <div class="field">
                    <span class="label">Photo 2</span>
                    <input type="file" name="file2" onchange="previewImage(event,'preview2')">
                    <img id="preview2" style="max-width:120px;margin-top:5px;display:none;">
                </div>

                <div class="field">
                    <span class="label">Photo 3</span>
                    <input type="file" name="file3" onchange="previewImage(event,'preview3')">
                    <img id="preview3" style="max-width:120px;margin-top:5px;display:none;">
                </div>

                <input type="hidden" name="_csrf" value="${_csrf.token}">

                <input type="submit" value="Add product">

            </form>

        </div>

    </#if>

</div>

<script>

    function nextImage(productId){

        let images = window['images' + productId];
        let index = window['index' + productId];

        index++;

        if(index >= images.length){
            index = 0;
        }

        window['index' + productId] = index;

        document.getElementById("img-" + productId).src = images[index];
    }


    function prevImage(productId){

        let images = window['images' + productId];
        let index = window['index' + productId];

        index--;

        if(index < 0){
            index = images.length - 1;
        }

        window['index' + productId] = index;

        document.getElementById("img-" + productId).src = images[index];
    }


    function previewImage(event, previewId){

        const file = event.target.files[0];

        if(!file) return;

        const reader = new FileReader();

        reader.onload = function(e){

            const img = document.getElementById(previewId);

            img.src = e.target.result;
            img.style.display = "block";

        };

        reader.readAsDataURL(file);
    }

</script>

</body>
</html>