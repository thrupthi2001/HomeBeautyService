<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Book Service</title>
<link rel="stylesheet" href="/css/style.css">
</head>
<body class="auth-bg">

<form class="card" method="post" action="/booking/preview">
<h2>Book Service</h2>

<input type="hidden" name="service.id" value="${service.id}">

<p><strong>Service:</strong> ${service.title}</p>
<p><strong>Price:</strong> ₹ ${service.price}</p>

<input name="customerName" placeholder="Your Full Name" required>

<input name="customerPhone" placeholder="Mobile Number" required>

<input type="date" name="serviceDate" required>

<input type="time" name="serviceTime" required>

<textarea name="customerAddress" placeholder="Complete Address" required></textarea>

<button>Proceed to Payment</button>

<p style="text-align:center;margin-top:10px;">
A nearby professional will accept your request
</p>
</form>

</body>
</html>
