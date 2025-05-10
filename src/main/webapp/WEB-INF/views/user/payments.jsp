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
            background-color: #f7f9fc; /* Light Grey Background */
            font-family: 'Roboto', sans-serif;
        }

        .form-container {
            max-width: 900px;
            margin: 50px auto;
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-top: 5px solid #0056b3; /* Blue Border on Top */
        }

        .form-header {
            font-size: 2rem;
            font-weight: 600;
            color: #0056b3;
            text-align: center;
            margin-bottom: 30px;
            text-transform: uppercase;
        }

        .form-row {
            margin-bottom: 20px;
        }

        .form-control {
            margin-bottom: 18px;
            border-radius: 8px;
            border: 1px solid #0056b3;
            font-size: 1rem;
            padding: 14px;
        }

        .form-control:focus {
            border-color: #0056b3;
            box-shadow: 0 0 8px rgba(0, 86, 179, 0.5);
        }

        .btn-submit {
            width: 100%;
            background-color: #0056b3;
            color: white;
            font-weight: bold;
            border-radius: 8px;
            padding: 14px;
            transition: background-color 0.3s ease-in-out;
            font-size: 1.1rem;
        }

        .btn-submit:hover {
            background-color: #004494; /* Darker Blue on hover */
        }

        .logo-container {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .logo-container img {
            max-width: 150px;
            height: auto;
        }

        /* Two-column Layout */
        .form-column-left {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
        }

        .form-column-right {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
        }

        /* Label Styling */
        label {
            font-size: 1rem;
            font-weight: 500;
            color: #444;
        }

        /* Responsive Adjustment */
        @media (max-width: 768px) {
            .form-container {
                padding: 25px;
                margin: 20px;
            }

            .form-header {
                font-size: 1.6rem;
            }

            .form-column-left, .form-column-right {
                margin-bottom: 20px;
            }

            .btn-submit {
                font-size: 1rem;
            }
        }
    </style>
    <%@ include file="../userhome.jsp" %>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <div class="logo-container">
 <img src="/images/esewa_logo.png" alt="eSewa Payment">            </div>
            <div class="form-header">eSewa Payment Form</div>
            <form action="https://rc-epay.esewa.com.np/api/epay/main/v2/form" method="post">
                <div class="row">
                    <!-- Left Column -->
                    <div class="col-md-6 form-column-left">
                        <div class="mb-3">
                            <label for="amount" class="form-label">Amount</label>
                            <input type="text" class="form-control" id="amount" name="amount" value="${payment.amount}">
                        </div>
                        <div class="mb-3">
                            <label for="tax_amount" class="form-label">Tax Amount</label>
                            <input type="text" class="form-control" id="tax_amount" name="tax_amount" value="${payment.tax_amount}">
                        </div>
                        <div class="mb-3">
                            <c:forEach var="order" items="${orders}">
                                <label for="discount" class="form-label">Discount</label>
                                <input type="text" class="form-control" id="discount" name="discount" value="${order.discount}">
                            </c:forEach>
                        </div>
                    </div>
                    <!-- Right Column -->
                    <div class="col-md-6 form-column-right">
                        <div class="mb-3">
                            <label for="product_service_charge" class="form-label">Product Service Charge</label>
                            <input type="text" class="form-control" id="product_service_charge" name="product_service_charge" value="${payment.psc}">
                        </div>
                        <div class="mb-3">
                            <label for="product_delivery_charge" class="form-label">Product Delivery Charge</label>
                            <input type="text" class="form-control" id="product_delivery_charge" name="product_delivery_charge" value="${payment.pdc}">
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="total_amount" class="form-label">Total Amount</label>
                    <input type="text" class="form-control" id="total_amount" name="total_amount" value="${payment.total_amount}">
                </div>
                <input type="submit" class="btn-submit" value="Proceed to Payment">
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
