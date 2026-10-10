<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>AI Chatbot | ShinyMart</title>

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
            max-width: 750px;
            margin: 40px auto;
            padding: 0 16px;
        }

        .heading {
            margin-bottom: 25px;
        }

        .heading h1 {
            font-size: 30px;
        }

        .heading p {
            color: #817589;
            line-height: 1.6;
        }

        .chat-card {
            background: white;
            padding: 25px;
            border-radius: 18px;
            box-shadow: 0 8px 30px rgba(70,30,100,.07);
        }

        .chat-header {
            padding: 18px;
            background: linear-gradient(135deg,#9146c6,#702bb0);
            color: white;
            border-radius: 12px;
            margin-bottom: 22px;
        }

        .chat-header h2 {
            margin: 0 0 8px;
        }

        .chat-header p {
            margin: 0;
            font-size: 14px;
            line-height: 1.5;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        textarea {
            width: 100%;
            min-height: 110px;
            padding: 13px;
            border: 1px solid #e1d6e9;
            border-radius: 10px;
            font-family: Arial, sans-serif;
            font-size: 15px;
            resize: vertical;
        }

        .ask-button {
            width: 100%;
            margin-top: 15px;
            padding: 14px;
            border: none;
            border-radius: 10px;
            background: #7628b8;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .response {
            margin-top: 22px;
            padding: 18px;
            border-radius: 12px;
            background: #f5eaff;
            line-height: 1.7;
            overflow-wrap: anywhere;
        }

        .response h3 {
            margin-top: 0;
            color: #7628b8;
        }

        .error {
            margin-top: 18px;
            padding: 14px;
            background: #fff0f0;
            color: #b42318;
            border-radius: 9px;
        }

        .examples {
            margin-top: 25px;
            padding: 20px;
            background: white;
            border-radius: 14px;
        }

        .examples li {
            margin-bottom: 12px;
            line-height: 1.5;
        }

        .links {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 25px;
        }

        .links a {
            color: #7628b8;
            text-decoration: none;
            font-weight: bold;
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

            .chat-card {
                padding: 17px;
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
        <h1>🤖 ShinyMart Assistant</h1>
        <p>Ask questions about shopping, accounts, checkout, and orders.</p>
    </div>

    <section class="chat-card">

        <div class="chat-header">
            <h2>💜 How can I help you?</h2>
            <p>
                Enter your question below. I'll try to guide you
                through using ShinyMart.
            </p>
        </div>

        <form action="${pageContext.request.contextPath}/chatbot"
              method="post">

            <label for="message">Your Question</label>

            <textarea id="message"
                      name="message"
                      maxlength="500"
                      placeholder="Example: How do I add a product to my cart?"
                      required><c:out value="${param.message}"/></textarea>

            <button class="ask-button" type="submit">
                💬 Ask Assistant
            </button>

        </form>

        <c:if test="${not empty chatbotResponse}">
            <div class="response">
                <h3>🤖 Assistant's Answer</h3>
                <p><c:out value="${chatbotResponse}"/></p>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error">
                <strong>Error:</strong>
                <c:out value="${error}"/>
            </div>
        </c:if>

    </section>

    <section class="examples">

        <h2>💡 Example Questions</h2>

        <ul>
            <li>How do I register?</li>
            <li>How do I log in?</li>
            <li>How do I add a product to my cart?</li>
            <li>How do I proceed to checkout?</li>
            <li>How can I see my orders?</li>
            <li>How do I write a product review?</li>
            <li>How can a seller add a product?</li>
        </ul>

    </section>

    <div class="links">
        <a href="${pageContext.request.contextPath}/home.jsp">
            ← Home
        </a>

        <a href="${pageContext.request.contextPath}/products">
            🛍️ Browse Products
        </a>
    </div>

</main>

</body>
</html>
