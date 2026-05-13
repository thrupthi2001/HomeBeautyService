<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>View Review</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

<style>
body {
    margin: 0;
    min-height: 100vh;
    background: linear-gradient(120deg, #ff512f, #dd2476);
    font-family: Segoe UI, sans-serif;
}

.review-card {
    max-width: 520px;
    margin: 60px auto;
    background: #fff;
    padding: 30px;
    border-radius: 14px;
    box-shadow: 0 10px 35px rgba(0,0,0,0.2);
}

.review-card h2 {
    text-align: center;
    margin-bottom: 20px;
}

.section {
    margin-top: 15px;
}

.rating-value {
    font-size: 20px;
    font-weight: bold;
    color: #f9a825;
}

.comment-box {
    margin-top: 8px;
    color: #444;
}

.review-photo {
    margin-top: 15px;
    width: 100%;
    border-radius: 10px;
}

.back {
    display: inline-block;
    margin-top: 25px;
    text-decoration: none;
    color: #1976d2;
    font-weight: 600;
}
</style>
</head>

<body>

<div class="review-card">

    <h2>My Review</h2>

    <!-- SERVICE RATING -->
    <div class="section">
        <strong>Service Rating:</strong>
        <div class="rating-value">
            <fmt:formatNumber
                value="${empty review.serviceRating ? 0 : review.serviceRating}"
                minFractionDigits="1"
                maxFractionDigits="1" />
        </div>
    </div>

    <!-- HELPER RATING -->
    <div class="section">
        <strong>Helper Rating:</strong>
        <div class="rating-value">
            <fmt:formatNumber
                value="${empty review.helperRating ? 0 : review.helperRating}"
                minFractionDigits="1"
                maxFractionDigits="1" />
        </div>
    </div>

    <!-- COMMENT -->
    <div class="section">
        <strong>Comment:</strong>
        <div class="comment-box">
            <c:choose>
                <c:when test="${not empty review.comment}">
                    ${review.comment}
                </c:when>
                <c:otherwise>
                    No comment provided.
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- REVIEW PHOTO -->
    <c:if test="${not empty review.reviewPhoto}">
        <img src="${review.reviewPhoto}" class="review-photo">
    </c:if>

    <!-- ✅ HELPER REPLY (NEW) -->
    <div class="section">
        <strong>Helper Reply:</strong>
        <div class="comment-box">
            <c:choose>
                <c:when test="${not empty review.helperReply}">
                    ${review.helperReply}
                </c:when>
                <c:otherwise>
                    <em>No reply from helper yet.</em>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <a class="back"
       href="${pageContext.request.contextPath}/user/bookings">
        ⬅ Back to My Bookings
    </a>

</div>

</body>
</html>
