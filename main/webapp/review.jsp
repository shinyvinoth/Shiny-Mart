<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Product Reviews | ShinyMart</title>

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
            box-shadow: 0 3px 15px rgba(0,0,0,.05);
        }

        .brand {
            color: #7628b8;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 18px;
        }

        .nav-links a {
            color: #51445c;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
        }

        .container {
            max-width: 850px;
            margin: 40px auto;
            padding: 0 16px;
        }

        .heading {
            margin-bottom: 25px;
        }

        .heading h1 {
            margin-bottom: 8px;
            font-size: 30px;
        }

        .heading p {
            color: #817589;
            line-height: 1.6;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 16px;
            margin-bottom: 25px;
            box-shadow: 0 8px 30px rgba(70,30,100,.06);
        }

        .card h2 {
            margin-top: 0;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: bold;
        }

        input, textarea, select {
            width: 100%;
            padding: 13px;
            border: 1px solid #e1d6e9;
            border-radius: 9px;
            font-size: 15px;
            font-family: Arial, sans-serif;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .submit-button {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg,#9146c6,#702bb0);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .message {
            padding: 13px;
            margin-bottom: 18px;
            border-radius: 9px;
            background: #f4e8ff;
            color: #60228b;
            line-height: 1.5;
        }

        .error {
            background: #fff0f0;
            color: #b42318;
        }

        .review-item {
            padding: 18px 0;
            border-bottom: 1px solid #eee5f5;
        }

        .review-item:last-child {
            border-bottom: none;
        }

        .rating {
            color: #f0a800;
            font-size: 20px;
            margin: 8px 0;
        }

        .review-comment {
            line-height: 1.7;
            overflow-wrap: anywhere;
        }

        .review-date {
            color: #817589;
            font-size: 12px;
            margin-top: 8px;
        }

        .back-link {
            display: inline-block;
            margin-top: 18px;
            color: #7628b8;
            font-weight: bold;
            text-decoration: none;
        }

        .empty {
            color: #817589;
            padding: 15px 0;
        }

        @media(max-width:600px) {
            .navbar {
                padding: 16px 5%;
            }

            .brand {
                font-size: 20px;
            }

            .nav-links {
                gap: 10px;
            }

            .nav-links a {
                font-size: 12px;
            }

            .container {
                margin: 25px auto;
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
        <a href="${pageContext.request.contextPath}/products">Products</a>
        <a href="${pageContext.request.contextPath}/cart">Cart</a>
        <a href="${pageContext.request.contextPath}/orders">My Orders</a>
    </div>
</nav>

<main class="container">

    <div class="heading">
        <h1>⭐ Product Reviews</h1>
        <p>Share your experience and help other customers.</p>
    </div>

    <section class="card">

        <h2>Write a Review</h2>

        <c:if test="${not empty error}">
            <div class="message error">
                <c:out value="${error}"/>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reviews"
              method="post">

            <input type="hidden"
                   name="productId"
                   value="<c:out value='${productId}'/>">

            <div class="form-group">
                <label for="rating">Your Rating</label>

                <select name="rating" id="rating" required>
                    <option value="">Select your rating</option>
                    <option value="5">⭐⭐⭐⭐⭐ Excellent</option>
                    <option value="4">⭐⭐⭐⭐ Very Good</option>
                    <option value="3">⭐⭐⭐ Good</option>
                    <option value="2">⭐⭐ Fair</option>
                    <option value="1">⭐ Poor</option>
                </select>
            </div>

            <div class="form-group">
                <label for="comment">Your Comment</label>

                <textarea id="comment"
                          name="comment"
                          maxlength="1000"
                          placeholder="What did you think about this product?"
                          required></textarea>
            </div>

            <button type="submit" class="submit-button">
                Submit Review 💜
            </button>

        </form>

        <a class="back-link"
           href="${pageContext.request.contextPath}/products">
            ← Back to Products
        </a>

    </section>

    <section class="card">

        <h2>Customer Reviews</h2>

        <c:choose>

            <c:when test="${not empty reviews}">

                <c:forEach var="review" items="${reviews}">

                    <article class="review-item">

                        <strong>Customer Review</strong>

                        <div class="rating">
                            <c:forEach begin="1" end="${review.rating}">
                                ★
                            </c:forEach>

                            <span style="color:#817589;font-size:13px;">
                                <c:out value="${review.rating}"/> / 5
                            </span>
                        </div>

                        <p class="review-comment">
                            <c:out value="${review.comment}"/>
                        </p>

                        <c:if test="${not empty review.createdAt}">
                            <div class="review-date">
                                <c:out value="${review.createdAt}"/>
                            </div>
                        </c:if>

                    </article>

                </c:forEach>

            </c:when>

            <c:otherwise>
                <p class="empty">
                    No reviews yet. Be the first to review this product!
                </p>
            </c:otherwise>

        </c:choose>

    </section>

</main>

</body>
</html>
