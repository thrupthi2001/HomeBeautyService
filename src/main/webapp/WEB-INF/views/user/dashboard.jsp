<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>

    <!-- Font Awesome (NO EMOJI ISSUES EVER) -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="/css/style.css">

    <style>
        .layout { display: flex; min-height: 100vh; }

        /* SIDEBAR */
        .sidebar {
            width: 240px;
            background: #1f1f1f;
            color: white;
            padding: 25px 20px;
        }
        .sidebar h3 { margin-bottom: 20px; }
        .sidebar a {
            display: block;
            color: white;
            padding: 12px;
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 8px;
        }
        .sidebar a i { width: 20px; }
        .sidebar a:hover { background: #333; }

        /* CONTENT */
        .content { flex: 1; padding: 40px; }

        .glass {
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            padding: 35px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .welcome {
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 25px;
        }

        /* SEARCH */
        .search-box {
            display: flex;
            gap: 12px;
            margin-bottom: 35px;
        }
        .search-box input,
        .search-box select {
            padding: 12px;
            width: 100%;
            border-radius: 10px;
            border: 1px solid #ccc;
        }
        .search-box button {
            padding: 12px 28px;
            background: #1976d2;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
        }

        /* CATEGORIES */
        .category-title {
            font-size: 22px;
            margin-bottom: 15px;
        }

        .category-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .category-card {
            background: white;
            padding: 30px 20px;
            border-radius: 18px;
            text-align: center;
            box-shadow: 0 12px 28px rgba(0,0,0,0.12);
            transition: 0.3s;
        }

        .category-card:hover {
            transform: translateY(-6px);
        }

        .category-icon {
            font-size: 42px;
            color: #ff416c;
            margin-bottom: 12px;
        }

        .category-name {
            font-weight: 600;
            font-size: 16px;
        }

        .category-sub {
            font-size: 13px;
            color: #666;
            margin-top: 4px;
        }

        .services-btn {
            display: inline-block;
            margin-top: 40px;
            padding: 14px 32px;
            background: linear-gradient(135deg, #ff416c, #ff4b2b);
            color: white;
            text-decoration: none;
            border-radius: 30px;
            font-weight: 600;
        }
    </style>
</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <h3><i class="fa-solid fa-user"></i> User Dashboard</h3>

        <a href="/user/dashboard">
            <i class="fa-solid fa-house"></i> Home
        </a>

        <a href="/user/services">
            <i class="fa-solid fa-screwdriver-wrench"></i> Services
        </a>

        <a href="/user/profile">
            <i class="fa-solid fa-user-gear"></i> My Profile
        </a>

        <a href="/user/bookings">
            <i class="fa-solid fa-box"></i> My Bookings
        </a>

        <a href="/user/logout">
            <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>
    </div>

    <!-- CONTENT -->
    <div class="content">
        <div class="glass">

            <div class="welcome">
                Hello ${sessionScope.user.name}, Welcome
            </div>
<!-- SUBSCRIPTION BADGE -->
<c:choose>
    <c:when test="${not empty activeSubscription}">

        <c:choose>
            <c:when test="${remainingDays le 5}">
                <div style="background:linear-gradient(135deg,#ff512f,#dd2476);
                            color:white;padding:20px;border-radius:16px;margin-bottom:25px;">
                    <h3><i class="fa-solid fa-triangle-exclamation"></i>
                        Subscription Expiring Soon
                    </h3>

                    <p style="font-size:18px;font-weight:600;">
                        ${activeSubscription.subscriptionPlan.name}
                    </p>

                    <p>⏳ Only <b>${remainingDays}</b> days left</p>

                    <a href="/user/subscriptions"
                       style="background:white;color:#dd2476;
                              padding:10px 22px;border-radius:20px;
                              text-decoration:none;font-weight:700;">
                        View Subscription
                    </a>
                </div>
            </c:when>

            <c:otherwise>
                <div style="background:linear-gradient(135deg,#11998e,#38ef7d);
                            color:white;padding:20px;border-radius:16px;margin-bottom:25px;">
                    <h3><i class="fa-solid fa-crown"></i> Active Subscription</h3>

                    <p style="font-size:18px;font-weight:600;">
                        ${activeSubscription.subscriptionPlan.name}
                    </p>

                    <p>⏳ <b>${remainingDays}</b> days remaining</p>

                    <small>Valid till: ${activeSubscription.endDate}</small>

                    <br><br>
                    <a href="/user/subscriptions"
                       style="background:white;color:#11998e;
                              padding:8px 18px;border-radius:20px;
                              text-decoration:none;font-weight:700;">
                        View Subscription
                    </a>
                    
                    <a href="/user/subscription/usage"
   style="display:inline-block;margin-top:10px;
          background:#ffffff;color:#11998e;
          padding:8px 18px;border-radius:20px;
          text-decoration:none;font-weight:700;">
    View Booked Services
</a>
                </div>
            </c:otherwise>
        </c:choose>

    </c:when>

    <c:otherwise>
        <div style="background:#f5f5f5;padding:20px;border-radius:16px;
                    margin-bottom:25px;border:2px dashed #ccc;">
            <h3><i class="fa-solid fa-circle-xmark"></i> No Active Subscription</h3>

            <a href="/user/subscriptions"
               style="background:#ff416c;color:white;
                      padding:10px 22px;border-radius:20px;
                      text-decoration:none;font-weight:600;">
                View Plans
            </a>
        </div>
    </c:otherwise>
</c:choose>

           
            
            <!-- WALLET + STREAK -->
<div style="display:flex;gap:20px;margin-bottom:30px;">

    <div style="
        flex:1;
        background:linear-gradient(135deg,#43cea2,#185a9d);
        color:white;
        padding:20px;
        border-radius:16px;
        box-shadow:0 10px 25px rgba(0,0,0,0.2);
    ">
        <h3><i class="fa-solid fa-wallet"></i> Wallet Balance</h3>
        <p style="font-size:28px;font-weight:700;">
            ₹ ${walletBalance}
        </p>
        <small>Auto-earned from streak rewards</small>
    </div>

    <div style="
        flex:1;
        background:linear-gradient(135deg,#ff512f,#dd2476);
        color:white;
        padding:20px;
        border-radius:16px;
        box-shadow:0 10px 25px rgba(0,0,0,0.2);
    ">
        <h3><i class="fa-solid fa-fire"></i> Service Streak</h3>
        <p style="font-size:28px;font-weight:700;">
            ${currentStreak} services
        </p>
        <small>Complete more to earn discounts</small>
    </div>

</div>
            

            <!-- SEARCH -->
            <form class="search-box" action="/user/search" method="get">
                <input type="text" name="q" placeholder="Search for services…">

                <select name="categoryId">
                    <option value="">All Categories</option>
                    <c:forEach var="c" items="${categories}">
                        <option value="${c.id}">${c.name}</option>
                    </c:forEach>
                </select>

                <button>
                    <i class="fa-solid fa-magnifying-glass"></i> Search
                </button>
            </form>

            <!-- CATEGORIES -->
            <div class="category-title">What are you looking for?</div>

            <div class="category-grid">
                <c:forEach var="c" items="${categories}">
                    <a href="/user/category/${c.id}" style="text-decoration:none;color:black;">
                        <div class="category-card">

                            <div class="category-icon">
                                <c:choose>
                                    <c:when test="${c.name eq 'Beauty & Wellness'}">
                                        <i class="fa-solid fa-spa"></i>
                                    </c:when>
                                    <c:when test="${c.name eq 'Appliance Repair'}">
                                        <i class="fa-solid fa-plug-circle-bolt"></i>
                                    </c:when>
                                    <c:when test="${c.name eq 'Home Cleaning & Maintenance'}">
                                        <i class="fa-solid fa-broom"></i>
                                    </c:when>
                                    <c:when test="${c.name eq 'Pest Control'}">
                                        <i class="fa-solid fa-bug-slash"></i>
                                    </c:when>
                                    <c:when test="${c.name eq 'Gardening & Outdoor'}">
                                        <i class="fa-solid fa-seedling"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-solid fa-hammer"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="category-name">${c.name}</div>

                            <div class="category-sub">
                                <c:choose>
                                    <c:when test="${c.name eq 'Beauty & Wellness'}">
                                        Salon & spa services at home
                                    </c:when>
                                    <c:when test="${c.name eq 'Appliance Repair'}">
                                        Fast repairs for everyday appliances
                                    </c:when>
                                    <c:when test="${c.name eq 'Home Cleaning & Maintenance'}">
                                        Deep cleaning & regular upkeep
                                    </c:when>
                                    <c:when test="${c.name eq 'Pest Control'}">
                                        Safe & long-lasting pest solutions
                                    </c:when>
                                    <c:when test="${c.name eq 'Gardening & Outdoor'}">
                                        Garden care & outdoor maintenance
                                    </c:when>
                                    <c:otherwise>
                                        Skilled professionals for home repairs
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                    </a>
                </c:forEach>
            </div>

            <a href="/user/services" class="services-btn">
                <i class="fa-solid fa-list"></i> View All Services
            </a>

        </div>
    </div>

</div>

</body>
</html>
