<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Subscription Plans</title>

<style>
    body {
        margin: 0;
        font-family: "Segoe UI", sans-serif;
        background: linear-gradient(135deg, #ff416c, #ff4b2b);
    }

    /* TOP NAV */
    .top-nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 18px 30px;
        background: #111;
    }

    .top-nav a {
        color: #fff;
        text-decoration: none;
        font-weight: 600;
    }

    .logout {
        background: #ff4b2b;
        padding: 8px 16px;
        border-radius: 20px;
    }

    /* PAGE */
    .container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 0 20px;
    }

    h2 {
        color: #fff;
        margin-bottom: 25px;
    }

    /* ACTIVE SUB BOX */
    .success-box {
        background: #e7f8ef;
        color: #1e8e3e;
        padding: 14px 20px;
        border-radius: 10px;
        font-weight: 600;
        margin-bottom: 30px;
    }

    /* GRID */
    .services-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        gap: 25px;
    }

    /* CARD */
    .service-card {
        background: #fff;
        border-radius: 16px;
        padding: 24px;
        box-shadow: 0 12px 30px rgba(0,0,0,0.25);
        display: flex;
        flex-direction: column;
        transition: 0.3s;
    }

    .service-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 18px 40px rgba(0,0,0,0.3);
    }

    .service-card h3 {
        margin: 0 0 8px;
        font-size: 18px;
    }

    .price {
        font-weight: 700;
        margin-bottom: 14px;
        color: #333;
    }

    /* SERVICES LIST */
    .services-list {
        list-style: none;
        padding: 0;
        margin: 0 0 20px;
        flex-grow: 1;
    }

    .services-list li {
        font-size: 14px;
        padding: 6px 0;
        display: flex;
        justify-content: space-between;
        border-bottom: 1px dashed #eee;
    }

    .count {
        font-weight: 700;
        color: #3f51b5;
    }

    /* BUTTONS */
    .btn {
        text-align: center;
        padding: 12px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 700;
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        color: #fff;
        transition: 0.3s;
    }

    .btn:hover {
        opacity: 0.9;
    }

    .btn.disabled {
        background: #ccc;
        cursor: not-allowed;
    }
</style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <a href="/user/dashboard">⬅ Dashboard</a>
    <a class="logout" href="/user/logout">Logout</a>
</div>

<div class="container">

    <h2>🔔 Subscription Plans</h2>

    <c:if test="${activeSubscription.isPresent()}">
        <div class="success-box">
            ✅ You already have an active subscription till
            <strong>${activeSubscription.get().endDate}</strong>
        </div>
    </c:if>

    <div class="services-grid">
        <c:forEach var="p" items="${plans}">

            <div class="service-card">

                <h3>${p.name}</h3>
                <div class="price">
                    ₹ ${p.price} / ${p.durationDays} days
                </div>

                <ul class="services-list">
                    <c:forEach var="i" items="${p.items}">
                        <c:if test="${i.allowedCount > 0}">
                            <li>
                                <span>${i.service.title}</span>
                                <span class="count">× ${i.allowedCount}</span>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>

                <c:choose>
    <c:when test="${activeSubscription.isPresent() 
                   && activeSubscription.get().subscriptionPlan.id == p.id}">
        <div class="btn disabled">Subscribed</div>
    </c:when>

    <c:when test="${activeSubscription.isPresent()}">
        <div class="btn disabled">Subscribe</div>
    </c:when>

    <c:otherwise>
        <a class="btn" href="/user/subscriptions/buy/${p.id}">
            Subscribe
        </a>
    </c:otherwise>
</c:choose>


            </div>

        </c:forEach>
    </div>

</div>

</body>
</html>
