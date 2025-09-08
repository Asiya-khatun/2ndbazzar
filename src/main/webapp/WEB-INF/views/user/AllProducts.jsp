<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Products | Red Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <style>
        :root {
            --primary-color: #e63946; /* Bright red */
            --secondary-color: #f1faee;
            --accent-color: #a8dadc;
            --dark-color: #1d3557;
            --light-color: #f8f9fa;
            --text-color: #333;
        }
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-color);
        }
        /* Fullscreen Image Viewer */
        .image-viewer {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.9);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.3s ease;
        }
        .image-viewer.active {
            opacity: 1;
            pointer-events: all;
        }
        .image-viewer img {
            max-width: 90%;
            max-height: 90%;
            object-fit: contain;
        }
        .close-viewer {
            position: absolute;
            top: 30px; right: 30px;
            color: white;
            font-size: 2rem !important;
            cursor: pointer;
            background: var(--primary-color);
            width: 50px; height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        /* Bright Red Theme */
        .navbar {
            background-color: var(--primary-color) !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-primary:hover {
            background-color: #d62839;
            border-color: #d62839;
        }
        .sidebar {
            background: white;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            padding: 1.5rem;
        }
        .sidebar-header h5 {
            color: var(--primary-color);
        }
        .products-header {
            background: white;
            border-radius: 10px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        /* Product Cards */
        .product-card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: all 0.3s ease;
            background: white;
            height: 100%;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem 0 rgba(58, 59, 69, 0.2);
        }
        .product-img-container {
            height: 220px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            background: #f8f9fa;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .product-img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-img-container:hover .product-img {
            transform: scale(1.05);
        }
        .product-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: white;
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
        }
        .product-body {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            height: calc(100% - 220px);
        }
        .product-title {
            font-weight: 700;
            color: var(--dark-color);
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        .product-seller {
            font-size: 1.5rem;
            color: Purple;
            margin-bottom: 0.5rem;
        }
        .product-price {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 1.7rem;
            margin: 0.5rem 0;
        }
        .product-stock-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        .product-stock-status {
            font-size: 1.5rem !important;
        }
        .product-stock-quantity {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-color);
        }
        .in-stock {
            color: #28a745;
        }
        .low-stock {
            color: #ffc107;
        }
        .out-stock {
            color: var(--primary-color);
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }
        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border-color: #ffeeba;
        }
    </style>
</head>
<body>

<%@ include file="../user/navbar.jsp" %>

<!-- Cart Message -->
<c:if test="${not empty Cartmessage}">
    <div class="alert alert-success text-center mb-0 alert-dismissible fade show">
        <i class="bi bi-check-circle-fill me-2"></i> ${Cartmessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<!-- Fullscreen Image Viewer -->
<div class="image-viewer" id="imageViewer">
    <span class="close-viewer" id="closeViewer"><i class="bi bi-x"></i></span>
    <img id="fullscreenImage" src="" alt="Fullscreen Product Image" />
</div>

<div class="container py-4">
    <div class="row">
        <!-- Filter Sidebar -->
        <div class="col-lg-3 mb-4">
            <div class="sidebar sticky-top" style="top: 20px;">
                <div class="sidebar-header">
                    <h5 style="font-size: 1.5rem;">
                        <i class="bi bi-funnel me-2"></i> Filter Products
                    </h5>
                </div>
                <c:if test="${not empty message}">
                    <div class="alert alert-warning mb-3" style="font-size: 1.1rem;">${message}</div>
                </c:if>
                <form action="${cp}/user/product/filter/${user.id}" method="post">
                    <div class="filter-group">
                        <h6 class="filter-title" style="font-size: 1.8rem;">Categories</h6>
                        <select name="categoryEnum" class="form-select" style="font-size: 1.5rem; padding: 0.5rem 1rem;">
                            <option value="">All Categories</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat}" <c:if test="${cat == param.categoryEnum}">selected</c:if>>
                                    ${cat}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-danger" style="font-size: 1.5rem; padding: 0.5rem;">
                            <i class="bi bi-funnel me-2"></i> Apply Filters
                        </button>
                        <a href="${cp}/user/product/allproducts/${user.id}" class="btn btn-outline-secondary" style="font-size: 1.5rem; padding: 0.5rem;">
                            <i class="bi bi-arrow-counterclockwise me-2"></i> Reset
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Products Listing -->
        <div class="col-lg-9">
            <div class="products-header d-flex justify-content-between align-items-center">
                <h3 class="mb-0">Browse Products</h3>
                <div class="product-count">
                    <i class="bi bi-grid me-1"></i> ${products.size()} ${products.size() == 1 ? 'product' : 'products'}
                </div>
            </div>

            <div class="row">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach items="${products}" var="product">
                            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12 mb-4">
                                <div class="product-card">
                                    <div class="product-img-container" onclick="viewImage('${cp}/product_image/${product.imageName}')">
                                        <c:choose>
                                            <c:when test="${product.quantity > 0}">
                                                <span class="product-badge text-success">${product.category}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="product-badge text-danger">${product.category}</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <img src="${cp}/product_image/${product.imageName}" class="product-img" alt="${product.name}" />
                                    </div>
                                    <div class="product-body">
                                        <h5 class="product-title">${product.name}</h5>
                                        <p class="product-seller" style="font-size: 1.5rem;">
                                            <i class="bi bi-person me-1"></i> ${product.user.username} <br>
                                              <i class="bi bi-person me-1"></i> ${product.description}
                                            
                                        </p>
                                        <div class="product-price">
                                            <c:choose>
                                                <c:when test="${product.quantity > 0}">
                                                    <span class="price text-success"> Rs:${product.price}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="price text-danger">Rs: ${product.price}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="product-stock-container">
                                            <div class="product-stock-status">
                                                <c:choose>
                                                    <c:when test="${product.quantity > 5}">
                                                        <span class="in-stock"><i class="bi bi-box-seam me-1"></i> Total Stock</span>
                                                    </c:when>
                                                    <c:when test="${product.quantity > 0}">
                                                        <span class="in-stock"><i class="bi bi-box-seam me-1"></i> Total Stock</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="out-stock"><i class="bi bi-x-circle-fill me-1"></i> Out of Stock</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="product-stock-quantity">
                                                <i class="bi bi-box-seam me-1"></i> ${product.quantity} left
                                            </div>
                                        </div>

                                        <!-- Updated buttons with View Details -->
                                        <div class="mt-auto d-flex gap-2">
                                            <c:choose>
                                                <c:when test="${product.quantity == 0}">
                                                    <button class="btn btn-danger flex-grow-1" disabled>
                                                        <i class="bi bi-cart-x me-2"></i> Not Available
                                                    </button>
                                                    <a href="${cp}/user/product/details/${product.id}" class="btn btn-secondary flex-grow-1">
                                                        <i class="bi bi-info-circle me-2"></i> View Details
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${cp}/user/cart/add/${product.id}" class="btn btn-success flex-grow-1">
                                                        <i class="bi bi-cart-plus me-2"></i> Add to Cart
                                                    </a>
                                                    <a href="${cp}/user/product/details/${product.id}" class="btn btn-primary flex-grow-1">
                                                        <i class="bi bi-info-circle me-2"></i> View Details
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="alert alert-warning text-center py-4">
                                <h4><i class="bi bi-exclamation-circle me-2"></i> No products found</h4>
                                <p class="mb-0">Try adjusting your filters or check back later</p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<%@ include file="../user/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Fullscreen Image Viewer
    function viewImage(src) {
        const viewer = document.getElementById('imageViewer');
        const fullscreenImg = document.getElementById('fullscreenImage');
        fullscreenImg.src = src;
        viewer.classList.add('active');
        document.body.style.overflow = 'hidden';
    }
    
    document.getElementById('closeViewer').addEventListener('click', function() {
        const viewer = document.getElementById('imageViewer');
        viewer.classList.remove('active');
        document.body.style.overflow = 'auto';
    });
    
    // Close viewer when clicking outside the image
    document.getElementById('imageViewer').addEventListener('click', function(e) {
        if (e.target === this) {
            this.classList.remove('active');
            document.body.style.overflow = 'auto';
        }
    });
    
    // Auto-dismiss the cart message after 5 seconds
    setTimeout(function() {
        const alert = document.querySelector('.alert-success');
        if (alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }
    }, 5000);
</script>
</body>
</html>
