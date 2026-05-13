<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create Subscription Plan</title>
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
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .admin-card h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }

        .form-group label {
            font-weight: 600;
            display: block;
            margin-bottom: 6px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .services-section {
            margin-top: 20px;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
            gap: 18px;
        }

        .service-card {
            border-radius: 12px;
            padding: 16px;
            background: #f9f9f9;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .service-card h4 {
            font-size: 15px;
            margin-bottom: 6px;
        }

        .service-card .price {
            color: #2e7d32;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .service-card label {
            font-size: 13px;
            font-weight: 600;
        }

        .service-card input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #bbb;
        }

        .actions {
            margin-top: 30px;
            text-align: right;
        }

        .btn-primary {
            background: #ff5252;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-size: 15px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background: #e53935;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .back-link {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>

<body>

<div class="top-nav">
    <div class="nav-left">
        <a href="/admin/subscriptions" class="back-link">← Back to Plans</a>
    </div>
    <div class="nav-right">
        <a href="/admin/logout" class="logout">Logout</a>
    </div>
</div>

<div class="page-wrapper">

    <div class="admin-card">

        <h2>✨ Create Subscription Plan</h2>

        <form method="post">

            <!-- PLAN DETAILS -->
            <div class="form-grid">

                <div class="form-group">
                    <label>Plan Name</label>
                    <input type="text" name="name"
                           placeholder="Eg: Monthly Home Care Pack" required>
                </div>

                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" name="price" required>
                </div>

                <div class="form-group">
                    <label>Duration (days)</label>
                    <input type="number" name="durationDays" value="30">
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

                            <input type="hidden" name="serviceIds" value="${s.id}">

                            <label>Allowed Uses</label>
                            <input type="number"
                                   name="allowedCounts"
                                   value="1"
                                   min="0">
                        </div>
                    </c:forEach>

                </div>
            </div>

            <!-- ACTION -->
            <div class="actions">
                <button class="btn-primary">
                    Create Subscription Plan
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>
