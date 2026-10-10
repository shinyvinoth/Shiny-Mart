<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>ShinyMart | Products</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .products-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
            margin: 35px 0 22px;
        }

        .products-heading h1 {
            font-size: clamp(26px, 5vw, 38px);
            font-weight: 900;
        }

        .welcome-text {
            color: var(--muted);
            margin-top: 5px;
        }

        .search-panel {
            background: white;
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 22px;
            margin: 25px 0;
            box-shadow: var(--shadow);
        }

        .search-grid {
            display: grid;
            grid-template-columns: 2fr 1fr auto;
            gap: 12px;
            align-items: end;
        }

        .search-grid label,
        .seller-form label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 6px;
        }

        .search-grid input,
        .search-grid select,
        .seller-form input,
        .seller-form textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 10px;
            outline: none;
            background: #fcfcff;
        }

        .search-grid input:focus,
        .search-grid select:focus,
        .seller-form input:focus,
        .seller-form textarea:focus {
            border-color: var(--primary);
        }

        .seller-panel {
            background: linear-gradient(135deg, #efedff, #fff0f5);
            padding: 25px;
            margin: 25px 0;
            border-radius: 20px;
        }

        .seller-form {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 15px;
            margin-top: 18px;
        }

        .seller-form .full-width {
            grid-column: 1 / -1;
        }

        .seller-form textarea {
            min-height: 80px;
            resize: vertical;
        }

        .products-table-wrap {
            overflow-x: auto;
            background: white;
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
        }

        .products-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        .products-table th {
            background: #f5f4ff;
            color: var(--text);
            text-align: left;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: .5px;
        }

        .products-table th,
        .products-table td {
            padding: 15px;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .products-table td {
            font-size: 13px;
        }

        .products-table tr:last-child td {
            border-bottom: none;
        }

        .products-table tbody tr:hover {
            background: #fafaff;
        }

        .table-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 7px;
        }

        .table-actions .btn,
        .products-table form .btn {
            padding: 8px 11px;
            font-size: 12px;
        }

        .product-title {
            font-weight: 800;
            color: var(--text);
        }

        .price-text {
            color: var(--primary);
            font-weight: 900;
            white-space: nowrap;
        }

        .category-pill {
            display: inline-block;
            background: #efedff;
            color: var(--primary);
            border-radius: 30px;
            padding: 5px 10px;
            font-size: 11px;
            font-weight: 700;
        }

        .quick-links {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin: 25px 0;
        }

        @media (max-width: 650px) {
            .search-grid,
            .seller-form {
                grid-template-columns: 1fr;
            }

            .seller-form .full-width {
                grid-column: auto;
            }

            .products-heading {
                align-items: flex-start;
            }
        }
    </style>
</head>

<body>

<!-- NAVIGATION -->
<header class="navbar">
    <div class="container nav-inner">

        <a class="brand"
           href="${pageContext.request.contextPath}/home.jsp">
            Shiny<span>Mart.</span>
        </a>

        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
            <a class="active"
               href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/orders">My Orders</a>
            <a href="${pageContext.request.contextPath}/cart">🛒 My Cart</a>
        </nav>

    </div>
</header>


<main class="container">

    <!-- PAGE HEADING -->
    <section class="products-heading">
        <div>
            <h1>Discover Products ✨</h1>

            <p class="welcome-text">
                Welcome,
                <strong><c:out value="${sessionScope.user.name}"/></strong>!
                Find something you'll love.
            </p>
        </div>

        <a class="btn btn-outline"
           href="${pageContext.request.contextPath}/home.jsp">
            ← Back Home
        </a>
    </section>


    <!-- SEARCH AND FILTER -->
    <section class="search-panel">

        <h2 style="margin-bottom:5px;">Find your favourite</h2>

        <p class="section-subtitle">
            Search by product name or explore a category.
        </p>

        <form action="${pageContext.request.contextPath}/products"
              method="get">

            <div class="search-grid">

                <div>
                    <label for="keyword">Search products</label>

                    <input type="text"
                           id="keyword"
                           name="keyword"
                           value="<c:out value='${param.keyword}'/>"
                           placeholder="e.g. headphones, bag, watch">
                </div>

                <div>
                    <label for="category">Category</label>

                    <input type="text"
                           id="category"
                           name="category"
                           value="<c:out value='${param.category}'/>"
                           placeholder="Enter category">
                </div>

                <div>
                    <button class="btn btn-primary" type="submit">
                        🔍 Search
                    </button>
                </div>

            </div>

        </form>

    </section>


    <!-- SELLER ADD PRODUCT -->
    <c:if test="${sessionScope.user.role == 'SELLER'}">

        <section class="seller-panel">

            <h2>➕ Add a New Product</h2>

            <p>
                Share your products with ShinyMart shoppers.
            </p>

            <form action="${pageContext.request.contextPath}/products"
                  method="post"
                  class="seller-form">

                <input type="hidden" name="action" value="add">

                <div>
                    <label for="productName">Product Name *</label>

                    <input type="text"
                           id="productName"
                           name="name"
                           maxlength="150"
                           required>
                </div>

                <div>
                    <label for="productPrice">Price (₹) *</label>

                    <input type="number"
                           id="productPrice"
                           name="price"
                           step="0.01"
                           min="0.01"
                           required>
                </div>

                <div>
                    <label for="stockQty">Stock Quantity *</label>

                    <input type="number"
                           id="stockQty"
                           name="stockQty"
                           min="0"
                           required>
                </div>

                <div>
                    <label for="productCategory">Category</label>

                    <input type="text"
                           id="productCategory"
                           name="category"
                           maxlength="100"
                           placeholder="e.g. Electronics">
                </div>

                <div class="full-width">
                    <label for="productDescription">Description</label>

                    <textarea id="productDescription"
                              name="description"
                              maxlength="1000"
                              placeholder="Describe your product"></textarea>
                </div>

                <div class="full-width">
                    <button class="btn btn-primary" type="submit">
                        ➕ Add Product
                    </button>
                </div>

            </form>

        </section>

    </c:if>


    <!-- PRODUCT LIST -->
    <section class="section">

        <h2 class="section-title">Available Products 🛍️</h2>

        <p class="section-subtitle">
            Explore the products listed on our marketplace.
        </p>

        <c:choose>

            <c:when test="${not empty products}">

                <div class="products-table-wrap">

                    <table class="products-table">

                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Category</th>
                            <th>Cart</th>
                            <th>Review</th>

                            <c:if test="${sessionScope.user.role == 'SELLER'}">
                                <th>Manage</th>
                            </c:if>
                        </tr>
                        </thead>

                        <tbody>

                        <c:forEach var="product" items="${products}">

                            <tr>

                                <td>
                                    <c:out value="${product.id}"/>
                                </td>

                                <td>
                                    <span class="product-title">
                                        <c:out value="${product.name}"/>
                                    </span>
                                </td>

                                <td>
                                    <c:out value="${product.description}"/>
                                </td>

                                <td>
                                    <span class="price-text">
                                        ₹<c:out value="${product.price}"/>
                                    </span>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${product.stockQty > 0}">
                                            <span class="status status-success">
                                                In Stock:
                                                <c:out value="${product.stockQty}"/>
                                            </span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status status-pending">
                                                Out of Stock
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <span class="category-pill">
                                        <c:out value="${product.category}"/>
                                    </span>
                                </td>

                                <!-- ADD TO CART -->
                                <td>

                                    <c:choose>

                                        <c:when test="${product.stockQty > 0}">

                                            <form action="${pageContext.request.contextPath}/cart"
                                                  method="post">

                                                <input type="hidden"
                                                       name="productId"
                                                       value="<c:out value='${product.id}'/>">

                                                <input type="hidden"
                                                       name="quantity"
                                                       value="1">

                                                <button class="btn btn-primary"
                                                        type="submit">
                                                    🛒 Add
                                                </button>

                                            </form>

                                        </c:when>

                                        <c:otherwise>
                                            <span>Unavailable</span>
                                        </c:otherwise>

                                    </c:choose>

                                </td>

                                <!-- REVIEW -->
                                <td>
                                    <a class="btn btn-secondary"
                                       href="${pageContext.request.contextPath}/reviews?productId=${product.id}">
                                        ⭐ Review
                                    </a>
                                </td>

                                <!-- SELLER MANAGEMENT -->
                                <c:if test="${sessionScope.user.role == 'SELLER'
                                              && sessionScope.user.id == product.sellerId}">

                                    <td>

                                        <div class="table-actions">

                                            <form action="${pageContext.request.contextPath}/edit-product"
                                                  method="get">

                                                <input type="hidden"
                                                       name="id"
                                                       value="<c:out value='${product.id}'/>">

                                                <button class="btn btn-secondary"
                                                        type="submit">
                                                    ✏️ Edit
                                                </button>

                                            </form>

                                            <form action="${pageContext.request.contextPath}/products"
                                                  method="post"
                                                  onsubmit="return confirm('Delete this product?');">

                                                <input type="hidden"
                                                       name="action"
                                                       value="delete">

                                                <input type="hidden"
                                                       name="id"
                                                       value="<c:out value='${product.id}'/>">

                                                <button class="btn btn-danger"
                                                        type="submit">
                                                    🗑️ Delete
                                                </button>

                                            </form>

                                        </div>

                                    </td>

                                </c:if>

                            </tr>

                        </c:forEach>

                        </tbody>

                    </table>

                </div>

            </c:when>

            <c:otherwise>

                <div class="empty-state">

                    <div class="empty-icon">🛍️</div>

                    <h3>No products found</h3>

                    <p>
                        Try a different search or category.
                        Sellers can add products using the form above.
                    </p>

                    <a class="btn btn-primary"
                       href="${pageContext.request.contextPath}/products">
                        Show All Products
                    </a>

                </div>

            </c:otherwise>

        </c:choose>

    </section>


    <!-- QUICK LINKS -->
    <section class="quick-links">

        <a class="btn btn-outline"
           href="${pageContext.request.contextPath}/cart">
            🛒 My Cart
        </a>

        <a class="btn btn-outline"
           href="${pageContext.request.contextPath}/orders">
            📦 My Orders
        </a>

        <a class="btn btn-outline"
           href="${pageContext.request.contextPath}/login">
            🚪 Logout
        </a>

    </section>

</main>


<!-- FOOTER -->
<footer class="footer">

    <div class="container footer-inner">

        <div>
            <a class="brand"
               href="${pageContext.request.contextPath}/home.jsp">
                Shiny<span>Mart.</span>
            </a>

            <p>Smart Shopping. Simple Experience.</p>
        </div>

        <p>© 2026 ShinyMart</p>

    </div>

</footer>

</body>
</html>
