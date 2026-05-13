<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Available Jobs</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>
.job-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
}
@media (max-width: 1024px) {
    .job-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 600px) {
    .job-grid { grid-template-columns: 1fr; }
}
.job-card {
    background: #fff;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}
.job-card img {
    width: 100%;
    border-radius: 6px;
}
.btn {
    display: inline-block;
    margin-top: 10px;
    padding: 8px 12px;
    background: #1976d2;
    color: white;
    text-decoration: none;
    border-radius: 4px;
}
.offline-card {
    background: #ffebee;
    color: #c62828;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
    font-weight: 600;
    margin-top: 30px;
}
</style>
</head>

<body>

<!-- 🔝 TOP NAV -->
<nav class="top-nav">
    <div class="nav-left">
        <a href="<c:url value='/helper/dashboard'/>">Dashboard</a>
        <a href="<c:url value='/helper/jobs/available'/>">Available Jobs</a>
    </div>
    <div class="nav-right">
        <a class="profile" href="<c:url value='/helper/profile'/>">Profile</a>
        <a class="logout" href="<c:url value='/helper/logout'/>">Logout</a>
    </div>
</nav>

<div class="container">
    <h2>Available Jobs</h2>

    <!-- 🛡️ SAFETY DEFAULT -->
    <c:if test="${offline == null}">
        <c:set var="offline" value="false"/>
    </c:if>

    <!-- 🔴 OFFLINE MESSAGE -->
    <c:if test="${offline}">
        <div class="offline-card">
            ⚠ You are currently <strong>Offline</strong>.<br><br>
            Go <strong>Online</strong> from your profile to start receiving jobs.
        </div>
    </c:if>

    <!-- 🟢 ONLINE JOB LIST -->
    <c:if test="${!offline}">
        <c:if test="${empty bookings}">
            <p>No jobs available right now.</p>
        </c:if>

        <div class="job-grid">
            <c:forEach var="b" items="${bookings}">
                <div class="job-card">
                    <img src="${b.service.image}">
                    <h3>${b.service.title}</h3>

                    <a class="btn"
                       href="<c:url value='/helper/job/${b.id}'/>">
                        View Details
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

</body>
</html>
