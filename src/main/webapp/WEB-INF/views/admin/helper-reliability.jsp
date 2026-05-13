<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Helper Reliability</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.reliability-container {
    padding: 40px;
}

.reliability-title {
    color: white;
    font-size: 26px;
    font-weight: 600;
    margin-bottom: 25px;
}

table {
    width: 100%;
    background: white;
    border-radius: 14px;
    border-collapse: collapse;
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
}

th, td {
    padding: 16px;
    text-align: left;
}

th {
    background: #f5f5f5;
    font-size: 14px;
}

.helper-photo {
    width: 46px;
    height: 46px;
    border-radius: 50%;
    object-fit: cover;
}

.badge {
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 600;
    color: white;
}

.good { background: #2e7d32; }
.avg  { background: #f9a825; }
.bad  { background: #c62828; }

.delete-btn {
    background: #e53935;
    color: white;
    border: none;
    padding: 7px 14px;
    border-radius: 18px;
    font-size: 13px;
    cursor: pointer;
}

.delete-btn:hover {
    background: #c62828;
}
</style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <div class="nav-left">
        <a href="/admin/dashboard">⬅ Dashboard</a>
    </div>
    <div class="nav-right">
        <a href="/admin/logout" class="logout">Logout</a>
    </div>
</div>

<div class="reliability-container">

    <div class="reliability-title">
        🛡️ Helper Reliability Scores
    </div>

    <!-- FLASH MESSAGES -->
    <c:if test="${not empty error}">
        <p style="color:#c62828;font-weight:600;">${error}</p>
    </c:if>

    <c:if test="${not empty success}">
        <p style="color:#2e7d32;font-weight:600;">${success}</p>
    </c:if>

    <table>
        <tr>
            <th>Photo</th>
            <th>Name</th>
            <th>Category</th>
            <th>Score</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <c:forEach var="h" items="${helpers}">

            <c:set var="score"
                   value="${reliabilityService.calculateHelperScore(
                            bookings, reviews, h.id)}"/>

            <tr>
                <td>
                    <img src="${h.profilePhoto != null ? h.profilePhoto : '/images/default-avatar.png'}"
                         class="helper-photo">
                </td>

                <td>${h.name}</td>
                <td>${h.category.name}</td>

                <td>
                    <fmt:formatNumber value="${score}" maxFractionDigits="0"/>%
                </td>

                <td>
                    <c:choose>
                        <c:when test="${score >= 80}">
                            <span class="badge good">Excellent</span>
                        </c:when>
                        <c:when test="${score >= 60}">
                            <span class="badge avg">Average</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bad">Risky</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- 🗑 DELETE ONLY IF RISKY -->
                <td>
                    <c:if test="${score < 60}">
                        <form method="post"
                              action="/admin/helpers/${h.id}/delete"
                              onsubmit="return confirm('Delete this helper permanently?');">
                            <button class="delete-btn">
                                🗑 Delete
                            </button>
                        </form>
                    </c:if>
                </td>
            </tr>

        </c:forEach>
    </table>

</div>

</body>
</html>
