<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create Account | ShinyMart</title>

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

        .navbar {
            background: white;
            padding: 18px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.06);
        }

        .brand {
            color: #7628b8;
            font-size: 25px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-link {
            color: #7628b8;
            font-weight: bold;
            text-decoration: none;
        }

        .register-container {
            width: 100%;
            max-width: 460px;
            margin: 35px auto;
            padding: 20px;
            flex: 1;
        }

        .register-card {
            background: white;
            padding: 32px;
            border-radius: 20px;
            box-shadow: 0 12px 40px rgba(100, 40, 140, 0.12);
        }

        .icon {
            width: 65px;
            height: 65px;
            margin: 0 auto 15px;
            border-radius: 18px;
            background: #f1e1ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
        }

        h1 {
            text-align: center;
            color: #382047;
            margin: 0 0 10px;
            font-size: 27px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 25px;
            font-size: 14px;
            line-height: 1.6;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #382047;
            font-size: 14px;
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 13px;
            border: 1px solid #ded3e8;
            border-radius: 10px;
            background: white;
            font-size: 15px;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: 2px solid #e1c7fa;
            border-color: #7628b8;
        }

        .register-button {
            width: 100%;
            padding: 14px;
            margin-top: 8px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #9146c6, #702bb0);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .register-button:hover {
            opacity: 0.92;
        }

        .error-message {
            padding: 12px;
            margin-bottom: 18px;
            border-radius: 8px;
            background: #fff0ef;
            color: #b42318;
            font-size: 14px;
        }

        .login-text {
            text-align: center;
            margin-top: 22px;
            color: #666;
            font-size: 14px;
        }

        .login-text a {
            color: #7628b8;
            font-weight: bold;
            text-decoration: none;
        }

        .footer {
            padding: 18px;
            text-align: center;
            color: #777;
            font-size: 13px;
        }

        @media (max-width: 480px) {
            .register-card {
                padding: 25px 20px;
            }

            .navbar {
                padding: 16px 5%;
            }

            .brand {
                font-size: 22px;
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

        <a class="nav-link"
           href="${pageContext.request.contextPath}/login">
            Log in
        </a>
    </nav>

    <main class="register-container">

        <section class="register-card">

            <div class="icon">🛍️</div>

            <h1>Create Your Account</h1>

            <p class="subtitle">
                Join ShinyMart and discover your next favourite product.
            </p>

            <c:if test="${not empty error}">
                <div class="error-message" role="alert">
                    <c:out value="${error}" />
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register"
                  method="post">

                <div class="form-group">
                    <label for="name">Full Name</label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Enter your full name"
                        autocomplete="name"
                        required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your email address"
                        autocomplete="email"
                        required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="At least 8 characters"
                        minlength="8"
                        autocomplete="new-password"
                        required>
                </div>

                <div class="form-group">
                    <label for="role">Account Type</label>

                    <select id="role" name="role" required>
                        <option value="BUYER">Buyer — Shop products</option>
                        <option value="SELLER">Seller — Sell products</option>
                    </select>
                </div>

                <button type="submit" class="register-button">
                    Create Account →
                </button>

            </form>

            <p class="login-text">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login">
                    Log in here
                </a>
            </p>

        </section>

    </main>

    <footer class="footer">
        © 2026 ShinyMart · Happy Shopping 💜
    </footer>

</body>
</html>
