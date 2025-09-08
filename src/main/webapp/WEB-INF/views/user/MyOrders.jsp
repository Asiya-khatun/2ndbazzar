<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>My Ordered Products</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        :root {
            --primary: #e63946;
            --primary-light: #f8a5a5;
            --light: #f8f9fa;
            --dark: #212529;
            --dark-gray: #495057;
            --light-gray: #e9ecef;
            --success: #28a745;
            --warning: #ffc107;
            --border-radius: 12px;
            --card-shadow: 0 10px 25px rgba(0,0,0,0.05);
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            color: #374151;
            line-height: 1.6;
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            color: #1f2937;
        }
        
        .ordered-title {
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 700;
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
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--card-shadow);
            margin-bottom: 24px;
            transition: var(--transition);
            background: white;
        }
        
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        
        .order-header {
            background: linear-gradient(135deg, var(--primary), #c1121f);
            cursor: pointer;
            padding: 1.5rem;
            transition: var(--transition);
        }
        
        .order-header:hover {
            background: linear-gradient(135deg, #c1121f, var(--primary));
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
            font-size: 1.5rem;
        }
        
        .order-header h5 button:after {
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            content: "\f078";
            transition: var(--transition);
        }
        
        .order-header h5 button[aria-expanded="true"]:after {
            transform: rotate(180deg);
        }
        
        .order-body {
            padding: 1.75rem;
            background-color: white;
        }
        
        .order-detail {
            margin-bottom: 1rem;
            display: flex;
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .order-detail:last-child {
            border-bottom: none;
        }
        
        .order-detail strong {
            min-width: 150px;
            color: var(--dark);
            font-weight: 600;
        }
        
        .status-badge {
            padding: 0.4em 0.8em;
            border-radius: 50rem;
            font-weight: 600;
            font-size: 1rem;
        }
        
        .status-PENDING {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .status-DELIVERED {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-CANCELLED {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .no-orders {
            background-color: white;
            padding: 3rem;
            border-radius: var(--border-radius);
            text-align: center;
            box-shadow: var(--card-shadow);
            margin: 2rem 0;
        }
        
        .no-orders i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            color: #d1d5db;
        }
        
        .no-orders h4 {
            margin-bottom: 1rem;
            color: #374151;
        }
        
        .no-orders p {
            margin-bottom: 1.5rem;
            color: #6b7280;
        }
        
        .no-orders a {
            color: var(--primary);
            font-weight: 600;
            text-decoration: none;
            padding: 0.75rem 1.5rem;
            border: 2px solid var(--primary);
            border-radius: 50px;
            transition: var(--transition);
            display: inline-block;
        }
        
        .no-orders a:hover {
            background-color: var(--primary);
            color: white;
            transform: translateY(-2px);
        }
        
        .alert {
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            border: none;
            padding: 1rem 1.5rem;
        }
        
        /* Recommendation section styles */
        .hero { 
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
        }
        
       
        
        .chips { 
            display: flex; 
            gap: .60rem; 
            flex-wrap: wrap; 
        }
        
        .chip { 
            background: #edf2ff; 
            border-radius: 999px; 
            padding: .5rem .8rem; 
            font-size: 1.5rem; 
            color: #2b6cb0;
            font-weight: 500;
        }
        
        .section-title { 
            margin: 2rem 0 1.25rem; 
            display: flex; 
            align-items: center; 
            gap: .75rem; 
            color: #1f2937;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--light-gray);
        }
        
        .badge.rounded-pill { 
            background: #edf2ff; 
            color: #2b6cb0; 
            padding: .35rem .75rem; 
            border-radius: 999px; 
            font-size:1.2rem; 
            font-weight: 600;
        }
        
        .empty-state { 
            color: #6b7280; 
            background: #f9fafb; 
            padding: 1.5rem; 
            border-radius: var(--border-radius);
            text-align: center;
            margin: 1.5rem 0;
            border: 1px dashed #d1d5db;
        }
        
        .grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); 
            gap: 1.5rem; 
            margin: 1.5rem 0;
        }
        
        .reco-card { 
            border: 1px solid var(--light-gray); 
            border-radius: var(--border-radius); 
            overflow: hidden; 
            background: #fff; 
            transition: var(--transition);
            box-shadow: 0 4px 6px rgba(0,0,0,0.04);
        }
        
        .reco-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .reco-media { 
            width: 100%; 
            height: 200px; 
            background: #f8f9fa; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            overflow: hidden;
        }
        
        .reco-media-img { 
            width: 100%; 
            height: 100%; 
            object-fit: cover;
            transition: var(--transition);
        }
        
        .reco-card:hover .reco-media-img {
            transform: scale(1.05);
        }
        
        .card-body {
            padding: 1.25rem;
        }
        
        .owner { 
            color: var(--dark-gray); 
            font-size:1.5rem; 
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }
        
        .category-badge { 
            background: #fffbeb; 
            color: #92400e; 
            border-radius: 999px; 
            padding: .3rem .6rem; 
            font-size:1.5rem; 
            font-weight: 500;
            display: inline-block;
            margin: 0.5rem 0;
        }
        
        .description { 
            color: #374151; 
            font-size:1.5rem; 
            margin-bottom: 0.75rem;
        }
        
        .product-name {
            font-weight: 600;
            color: #1f2937;
            font-size:1.5rem; 
            margin-bottom: 0.5rem;
        }
        
        .view-link { 
            text-decoration: none; 
            color: var(--primary); 
            font-weight: 600; 
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
        }
        
        .view-link:hover {
            color: #c1121f;
            gap: 0.75rem;
        }
        
        .footer-gap { 
            height: 2rem; 
        }
        
        .section-divider { 
            height: 1px; 
            background: var(--light-gray); 
            margin: 2rem 0; 
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .order-detail {
                flex-direction: column;
            }
            
            .order-detail strong {
                min-width: auto;
                margin-bottom: 0.25rem;
            }
            
            .grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            }
            
            .hero {
                padding: 1.25rem;
            }
        }
        
        @media (max-width: 576px) {
            .order-header h5 button {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .grid {
                grid-template-columns: 1fr;
            }
            
            .no-orders {
                padding: 1.5rem;
            }
        }
    </style>
</head>

<body class="bg-light">
    <%@ include file="../user/navbar.jsp" %>

    <div class="container py-5">
        <div class="text-center mb-5">
            <h2 class="ordered-title text-danger">
                <i class="fas fa-box-open mr-2"></i> My Ordered Products
            </h2>
            <p class="text-muted">View your order history and product details</p>
        </div>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show">
                <strong>Error!</strong> Cart not found!
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${not empty orderSuccess}">
            <div class="alert alert-success alert-dismissible fade show">
                <strong>Success!</strong> ${orderSuccess}
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${not empty orders}">
            <div class="accordion" id="ordersAccordion">
                <c:forEach items="${orders}" var="order" varStatus="status">
                    <c:forEach items="${order.orderedProducts}" var="orderedProduct" varStatus="innerStatus">
                        <div class="order-card">
                            <div class="order-header" id="heading-${status.index}-${innerStatus.index}">
                                <h5 class="mb-0">
                                    <button class="btn btn-link p-0" type="button" data-toggle="collapse"
                                        data-target="#collapse-${status.index}-${innerStatus.index}" aria-expanded="true"
                                        aria-controls="collapse-${status.index}-${innerStatus.index}">
                                        <span>${orderedProduct.product.name} - Rs ${order.total_amount}</span>
                                        <span class="status-badge status-${order.status}">${order.status}</span>
                                    </button>
                                </h5>
                            </div>

                            <div id="collapse-${status.index}-${innerStatus.index}" class="collapse show"
                                aria-labelledby="heading-${status.index}-${innerStatus.index}" data-parent="#ordersAccordion">
                                <div class="order-body">
                                    <div class="order-detail">
                                        <strong>Ordered Quantity:</strong>
                                        <span>${orderedProduct.quantity}</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Category:</strong>
                                        <span>${orderedProduct.product.category}</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Descriptions:</strong>
                                        <span>${orderedProduct.product.description}</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Product Owner:</strong>
                                        <span>${orderedProduct.product.user.username}</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Email:</strong>
                                        <span>${orderedProduct.product.user.email}</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Order Date:</strong>
                                        <span>${order.order_date}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty orders}">
            <div class="no-orders">
                <i class="fas fa-box-open"></i>
                <h4 class="mb-3">You have no orders yet!</h4>
                <p class="mb-4">Start shopping to see your orders here</p>
                <a href="${cp}/user/product/allproducts/${user.id}">Browse Products</a>
            </div>
        </c:if>
    </div>

    <!-- Showing recommendations -->
    <div class="container mt-5">
        <!-- HERO -->
        <div class="hero">
         
            <div class="chips">
                <span class="chip"><i class="fa fa-fire"></i> Priority: Category</span>
                <span class="chip"><i class="fa fa-file-text-o"></i> Description Match</span>
                <span class="chip"><i class="fa fa-user-o"></i> Seller Fallback</span>
            </div>
        </div>

        <!-- INFO STATE -->
        <c:if test="${not empty noOrdersMessage}">
            <div class="empty-state">
                <i class="fas fa-info-circle mr-2"></i>
                <c:out value="${noOrdersMessage}"/>
            </div>
        </c:if>

        <!-- 1) Naive Bayes FIRST -->
        <h4 class="section-title">
            Recommended (Naive Bayes)
            <span class="badge rounded-pill">Model A</span>
        </h4>

        <c:choose>
            <c:when test="${empty naive}">
                <div class="empty-state">
                    <i class="fas fa-search mr-2"></i>
                    No recommendations available from Naive Bayes. Order some products first.
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid">
                    <c:forEach var="item" items="${naive}">
                        <div class="card reco-card">
                            <!-- Product image -->
                            <div class="reco-media">
                                <img src="${cp}/product_image/${item.imageName}"
                                     alt="Product image for ${item.productId}"
                                     onerror="this.onerror=null;this.src='${cp}/asset/img/placeholder.png';"
                                     class="reco-media-img" />
                            </div>

                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="owner">
                                        <i class="fa fa-user-circle"></i>
                                        <c:out value="${item.ownerName}"/>
                                    </span>
                                </div>

                                <div class="mb-2">
                                    <span class="category-badge">
                                        <i class="fa fa-tag"></i>
                                        <c:out value="${item.category}"/>
                                    </span>
                                </div>

                                <p class="product-name"><c:out value="${item.productName}"/></p>
                                <p class="description"><c:out value="${item.description}"/></p>

                                <div class="d-flex align-items-center justify-content-between card-actions">
                                    <a class="view-link" href="${cp}/user/product/details/${item.productId}">
                                        View product <i class="fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="section-divider"></div>

        <!-- 2) THEN Logistic Regression -->
        <h4 class="section-title">
            Recommended (Logistic Regression)
            <span class="badge rounded-pill">Model B</span>
        </h4>

        <c:choose>
            <c:when test="${empty logistic}">
                <div class="empty-state">
                    <i class="fas fa-search mr-2"></i>
                    No recommendations available from Logistic Regression.
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid">
                    <c:forEach var="item" items="${logistic}">
                        <div class="card reco-card">
                            <div class="reco-media">
                                <img src="${cp}/product_image/${item.imageName}"
                                     alt="Product image for ${item.productId}"
                                     onerror="this.onerror=null;this.src='${cp}/asset/img/placeholder.png';"
                                     class="reco-media-img" />
                            </div>

                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="owner">
                                        <i class="fa fa-user-circle"></i>
                                        <c:out value="${item.ownerName}"/>
                                    </span>
                                </div>

                                <div class="mb-2">
                                    <span class="category-badge">
                                        <i class="fa fa-tag"></i>
                                        <c:out value="${item.category}"/>
                                    </span>
                                </div>

                                <p class="product-name"><c:out value="${item.productName}"/></p>
                                <p class="description"><c:out value="${item.description}"/></p>

                                <div class="d-flex align-items-center justify-content-between card-actions">
                                    <a class="view-link" href="${cp}/user/product/details/${item.productId}">
                                        View product <i class="fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="footer-gap"></div>
    </div>
    <!-- Ends here -->

    <%@ include file="../user/footer.jsp" %>

    <!-- JS Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add smooth scrolling for anchor links
        $(document).ready(function() {
            $('a[href^="#"]').on('click', function(event) {
                var target = $(this.getAttribute('href'));
                if (target.length) {
                    event.preventDefault();
                    $('html, body').stop().animate({
                        scrollTop: target.offset().top - 80
                    }, 1000);
                }
            });
            
            // Add animation to cards when they come into view
            function animateCards() {
                $('.order-card, .reco-card').each(function() {
                    var position = $(this).offset().top;
                    var scroll = $(window).scrollTop();
                    var windowHeight = $(window).height();
                    
                    if (position < scroll + windowHeight - 100) {
                        $(this).addClass('animate__animated animate__fadeInUp');
                    }
                });
            }
            
            // Run on load and scroll
            animateCards();
            $(window).on('scroll', animateCards);
        });
    </script>
</body>
</html>