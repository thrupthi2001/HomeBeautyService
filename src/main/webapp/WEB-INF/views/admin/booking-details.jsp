<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Booking Details</title>
<link rel="stylesheet" href="/css/style.css">
</head>

<body>

<nav>
<a href="/admin/bookings">⬅ Back to Bookings</a>
</nav>

<div class="container">
<h2>📄 Booking #${booking.id}</h2>

<div class="card">

<img src="${booking.service.image}" style="width:100%;border-radius:12px">

<h3>${booking.service.title}</h3>

<p><strong>Customer:</strong> ${booking.customerName}</p>
<p><strong>Phone:</strong> ${booking.customerPhone}</p>
<p><strong>Address:</strong> ${booking.customerAddress}</p>

<p><strong>Helper:</strong>
<c:choose>
    <c:when test="${booking.helper != null}">
        ${booking.helper.name}
    </c:when>
    <c:otherwise>Not Assigned</c:otherwise>
</c:choose>
</p>

<p><strong>Status:</strong> ${booking.status}</p>

<p><strong>Booked On:</strong> ${booking.formattedCreatedAt}</p>


<c:if test="${booking.status == 'COMPLETED' && review != null}">
    <hr>
    <h3>⭐ Customer Review</h3>

    <p><strong>Service Rating:</strong>
        <c:forEach begin="1" end="${review.serviceRating}">
            ⭐
        </c:forEach>
    </p>

    <p><strong>Helper Rating:</strong>
        <c:forEach begin="1" end="${review.helperRating}">
            ⭐
        </c:forEach>
    </p>

    <p><strong>Comment:</strong> ${review.comment}</p>

    <c:if test="${review.reviewPhoto != null}">
        <img src="${pageContext.request.contextPath}${review.reviewPhoto}"
             style="width:100%;border-radius:10px;margin-top:10px;">
    </c:if>

    <c:if test="${review.helperReply != null}">
        <hr>
        <p><strong>Helper Reply:</strong></p>
        <p>${review.helperReply}</p>
    </c:if>
</c:if>


</div>
</div>

</body>
</html>
