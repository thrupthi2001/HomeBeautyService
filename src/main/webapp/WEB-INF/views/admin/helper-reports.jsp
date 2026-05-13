<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Helper Reports</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.report-card {
    background:white;
    padding:22px;
    border-radius:14px;
    box-shadow:0 8px 25px rgba(0,0,0,0.15);
    margin-bottom:25px;
}
.warning-box {
    background:#fff3e0;
    padding:18px;
    border-radius:12px;
    font-weight:600;
}
.critical {
    background:#ffebee;
    color:#c62828;
}
.section-title {
    font-weight:700;
    margin:18px 0 10px;
}
.admin-msg {
    background:#fff8e1;
    padding:14px;
    border-radius:10px;
    margin-top:10px;
}
.helper-reply {
    background:#f1f8e9;
    padding:14px;
    border-radius:10px;
    margin-top:10px;
}
textarea {
    width:100%;
    height:90px;
    padding:12px;
    border-radius:8px;
    border:1px solid #ccc;
}
button {
    background:#ff5722;
    color:white;
    border:none;
    padding:10px 20px;
    border-radius:22px;
    cursor:pointer;
}
button:hover {
    background:#e64a19;
}
</style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <div class="nav-left">
        <a href="/admin/dashboard">⬅ Dashboard</a>
    </div>
    <div class="nav-right">
        <a href="/admin/logout" class="logout">Logout</a>
    </div>
</div>

<div class="container">

    <!-- TOTAL WARNINGS -->
    <div class="report-card warning-box">
        ⚠️ Total Warnings: <strong>${warningCount}</strong>
    </div>

    <!-- DELETE SUGGESTION -->
    <c:if test="${warningCount >= 7}">
        <div class="report-card critical">
            🚨 <strong>Critical:</strong> Helper crossed 7 warnings.<br>
            Recommended action: <strong>Delete helper account</strong>
        </div>
    </c:if>

    <!-- EACH REPORT -->
    <c:forEach var="r" items="${reports}">

        <div class="report-card">

            <!-- REPORT DETAILS -->
            <p><strong>Customer:</strong> ${r.user.name}</p>
            <p><strong>Service:</strong> ${r.review.booking.service.title}</p>
            <p><strong>Service Date:</strong> ${r.review.booking.serviceDate}</p>
            <p><strong>Reason:</strong> ${r.reason}</p>

            <hr>

            <!-- WARNING CONVERSATION -->
            <div class="section-title">⚠️ Warning Conversation</div>

            <!-- get warnings for this report -->
            <c:set var="rw" value="${reportWarnings[r.id]}" />

            <c:if test="${empty rw}">
                <p style="color:#777;">No warnings sent for this report.</p>
            </c:if>

            <c:forEach var="w" items="${rw}">
                <div class="admin-msg">
                    <strong>Your Warning Message:</strong><br>
                    ${w.message}<br>
                    <small>
    Issued on: ${w.sentAt}
</small>
                </div>

                <c:if test="${not empty w.helperReply}">
                    <div class="helper-reply">
                        <strong>Helper Reply:</strong><br>
                        ${w.helperReply}
                    </div>
                </c:if>
            </c:forEach>

            <hr>

            <!-- SEND WARNING (ONLY IF NOT SENT) -->
            <c:if test="${empty rw}">
                <h4>Send Warning</h4>

                <form method="post" action="/admin/helpers/warn">
                    <input type="hidden" name="helperId" value="${r.helper.id}">
                    <input type="hidden" name="reportId" value="${r.id}">

                    <textarea name="message"
                              placeholder="Write official warning for this report..."
                              required></textarea>

                    <button style="margin-top:12px;">Send Warning</button>
                </form>
            </c:if>

            <c:if test="${not empty rw}">
                <p style="color:#388e3c; font-weight:600; margin-top:12px;">
                    ✅ Warning already issued for this report
                </p>
            </c:if>

        </div>

    </c:forEach>

</div>

</body>
</html>
