<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Subscription</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Global Style -->
    <link rel="stylesheet" href="/css/style.css">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #ff416c, #ff4b2b);
            font-family: "Segoe UI", sans-serif;
        }

        /* TOP NAV */
        .top-nav {
            background: #111;
            padding: 16px 30px;
        }

        .top-nav a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        /* CENTER WRAPPER */
        .center-wrapper {
            min-height: calc(100vh - 64px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        /* CARD */
        .card {
            width: 520px;
            background: #fff;
            border-radius: 22px;
            padding: 35px 40px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.25);
        }

        .card h2 {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 25px;
            font-size: 26px;
        }

        /* TABLE */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f5f5f5;
        }

        th {
            text-align: left;
            padding: 14px 12px;
            font-size: 14px;
            color: #555;
        }

        td {
            padding: 16px 12px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
            font-size: 15px;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        /* PLAN NAME */
        .plan-name {
            font-weight: 600;
            line-height: 1.4;
        }

        /* BUTTON */
        .btn-view {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            padding: 8px 18px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
            text-align: center;
            transition: 0.3s;
        }

        .btn-view:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.25);
        }

        /* EMPTY */
        .empty {
            text-align: center;
            color: #777;
            font-weight: 600;
            padding: 20px;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<div class="top-nav">
    <a href="/admin/subscriptions">
        <i class="fa-solid fa-arrow-left"></i> Subscriptions
    </a>
</div>

<!-- CONTENT -->
<div class="center-wrapper">
    <div class="card">

        <h2>
            <i class="fa-solid fa-box"></i>
            Select Subscription
        </h2>

        <table>
            <thead>
                <tr>
                    <th>Plan Name</th>
                    <th style="text-align:right;">Action</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="p" items="${plans}">
                    <tr>
                        <td class="plan-name">${p.name}</td>
                        <td style="text-align:right;">
                            <a href="/admin/subscriptions/${p.id}/users"
                               class="btn-view">
                                View Users
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty plans}">
                    <tr>
                        <td colspan="2" class="empty">
                            No subscription plans found.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

    </div>
</div>

</body>
</html>
