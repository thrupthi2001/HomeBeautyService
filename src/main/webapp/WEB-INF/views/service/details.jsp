<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>${service.title}</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.details-container {
    max-width: 900px;
    margin: auto;
}
.service-header {
    display: flex;
    gap: 30px;
    margin-bottom: 30px;
}
.service-header img {
    width: 300px;
    border-radius: 8px;
}
.review-card {
    background: #fff;
    padding: 15px;
    margin-bottom: 15px;
    border-radius: 6px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}
.review-photo {
    width: 120px;
    margin-top: 10px;
    border-radius: 6px;
}
.helper-reply {
    margin-top: 10px;
    padding: 10px;
    background: #f1f8ff;
    border-left: 4px solid #1976d2;
}
.book-btn {
    display: inline-block;
    margin-top: 15px;
    padding: 10px 16px;
    background: #1976d2;
    color: white;
    text-decoration: none;
    border-radius: 4px;
}
.portfolio {
    display: flex;
    gap: 10px;
    margin-top: 15px;
    flex-wrap: wrap;
}
.portfolio img {
    width: 100px;
    height: 100px;
    object-fit: cover;
    border-radius: 6px;
}
</style>
</head>

<body>

<div class="details-container">

<!-- ================= SERVICE INFO ================= -->
<div class="service-header">
    <img src="${service.image}">
    <div>

        <c:if test="${not empty service.images}">
            <div class="portfolio">
                <c:forEach var="img" items="${service.images}">
                    <img src="${img.imagePath}">
                </c:forEach>
            </div>
        </c:if>

        <h2>${service.title}</h2>
        <p>${service.description}</p>
        <h3>₹ ${service.price}</h3>

        <a href="/booking/${service.id}" class="book-btn">
            Book Service
        </a>
    </div>
</div>

<hr>

<!-- ================= REVIEWS ================= -->
<h3>⭐ Customer Reviews</h3>

<c:if test="${empty reviews}">
    <p>No reviews yet</p>
</c:if>

<c:forEach var="r" items="${reviews}">
    <div class="review-card">

        <!-- SERVICE RATING -->
        <p>
            <strong>Service Rating:</strong>
            <c:set var="sr" value="${r.serviceRating != null ? r.serviceRating : 0}" />
            <c:forEach begin="1" end="${sr}">⭐</c:forEach>
            <c:if test="${sr == 0}">(0.0)</c:if>
        </p>

        <!-- COMMENT -->
        <p>${r.comment}</p>

        <!-- REVIEW PHOTO -->
        <c:if test="${r.reviewPhoto != null}">
            <img src="${r.reviewPhoto}" class="review-photo">
        </c:if>

        <!-- HELPER REPLY -->
        <c:if test="${r.helperReply != null}">
            <div class="helper-reply">
                <strong>Helper Reply:</strong>
                <p>${r.helperReply}</p>
            </div>
        </c:if>

    </div>
</c:forEach>

</div>

</body>
</html>
