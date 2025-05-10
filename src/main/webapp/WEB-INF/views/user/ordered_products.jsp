<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Ordered Products</title>
    <!-- Bootstrap 4 CDN for responsiveness and styling -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/assets/css/styles.css" rel="stylesheet">
    <link href="${cp}/css/design.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        .container {
            max-width: 1100px;
        }

        .card-header {
            background-color: #6f42c1;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
            border-radius: 10px 10px 0 0;
        }

        .table {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .table th,
        .table td {
            padding: 10px;
            text-align: center;
        }

        .thead-dark th {
            background-color: #343a40;
            color: white;
            font-size: 1rem;
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

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }
    </style>
</head>
<%@ include file="../userhome.jsp" %>

<body class="bg-light">

    <div class="container mt-5" id="order_data">
        <div class="row">
            <div class="col-12">
                <div class="card shadow-lg rounded-lg border-info">
                    <div class="card-header text-center" style="background-color: #6f42c1; color: white; border-radius: 10px;">
                        <h2>My Ordered Products</h2>
                    </div>
                    <div class="card-body">
                        <!-- Check if there are no orders -->
                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger">Cart not found!</div>
                        </c:if>

                        <!-- Display the table only if there are orders -->
                        <c:if test="${not empty orders}">
                            <table class="table table-hover table-striped">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Product Name</th>
                                        <th>Quantity</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <c:forEach items="${order.orderedProducts}" var="orderedProduct">
                                            <tr data-toggle="modal" data-target="#orderModal-${orderedProduct.product.id}">
                                                <td>${orderedProduct.product.name}</td>
                                                <td>${orderedProduct.quantity}</td>
                                                
                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
<c:if test="${not empty orderSuccess}">
    <div class="alert alert-success">
        ${orderSuccess}
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        
    </div>
</c:if>
                        <!-- Display alert if no orders -->
                        <c:if test="${empty orders}">
                            <div class="alert alert-warning">
You have no orders yet !! Orders Some product <a href="${cp }/user/cart/show/${id}">Order now</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for displaying order details -->
    <c:forEach var="order" items="${orders}">
        <c:forEach items="${order.orderedProducts}" var="orderedProduct">
            <div class="modal fade" id="orderModal-${orderedProduct.product.id}" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel-${orderedProduct.product.id}" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="orderModalLabel-${orderedProduct.product.id}">${orderedProduct.product.name} - Order Details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p><strong>Quantity Ordered:</strong> ${orderedProduct.quantity}</p>
                            <p><strong>Discount:</strong> ${order.discount}</p>
                            <p><strong>Payment Status:</strong> ${order.status}</p>
                            <p><strong>Order Date:</strong> ${order.order_date}</p>
                            <p><strong>Total Amount:</strong> Rs:${order.total_amount}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:forEach>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
