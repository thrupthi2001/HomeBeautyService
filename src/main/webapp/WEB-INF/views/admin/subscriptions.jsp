<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Subscription Plans</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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
            padding: 8px 18px;
            border-radius: 20px;
        }

        /* PAGE */
        .page-container {
            max-width: 96%;
            margin: 40px auto;
        }

        .card {
            background: #fff;
            border-radius: 18px;
            padding: 35px 40px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
        }

        /* HEADER */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header h2 {
            font-size: 26px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .create-btn {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: #fff;
            padding: 12px 24px;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.25);
            transition: 0.3s;
        }

        .create-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.3);
        }

        /* TABLE */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f6f6f6;
        }

        th {
            padding: 14px;
            font-size: 14px;
            color: #555;
            text-align: left;
        }

        td {
            padding: 16px 14px;
            vertical-align: top;
            border-bottom: 1px solid #eee;
        }

        /* COLUMN WIDTHS */
        th:nth-child(1) { width: 20%; }
        th:nth-child(2) { width: 10%; }
        th:nth-child(3) { width: 10%; }
        th:nth-child(4) { width: 45%; }
        th:nth-child(5) { width: 15%; }

        /* SERVICES */
        .services-box {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .service-chip {
            background: linear-gradient(135deg, #eef2ff, #e0e7ff);
            color: #3730a3;
            padding: 6px 12px;
            border-radius: 18px;
            font-size: 12px;
            font-weight: 600;
            white-space: nowrap;
        }

        .muted-text {
            color: #999;
            font-size: 13px;
        }

        /* STATUS */
        .status-pill {
            padding: 7px 18px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
            text-align: center;
        }

        .status-pill.active {
            background: #e7f8ef;
            color: #1e8e3e;
        }

        .status-pill.inactive {
            background: #fdecea;
            color: #d93025;
        }
    </style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <a href="/admin/dashboard">
        <i class="fa-solid fa-arrow-left"></i> Admin Dashboard
    </a>
    <a class="logout" href="/admin/logout">Logout</a>
</div>

<div class="page-container">
    <div class="card">

        <!-- HEADER -->
        <div class="header">
            <h2>
                <i class="fa-solid fa-box"></i>
                Subscription Plans
            </h2>

            <a href="/admin/subscriptions/create" class="create-btn">
                <i class="fa-solid fa-plus"></i>
                Create Subscription
            </a>
            
            <a href="/admin/subscriptions/users" class="create-btn"
   style="background:linear-gradient(135deg,#11998e,#38ef7d);">
    <i class="fa-solid fa-users"></i>
    View Subscription Users
</a>
            
        </div>

        <!-- TABLE -->
        <table>
            <thead>
                <tr>
                    <th>Plan Name</th>
                    <th>Price</th>
                    <th>Duration</th>
                    <th>Included Services</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>
<c:forEach var="p" items="${plans}">
<tr>
    <td><strong>${p.name}</strong></td>
    <td>₹ ${p.price}</td>
    <td>${p.durationDays} days</td>

                            <td>
                            <div class="services-box">
                                <c:forEach var="i" items="${p.items}">
    <c:if test="${i.allowedCount > 0}">
        <span class="service-chip">
            ${i.service.title}
            <c:if test="${i.allowedCount > 1}">
                × ${i.allowedCount}
            </c:if>
        </span>
    </c:if>
</c:forEach>

                                <c:if test="${empty p.items}">
                                    <span class="muted-text">No services added</span>
                                </c:if>
                            </div>
                        </td>

    <td>
        <span class="status-pill ${p.status == 'ACTIVE' ? 'active' : 'inactive'}">
            ${p.status}
        </span>
        <br><br>

        <a href="/admin/subscriptions/edit/${p.id}"
           class="service-chip">Edit</a>

        <form action="/admin/subscriptions/toggle/${p.id}" method="post" style="display:inline;">
            <button class="service-chip">
                ${p.status == 'ACTIVE' ? 'Deactivate' : 'Activate'}
            </button>
        </form>

        <form action="/admin/subscriptions/delete/${p.id}" method="post"
              style="display:inline;"
              onsubmit="return confirm('Delete this subscription?')">
            <button class="service-chip" style="background:#ffebee;color:#c62828;">
                Delete
            </button>
        </form>
    </td>
</tr>
</c:forEach>
</tbody>

        </table>

    </div>
</div>

</body>
</html>
