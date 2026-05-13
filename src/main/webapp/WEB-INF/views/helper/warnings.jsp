<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Admin Warnings</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.warning-card {
    background:white;
    padding:22px;
    border-radius:14px;
    box-shadow:0 8px 25px rgba(0,0,0,0.15);
    margin-bottom:20px;
}

.warning-number {
    font-size:17px;
    font-weight:700;
    margin-bottom:8px;
}

.warning-message {
    font-size:14px;
    margin-bottom:10px;
}

.warning-date {
    font-size:12px;
    color:#666;
    margin-bottom:12px;
}

.reply-box {
    margin-top:12px;
}

.reply-text {
    background:#f1f8e9;
    padding:12px;
    border-radius:8px;
    font-size:13px;
}

textarea {
    width:100%;
    height:80px;
    padding:10px;
    border-radius:8px;
    border:1px solid #ccc;
    resize:none;
}

button {
    margin-top:8px;
    padding:8px 18px;
    border:none;
    border-radius:20px;
    background:#ff5722;
    color:white;
    cursor:pointer;
    font-size:13px;
}

button:hover {
    background:#e64a19;
}

.last-chance {
    background:#fff3cd;
    border-left:6px solid #ff9800;
}

.final-warning {
    background:#ffebee;
    border-left:6px solid #d32f2f;
}
</style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <div class="nav-left">
        <span style="color:white;font-size:18px;">⚠️ Admin Warnings</span>
    </div>
    <div class="nav-right">
        <a href="/helper/dashboard" class="profile">Dashboard</a>
        <a href="/helper/logout" class="logout">Logout</a>
    </div>
</div>

<div class="container">

<c:if test="${empty warnings}">
    <div class="warning-card">
        🎉 No warnings received. Keep up the good work!
    </div>
</c:if>

<c:forEach var="w" items="${warnings}" varStatus="status">

    <c:set var="count" value="${status.index + 1}" />

    <c:set var="extraClass" value="" />
    <c:if test="${count == 6}">
        <c:set var="extraClass" value="last-chance" />
    </c:if>
    <c:if test="${count >= 7}">
        <c:set var="extraClass" value="final-warning" />
    </c:if>

    <div class="warning-card ${extraClass}">

        <div class="warning-number">
            ⚠️ Warning #${count}
        </div>

        <div class="warning-message">
            <strong>Admin Message:</strong><br>
            ${w.message}
        </div>

        <div class="warning-date">
    Issued on:
    ${w.sentAt.toString().replace('T',' ')}
</div>

        <c:if test="${count == 6}">
            <p style="color:#e65100;font-weight:700;">
                ⚠️ This is your LAST chance. Any further complaints may result in account removal.
            </p>
        </c:if>

        <c:if test="${count >= 7}">
            <p style="color:#b71c1c;font-weight:700;">
                🚫 Final warning issued. Your account is under admin review.
            </p>
        </c:if>

        <div class="reply-box">
            <c:choose>
                <c:when test="${not empty w.helperReply}">
                    <div class="reply-text">
                        <strong>Your Reply:</strong><br>
                        ${w.helperReply}
                    </div>
                </c:when>
                <c:otherwise>
                    <form method="post" action="/helper/warnings/reply">
                        <input type="hidden" name="warningId" value="${w.id}" />
                        <textarea name="reply"
                                  placeholder="Write your response to admin..."
                                  required></textarea>
                        <button type="submit">Send Reply</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</c:forEach>

</div>

</body>
</html>
