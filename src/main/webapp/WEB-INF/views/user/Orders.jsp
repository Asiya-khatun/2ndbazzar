<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <!-- Bootstrap 4 CDN for responsiveness and styling -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/assets/css/styles.css" rel="stylesheet">
    <link href="${cp }/css/design.css" rel="stylesheet">
    <!-- Custom styles for the Orders page -->
    <style>
        body {
            background-color: #f4f4f4;
            font-family: 'Arial', sans-serif;
        }

        .container {
            max-width: 1100px;
        }

        .order-card {
            background-color: #fff;
            border-radius: 8px;
            margin: 10px 0;
            padding: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }

        .order-card:hover {
            background-color: #f1f1f1;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        }

        .order-header {
            font-size: 18px;
            font-weight: bold;
            color: #6f42c1;
        }

        .alert {
            background-color: #ffddcc;
            color: #d9534f;
            border: 1px solid #d9534f;
            padding: 10px;
            margin-top: 20px;
        }

        .btn-custom {
            background-color: #6f42c1;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
        }

        .btn-custom:hover {
            background-color: #5a32a3;
        }

    </style>
</head>

<body>
<%@ include file="../userhome.jsp" %>

    <div class="container mt-5" id="order_data">
        <div class="row">
            <div class="col-12">
                <div class="card shadow-lg rounded-lg">
                    <div class="card-header">
                        <h2>Orders</h2>
                    </div>
                    <div class="card-body">
                    
                    <c:if test="${not empty newOrder}">
    <div class="alert alert-success">
        ${newOrder}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        
    </div>
</c:if>
                        <!-- Check if there are no orders -->
                        <c:if test="${not empty orders}">
                            <div class="row">
                                <c:forEach var="order" items="${orders}">
                                    <div class="col-md-4">
                                        <div class="order-card" data-toggle="modal" data-target="#orderModal-${order.product.id}">
                                            <div class="order-header">
                                                <strong>${order.product.name}</strong>
                                            </div>
                                            <div class="order-info">
                                                <p><strong>Buyer:</strong> ${order.orderProduct.user.name}</p>
                                                <p><strong>Quantity:</strong> ${order.quantity}</p>
                                                <p><strong>Price:</strong> Rs:${order.product.price}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>

                        <!-- Display when no orders are available -->
                        <c:if test="${empty orders}">
                            <div class="alert">
                                No orders found.
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for displaying order details -->
    <c:forEach var="order" items="${orders}">
        <div class="modal fade" id="orderModal-${order.product.id}" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel-${order.product.id}" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="orderModalLabel-${order.product.id}">${order.product.name} - Order Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Buyer:</strong> ${order.orderProduct.user.name}</p>
                        <p><strong>Payment Method:</strong> ${order.orderProduct.payment_method}</p>
                        <p><strong>Quantity Ordered:</strong> ${order.quantity}</p>
                        <p><strong>Actual Price:</strong> Rs:${order.product.price}</p>
                        <p><strong>Total Amount:</strong> Rs:${order.orderProduct.total_amount}</p>
  						 <p><strong>Discount:</strong> ${order.orderProduct.discount}</p>
							<p><strong>Order Date:</strong> ${order.orderProduct.order_date}</p>
                        <p><strong>Delivery Date:</strong> ${order.orderProduct.delivery_date}</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
