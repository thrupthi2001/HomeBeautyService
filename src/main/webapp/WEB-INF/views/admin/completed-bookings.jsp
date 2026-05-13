<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<title>Completed Bookings</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>

<nav>
<a href="/admin/dashboard">Dashboard</a>
<a href="/admin/bookings/completed">Completed Bookings</a>
<a href="/admin/logout">Logout</a>
</nav>

<div class="container">
<h2>Completed Bookings</h2>

<table border="1" width="100%" cellpadding="10">
<tr>
<th>Service</th>
<th>User</th>
<th>Helper</th>
<th>Status</th>
<th>Proof</th>
<th>Date</th>
</tr>

<c:forEach var="b" items="${bookings}">
<tr>
<td>${b.service.title}</td>
<td>${b.user.name}</td>
<td>${b.helper.name}</td>
<td>${b.status}</td>
<td>
<c:if test="${b.completionPhoto != null}">
<img src="${b.completionPhoto}" width="100">
</c:if>
</td>
<td>${b.createdAt}</td>
</tr>
</c:forEach>

</table>
</div>

</body>
</html>
