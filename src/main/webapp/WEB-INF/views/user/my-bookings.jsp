<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<title>My Bookings</title>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">


<style>
.layout { display:flex; }
.sidebar {
    width:240px;
    background:#1976d2;
    color:white;
    min-height:100vh;
    padding:20px;
}
.sidebar a {
    display:block;
    color:white;
    padding:10px 0;
    text-decoration:none;
}
.content { flex:1; padding:30px; }

.booking-card {
    background:#fff;
    padding:20px;
    margin-bottom:20px;
    border-radius:6px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

.timeline {
    display:flex;
    justify-content:space-between;
    margin-top:20px;
}

.step {
    text-align:center;
    flex:1;
    position:relative;
}

.step::after {
    content:'';
    position:absolute;
    top:12px;
    right:-50%;
    width:100%;
    height:3px;
    background:#ddd;
    z-index:-1;
}

.step:last-child::after {
    display:none;
}

.circle {
    width:25px;
    height:25px;
    border-radius:50%;
    background:#ddd;
    margin:0 auto 5px;
}

.active .circle {
    background:#4caf50;
}

.active label {
    color:#4caf50;
    font-weight:bold;
}

.cancel-btn {
    background:#e53935;
    color:white;
    border:none;
    padding:8px 12px;
    border-radius:4px;
    cursor:pointer;
    margin-top:10px;
}
</style>

</head>
<body>

<div class="layout">

<!-- SIDEBAR -->
<div class="sidebar">
<h3>User Dashboard</h3>
<hr>
<a href="${pageContext.request.contextPath}/user/dashboard">Home</a>
<a href="${pageContext.request.contextPath}/user/bookings">My Bookings</a>
<a href="${pageContext.request.contextPath}/user/logout">Logout</a>

</div>

<!-- CONTENT -->
<div class="content">
<h2>My Bookings</h2>

<c:forEach var="b" items="${bookings}">
<div class="booking-card">

<h3>${b.service.title}</h3>

<p><strong>Status:</strong> ${b.status}</p>

<p><strong>Helper:</strong>
<c:choose>

    <c:when test="${b.helper != null}">
        ${b.helper.name}
        <br><br>

        <a href="${pageContext.request.contextPath}/user/helper/${b.helper.id}">
            <img
                src="${b.helper.profilePhoto != null ? b.helper.profilePhoto : '/images/default-avatar.png'}"
                style="
                    width:70px;
                    height:70px;
                    border-radius:50%;
                    object-fit:cover;
                    cursor:pointer;
                    border:2px solid #1976d2;
                "
                title="View Helper Profile"
            >
        </a>
        <p style="margin-top:6px;color:#fbc02d;font-weight:600;">
    ★ ${reviewService.getAverageHelperRating(b.helper.id)}
</p>
        
    </c:when>

    <c:otherwise>
        Not assigned yet
    </c:otherwise>

</c:choose>
</p>


<!-- ================= STATUS TIMELINE ================= -->
<div class="timeline">

<div class="step ${b.status == 'BOOKED' || b.status == 'ACCEPTED' || b.status == 'ON_THE_WAY' || b.status == 'IN_PROGRESS' || b.status == 'COMPLETED' ? 'active' : ''}">
<div class="circle"></div>
<label>Booked</label>
</div>

<div class="step ${b.status == 'ACCEPTED' || b.status == 'ON_THE_WAY' || b.status == 'IN_PROGRESS' || b.status == 'COMPLETED' ? 'active' : ''}">
<div class="circle"></div>
<label>Accepted</label>
</div>

<div class="step ${b.status == 'ON_THE_WAY' || b.status == 'IN_PROGRESS' || b.status == 'COMPLETED' ? 'active' : ''}">
<div class="circle"></div>
<label>On the Way</label>
</div>

<div class="step ${b.status == 'IN_PROGRESS' || b.status == 'COMPLETED' ? 'active' : ''}">
<div class="circle"></div>
<label>In Progress</label>
</div>

<div class="step ${b.status == 'COMPLETED' ? 'active' : ''}">
<div class="circle"></div>
<label>Completed</label>
</div>

</div>
<!-- ================================================== -->

<!-- ================= STEP 5: CANCEL BUTTON ================= -->
<c:if test="${b.status != 'COMPLETED' && b.status != 'CANCELLED'}">
<form method="post"
      action="${pageContext.request.contextPath}/booking/cancel">

<input type="hidden" name="bookingId" value="${b.id}">
<button class="cancel-btn">Cancel Booking</button>
</form>
</c:if>
<!-- ========================================================= -->

<!-- ================= STEP 6: CANCELLED MESSAGE ================= -->
<c:if test="${b.status == 'CANCELLED'}">
<p style="color:red;font-weight:bold;margin-top:10px;">
❌ Booking Cancelled
</p>
</c:if>
<!-- ============================================================ -->


<!-- ================= REVIEW ACTION ================= -->

<c:if test="${b.status == 'COMPLETED'}">

    <c:choose>

        <c:when test="${reviewService.alreadyReviewed(b.id)}">
            <a class="btn"
               href="${pageContext.request.contextPath}/review/view/${b.id}">
                View Review
            </a>
        </c:when>

        <c:otherwise>
            <a class="btn"
               href="${pageContext.request.contextPath}/review/add/${b.id}">
                Give Review
            </a>
        </c:otherwise>

    </c:choose>

</c:if>


<!-- ================================================ -->

</div>
</c:forEach>

</div>
</div>

</body>
</html>
