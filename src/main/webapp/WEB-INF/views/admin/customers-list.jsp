<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Customers</title>
<link rel="stylesheet" href="/css/style.css">

<style>
table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 12px;
    overflow: hidden;
}

th, td {
    padding: 14px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

th {
    background: #f5f5f5;
    font-weight: 600;
}

.profile-img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    object-fit: cover;
    cursor: pointer;
}

.delete-btn {
    background: #e53935;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
}

.delete-btn:hover {
    background: #c62828;
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
        <a class="logout" href="/admin/logout">Logout</a>
    </div>
</div>

<div class="container">
<h2>👥 Customers</h2>

<table>
    <thead>
        <tr>
            <th>Profile</th>
            <th>Name</th>
            <th>Email</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody>
    <c:forEach var="c" items="${customers}">
        <tr>
            <td>
                <c:if test="${not empty c.profilePhoto}">
                    <a href="${c.profilePhoto}" target="_blank">
                        <img src="${c.profilePhoto}" class="profile-img">
                    </a>
                </c:if>
                <c:if test="${empty c.profilePhoto}">
                    —
                </c:if>
            </td>

            <td>${c.name}</td>
            <td>${c.email}</td>

            <td>
                <form action="/admin/customers/delete/${c.id}"
                      method="post"
                      onsubmit="return confirm('Delete this customer account?')">
                    <button class="delete-btn">🗑 Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</div>

</body>
</html>
