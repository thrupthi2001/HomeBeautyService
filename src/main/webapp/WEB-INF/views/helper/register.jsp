<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Helper Registration</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body class="auth-bg">

<form class="card" method="post" enctype="multipart/form-data">
<h2>Join as Professional</h2>

<input name="name" placeholder="Full Name" required>
<input name="phone" placeholder="Mobile Number" required>
<input type="password" name="password" placeholder="Password" required>
<label>Select Category</label>
<select name="category.id" required>
    <c:forEach var="c" items="${categories}">
        <option value="${c.id}">${c.name}</option>
    </c:forEach>
</select>


<input type="file" name="photo" required>

<button>Create Account</button>

<p style="text-align:center">
Already registered? <a href="/helper/login">Login</a>
</p>
</form>

</body>
</html>
