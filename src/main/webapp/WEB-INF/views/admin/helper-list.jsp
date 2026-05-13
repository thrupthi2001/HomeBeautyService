<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Total Helpers</title>
<link rel="stylesheet" href="/css/style.css">

<style>
table {
    width:100%;
    background:white;
    border-radius:10px;
    border-collapse: collapse;
}
th, td {
    padding:14px;
    text-align:left;
}
th {
    background:#f5f5f5;
}
.helper-photo {
    width:45px;
    height:45px;
    border-radius:50%;
    object-fit:cover;
}
.action-btn {
    padding:6px 12px;
    border-radius:20px;
    text-decoration:none;
    font-size:13px;
}
.services { background:#1976d2; color:white; }
.jobs { background:#2e7d32; color:white; }
</style>
</head>

<body>

<div class="top-nav">
    <div class="nav-left">
        <a href="/admin/dashboard">⬅ Dashboard</a>
    </div>
</div>

<div class="container">
<h2>👷 Total Helpers</h2>

<table>
<tr>
    <th>Photo</th>
    <th>Name</th>
    <th>Phone</th>
    <th>Category</th>
    <th>Status</th>
    <th>Services</th>
    <th>Completed Jobs</th>
    <th>Actions</th>
</tr>


<c:forEach var="h" items="${helpers}">
<tr>
    <td>
        <a href="${h.profilePhoto}" target="_blank">
            <img src="${h.profilePhoto}" class="helper-photo">
        </a>
    </td>
    <td>${h.name}</td>
    <td>${h.phone}</td>
    <td>${h.category.name}</td>

<td>
    <c:choose>
        <c:when test="${h.available}">
            <span style="color:#2e7d32;font-weight:600;">🟢 Online</span>
        </c:when>
        <c:otherwise>
            <span style="color:#9e9e9e;font-weight:600;">⚪ Offline</span>
        </c:otherwise>
    </c:choose>
</td>

<td>${serviceRepo.countByHelper_Id(h.id)}</td>

    <td>${bookingRepo.findByHelperIdAndStatus(h.id,'COMPLETED').size()}</td>
    <td>
        <a class="action-btn services" href="/admin/helpers/${h.id}/services">
            🛠 Services
        </a>
        <a class="action-btn jobs" href="/admin/helpers/${h.id}/completed-jobs">
            ✅ Jobs
        </a>
    </td>
</tr>
</c:forEach>

</table>
</div>

</body>
</html>
