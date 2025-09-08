<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        :root {
            --primary: #e63946;
            --primary-light: #f8a5a5;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #28a745;
            --warning: #ffc107;
        }
        
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }
        
        .ordered-title {
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
            font-size: 2.5rem;
            display: inline-flex;
            align-items: center;
            gap: 1rem;
        }
        
        .ordered-title i {
            color: var(--primary);
        }
        
        .ordered-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--primary);
        }
        
        .order-card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            transition: transform 0.3s ease;
            border-left: 4px solid var(--primary);
        }
               
        .order-header {
            background: linear-gradient(135deg, var(--primary), #c1121f);
            cursor: pointer;
            padding: 1.25rem;
        }
        
        .order-header h5 button {
            color: white;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            text-align: left;
            font-size: 1.25rem;
        }
        
        .order-header h5 button:after {
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            content: "\f078";
            transition: all 0.3s ease;
        }
        
        .order-header h5 button[aria-expanded="true"]:after {
            transform: rotate(180deg);
        }
        
        .order-body {
            padding: 1.5rem;
            background-color: white;
        }
        
        .order-detail {
            margin-bottom: 0.8rem;
            display: flex;
            font-size: 1.1rem;
        }
        
        .order-detail strong {
            min-width: 120px;
            color: var(--dark);
        }
        
        .no-orders {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .no-orders a {
            color: var(--primary);
            font-weight: 600;
            text-decoration: none;
            border-bottom: 2px dotted var(--primary);
        }
        
        .no-orders a:hover {
            color: #c1121f;
        }
    </style>
</head>
<body>
    <%@ include file="../user/navbar.jsp" %>
    
    <div class="container py-4">
        <div class="text-center mb-5">
            <h2 class="ordered-title text-danger">
                <i class="fas fa-list-alt"></i> My Product Order Lists
            </h2>
        </div>

        <c:if test="${not empty orders}">
            <div class="accordion" id="orderAccordion">
                <c:forEach var="order" items="${orders}" varStatus="loop">
                    <div class="order-card">
                        <div class="order-header" id="heading-${loop.index}">
                            <h5 class="mb-0">
                                <button class="btn btn-link p-0" type="button" data-toggle="collapse"
                                        data-target="#collapse-${loop.index}" aria-expanded="false"
                                        aria-controls="collapse-${loop.index}">
                                    <span>Order #${loop.index + 1} - ${order.product.name}</span>
                                </button>
                            </h5>
                        </div>

                        <div id="collapse-${loop.index}" class="collapse" aria-labelledby="heading-${loop.index}"
                             data-parent="#orderAccordion">
                            <div class="order-body">
                                <div class="order-detail">
                                    <strong>Buyer:</strong>
                                    <span>${order.orderProduct.user.name}</span>
                                </div>
                                <div class="order-detail">
                                    <strong>Quantity:</strong>
                                    <span>${order.quantity}</span>
                                </div>
                                <div class="order-detail">
                                    <strong>Total:</strong>
                                    <span>Rs ${order.orderProduct.total_amount}</span>
                                </div>
                                <div class="order-detail">
                                    <strong>Date:</strong>
                                    <span>${order.orderProduct.order_date}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty orders}">
            <div class="no-orders">
                <i class="fas fa-box-open fa-3x mb-3 text-muted"></i>
                <h4 class="mb-3">You have no orders yet!</h4>
                <p class="mb-4">You'll get notified when new order is placed</p>
               
            </div>
        </c:if>
    </div>

    <%@ include file="../user/footer.jsp" %>

    <!-- Bootstrap 4 JS dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>