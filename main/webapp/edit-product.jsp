<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Edit Product - ShinyMart</title>
</head>

<body>

<h1>✏️ Edit Product</h1>

<p>
    <a href="${pageContext.request.contextPath}/products">
        ← Back to Products
    </a>
</p>

<hr>

<form action="${pageContext.request.contextPath}/products"
      method="post">

    <!-- Action -->
    <input type="hidden"
           name="action"
           value="edit">

    <!-- Product ID -->
    <input type="hidden"
           name="id"
           value="${product.id}">


    <label>Product Name:</label>
    <br>

    <input type="text"
           name="name"
           value="${product.name}"
           required>

    <br><br>


    <label>Description:</label>
    <br>

    <input type="text"
           name="description"
           value="${product.description}">

    <br><br>


    <label>Price:</label>
    <br>

    <input type="number"
           name="price"
           value="${product.price}"
           step="0.01"
           min="0.01"
           required>

    <br><br>


    <label>Stock Quantity:</label>
    <br>

    <input type="number"
           name="stockQty"
           value="${product.stockQty}"
           min="0"
           required>

    <br><br>


    <label>Category:</label>
    <br>

    <input type="text"
           name="category"
           value="${product.category}">

    <br><br>


    <button type="submit">
        💾 Update Product
    </button>

</form>

<br>

<a href="${pageContext.request.contextPath}/products">
    Cancel
</a>

</body>

</html>
