<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Edit Service</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body class="auth-bg">

<form class="card"
      action="/admin/services/update/${service.id}"
      method="post"
      enctype="multipart/form-data">

<h2>Edit Service</h2>

<!-- Service ID -->
<input type="hidden" name="id" value="${service.id}">

<!-- Title -->
<input type="text"
       name="title"
       value="${service.title}"
       required>

<!-- Description -->
<textarea name="description" required>${service.description}</textarea>

<!-- Price (IMPORTANT FIX) -->
<input type="number"
       step="0.01"
       name="price"
       value="${service.price}"
       required>

<!-- Category -->
<select name="category.id" required>
    <c:forEach var="c" items="${categories}">
        <option value="${c.id}"
            <c:if test="${c.id == service.category.id}">selected</c:if>>
            ${c.name}
        </option>
    </c:forEach>
</select>

<!-- Existing Image -->
<c:if test="${not empty service.image}">
    <img src="${service.image}" width="100%" style="margin:10px 0">
</c:if>

<!-- New Image -->
<input type="file" name="imageFile">

<button type="submit">Update Service</button>

<a href="/admin/services">← Back</a>

</form>

</body>
</html>
