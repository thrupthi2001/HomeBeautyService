<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>All Services</title>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
        <i class="fa-solid fa-screwdriver-wrench"></i>
        All Available Services
    </h2>

    <div class="services-grid">
        <c:forEach var="s" items="${services}">
            <div class="service-card">

                <img src="${s.image}" alt="${s.title}">

                <h3>
    ${s.title}
    <span style="font-size:14px;color:#fbc02d;">
        ★ ${reviewService.getAverageServiceRating(s.id)}
    </span>
</h3>

                <p>${s.description}</p>

                <strong style="color:#1b5e20;">₹ ${s.price}</strong>
                
                <c:if test="${subscriptionService.isIncluded(user.id, s.id)}">
    <div style="color:#2e7d32;font-weight:600;margin-top:6px;">
        ✔ Included in your subscription
    </div>
</c:if>

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
