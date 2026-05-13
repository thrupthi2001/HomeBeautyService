<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">

    <!-- DASHBOARD ONLY STYLES -->
    <style>
        .dashboard-wrapper {
            padding: 40px;
        }

        .dashboard-title {
            color: white;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .dashboard-card {
            background: white;
            border-radius: 14px;
            padding: 30px 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
        }

        .dashboard-card a {
            text-decoration: none;
            color: #222;
            display: block;
        }

        .card-icon {
            font-size: 38px;
            margin-bottom: 15px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .card-desc {
            font-size: 14px;
            color: #666;
        }

        @media (max-width: 900px) {
            .dashboard-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<!-- ✅ TOP NAVBAR (USING YOUR style.css) -->
<div class="top-nav">
    <div class="nav-left">
        <span style="color:white; font-size:18px;">
            👋 Hello ${admin.name}
        </span>
    </div>

    <div class="nav-right">
        <a href="/admin/profile" class="profile">Profile</a>
        <a href="/admin/logout" class="logout">Logout</a>
    </div>
</div>

<!-- ✅ DASHBOARD -->
<div class="dashboard-wrapper">

    <div class="dashboard-title">
        Admin Dashboard
    </div>

    <div class="dashboard-grid">

        <!-- 1. CATEGORY -->
        <div class="dashboard-card">
            <a href="/admin/categories">
                <div class="card-icon">🗂️</div>
                <div class="card-title">Manage Categories</div>
                <div class="card-desc">
                    Add or delete service categories
                </div>
            </a>
        </div>

        <!-- 2. APPROVE SERVICES -->
        <div class="dashboard-card">
            <a href="/admin/services/pending">
                <div class="card-icon">✅</div>
                <div class="card-title">Approve Services</div>
                <div class="card-desc">
                    Review helper-added services
                </div>
            </a>
        </div>

        <!-- 3. HELPERS -->
        <div class="dashboard-card">
            <a href="/admin/helpers">
                <div class="card-icon">🧑‍🔧</div>
                <div class="card-title">Total Helpers</div>
                <div class="card-desc">
                    View all registered helpers
                </div>
            </a>
        </div>

        <!-- 4. CUSTOMERS -->
        <div class="dashboard-card">
            <a href="/admin/customers">
                <div class="card-icon">👥</div>
                <div class="card-title">View Customers</div>
                <div class="card-desc">
                    Manage customer accounts
                </div>
            </a>
        </div>

        <!-- 5. BOOKINGS -->
        <div class="dashboard-card">
            <a href="/admin/bookings">
                <div class="card-icon">📅</div>
                <div class="card-title">View Bookings</div>
                <div class="card-desc">
                    Track service bookings
                </div>
            </a>
        </div>

        <!-- 6. Helper Reliability -->
        <div class="dashboard-card">
    <a href="/admin/helpers/reliability">
        <div class="card-icon">🛡️</div>
        <div class="card-title">Helper Reliability</div>
        <div class="card-desc">
            Trust & performance score
        </div>
    </a>
</div>

<div class="dashboard-card">
    <a href="/admin/helpers/reliability-v2">
        <div class="card-icon">⚠️</div>
        <div class="card-title">Helper Reports</div>
        <div class="card-desc">
            View reported helpers & warnings
        </div>
    </a>
</div>

<div class="dashboard-card">
    <a href="/admin/subscriptions">
        <div class="card-icon">📦</div>
        <div class="card-title">Subscription Block</div>
        <div class="card-desc">
            Create & maintain Subscription
        </div>
    </a>
</div>

        
        

    </div>
</div>

</body>
</html>
