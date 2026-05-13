<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
<head>
<title>Helper Profile</title>
<link rel="stylesheet" href="/css/style.css">

<style>
.profile-card {
    max-width: 420px;
    margin: 40px auto;
    background: white;
    padding: 25px;
    border-radius: 14px;
    text-align: center;
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

.profile-card img {
    width: 130px;
    height: 130px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 15px;
}

.profile-card h2 {
    margin-bottom: 8px;
}

.back {
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    color: #1976d2;
    font-weight: 600;
}
</style>
</head>

<body>

<div class="profile-card">

    <img src="${helper.profilePhoto != null ? helper.profilePhoto : '/images/default-avatar.png'}">

    <h2>${helper.name}</h2>

    <p><strong>Phone:</strong> ${helper.phone}</p>

    <p><strong>Category:</strong> ${helper.category.name}</p>
    <p style="color:#fbc02d;font-size:18px;font-weight:600;">
    <strong>Rating:</strong>
    <fmt:formatNumber value="${helperRating}"
                      minFractionDigits="1"
                      maxFractionDigits="1" />
</p>
    

    <a class="back" href="/user/bookings">⬅ Back to My Bookings</a>
</div>

</body>
</html>
