<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Helper Services</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.page-title {
    color:white;
    font-size:26px;
    margin-bottom:20px;
}

.view-btn {
    display:inline-block;
    margin-top:10px;
    padding:8px 14px;
    background:#1976d2;
    color:white;
    border-radius:20px;
    text-decoration:none;
    font-size:14px;
}

.portfolio img {
    width:55px;
    height:55px;
    border-radius:6px;
    margin-right:6px;
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

<h2 class="page-title">
    🛠 Services by ${helper.name}
</h2>

<div class="services-grid">

<c:forEach var="s" items="${services}">
    <c:if test="${s.status == 'APPROVED'}">
        <div class="service-card">

            <img src="${s.image}" alt="${s.title}">

            <!-- Portfolio thumbnails -->
            <c:if test="${not empty s.images}">
                <div class="portfolio" style="margin:10px 0;">
                    <c:forEach var="img" items="${s.images}">
                        <img src="${img.imagePath}">
                    </c:forEach>
                </div>
            </c:if>

            <h3>${s.title}</h3>
            <p>${s.description}</p>
            <strong>₹ ${s.price}</strong>

            <!-- VIEW DETAILS -->
            <a class="view-btn" href="/services/details/${s.id}">
                🔍 View Details
            </a>

        </div>
    </c:if>
</c:forEach>

</div>
</div>

</body>
</html>
