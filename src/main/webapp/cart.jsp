<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Shopping Cart | ShinyMart</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #faf7fc;
            color: #30243a;
        }

        .navbar {
            background: white;
            padding: 18px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.05);
        }

        .brand {
            color: #7628b8;
            font-size: 25px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: #51445c;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
        }

        .page-container {
            max-width: 1000px;
            margin: 45px auto;
            padding: 0 20px;
        }

        .page-heading {
            margin-bottom: 25px;
        }

        .page-heading h1 {
            font-size: 32px;
            margin: 0 0 10px;
        }

        .page-heading p {
            color: #817589;
            margin: 0;
            line-height: 1.6;
        }

        .cart-card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: 0 8px 30px rgba(70, 30, 100, 0.07);
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 420px;
        }

        .cart-table th {
            text-align: left;
            padding: 16px 12px;
            color: #806d8d;
            font-size: 13px;
            background: #faf6ff;
            border-bottom: 1px solid #eee5f5;
        }

        .cart-table td {
            padding: 20px 12px;
            border-bottom: 1px solid #f0eaf4;
            font-size: 15px;
        }

        .product-name {
            font-weight: bold;
            color: #382047;
        }

        .quantity {
            display: inline-block;
            padding: 7px 13px;
            background: #f3e8ff;
            color: #7628b8;
            border-radius: 8px;
            font-weight: bold;
        }

        .price {
            font-weight: bold;
            white-space: nowrap;
        }

        .cart-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-top: 25px;
            flex-wrap: wrap;
        }

        .continue-link {
            color: #7628b8;
            font-weight: bold;
            text-decoration: none;
        }

        .checkout-button {
            display: inline-block;
            padding: 14px 24px;
            border-radius: 10px;
            background: linear-gradient(135deg, #9146c6, #702bb0);
            color: white;
            text-decoration: none;
            font-weight: bold;
            text-align: center;
        }

        .checkout-button:hover {
            opacity: 0.9;
        }

        .empty-cart {
            padding: 45px 15px;
            text-align: center;
        }

        .empty-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }

        .empty-cart h2 {
            margin-bottom: 10px;
        }

        .empty-cart p {
            color: #817589;
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .footer {
            text-align: center;
            padding: 25px;
            color: #8b8092;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 16px 5%;
            }

            .brand {
                font-size: 21px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a {
                font-size: 12px;
            }

            .page-container {
                margin: 30px auto;
                padding: 0 12px;
            }

            .page-heading h1 {
                font-size: 27px;
            }

            .cart-card {
                padding: 12px;
            }

            .cart-bottom {
                align-items: stretch;
                flex-direction: column;
            }

            .checkout-button {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a class="brand"
       href="${pageContext.request.contextPath}/home.jsp">
        ShinyMart
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/products">
            Products
        </a>

        <a href="${pageContext.request.contextPath}/orders">
            My Orders
        </a>
    </div>
</nav>

<main class="page-container">

    <div class="page-heading">
        <h1>🛒 Your Shopping Cart</h1>
        <p>Review your items before proceeding to checkout.</p>
    </div>

    <section class="cart-card">

        <c:choose>

            <c:when test="${not empty items}">

                <div class="table-wrapper">
                    <table class="cart-table">

                        <thead>
                            <tr>
                                <th>PRODUCT</th>
                                <th>QUANTITY</th>
                                <th>UNIT PRICE</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="item" items="${items}">
                                <tr>
                                    <td class="product-name">
                                        <c:out value="${item.productName}" />
                                    </td>

                                    <td>
                                        <span class="quantity">
                                            <c:out value="${item.quantity}" />
                                        </span>
                                    </td>

                                    <td class="price">
                                        <fmt:formatNumber
                                            value="${item.unitPrice}"
                                            type="currency"
                                            currencyCode="INR"
                                            maxFractionDigits="2" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>
                </div>

                <div class="cart-bottom">

                    <a class="continue-link"
                       href="${pageContext.request.contextPath}/products">
                        ← Continue Shopping
                    </a>

                    <a class="checkout-button"
                       href="${pageContext.request.contextPath}/checkout">
                        Proceed to Checkout →
                    </a>

                </div>

            </c:when>

            <c:otherwise>

                <div class="empty-cart">

                    <div class="empty-icon">🛍️</div>

                    <h2>Your cart is waiting!</h2>

                    <p>
                        You haven't added any products yet.
                        Explore our products to get started.
                    </p>

                    <a class="checkout-button"
                       href="${pageContext.request.contextPath}/products">
                        Explore Products
                    </a>

                </div>

            </c:otherwise>

        </c:choose>

    </section>

</main>

<footer class="footer">
    © 2026 ShinyMart · Happy Shopping 💜
</footer>

</body>
</html>
