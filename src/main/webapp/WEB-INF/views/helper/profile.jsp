<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>My Profile</title>
<link rel="stylesheet" href="/css/style.css">
</head>

<body>

<nav>
    <a href="/helper/profile">Profile</a>
    <a href="/helper/dashboard">Dashboard</a>
    <a href="/helper/logout">Logout</a>
</nav>

<form class="card" method="post" enctype="multipart/form-data">

    <h2>My Profile</h2>

    <img src="${helper.profilePhoto}" class="avatar">

    <input type="hidden" name="id" value="${helper.id}">

    <label>Name</label>
    <input name="name" value="${helper.name}" required>

    <label>Phone</label>
    <input name="phone" value="${helper.phone}" required>

    <label>Password</label>
    <input name="password" value="${helper.password}" required>

    <!-- ✅ CATEGORY DROPDOWN -->
    <label><strong>Category</strong></label>
    <select name="category.id" required>
        <c:forEach var="c" items="${categories}">
            <option value="${c.id}"
                ${helper.category != null && helper.category.id == c.id ? "selected" : ""}>
                ${c.name}
            </option>
        </c:forEach>
    </select>

    <label>Profile Photo</label>
    <input type="file" name="photo">

    <p>
        <strong>Status:</strong>
        ${helper.available ? "Online" : "Offline"}
    </p>

    <button>Update Profile</button>
</form>

<!-- AVAILABILITY TOGGLE -->
<form method="post" action="/helper/availability" class="card">
    <button>
        ${helper.available ? "Go Offline" : "Go Online"}
    </button>
</form>

</body>
</html>
