<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Pending Services</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.portfolio img {
    width: 60px;
    height: 60px;
    border-radius: 6px;
    margin-right: 6px;
    cursor: pointer;
}
.reason-box {
    width:100%;
    margin-top:8px;
}
</style>
</head>

<body>

<div class="top-nav">
    <div class="nav-left">
        <a href="/admin/dashboard">⬅ Dashboard</a>
    </div>
    <div class="nav-right">
        <a class="logout" href="/admin/logout">Logout</a>
    </div>
</div>

<div class="container">
<h2>🕒 Pending Services (Approval Required)</h2>

<div class="services-grid">

<c:forEach var="s" items="${services}">
    <div class="service-card">

        <img src="${s.image}">

        <c:if test="${not empty s.images}">
            <div class="portfolio" style="margin:10px 0;">
                <c:forEach var="img" items="${s.images}">
                    <a href="${img.imagePath}" target="_blank">
                        <img src="${img.imagePath}">
                    </a>
                </c:forEach>
            </div>
        </c:if>

        <h3>${s.title}</h3>
        <p>${s.description}</p>
        <strong>₹ ${s.price}</strong>

        <!-- APPROVE -->
        <a href="/admin/services/approve/${s.id}"
           onclick="return confirm('Approve this service?')">
           ✅ Approve
        </a>

        <!-- REJECT -->
        <!-- REJECT -->
<a href="/admin/services/reject/${s.id}"
   style="margin-left:10px;color:#d32f2f;font-weight:600;">
   ❌ Reject
</a>
        

    </div>
</c:forEach>

</div>
</div>

</body>
</html>
