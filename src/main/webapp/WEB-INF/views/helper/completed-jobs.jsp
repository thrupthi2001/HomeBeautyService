<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Completed Jobs</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>
.job-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 22px;
}
@media (max-width: 900px) {
    .job-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 600px) {
    .job-grid { grid-template-columns: 1fr; }
}

.job-card {
    background: #fff;
    padding: 18px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.18);
}

.job-card img.service-img {
    width: 100%;
    border-radius: 10px;
    margin-bottom: 10px;
}

.review-box {
    background:#f7f7f7;
    padding:14px;
    margin-top:15px;
    border-radius:10px;
}

.rating {
    color:#f9a825;
    font-size:15px;
    margin-bottom:6px;
}

.review-photo {
    width:100%;
    border-radius:8px;
    margin-top:10px;
}

textarea {
    width:100%;
    min-height:70px;
    margin-top:8px;
    padding:8px;
    border-radius:6px;
    border:1px solid #ccc;
}

.btn {
    margin-top:8px;
    padding:8px 14px;
    border:none;
    border-radius:6px;
    background:#1976d2;
    color:white;
    cursor:pointer;
}
</style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <div class="nav-left">
        <a href="${pageContext.request.contextPath}/helper/dashboard">Dashboard</a>
    </div>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/helper/profile" class="profile">Profile</a>
        <a href="${pageContext.request.contextPath}/helper/logout" class="logout">Logout</a>
    </div>
</div>

<div class="container">
<h2>✅ Completed Jobs</h2>

<div class="job-grid">

<c:forEach var="b" items="${jobs}">
<div class="job-card">

    <!-- SERVICE IMAGE -->
    <img class="service-img" src="${b.service.image}" alt="Service Image">

    <h3>${b.service.title}</h3>

    <p><strong>Customer:</strong> ${b.user.name}</p>
    <p><strong>Price:</strong> ₹ ${b.service.price}</p>
    <p><strong>Status:</strong> COMPLETED</p>

    <!-- REVIEW FETCH -->
    <c:set var="review"
           value="${reviewService.findByBookingId(b.id).orElse(null)}" />

    <c:if test="${review != null}">
        <div class="review-box">

            <p><strong>Customer Review:</strong></p>

            <!-- SERVICE RATING -->
            <p class="rating">
                Service Rating:
                <fmt:formatNumber
                    value="${review.serviceRating != null ? review.serviceRating : 0.0}"
                    minFractionDigits="1" maxFractionDigits="1" />
                <br>
                <c:forEach begin="1"
                           end="${review.serviceRating != null ? review.serviceRating : 0}">
                    ⭐
                </c:forEach>
            </p>

            <!-- HELPER RATING -->
            <p class="rating">
                Helper Rating:
                <fmt:formatNumber
                    value="${review.helperRating != null ? review.helperRating : 0.0}"
                    minFractionDigits="1" maxFractionDigits="1" />
                <br>
                <c:forEach begin="1"
                           end="${review.helperRating != null ? review.helperRating : 0}">
                    ⭐
                </c:forEach>
            </p>

            <!-- COMMENT -->
            <p>${review.comment}</p>

            <!-- REVIEW IMAGE -->
            <c:if test="${review.reviewPhoto != null}">
                <img src="${pageContext.request.contextPath}${review.reviewPhoto}"
                     class="review-photo">
            </c:if>

            <!-- HELPER REPLY -->
            <c:choose>
                <c:when test="${review.helperReply == null}">
                    <form method="post"
                          action="${pageContext.request.contextPath}/helper/reply-review">
                        <input type="hidden" name="reviewId" value="${review.id}">
                        <textarea name="reply" required
                                  placeholder="Reply to customer"></textarea>
                        <button class="btn">Send Reply</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <p><strong>Your Reply:</strong> ${review.helperReply}</p>
                </c:otherwise>
            </c:choose>

        </div>
    </c:if>

</div>
</c:forEach>

</div>
</div>

</body>
</html>
