<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<title>Customer Reviews</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>

<nav>
<a href="/admin/dashboard">Dashboard</a>
<a href="/admin/reviews">Reviews</a>
<a href="/admin/logout">Logout</a>
</nav>

<div class="container">
<h2>Customer Reviews</h2>

<c:forEach var="r" items="${reviews}">
<div class="box">

<h3>${r.service.title}</h3>

<p>
Rating:
<c:forEach begin="1" end="${r.rating}">⭐</c:forEach>
</p>

<p>${r.comment}</p>

<c:if test="${r.reviewPhoto != null}">
<img src="${r.reviewPhoto}" width="120">
</c:if>

<c:if test="${r.helperReply != null}">
<p><strong>Helper Reply:</strong> ${r.helperReply}</p>
</c:if>

<hr>
</div>
</c:forEach>

</div>

</body>
</html>
