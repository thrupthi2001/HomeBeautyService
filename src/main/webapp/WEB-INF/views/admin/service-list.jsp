<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Services</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>

<nav>
    <a href="/admin/dashboard">Dashboard</a>
    <a href="/admin/logout">Logout</a>
</nav>

<div class="container">
<h2>Pending Services (Waiting for Approval)</h2>


<!-- ✅ GRID START -->
<div class="services-grid">

<c:forEach var="s" items="${services}">
    <div class="service-card">

        <img src="${s.image}" alt="${s.title}">
        <c:if test="${not empty s.images}">
    <div class="portfolio">
        <c:forEach var="img" items="${s.images}">
            <img src="${img.imagePath}" style="width:60px;height:60px;border-radius:4px;">
        </c:forEach>
    </div>
</c:if>
        <h3>${s.title}</h3>
        <p>${s.description}</p>
        <strong>₹ ${s.price}</strong>

        <div class="actions">
    <a href="/admin/services/approve/${s.id}"
       onclick="return confirm('Approve this service?')">
       Approve
    </a>
    |
    <a href="/admin/services/reject/${s.id}"
       onclick="return confirm('Reject this service?')">
       Reject
    </a>
</div>
        

    </div>
</c:forEach>

</div>
<!-- ✅ GRID END -->

</div>

</body>
</html>
