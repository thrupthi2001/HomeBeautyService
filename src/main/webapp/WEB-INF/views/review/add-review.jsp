<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Review</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

<style>
.review-container {
    max-width: 520px;
    margin: 60px auto;
    background: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.15);
}

.review-container h2 {
    text-align: center;
    margin-bottom: 10px;
}

.section-title {
    margin-top: 20px;
    font-weight: 600;
    text-align: center;
}

.star-rating {
    display: flex;
    justify-content: center;
    gap: 8px;
    font-size: 28px;
    margin: 10px 0;
}

.star-rating input {
    display: none;
}

.star-rating label {
    cursor: pointer;
    color: #ccc;
}

.star-rating input:checked ~ label,
.star-rating label:hover,
.star-rating label:hover ~ label {
    color: #fbc02d;
}

textarea {
    width: 100%;
    height: 90px;
    margin-top: 15px;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
}

input[type=file] {
    margin-top: 15px;
}

button {
    width: 100%;
    margin-top: 20px;
    padding: 12px;
    background: #1976d2;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
}
button:hover {
    background: #125aa0;
}
</style>
</head>

<body>

<div class="review-container">

<h2>Leave a Review</h2>

<form method="post"
      action="${pageContext.request.contextPath}/review/submit"
      enctype="multipart/form-data">

<input type="hidden" name="bookingId" value="${booking.id}">

<!-- ⭐ SERVICE RATING -->
<div class="section-title">Rate the Service</div>
<div class="star-rating">
    <input type="radio" id="sr5" name="serviceRating" value="5" required/>
    <label for="sr5">★</label>

    <input type="radio" id="sr4" name="serviceRating" value="4"/>
    <label for="sr4">★</label>

    <input type="radio" id="sr3" name="serviceRating" value="3"/>
    <label for="sr3">★</label>

    <input type="radio" id="sr2" name="serviceRating" value="2"/>
    <label for="sr2">★</label>

    <input type="radio" id="sr1" name="serviceRating" value="1"/>
    <label for="sr1">★</label>
</div>

<!-- ⭐ HELPER RATING -->
<div class="section-title">Rate the Helper</div>
<div class="star-rating">
    <input type="radio" id="hr5" name="helperRating" value="5" required/>
    <label for="hr5">★</label>

    <input type="radio" id="hr4" name="helperRating" value="4"/>
    <label for="hr4">★</label>

    <input type="radio" id="hr3" name="helperRating" value="3"/>
    <label for="hr3">★</label>

    <input type="radio" id="hr2" name="helperRating" value="2"/>
    <label for="hr2">★</label>

    <input type="radio" id="hr1" name="helperRating" value="1"/>
    <label for="hr1">★</label>
</div>

<textarea name="comment"
          placeholder="Share your experience..."
          required></textarea>

<input type="file" name="photo">

<hr>

<label style="display:block; margin-top:10px;">
    <input type="checkbox" name="reportHelper">
    Report this helper (if necessary)
</label>

<textarea name="reportReason"
          placeholder="Describe the issue (optional)"
          style="margin-top:8px; display:none;"
          id="reportBox"></textarea>

<script>
document.querySelector('input[name="reportHelper"]').addEventListener('change', function () {
    document.getElementById('reportBox').style.display =
        this.checked ? 'block' : 'none';
});
</script>


<button type="submit">Submit Review</button>

</form>

</div>

</body>
</html>
