<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<title>Categories</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body>

<nav>
<a href="/admin/dashboard">Dashboard</a>
<a href="/admin/categories/add">Add Category</a>
<a href="/admin/logout">Logout</a>
</nav>

<div class="container">
<h2>Service Categories</h2>

<div class="stats">
<c:forEach var="c" items="${categories}">
<div class="box">
<h3>${c.name}</h3>
<a href="/admin/categories/delete/${c.id}"
   onclick="return confirm('Delete this category?')">
Delete
</a>
</div>
</c:forEach>
</div>
</div>

</body>
</html>
