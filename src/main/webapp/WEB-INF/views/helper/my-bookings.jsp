<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<title>My Jobs</title>
<link rel="stylesheet" href="/css/style.css">
<style>
.job-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
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
    background: #ff5722;
    color: white;
    border: none;
    padding: 8px;
    width: 100%;
    margin-top: 10px;
}

@media (max-width: 1024px) {
    .job-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 600px) {
    .job-grid { grid-template-columns: 1fr; }
}
</style>
</head>
<body>

<nav>
    <a href="<c:url value='/helper/dashboard'/>">Dashboard</a>
</nav>

<div class="container">
<h2>My Assigned Jobs</h2>

<c:forEach var="b" items="${jobs}">
    <div class="job-card">

        <img src="${b.service.image}" />

        <h3>${b.service.title}</h3>
        <p>Customer: ${b.customerName}</p>
        <p>Address: ${b.customerAddress}</p>
        <p>₹ ${b.service.price}</p>
        <p>Date: ${b.serviceDate}</p>
        <p>Time: ${b.serviceTime}</p>
        <p>Status: ${b.status}</p>

        <form method="post"
              action="${pageContext.request.contextPath}/helper/status">
            <input type="hidden" name="bookingId" value="${b.id}">
            <select name="status">
                <option ${b.status=='ACCEPTED'?'selected':''}>ACCEPTED</option>
                <option ${b.status=='ON_THE_WAY'?'selected':''}>ON_THE_WAY</option>
                <option ${b.status=='IN_PROGRESS'?'selected':''}>IN_PROGRESS</option>
                <option>COMPLETED</option>
            </select>
            <button class="btn">Update Status</button>
        </form>

    </div>
</c:forEach>
</div>


</body>
</html>
