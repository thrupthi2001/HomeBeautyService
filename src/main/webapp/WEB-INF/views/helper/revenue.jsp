<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Monthly Revenue</title>
<link rel="stylesheet" href="/css/style.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
.revenue-box {
    background: white;
    padding: 25px;
    border-radius: 14px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

.revenue-total {
    font-size: 26px;
    font-weight: 700;
    color: #2e7d32;
    margin-bottom: 15px;
}
</style>
</head>

<body>

<!-- TOP NAV -->
<div class="top-nav">
    <div class="nav-left">
        <a href="/helper/dashboard">⬅ Dashboard</a>
    </div>
    <div class="nav-right">
        <a href="/helper/profile" class="profile">Profile</a>
        <a href="/helper/logout" class="logout">Logout</a>
    </div>
</div>

<div class="container">

<h2>💰 Monthly Revenue</h2>

<div class="revenue-box">

    <div class="revenue-total">
        Total Earnings: ₹ ${totalRevenue}
    </div>

    <canvas id="revenueChart" height="120"></canvas>

</div>

</div>

<script>
const ctx = document.getElementById('revenueChart');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [
            'Jan','Feb','Mar','Apr','May','Jun',
            'Jul','Aug','Sep','Oct','Nov','Dec'
        ],
        datasets: [{
            label: 'Revenue (₹)',
            data: [
                <c:forEach var="r" items="${monthlyRevenue}" varStatus="s">
                    ${r}<c:if test="${!s.last}">,</c:if>
                </c:forEach>
            ],
            backgroundColor: '#42a5f5',
            borderRadius: 8
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { display: false },
            tooltip: {
                callbacks: {
                    label: ctx => `₹ ${ctx.parsed.y}`
                }
            }
        },
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>


</body>
</html>
