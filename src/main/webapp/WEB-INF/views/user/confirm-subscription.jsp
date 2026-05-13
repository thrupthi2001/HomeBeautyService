<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Confirm Subscription</title>
<link rel="stylesheet" href="/css/style.css">
</head>

<body class="auth-bg">

<form class="card" method="post" action="/user/subscriptions/buy">

<h2>Confirm Subscription</h2>

<input type="hidden" name="planId" value="${plan.id}">

<p><strong>Plan:</strong> ${plan.name}</p>
<p><strong>Price:</strong> ₹ ${plan.price}</p>
<p><strong>Valid From:</strong> ${startDate}</p>
<p><strong>Valid Till:</strong> ${endDate}</p>

<hr>

<button>Activate Subscription</button>

</form>
</body>
</html>
