<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<title>Add Service</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body class="auth-bg">

<form class="card" method="post" enctype="multipart/form-data">
<h2>Add Service</h2>

<input name="title" placeholder="Service Title" required>
<textarea name="description" placeholder="Description"></textarea>
<input name="price" placeholder="Price" required>

<select name="category.id">
<option value="">Select Category</option>
<c:forEach var="c" items="${categories}">
<option value="${c.id}">${c.name}</option>
</c:forEach>
</select>

<label>Main Image</label>
<input type="file" name="mainImage" required>

<label>Portfolio Images</label>
<input type="file" name="portfolioImages" multiple>

<button>Add</button>
</form>

</body>
</html>
