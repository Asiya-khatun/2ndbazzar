<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Payment Checkout</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --primary-red: #d9232e;
            --dark-red: #a71d26;
            --light-red: #f8d7da;
        }
        
        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .payment-card {
            max-width: 500px;
            margin: 40px auto;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            overflow: hidden;
        }
        .payment-header {
            background-color: var(--primary-red);
            color: white;
            padding: 20px;
            font-weight: 600;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .payment-body {
            padding: 30px;
            background-color: white;
        }
        .esewa-logo {
            width: 80px;
            height: auto;
            margin: 0 auto 20px;
            display: block;
        }
        .payment-title {
            font-size: 1.5rem;
            margin-bottom: 5px;
            color: #333;
        }
        .payment-subtitle {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 25px;
        }
        .amount-display {
            background-color: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid #eee;
        }
        .amount-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 8px;
            border-bottom: 1px dashed #eee;
        }
        .amount-row:last-child {
            border-bottom: none;
        }
        .total-amount {
            font-weight: 700;
            font-size: 1.3rem;
            color: var(--primary-red);
            margin-top: 10px;
        }
        .btn-pay {
            background-color: green !important;
            color: black !important;
            border: none;
            border-radius: 8px;
            font-weight: bold !important;
            width: 100%;
            height:40px;
            transition: all 0.3s;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 1.2rem !important;
        }
        .btn-pay:hover {
            background-color: var(--dark-red);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(217, 35, 46, 0.2);
        }
        .security-note {
            font-size: 0.8rem;
            color: #666;
            text-align: center;
            margin-top: 20px;
        }
        .security-note i {
            color: var(--primary-red);
            margin-right: 5px;
        }
    
    </style>
</head>

<body>
    <%@include file="navbar.jsp" %>
    <div class="container py-4">
        <div class="card payment-card">
            <div class="card-header payment-header">
                <h3>Payment Checkout</h3>
            </div>
            <div class="card-body payment-body">
                <div class="text-center">
                    <img src="/images/esewa_logo.png" alt="eSewa Logo" class="esewa-logo">
                    <h4 class="payment-title">Complete Your Payment</h4>
                    <p class="payment-subtitle">Secure payment processed through eSewa</p>
                </div>
                
                <!-- Payment Summary -->
                <div class="amount-display">
                    <div class="amount-row">
                        <span>Product Amount:</span>
                        <span class="fw-bold">Rs. ${payment.amount}</span>
                    </div>
                                        <div class="amount-row total-amount">
                        <span>Total Payable:</span>
                        <span>Rs. ${payment.total_amount}</span>
                    </div>
                </div>
                
                   
                <!-- Payment Form -->
                <form action="https://rc-epay.esewa.com.np/api/epay/main/v2/form" method="POST">
                    <input type="hidden" id="amount" name="amount" value="${payment.amount}">
                    <input type="hidden" id="product_delivery_charge" name="product_delivery_charge" value="${payment.pdc}">
                    <input type="hidden" id="tax_amount" name="tax_amount" value="${payment.tax_amount}">
                    <input type="hidden" id="product_service_charge" name="product_service_charge" value="${payment.psc}">
                    <input type="hidden" id="total_amount" name="total_amount" value="${payment.total_amount}">
                    <input type="hidden" id="transaction_uuid" name="transaction_uuid" value="${payment.transactionalUUID}">
                    <input type="hidden" id="product_code" name="product_code" value="${payment.product_code}">
                    <input type="hidden" id="success_url" name="success_url" value="${payment.success_url}">
                    <input type="hidden" id="failure_url" name="failure_url" value="${payment.failure_url}">
                    <input type="hidden" id="signed_field_names" name="signed_field_names" value="${payment.signed_field_name}">
                    <input type="hidden" id="signature" name="signature" value="${payment.signature}">
                    
                    <button type="submit" class="btn btn-pay">
                        <i class="fas fa-lock me-2"></i> Pay Rs. ${payment.total_amount} with eSewa
                    </button>
                    
                    <p class="security-note">
                        <i class="fas fa-shield-alt"></i> Your payment is secured 
                    </p>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>