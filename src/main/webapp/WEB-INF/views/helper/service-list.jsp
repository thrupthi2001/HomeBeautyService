<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>My Services</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.status-badge {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}
.pending { background:#fff3cd; color:#856404; }
.approved { background:#d4edda; color:#155724; }
.rejected { background:#f8d7da; color:#721c24; }

.portfolio img {
    width: 55px;
    height: 55px;
    object-fit: cover;
    border-radius: 6px;
    margin-right: 6px;
    cursor: pointer;
}
</style>
</head>

<body>

<div class="top-nav">
    <div class="nav-left">
        <a href="/helper/dashboard">⬅ Dashboard</a>
    </div>
    <div class="nav-right">
        <a class="logout" href="/helper/logout">Logout</a>
    </div>
</div>

<div class="container">
<h2>🛠️ My Services</h2>

<div class="services-grid">

<c:forEach var="s" items="${services}">
    <div class="service-card">

        <img src="${s.image}" alt="${s.title}">

        <!-- Portfolio -->
        <c:if test="${not empty s.images}">
            <div class="portfolio" style="margin:10px 0;">
                <c:forEach var="img" items="${s.images}">
                    <a href="${img.imagePath}" target="_blank">
                        <img src="${img.imagePath}">
                    </a>
                </c:forEach>
            </div>
        </c:if>

        <h3>${s.title}</h3>
        <p>${s.description}</p>
        <strong>₹ ${s.price}</strong>

        <p>
            Status:
            <span class="status-badge
                ${s.status == 'APPROVED' ? 'approved' :
                  s.status == 'REJECTED' ? 'rejected' : 'pending'}">
                ${s.status}
            </span>
        </p>
        
        <c:if test="${s.status == 'REJECTED' && not empty s.rejectReason}">
    <div style="
        margin-top:10px;
        padding:10px;
        background:#fdecea;
        border-left:4px solid #e53935;
        font-size:14px;
        color:#721c24;">
        ❌ <strong>Rejected Reason:</strong><br>
        ${s.rejectReason}
    </div>
</c:if>
        

        <div class="actions" style="display:flex;gap:10px;margin-top:12px;">

    <a href="/helper/services/edit/${s.id}"
       style="padding:6px 12px;
              background:#1976d2;
              color:white;
              border-radius:6px;
              text-decoration:none;">
        ✏ Edit
    </a>

    <a href="/helper/services/delete/${s.id}"
       onclick="return confirm('⚠️ Are you sure you want to permanently delete this service?')"
       style="padding:6px 12px;
              background:#e53935;
              color:white;
              border-radius:6px;
              text-decoration:none;">
      <c:if test="${s.status != 'APPROVED'}">
        🗑 Delete
       </c:if>
    </a>

</div>


    </div>
</c:forEach>

</div>
</div>

</body>
</html>
