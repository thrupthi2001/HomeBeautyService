<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Confirm Booking</title>
<link rel="stylesheet" href="/css/style.css">
</head>

<body class="auth-bg">

<form class="card" method="post" action="/booking/confirm">
<h2>Confirm & Pay</h2>

<input type="hidden" name="service.id" value="${service.id}">
<input type="hidden" name="customerName" value="${booking.customerName}">
<input type="hidden" name="customerPhone" value="${booking.customerPhone}">
<input type="hidden" name="customerAddress" value="${booking.customerAddress}">
<input type="hidden" name="serviceDate" value="${booking.serviceDate}">
<input type="hidden" name="serviceTime" value="${booking.serviceTime}">
<input type="hidden" name="originalPrice" value="${booking.originalPrice}">

<p><strong>Service:</strong> ${service.title}</p>
<p><strong>Base Price:</strong> ₹ ${booking.originalPrice}</p>

<c:if test="${subscriptionApplied}">
    <div class="success-box">
        🎉 This service is covered by your subscription.<br>
        No payment required.
    </div>
</c:if>

<hr>

<c:if test="${!subscriptionApplied}">

<p><strong>Wallet Balance:</strong> ₹ ${walletBalance}</p>
<p><strong>Wallet Can Be Used:</strong> ₹ ${walletUsable}</p>

<label>
    <input type="checkbox" name="useWallet" checked>
    Use wallet balance
</label>

<hr>

<p><strong>Amount to Pay:</strong></p>
<h3 style="margin:5px 0;">₹ ${payableAmount}</h3>

<hr>

<p><strong>Payment Mode</strong></p>

<label>
    <input type="radio" name="paymentMode" value="COD" checked>
    Cash on Delivery
</label><br>

<label>
    <input type="radio" name="paymentMode" value="ONLINE">
    UPI (GPay / PhonePe / Paytm)
</label>

</c:if>

<button style="margin-top:15px;">Confirm Booking</button>
</form>

</body>
</html>
