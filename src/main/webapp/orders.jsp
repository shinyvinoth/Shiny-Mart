<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Orders | ShinyMart</title>

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
            max-width: 1000px;
            margin: 45px auto;
            padding: 0 20px;
        }

        h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #817589;
            line-height: 1.6;
            margin-bottom: 28px;
        }

        .orders-card {
            background: white;
            padding: 25px;
            border-radius: 18px;
            box-shadow: 0 8px 30px rgba(70, 30, 100, 0.07);
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 450px;
            border-collapse: collapse;
        }

        th {
            background: #faf6ff;
            color: #806d8d;
            text-align: left;
            padding: 16px 12px;
            font-size: 13px;
        }

        td {
            padding: 19px 12px;
            border-bottom: 1px solid #f0eaf4;
            font-size: 14px;
        }

        .order-id {
            color: #7628b8;
            font-weight: bold;
        }

        .status {
            display: inline-block;
            background: #f3e8ff;
            color: #7628b8;
            padding: 7px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .amount {
            font-weight: bold;
            white-space: nowrap;
        }

        .empty-state {
            text-align: center;
            padding: 40px 15px;
        }

        .empty-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }

        .empty-state p {
            color: #817589;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .button {
            display: inline-block;
            padding: 13px 22px;
            background: linear-gradient(135deg, #9146c6, #702bb0);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: bold;
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

            .container {
                margin: 30px auto;
                padding: 0 12px;
            }

            h1 {
                font-size: 27px;
            }

            .orders-card {
                padding: 12px;
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
    </div>
</nav>

<main class="container">

    <h1>📦 My Orders</h1>

    <p class="subtitle">
        Track and view your orders in one place.
    </p>

    <section class="orders-card">

        <c:choose>

            <c:when test="${not empty orders}">

                <div class="table-wrapper">
                    <table>

                        <thead>
                            <tr>
                                <th>ORDER ID</th>
                                <th>STATUS</th>
                                <th>TOTAL AMOUNT</th>
                                <th>ORDER DATE</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td class="order-id">
                                        #<c:out value="${o.id}" />
                                    </td>

                                    <td>
                                        <span class="status">
                                            <c:out value="${o.status}" />
                                        </span>
                                    </td>

                                    <td class="amount">
                                        <fmt:formatNumber
                                            value="${o.totalAmount}"
                                            type="currency"
                                            currencyCode="INR"
                                            maxFractionDigits="2" />
                                    </td>

                                    <td>
                                        <c:out value="${o.createdAt}" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>
                </div>

            </c:when>

            <c:otherwise>

                <div class="empty-state">

                    <div class="empty-icon">🛍️</div>

                    <h2>No orders yet</h2>

                    <p>
                        Your orders will appear here after
                        you complete a purchase.
                    </p>

                    <a class="button"
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
