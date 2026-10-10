<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | ShinyMart</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f5eaff, #fff7fb);
            display: flex;
            flex-direction: column;
        }

        header {
            background: white;
            padding: 18px 7%;
            box-shadow: 0 3px 15px #0000000d;
        }

        header a {
            color: #7628b8;
            font-size: 25px;
            font-weight: bold;
            text-decoration: none;
        }

        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            background: white;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 12px 40px #64288c1a;
        }

        .icon {
            text-align: center;
            font-size: 48px;
        }

        h1 {
            text-align: center;
            color: #382047;
            margin-bottom: 10px;
        }

        .description {
            text-align: center;
            color: #777;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        label {
            display: block;
            margin: 18px 0 8px;
            font-weight: bold;
            color: #382047;
        }

        input {
            width: 100%;
            padding: 13px;
            border: 1px solid #ded3e8;
            border-radius: 9px;
            font-size: 15px;
        }

        input:focus {
            outline: 2px solid #d9b8f4;
            border-color: #7628b8;
        }

        button {
            width: 100%;
            margin-top: 24px;
            padding: 14px;
            background: linear-gradient(135deg, #9146c6, #702bb0);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .error {
            background: #fff0ef;
            color: #b42318;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .message {
            background: #eaf8ee;
            color: #18753b;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .register-link {
            text-align: center;
            margin-top: 22px;
            color: #666;
            font-size: 14px;
        }

        .register-link a {
            color: #7628b8;
            font-weight: bold;
            text-decoration: none;
        }

        footer {
            text-align: center;
            padding: 18px;
            color: #777;
            font-size: 13px;
        }
    </style>
</head>

<body>

<header>
    <a href="${pageContext.request.contextPath}/home.jsp">
        ShinyMart
    </a>
</header>

<main>
    <section class="login-card">

        <div class="icon">🛍️</div>

        <h1>Welcome Back!</h1>

        <p class="description">
            Sign in to continue shopping with ShinyMart.
        </p>

        <c:if test="${not empty error}">
            <div class="error">
                <c:out value="${error}" />
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="message">
                <c:out value="${message}" />
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login"
              method="post">

            <label for="email">Email Address</label>
            <input
                type="email"
                id="email"
                name="email"
                placeholder="Enter your email"
                autocomplete="email"
                required>

            <label for="password">Password</label>
            <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter your password"
                autocomplete="current-password"
                required>

            <button type="submit">Login →</button>

        </form>

        <div class="register-link">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">
                Create Account
            </a>
        </div>

    </section>
</main>

<footer>
    © 2026 ShinyMart · Happy Shopping 💜
</footer>

</body>
</html>
