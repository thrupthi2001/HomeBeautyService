<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Job Details</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>
.details-card {
    max-width: 700px;
    margin: 40px auto;
    background: #fff;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
.details-card img {
    width: 100%;
    border-radius: 6px;
    margin-bottom: 15px;
}
.actions {
    display: flex;
    gap: 15px;
    margin-top: 20px;
}
.btn {
    padding: 10px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    color: white;
    font-size: 15px;
}
.btn-accept { background: #2e7d32; }
.btn-decline { background: #c62828; }
</style>
</head>

<body>

<div class="details-card">

    <img src="${booking.service.image}">
    <h2>${booking.service.title}</h2>
    <p>${booking.service.description}</p>

    <h3>₹ ${booking.service.price}</h3>
    <hr>

    <p><strong>Customer Name:</strong> ${booking.customerName}</p>
    <p><strong>Mobile Number:</strong> ${booking.customerPhone}</p>
    <p><strong>Address:</strong> ${booking.customerAddress}</p>
    <p><strong>Service Date:</strong> ${booking.serviceDate}</p>
    <p><strong>Service Time:</strong> ${booking.serviceTime}</p>

    <div class="actions">
        <form method="post"
      action="<c:url value='/helper/accept/${booking.id}'/>">
    <button class="btn btn-accept">Accept Job</button>
</form>

<form method="post"
      action="<c:url value='/helper/decline/${booking.id}'/>">
    <button class="btn btn-decline">Decline Job</button>
</form>
        
    </div>

</div>
</body>
</html>
