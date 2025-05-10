<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">
    <div class="form-container">
        <div class="form-header">Payment Options</div>
        <div class="d-flex justify-content-around">
            <!-- Cash on "C:/Users/HP/OneDrive/Pictures/Screenshots/Screenshot 2025-01-03 124716.png"Delivery -->
            <a href="${cp }/user/payment/success/cod"> 
                <img src="/images/cod_logo.png" alt="Cash on Delivery" style="width: 100px; height: auto;">
            </a>

            <!-- eSewa Payment -->
            <a href="${cp}/user/payment/esewa/${user.id}">
                <img src="/images/esewa_logo.png" alt="eSewa Payment" style="width: 100px; height: auto;">
            </a>

            <!-- Khalti Payment -->
            <a href="/khalti-payment">
                <img src="/images/khalti_logo.png" alt="Khalti Payment" style="width: 100px; height: auto;">
            </a>
        </div>
    </div>
</div>


</div>
</body>
</html>