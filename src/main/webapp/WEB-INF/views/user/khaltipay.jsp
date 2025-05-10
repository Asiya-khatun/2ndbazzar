<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eSewa Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f3e5f5; /* Light Purple */
            font-family: 'Arial', sans-serif;
        }

        .form-container {
            max-width: 650px;
            margin: 50px auto;
            background: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #8e24aa; 
        }

        .form-header {
            font-size: 1.8rem;
            font-weight: bold;
            color: #8e24aa; 
            text-align: center;
            margin-bottom: 30px;
        }

        .form-control {
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #8e24aa;
        }

        .btn-submit {
            width: 100%;
            background-color: #8e24aa; 
            color: white;
            font-weight: bold;
            border-radius: 5px;
            padding: 12px;
            transition: background-color 0.3s ease-in-out;
        }

        .btn-submit:hover {
            background-color: #6a1b9a; 
        }

        .footer-text {
            color: #8e24aa;
            font-size: 0.9rem;
        }

        .khalti-logo {
            display: block;
            margin: 0 auto 20px;
            width: 150px;
        }
    </style>
    <%@ include file="../userhome.jsp" %>
</head>
<body>
    <div class="container">
        <div class="form-container">
                <img src="/images/khalti_logo.png" alt="Khalti Payment">
            <div class="form-header">Khalti Payment Form</div>
            <form action="${cp }/user/payment/khalti" method="post">
                <div class="mb-3">
                    <label for="amount" class="form-label">Amount</label>
                    <input type="text" class="form-control" id="amount" name="amount" value="${payment.amount}"  >
                </div>
                <div class="mb-3">
                    <label for="tax_amount" class="form-label">Tax Amount</label>
                    <input type="text" class="form-control" id="tax_amount" name="tax_amount" value="${payment.tax_amount}"  >
                </div>
                <div class="mb-3">
                    <label for="product_service_charge" class="form-label">Product Service Charge</label>
                    <input type="text" class="form-control" id="product_service_charge" name="product_service_charge" value="${payment.psc}"  >
                </div>
                <div class="mb-3">
                    <label for="product_delivery_charge" class="form-label">Product Delivery Charge</label>
                    <input type="text" class="form-control" id="product_delivery_charge" name="product_delivery_charge" value="${payment.pdc}"  >
                </div>
                <div class="mb-3">
                    <label for="total_amount" class="form-label">Total Amount</label>
                    <input type="text" class="form-control" id="total_amount" name="total_amount" value="${payment.total_amount}"  >
                </div>
                <input type="submit" class="btn-submit" value="Submit">
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
