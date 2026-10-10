<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Checkout | ShinyMart</title>

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

        .container {
            max-width: 1050px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .heading {
            margin-bottom: 25px;
        }

        .heading h1 {
            font-size: 32px;
            margin: 0 0 10px;
        }

        .heading p {
            color: #817589;
            line-height: 1.6;
        }

        .checkout-layout {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 25px;
            align-items: start;
        }

        .card {
            background: white;
            border-radius: 18px;
            padding: 25px;
            box-shadow: 0 8px 30px rgba(70, 30, 100, 0.07);
        }

        .card h2 {
            font-size: 21px;
            margin-top: 0;
            margin-bottom: 22px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 13px;
            border: 1px solid #e1d6e9;
            border-radius: 9px;
            font-size: 15px;
            font-family: Arial, sans-serif;
            background: white;
            color: #30243a;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #9146c6;
            box-shadow: 0 0 0 3px rgba(145, 70, 198, 0.1);
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .submit-button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #9146c6, #702bb0);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .submit-button:hover {
            opacity: 0.9;
        }

        .back-link {
            display: inline-block;
            margin-top: 18px;
            color: #7628b8;
            font-weight: bold;
            text-decoration: none;
        }

        .order-item {
            padding: 15px 0;
            border-bottom: 1px solid #f0eaf4;
        }

        .item-top {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            align-items: flex-start;
        }

        .item-name {
            font-weight: bold;
            overflow-wrap: anywhere;
        }

        .item-price {
            font-weight: bold;
            white-space: nowrap;
        }

        .item-quantity {
            color: #817589;
            font-size: 13px;
            margin-top: 7px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            margin-top: 22px;
            font-size: 18px;
            font-weight: bold;
        }

        .total-amount {
            color: #7628b8;
            white-space: nowrap;
        }

        .secure-note {
            margin-top: 20px;
            padding: 14px;
            background: #f8f0ff;
            color: #68417e;
            border-radius: 10px;
            font-size: 13px;
            line-height: 1.6;
        }

        .error-message {
            padding: 13px;
            margin-bottom: 20px;
            border-radius: 9px;
            background: #fff0f0;
            color: #b42318;
            font-size: 14px;
        }

        .empty-message {
            padding: 30px 10px;
            text-align: center;
            color: #817589;
        }

        .footer {
            text-align: center;
            padding: 25px;
            color: #8b8092;
            font-size: 13px;
        }

        @media (max-width: 700px) {
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

            .container {
                margin: 28px auto;
                padding: 0 12px;
            }

            .heading h1 {
                font-size: 27px;
            }

            .checkout-layout {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 18px;
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

        <a href="${pageContext.request.contextPath}/cart">
            Cart
        </a>

        <a href="${pageContext.request.contextPath}/orders">
            My Orders
        </a>
    </div>
</nav>

<main class="container">

    <div class="heading">
        <h1>💜 Checkout</h1>
        <p>Enter your delivery details and review your order.</p>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">
            <c:out value="${error}" />
        </div>
    </c:if>

    <div class="checkout-layout">

        <!-- Delivery Information -->
        <section class="card">

            <h2>📦 Delivery Information</h2>

            <form action="${pageContext.request.contextPath}/checkout"
                  method="post">

                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text"
                           id="fullName"
                           name="fullName"
                           placeholder="Enter your full name"
                           maxlength="100"
                           autocomplete="name"
                           required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="Enter your email address"
                           maxlength="150"
                           autocomplete="email"
                           required>
                </div>

                <div class="form-group">
                    <label for="phone">Mobile Number</label>
                    <input type="tel"
                           id="phone"
                           name="phone"
                           placeholder="Enter your 10-digit mobile number"
                           inputmode="numeric"
                           pattern="[0-9]{10}"
                           maxlength="10"
                           autocomplete="tel"
                           required>
                </div>

                <div class="form-group">
                    <label for="address">Delivery Address</label>
                    <textarea id="address"
                              name="address"
                              placeholder="Enter your complete delivery address"
                              maxlength="500"
                              autocomplete="street-address"
                              required></textarea>
                </div>

                <div class="form-group">
                    <label for="paymentMethod">Payment Method</label>

                    <select id="paymentMethod"
                            name="paymentMethod"
                            required>

                        <option value="">Select payment method</option>

                        <option value="COD">
                            Cash on Delivery
                        </option>

                        <option value="ONLINE">
                            Online Payment
                        </option>

                    </select>
                </div>

                <button type="submit" class="submit-button">
                    Place Order →
                </button>

            </form>

            <a class="back-link"
               href="${pageContext.request.contextPath}/cart">
                ← Back to Cart
            </a>

        </section>

        <!-- Order Summary -->
        <section class="card">

            <h2>🛍️ Order Summary</h2>

            <c:choose>

                <c:when test="${not empty items}">

                    <c:set var="grandTotal" value="${0}" />

                    <c:forEach var="item" items="${items}">

                        <c:set var="lineTotal"
                               value="${item.unitPrice * item.quantity}" />

                        <c:set var="grandTotal"
                               value="${grandTotal + lineTotal}" />

                        <div class="order-item">

                            <div class="item-top">

                                <div class="item-name">
                                    <c:out value="${item.productName}" />
                                </div>

                                <div class="item-price">
                                    ₹<fmt:formatNumber
                                        value="${lineTotal}"
                                        minFractionDigits="2"
                                        maxFractionDigits="2" />
                                </div>

                            </div>

                            <div class="item-quantity">
                                Quantity:
                                <c:out value="${item.quantity}" />
                            </div>

                        </div>

                    </c:forEach>

                    <div class="total-row">
                        <span>Total Amount</span>

                        <span class="total-amount">
                            ₹<fmt:formatNumber
                                value="${grandTotal}"
                                minFractionDigits="2"
                                maxFractionDigits="2" />
                        </span>
                    </div>

                    <div class="secure-note">
                        🔒 Please check your delivery details before
                        placing your order.
                    </div>

                </c:when>

                <c:otherwise>

                    <div class="empty-message">
                        <h3>Your cart is empty</h3>

                        <p>
                            Add products to your cart before checking out.
                        </p>

                        <a class="back-link"
                           href="${pageContext.request.contextPath}/products">
                            Browse Products
                        </a>
                    </div>

                </c:otherwise>

            </c:choose>

        </section>

    </div>

</main>

<footer class="footer">
    © 2026 ShinyMart · Happy Shopping 💜
</footer>

</body>
</html>
