<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Subscription Users</title>

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
            width: 760px;
            background: #fff;
            border-radius: 22px;
            padding: 35px 40px 40px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.25);
        }

        .card h2 {
            font-size: 26px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            line-height: 1.3;
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
            padding: 14px 12px;
            font-size: 14px;
            color: #555;
            text-align: left;
        }

        td {
            padding: 16px 12px;
            border-bottom: 1px solid #eee;
            font-size: 15px;
            vertical-align: middle;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        /* ALIGNMENTS */
        .center {
            text-align: center;
        }

        /* STATUS */
        .status-pill {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
            min-width: 80px;
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

        /* BACK BUTTON */
        .back-btn {
            margin-top: 28px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            padding: 10px 22px;
            border-radius: 22px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .back-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 24px rgba(0,0,0,0.3);
        }

        /* EMPTY STATE */
        .empty {
            text-align: center;
            padding: 25px;
            color: #777;
            font-weight: 600;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<div class="top-nav">
    <a href="/admin/subscriptions/users">
        <i class="fa-solid fa-arrow-left"></i> Select Plan
    </a>
</div>

<!-- CONTENT -->
<div class="center-wrapper">
    <div class="card">

        <h2>
            <i class="fa-solid fa-crown"></i>
            ${plan.name} – Users
        </h2>

        <table>
            <thead>
                <tr>
                    <th>User</th>
                    <th>Email</th>
                    <th class="center">Start Date</th>
                    <th class="center">End Date</th>
                    <th class="center">Status</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td><strong>${u.user.name}</strong></td>
                        <td>${u.user.email}</td>
                        <td class="center">${u.startDate}</td>
                        <td class="center">${u.endDate}</td>
                        <td class="center">
                            <span class="status-pill
                                ${u.status == 'ACTIVE' ? 'active' : 'inactive'}">
                                ${u.status}
                            </span>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty users}">
                    <tr>
                        <td colspan="5" class="empty">
                            No users subscribed to this plan.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <a href="/admin/subscriptions/users" class="back-btn">
            ← Back
        </a>

    </div>
</div>

</body>
</html>
