<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Helper Reports</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.reports-container {
    padding: 40px;
}

.reports-title {
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
    vertical-align: middle;
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
    display: inline-block;
}

.safe { background: #2e7d32; }
.warn { background: #f9a825; }
.high { background: #c62828; }

.action-btn {
    background: #ff5722;
    color: white;
    padding: 8px 16px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
}

.action-btn:hover {
    background: #e64a19;
}

/* 🔴 DELETE BUTTON */
.delete-btn {
    background: #c62828;
    margin-left: 10px;
}

.delete-btn:hover {
    background: #b71c1c;
}
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

<div class="reports-container">

    <div class="reports-title">
        ⚠️ Helper Reports & Warnings
    </div>

    <table>
        <tr>
            <th>Photo</th>
            <th>Name</th>
            <th>Category</th>
            <th>Reports</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <c:forEach var="h" items="${helpers}">
            <c:set var="count" value="${reportService.countReports(h.id)}"/>

            <tr>
                <!-- PHOTO -->
                <td>
                    <img src="${h.profilePhoto != null ? h.profilePhoto : '/images/default-avatar.png'}"
                         class="helper-photo">
                </td>

                <!-- NAME -->
                <td>${h.name}</td>

                <!-- CATEGORY -->
                <td>${h.category.name}</td>

                <!-- REPORT COUNT -->
                <td>${count}</td>

                <!-- STATUS -->
                <td>
                    <c:choose>
                        <c:when test="${count >= 7}">
                            <span class="badge high">High Risk</span>
                        </c:when>
                        <c:when test="${count >= 3}">
                            <span class="badge warn">Warning</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge safe">Safe</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- ACTION -->
                <td>
    <!-- View Reports (always visible) -->
    <a class="action-btn"
       href="/admin/helpers/reports/${h.id}">
        View Reports
    </a>

    <!-- Delete Helper (only if High Risk) -->
    <c:if test="${count >= 7}">
        <a class="action-btn delete-btn"
           href="/admin/helpers/delete/${h.id}"
           onclick="return confirm('⚠️ Are you sure you want to delete this helper? This action cannot be undone.');">
            Delete
        </a>
    </c:if>
</td>

            </tr>

        </c:forEach>
    </table>

</div>

</body>
</html>
