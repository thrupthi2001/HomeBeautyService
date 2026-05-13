<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Completed Jobs</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.job-card {
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.15);
}

.job-photo {
    width:100%;
    border-radius:8px;
    margin-top:10px;
}

.badge {
    display:inline-block;
    padding:4px 10px;
    background:#d4edda;
    color:#155724;
    border-radius:20px;
    font-size:12px;
    margin-top:6px;
}
</style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <div class="nav-left">
        <a href="/admin/helpers">⬅ Back to Helpers</a>
    </div>
    <div class="nav-right">
        <a class="logout" href="/admin/logout">Logout</a>
    </div>
</div>

<div class="container">

<h2 style="color:white;margin-bottom:20px;">
    ✅ Completed Jobs by ${helper.name}
</h2>

<div class="services-grid">

<c:forEach var="b" items="${jobs}">
    <div class="job-card">

        <h3>${b.service.title}</h3>
        <p><strong>Customer:</strong> ${b.customerName}</p>
        <p><strong>Phone:</strong> ${b.customerPhone}</p>
        <p><strong>Address:</strong> ${b.customerAddress}</p>
        <p><strong>Date:</strong> ${b.serviceDate}</p>

        <span class="badge">COMPLETED</span>

        <c:if test="${not empty b.completionPhoto}">
            <a href="${b.completionPhoto}" target="_blank">
                <img src="${b.completionPhoto}" class="job-photo">
            </a>
        </c:if>

    </div>
</c:forEach>

<c:if test="${empty jobs}">
    <p style="color:white;">No completed jobs yet.</p>
</c:if>

</div>
</div>

</body>
</html>
