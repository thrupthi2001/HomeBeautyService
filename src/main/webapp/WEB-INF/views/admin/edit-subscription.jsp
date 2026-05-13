<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Subscription Plan</title>

    <!-- GLOBAL STYLE -->
    <link rel="stylesheet" href="/css/style.css">

    <style>
        .page-wrapper {
            min-height: 100vh;
            background: linear-gradient(135deg, #ff5252, #d81b60);
            padding: 30px;
        }

        .admin-card {
            max-width: 1200px;
            margin: auto;
            background: #ffffff;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 18px 45px rgba(0,0,0,0.25);
        }

        .admin-card h2 {
            font-size: 26px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 22px;
            margin-bottom: 30px;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 6px;
            display: block;
        }

        .form-group input {
            width: 100%;
            padding: 11px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .services-section h3 {
            margin-bottom: 18px;
            font-size: 20px;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 18px;
        }

        .service-card {
            background: #f9f9f9;
            padding: 16px;
            border-radius: 14px;
            box-shadow: 0 6px 16px rgba(0,0,0,0.08);
        }

        .service-card h4 {
            font-size: 15px;
            margin-bottom: 6px;
        }

        .service-card .price {
            font-size: 14px;
            font-weight: 600;
            color: #2e7d32;
            margin-bottom: 10px;
        }

        .service-card label {
            font-size: 13px;
            font-weight: 600;
        }

        .service-card input {
            width: 100%;
            padding: 8px;
            border-radius: 8px;
            border: 1px solid #bbb;
            margin-top: 5px;
        }

        .actions {
            margin-top: 35px;
            text-align: right;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff5252, #e53935);
            color: white;
            border: none;
            padding: 13px 28px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(0,0,0,0.25);
            transition: 0.25s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.3);
        }

        .top-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #111;
            padding: 16px 28px;
        }

        .top-nav a {
            color: white;
            text-decoration: none;
            font-weight: 600;
        }

        .logout {
            background: #ff4b2b;
            padding: 8px 18px;
            border-radius: 20px;
        }
    </style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <a href="/admin/subscriptions">← Back to Plans</a>
    <a href="/admin/logout" class="logout">Logout</a>
</div>

<div class="page-wrapper">

    <div class="admin-card">

        <h2>✏️ Edit Subscription Plan</h2>

        <form method="post" action="/admin/subscriptions/edit">

            <!-- HIDDEN ID -->
            <input type="hidden" name="planId" value="${plan.id}" />

            <!-- PLAN DETAILS -->
            <div class="form-grid">

                <div class="form-group">
                    <label>Plan Name</label>
                    <input type="text" name="name"
                           value="${plan.name}" required>
                </div>

                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" name="price"
                           value="${plan.price}" required>
                </div>

                <div class="form-group">
                    <label>Duration (days)</label>
                    <input type="number" name="durationDays"
                           value="${plan.durationDays}" required>
                </div>

            </div>

            <!-- SERVICES -->
            <div class="services-section">
                <h3>Included Services</h3>

                <div class="services-grid">

                    <c:forEach var="s" items="${services}">
                        <div class="service-card">

                            <h4>${s.title}</h4>
                            <div class="price">₹ ${s.price}</div>

                            <input type="hidden" name="serviceIds" value="${s.id}" />

                            <label>Allowed Uses</label>
                            <input type="number"
                                   name="allowedCounts"
                                   min="0"
                                   value="<c:forEach var='i' items='${plan.items}'><c:if test='${i.service.id == s.id}'>${i.allowedCount}</c:if></c:forEach>" />
                        </div>
                    </c:forEach>

                </div>
            </div>

            <!-- ACTION -->
            <div class="actions">
                <button class="btn-primary">
                    Update Subscription
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>
