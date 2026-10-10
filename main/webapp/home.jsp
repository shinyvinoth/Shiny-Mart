<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShinyMart | Smart Shopping</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f8fafc;
            color: #1e293b;
        }

        a {
            text-decoration: none;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: auto;
        }

        /* Navigation */

        .navbar {
            background: white;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-inner {
            min-height: 75px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }

        .brand {
            font-size: 27px;
            font-weight: bold;
            color: #172554;
            white-space: nowrap;
        }

        .brand span {
            color: #7c3aed;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #334155;
            font-size: 14px;
            font-weight: 600;
            transition: 0.2s;
        }

        .nav-links a:hover,
        .nav-links a.active {
            color: #7c3aed;
        }

        .nav-links .btn-primary {
            color: white;
        }

        /* Buttons */

        .btn {
            display: inline-block;
            padding: 13px 23px;
            background: #7c3aed;
            color: white;
            border-radius: 9px;
            font-weight: bold;
            font-size: 14px;
            border: none;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn:hover {
            background: #6d28d9;
            transform: translateY(-2px);
        }

        .btn-primary {
            background: #7c3aed;
            color: white;
        }

        .btn-outline {
            display: inline-block;
            padding: 12px 22px;
            border: 1px solid #7c3aed;
            border-radius: 9px;
            color: #7c3aed;
            font-weight: bold;
        }

        .btn-outline:hover {
            background: #f3e8ff;
        }

        /* Hero */

        .hero {
            margin-top: 35px;
            padding: 75px 55px;
            border-radius: 24px;
            background: linear-gradient(
                120deg,
                #ede9fe,
                #f5f3ff,
                #e0e7ff
            );
            display: flex;
            align-items: center;
            min-height: 360px;
        }

        .hero-content {
            max-width: 650px;
        }

        .hero-label {
            display: inline-block;
            padding: 9px 14px;
            border-radius: 30px;
            background: white;
            color: #6d28d9;
            font-size: 12px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .hero h1 {
            font-size: clamp(38px, 6vw, 62px);
            line-height: 1.1;
            margin: 22px 0 18px;
            color: #172554;
        }

        .hero p {
            max-width: 520px;
            font-size: 16px;
            line-height: 1.8;
            color: #475569;
            margin-bottom: 28px;
        }

        /* Sections */

        .section {
            padding: 65px 0 10px;
        }

        .section-title {
            text-align: center;
            font-size: 30px;
            color: #172554;
            margin-bottom: 12px;
        }

        .section-subtitle {
            text-align: center;
            color: #64748b;
            line-height: 1.7;
            margin-bottom: 32px;
        }

        /* Category cards */

        .category-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .category-card {
            background: white;
            padding: 28px 18px;
            border-radius: 16px;
            text-align: center;
            border: 1px solid #e2e8f0;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.03);
            transition: 0.25s;
        }

        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(124, 58, 237, 0.10);
            border-color: #c4b5fd;
        }

        .category-icon {
            font-size: 38px;
            margin-bottom: 15px;
        }

        .category-card h3 {
            color: #172554;
            font-size: 17px;
            margin: 10px 0;
        }

        .category-card p {
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
            margin-bottom: 0;
        }

        /* Featured section */

        .content-card {
            background: white;
            padding: 40px 25px;
            border-radius: 18px;
            border: 1px solid #e2e8f0;
        }

        .empty-state {
            text-align: center;
            padding: 20px 10px;
        }

        .empty-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            color: #172554;
            font-size: 23px;
        }

        .empty-state p {
            color: #64748b;
            line-height: 1.8;
            margin-bottom: 25px;
        }

        /* Shopping benefits */

        .benefit-card {
            background: white;
            border-radius: 16px;
            padding: 25px 18px;
            text-align: center;
            border: 1px solid #e2e8f0;
            transition: 0.2s;
        }

        .benefit-card:hover {
            border-color: #c4b5fd;
            transform: translateY(-4px);
        }

        .benefit-card h3 {
            color: #172554;
            font-size: 17px;
        }

        .benefit-card p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.7;
        }

        /* Chatbot promotion */

        .chatbot-banner {
            margin-top: 60px;
            padding: 35px;
            border-radius: 20px;
            background: linear-gradient(
                120deg,
                #172554,
                #4c1d95
            );
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .chatbot-banner h2 {
            margin-top: 0;
            font-size: 26px;
        }

        .chatbot-banner p {
            color: #e2e8f0;
            line-height: 1.7;
            margin-bottom: 0;
        }

        .chatbot-banner .btn {
            background: white;
            color: #6d28d9;
            white-space: nowrap;
        }

        .chatbot-banner .btn:hover {
            background: #f3e8ff;
        }

        /* Footer */

        .footer {
            margin-top: 75px;
            background: #0f172a;
            color: #cbd5e1;
            padding: 35px 0;
        }

        .footer-inner {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .footer .brand {
            color: white;
        }

        .footer p {
            font-size: 13px;
            line-height: 1.7;
        }

        /* Mobile layout */

        @media (max-width: 900px) {
            .nav-inner {
                padding: 15px 0;
                flex-direction: column;
            }

            .nav-links {
                justify-content: center;
                gap: 15px;
            }

            .category-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .hero {
                padding: 45px 30px;
            }
        }

        @media (max-width: 500px) {
            .container {
                width: 92%;
            }

            .brand {
                font-size: 24px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a {
                font-size: 12px;
            }

            .hero {
                padding: 35px 22px;
                min-height: auto;
            }

            .hero h1 {
                font-size: 39px;
            }

            .hero p {
                font-size: 14px;
            }

            .section-title {
                font-size: 25px;
            }

            .category-grid {
                gap: 12px;
            }

            .category-card {
                padding: 22px 12px;
            }

            .chatbot-banner {
                padding: 25px 20px;
            }

            .footer-inner {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>

<body>

<%
    String context = request.getContextPath();
%>

<!-- ================= NAVIGATION ================= -->

<header class="navbar">

    <div class="container nav-inner">

        <a class="brand" href="<%= context %>/home.jsp">
            Shiny<span>Mart.</span>
        </a>

        <nav class="nav-links">

            <a class="active" href="<%= context %>/home.jsp">
                Home
            </a>

            <a href="<%= context %>/products">
                Products
            </a>

            <a href="<%= context %>/orders">
                My Orders
            </a>

            <a href="<%= context %>/cart">
                🛒 Cart
            </a>

            <!-- Chatbot link -->

            <a href="<%= context %>/chatbot">
                🤖 Chatbot
            </a>

            <a class="btn btn-primary"
               href="<%= context %>/login">
                Login
            </a>

        </nav>

    </div>

</header>


<main class="container">

    <!-- ================= HERO SECTION ================= -->

    <section class="hero">

        <div class="hero-content">

            <span class="hero-label">
                ✨ YOUR EVERYDAY MARKETPLACE
            </span>

            <h1>
                Shop Smart.<br>
                Live Better.
            </h1>

            <p>
                Welcome to ShinyMart! Discover products you love,
                explore different categories, manage your cart,
                and enjoy a simple online shopping experience.
            </p>

            <a class="btn"
               href="<%= context %>/products">
                Explore Products &nbsp; →
            </a>

            &nbsp;

            <a class="btn-outline"
               href="<%= context %>/chatbot">
                🤖 Ask Assistant
            </a>

        </div>

    </section>


    <!-- ================= CATEGORIES ================= -->

    <section class="section" id="categories">

        <h2 class="section-title">
            Explore Categories
        </h2>

        <p class="section-subtitle">
            Find something special for your everyday needs.
        </p>

        <div class="category-grid">

            <a class="category-card"
               href="<%= context %>/products?category=Electronics">

                <div class="category-icon">🎧</div>

                <h3>Electronics</h3>

                <p>
                    Discover everyday technology.
                </p>

            </a>


            <a class="category-card"
               href="<%= context %>/products?category=Fashion">

                <div class="category-icon">👗</div>

                <h3>Fashion</h3>

                <p>
                    Find your personal style.
                </p>

            </a>


            <a class="category-card"
               href="<%= context %>/products?category=Home">

                <div class="category-icon">🏡</div>

                <h3>Home & Living</h3>

                <p>
                    Make your home comfortable.
                </p>

            </a>


            <a class="category-card"
               href="<%= context %>/products?category=Accessories">

                <div class="category-icon">⌚</div>

                <h3>Accessories</h3>

                <p>
                    Discover little things you love.
                </p>

            </a>

        </div>

    </section>


    <!-- ================= FEATURED PRODUCTS ================= -->

    <section class="section" id="products">

        <h2 class="section-title">
            Find Your Next Favourite
        </h2>

        <p class="section-subtitle">
            Explore products available from ShinyMart sellers.
        </p>

        <div class="content-card">

            <div class="empty-state">

                <div class="empty-icon">🛍️</div>

                <h3>
                    Your next favourite is waiting!
                </h3>

                <p>
                    Browse our product listings to discover
                    something you love.
                </p>

                <a class="btn btn-primary"
                   href="<%= context %>/products">
                    Browse All Products →
                </a>

            </div>

        </div>

    </section>


    <!-- ================= BENEFITS ================= -->

    <section class="section">

        <h2 class="section-title">
            Shopping Made Simpler
        </h2>

        <p class="section-subtitle">
            Enjoy a convenient shopping experience with ShinyMart.
        </p>

        <div class="category-grid">

            <div class="benefit-card">

                <div class="category-icon">🔎</div>

                <h3>Easy Discovery</h3>

                <p>
                    Browse and search for products.
                </p>

            </div>


            <div class="benefit-card">

                <div class="category-icon">🛒</div>

                <h3>Simple Cart</h3>

                <p>
                    View and manage your cart items.
                </p>

                <a href="<%= context %>/cart">
                    Open Cart →
                </a>

            </div>


            <div class="benefit-card">

                <div class="category-icon">📦</div>

                <h3>My Orders</h3>

                <p>
                    Visit your order history.
                </p>

                <a href="<%= context %>/orders">
                    View Orders →
                </a>

            </div>


            <div class="benefit-card">

                <div class="category-icon">🤖</div>

                <h3>Smart Assistant</h3>

                <p>
                    Get help with shopping and orders.
                </p>

                <a href="<%= context %>/chatbot">
                    Chat Now →
                </a>

            </div>

        </div>

    </section>


    <!-- ================= CHATBOT BANNER ================= -->

    <section class="chatbot-banner">

        <div>

            <h2>
                🤖 Need Help? Ask Our Smart Assistant!
            </h2>

            <p>
                Have questions about products, registration,
                your cart, checkout, orders, or reviews?
                Our ShinyMart chatbot can help.
            </p>

        </div>

        <div>

            <a class="btn"
               href="<%= context %>/chatbot">
                Start Chatting →
            </a>

        </div>

    </section>

</main>


<!-- ================= FOOTER ================= -->

<footer class="footer">

    <div class="container footer-inner">

        <div>

            <a class="brand"
               href="<%= context %>/home.jsp">
                Shiny<span>Mart.</span>
            </a>

            <p>
                Smart Shopping. Simple Experience.
            </p>

        </div>

        <p>
            © 2026 ShinyMart. All rights reserved.
        </p>

    </div>

</footer>

</body>

</html>
