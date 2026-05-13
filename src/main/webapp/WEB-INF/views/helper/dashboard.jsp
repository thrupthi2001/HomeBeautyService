<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Helper Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">

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

<!-- TOP NAV -->
<div class="top-nav">
    <div class="nav-left">
        <span style="color:white;font-size:18px;">
            👋 Hello ${helper.name}
        </span>
    </div>

    <div class="nav-right">
        <a href="/helper/profile" class="profile">Profile</a>
        <a href="/helper/logout" class="logout">Logout</a>
    </div>
</div>

<!-- DASHBOARD -->
<div class="dashboard-wrapper">

    <div class="dashboard-title">
        Helper Dashboard
    </div>

    <div class="dashboard-grid">

        <!-- ADD SERVICE -->
        <div class="dashboard-card">
            <a href="/helper/services/add">
                <div class="card-icon">➕</div>
                <div class="card-title">Add Service</div>
                <div class="card-desc">
                    Add new services (approval required)
                </div>
            </a>
        </div>

        <!-- VIEW SERVICES -->
        <div class="dashboard-card">
            <a href="/helper/services">
                <div class="card-icon">🛠️</div>
                <div class="card-title">View Services</div>
                <div class="card-desc">
                    Approved & pending services
                </div>
            </a>
        </div>

        <!-- AVAILABLE JOBS -->
        <div class="dashboard-card">
            <a href="/helper/jobs/available">
                <div class="card-icon">📢</div>
                <div class="card-title">Available Jobs</div>
                <div class="card-desc">
                    New customer bookings
                </div>
            </a>
        </div>

        <!-- MY JOBS -->
        <div class="dashboard-card">
            <a href="/helper/my-jobs">
                <div class="card-icon">📋</div>
                <div class="card-title">My Jobs</div>
                <div class="card-desc">
                    Accepted jobs
                </div>
            </a>
        </div>

        <!-- COMPLETED JOBS -->
        <div class="dashboard-card">
            <a href="/helper/completed-jobs">
                <div class="card-icon">✅</div>
                <div class="card-title">Completed Jobs</div>
                <div class="card-desc">
                    Finished services
                </div>
            </a>
        </div>

        <!-- REVENUE -->
        <div class="dashboard-card">
            <a href="/helper/revenue">
                <div class="card-icon">💰</div>
                <div class="card-title">Monthly Revenue</div>
                <div class="card-desc">
                    Earnings & performance
                </div>
            </a>
        </div>
        
        <div class="dashboard-card">
    <a href="/helper/warnings">
        <div class="card-icon">⚠️</div>
        <div class="card-title">Admin Warnings</div>
        <div class="card-desc">
            View messages from admin
        </div>
    </a>
</div>
        

    </div>
</div>

</body>
</html>
