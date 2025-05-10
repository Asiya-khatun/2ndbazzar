<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Card Title Styling */
        .card-title {
            font-weight: bold;
            color: #ff6347; /* Vibrant orange-red for the product name */
            font-size: 1.2rem; /* Slightly larger font size for the title */
        }

        /* Card Text (Description and Category) Styling */
        .card-text {
            font-size: 0.9rem;
            color: #6c757d; /* Subtle gray color for description */
        }

        /* Card Image Styling */
        .card-img-top {
            transition: transform 0.3s ease;
            border-radius: 8px; /* Slightly rounded corners for the image */
        }

        .card-img-top:hover {
            transform: scale(1.05);
        }

        /* Card Styling */
        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            border-radius: 10px; /* Rounded corners for the card */
            overflow: hidden; /* Ensure that the card content doesn't overflow */
        }

        .card:hover {
            transform: translateY(-5px); /* Lift the card */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15); /* Enhanced shadow for hover effect */
        }

        /* Card Body Styling */
        .card-body {
            background-color: #f8f9fa; /* Light background for the card body */
            border-top: 2px solid #ff6347; /* Vibrant border for better emphasis */
            padding: 20px;
        }

        /* Product Price Styling */
        .card .text-success {
            color: #28a745; /* Vibrant green for the price */
            font-size: 1.1rem; /* Slightly larger font size for emphasis */
        }

        /* Product Quantity Styling */
        .card .card-text.text-muted {
            color: #6c757d; /* Soft gray color for the quantity */
            font-size: 0.95rem;
        }

        /* Button Styling */
        .btn-primary {
            background-color: #ff6347; /* Vibrant red-orange color for the button */
            border-color: #ff6347;
            font-size: 1rem;
            padding: 12px 20px;
            border-radius: 30px; /* Rounded button */
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #e55347; /* Darker red-orange on hover */
            border-color: #e55347;
        }

        .btn-primary i {
            margin-right: 8px; /* Spacing between the icon and the text */
        }

        /* Container Styling */
        .container {
            padding-top: 50px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .card-body {
                padding: 15px; /* Reduced padding for smaller screens */
            }
            .card-title {
                font-size: 1.1rem; /* Smaller title size for mobile */
            }
            .btn-primary {
                font-size: 0.9rem; /* Smaller button size for mobile */
                padding: 10px 18px; /* Smaller padding */
            }
        }
    </style>
</head>
<body>
<%@ include file="../userhome.jsp" %>

 <c:if test="${not empty Cartmessage}">
    <div class="alert alert-success" >${Cartmessage}</div>
</c:if>
<div class="container my-4">
    <!-- Success and Error Messages -->
    <div class="row">
        <c:forEach items="${products}" var="product">
            <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                <div class="card shadow-sm">
                    <!-- Product Image -->
                    <img src="${cp}/product_image/${product.imageName}" class="card-img-top" alt="Product Image" style="height: 200px; object-fit: cover;">
                    <!-- Card Body -->
                    <div class="card-body text-center">
                        <h5 class="card-title">${product.name}</h5>
                        <h5 class="card-title"> Seller: ${product.user.username}</h5>
                        
                        <!-- Product Category -->
                        <p class="card-text text-muted mb-2">Category: ${product.category.name}</p>
                        <!-- Product Price -->
                        <h6 class="text-success mb-3">RS ${product.price}</h6>
                        <!-- Product Quantity -->
                        <p class="card-text text-muted mb-2">Quantity: ${product.quantity}</p>

                        <!-- If product quantity is 0, show Out of Stock and disable Add to Cart -->
                        <c:if test="${product.quantity == 0}">
                            <p class="text-danger">Out of Stock</p>
                            <button class="btn btn-primary" disabled>
                                <i class="bi bi-cart"></i> Add to Cart
                            </button>
                        </c:if>
                        
                        <!-- If product quantity is greater than 0, allow Add to Cart -->
                        <c:if test="${product.quantity > 0}">
                            <a href="${cp}/user/cart/add/${product.id}" class="btn btn-primary">
                                <i class="bi bi-cart"></i> Add to Cart
                            </a>
                        </c:if>

                        
                        
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
