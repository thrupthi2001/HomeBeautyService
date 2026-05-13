<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Subscription Usage</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- GLOBAL STYLE -->
    <link rel="stylesheet" href="/css/style.css">

    <style>
        /* PAGE CENTERING */
        .page-wrapper {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 20px;
        }

        /* CARD */
        .usage-container {
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            padding: 35px;
            width: 100%;
            max-width: 1100px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        /* HEADER */
        .usage-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .usage-header h2 {
            font-size: 24px;
            font-weight: 700;
        }

        .back-btn {
            text-decoration: none;
            font-weight: 600;
            color: #1976d2;
        }

        /* TABLE */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background: linear-gradient(135deg,#11998e,#38ef7d);
            color: white;
            font-weight: 600;
        }

        /* BADGES */
        .badge-ok {
            background: #2ecc71;
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .badge-full {
            background: #e74c3c;
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .empty-msg {
            margin-top: 20px;
            font-weight: 600;
            color: #777;
            text-align: center;
        }
    </style>
</head>

<body>

<div class="page-wrapper">
    <div class="usage-container">

        <!-- HEADER -->
        <div class="usage-header">
            <h2>
                <i class="fa-solid fa-crown"></i>
                ${subscription.subscriptionPlan.name} – Usage
            </h2>

            <a href="/user/dashboard" class="back-btn">
                <i class="fa-solid fa-arrow-left"></i> Dashboard
            </a>
        </div>

        <!-- EMPTY STATE -->
        <c:if test="${empty usages}">
            <div class="empty-msg">
                No services available under this subscription.
            </div>
        </c:if>

        <!-- USAGE TABLE -->
        <c:if test="${not empty usages}">
            <table>
                <tr>
                    <th>Service</th>
                    <th>Allowed</th>
                    <th>Booked</th>
                    <th>Remaining</th>
                    <th>Status</th>
                </tr>

                <c:forEach var="u" items="${usages}">
                    <c:set var="remaining" value="${u.allowedCount - u.usedCount}" />

                    <tr>
                        <td>${u.service.title}</td>
                        <td>${u.allowedCount}</td>
                        <td>${u.usedCount}</td>
                        <td>${remaining}</td>
                        <td>
                            <c:choose>
                                <c:when test="${remaining gt 0}">
                                    <span class="badge-ok">Available</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-full">Fully Used</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

    </div>
</div>

</body>
</html>
