<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Register</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body class="auth-bg">
<form class="card" method="post" enctype="multipart/form-data">
<h2>Create Admin Account</h2>
<input name="name" placeholder="Full Name" required>
<input name="email" placeholder="Email" required>
<input name="password" type="password" placeholder="Password" required>
<input type="file" name="photo" required>
<button>Create Account</button>
<p>Already admin? <a href="/admin/login">Login</a></p>
</form>
</body>
</html>