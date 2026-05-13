<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>All Bookings</title>
<link rel="stylesheet" href="/css/style.css">

<style>
table {
    width:100%;
    background:white;
    border-radius:12px;
    border-collapse: collapse;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}
th, td {
    padding:14px;
    text-align:left;
}
th {
    background:#f5f5f5;
}
.status {
    padding:6px 12px;
    border-radius:20px;
    font-size:12px;
    font-weight:600;
}
.COMPLETED { background:#d4edda; color:#155724; }
.BOOKED { background:#fff3cd; color:#856404; }
.IN_PROGRESS { background:#e3f2fd; color:#1565c0; }

.action-btn {
    padding:6px 12px;
    border-radius:20px;
    text-decoration:none;
    font-size:13px;
    margin-right:6px;
}
.view { background:#1976d2; color:white; }
.completed { background:#2e7d32; color:white; }
</style>
</head>

<body>

<nav>
<a href="/admin/dashboard">Dashboard</a>
<a href="/admin/bookings">Bookings</a>
<a href="/admin/logout">Logout</a>
</nav>

<div class="container">
<h2>📦 Live Bookings</h2>

<table>
<tr>
    <th>ID</th>
    <th>Customer</th>
    <th>Service</th>
    <th>Helper</th>
    <th>Booking Date</th>
    <th>Status</th>
    <th>Actions</th>
</tr>

<c:forEach var="b" items="${bookings}">
<tr>
    <td>${b.id}</td>
    <td>${b.customerName}</td>
    <td>${b.service.title}</td>

    <td>
        <c:choose>
            <c:when test="${b.helper != null}">
                ${b.helper.name}
            </c:when>
            <c:otherwise>
                Not Assigned
            </c:otherwise>
        </c:choose>
    </td>

    <!-- BOOKING DATE -->
    <td>${b.formattedCreatedAt}</td>

    <!-- STATUS -->
    <td>
        <span class="status ${b.status}">
            ${b.status}
        </span>
    </td>

    <!-- ACTIONS -->
    <td>
    <a class="action-btn view"
       href="/admin/bookings/${b.id}">
       👁 View
    </a>
</td>
</tr>
</c:forEach>

</table>
</div>

</body>
</html>
