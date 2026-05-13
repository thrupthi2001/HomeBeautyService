<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Profile</title>
<link rel="stylesheet" href="/css/style.css">

<style>
/* PAGE BACKGROUND */
.profile-page {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #ff4b2b, #ff416c);
}

/* PROFILE CARD */
.profile-card {
    width: 420px;
    background: #fff;
    border-radius: 16px;
    padding: 30px 28px;
    box-shadow: 0 20px 45px rgba(0,0,0,0.25);
}

/* TITLE */
.profile-card h2 {
    text-align: center;
    margin-bottom: 20px;
    font-size: 24px;
}

/* AVATAR */
.avatar-wrapper {
    display: flex;
    justify-content: center;
    margin-bottom: 18px;
}
.avatar {
    width: 110px;
    height: 110px;
    border-radius: 50%;
    object-fit: cover;
    border: 4px solid #ff416c;
}

/* INPUTS */
.profile-card input[type="text"],
.profile-card input[type="email"],
.profile-card input[type="password"],
.profile-card input[type="file"] {
    width: 100%;
    padding: 12px 14px;
    margin-bottom: 14px;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
}

/* BUTTON */
.profile-card button {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 10px;
    background: linear-gradient(135deg, #ff4b2b, #ff416c);
    color: white;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
}

.profile-card button:hover {
    opacity: 0.9;
}

/* BACK LINK */
.back-link {
    text-align: center;
    margin-top: 14px;
}
.back-link a {
    text-decoration: none;
    color: #ff416c;
    font-weight: 500;
}
</style>
</head>

<body>

<div class="profile-page">

    <form class="profile-card" method="post" enctype="multipart/form-data">

        <h2>👤 Edit Profile</h2>

        <div class="avatar-wrapper">
            <img src="${admin.profilePhoto != null ? admin.profilePhoto : '/images/default-avatar.png'}"
                 class="avatar">
        </div>

        <input type="hidden" name="id" value="${admin.id}">

        <input type="text"
               name="name"
               placeholder="Full Name"
               value="${admin.name}"
               required>

        <input type="email"
               name="email"
               placeholder="Email Address"
               value="${admin.email}"
               required>

        <input type="password"
               name="password"
               placeholder="Password"
               value="${admin.password}"
               required>

        <input type="file" name="photo">

        <button type="submit">Update Profile</button>

        <div class="back-link">
            <a href="/admin/dashboard">⬅ Back to Dashboard</a>
        </div>

    </form>

</div>

</body>
</html>
