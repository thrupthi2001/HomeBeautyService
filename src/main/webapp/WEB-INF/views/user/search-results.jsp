<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Search Results</title>
<link rel="stylesheet" href="/css/style.css">
</head>

<body>

<!-- TOP NAVBAR -->
<div class="top-nav">
    <div class="nav-left">
        <a href="/user/dashboard">⬅ Dashboard</a>
    </div>
    <div class="nav-right">
        <a class="logout" href="/user/logout">Logout</a>
    </div>
</div>

<div class="container">

    <h2 style="color:white;margin-bottom:20px;">
        🔍 Search Results
    </h2>

    <c:if test="${empty services}">
        <p style="color:white;">No matching services found.</p>
    </c:if>

    <div class="services-grid">
        <c:forEach var="s" items="${services}">
            <div class="service-card">

                <img src="${s.image}">
                <h3>
    ${s.title}
    <span style="font-size:14px;color:#fbc02d;">
        ★ ${reviewService.getAverageServiceRating(s.id)}
    </span>
</h3>

                <p>${s.description}</p>

                <strong style="color:#1b5e20;">₹ ${s.price}</strong>

                <div class="actions">
                    <a href="/services/details/${s.id}" class="btn">
                        View Details
                    </a>
                </div>

            </div>
        </c:forEach>
    </div>

</div>

</body>
</html>
