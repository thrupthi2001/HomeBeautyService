<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>User Register</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body class="auth-bg">

<form class="card" method="post" enctype="multipart/form-data">
<h2>Create Account</h2>

<input name="name" placeholder="Full Name" required>
<input name="email" placeholder="Email" required>
<input type="password" name="password" placeholder="Password" required>

<input type="file" name="photo" required>

<button>Register</button>

<p style="text-align:center">
Already have account? <a href="/user/login">Login</a>
</p>
</form>

</body>
</html>
