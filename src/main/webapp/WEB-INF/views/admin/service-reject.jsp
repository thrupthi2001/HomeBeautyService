<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Reject Service</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body class="auth-bg">

<form class="card" method="post" action="/admin/services/reject">

    <h2>❌ Reject Service</h2>

    <input type="hidden" name="id" value="${service.id}">

    <p><strong>${service.title}</strong></p>

    <textarea name="reason"
              placeholder="Enter reason for rejection"
              required
              style="height:120px;"></textarea>

    <button type="submit"
            style="background:#e53935;">
        Reject Service
    </button>

    <a href="/admin/services/pending"
       style="display:block;text-align:center;margin-top:10px;">
        Cancel
    </a>

</form>

</body>
</html>
