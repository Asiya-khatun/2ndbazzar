<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.name} - Product Details</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
<style>
:root {
  --primary-red: #d62828;
  --dark-red: #ba181b;
  --light-red: #f8ad9d;
  --cream: #f8edeb;
  --dark: #212529;
  --light: #f8f9fa;
  --gold: #ffd166;
}

body {
  background-color: var(--cream);
  font-family: 'Montserrat', sans-serif;
  color: var(--dark);
}

.product-container {
  max-width: 1200px;
  margin: 2rem auto;
}

.product-card {
  border: none;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 15px 30px rgba(214, 40, 40, 0.1);
  transition: all 0.3s ease;
  background: white;
}

.product-header {
  background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
  color: white;
  padding: 2rem;
  position: relative;
  overflow: hidden;
}

.product-header::before {
  content: "";
  position: absolute;
  top: -50px;
  right: -50px;
  width: 150px;
  height: 150px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
}

.product-header h1 {
  font-family: 'Playfair Display', serif;
  font-weight: 700;
  position: relative;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
}

.product-body {
  padding: 2.5rem;
}

.product-image-container {
  position: relative;
  overflow: hidden;
  border-radius: 12px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.product-image {
  width: 100%;
  height: 100%;
  max-height: 400px;
  object-fit: contain;
  transition: transform 0.5s ease;
}

.product-image:hover {
  transform: scale(1.05);
}

.detail-item {
  margin-bottom: 1.5rem;
  padding-bottom: 1.5rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.detail-item:last-child {
  border-bottom: none;
}

.detail-label {
  font-weight: 600;
  color: var(--primary-red);
  min-width: 120px;
  display: inline-block;
  font-size: 1.1rem;
}

.detail-value {
  color: var(--dark);
  font-weight: 500;
  font-size: 1.05rem;
}

.price-tag {
  font-size: 2rem;
  font-weight: 700;
  color: var(--dark-red);
  font-family: 'Playfair Display', serif;
}

.quantity-badge {
  font-size: 1rem;
  padding: 0.5rem 1rem;
  background: var(--light-red);
  color: var(--dark-red);
  border-radius: 50px;
}

.seller-info {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 1rem;
}

.seller-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: bold;
  font-size: 1.2rem;
  box-shadow: 0 4px 10px rgba(214, 40, 40, 0.2);
}

.btn-add-to-cart {
  background: linear-gradient(135deg, var(--primary-red) 0%, var(--dark-red) 100%);
  border: none;
  padding: 1rem 2rem;
  font-weight: 600;
  letter-spacing: 0.5px;
  transition: all 0.3s ease;
  border-radius: 50px;
  box-shadow: 0 4px 15px rgba(214, 40, 40, 0.3);
  position: relative;
  overflow: hidden;
  font-size: 1.1rem;
}

.btn-add-to-cart:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(214, 40, 40, 0.4);
}

.btn-add-to-cart::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, var(--dark-red) 0%, var(--primary-red) 100%);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.btn-add-to-cart:hover::after {
  opacity: 1;
}

.btn-add-to-cart span {
  position: relative;
  z-index: 1;
}

.btn-back {
  background: white;
  color: var(--primary-red);
  border: 2px solid var(--primary-red);
  padding: 1rem 2rem;
  transition: all 0.3s ease;
  border-radius: 50px;
  font-weight: 600;
  font-size: 1.1rem;
}

.btn-back:hover {
  background: var(--light-red);
  color: var(--dark-red);
  border-color: var(--light-red);
  transform: translateY(-3px);
}

.action-buttons {
  display: flex;
  gap: 20px;
  margin-top: 2.5rem;
}

.stock-status {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-weight: 600;
  padding: 0.5rem 1rem;
  border-radius: 50px;
}

.in-stock {
  background: rgba(40, 167, 69, 0.1);
  color: #28a745;
}

.low-stock {
  background: rgba(255, 193, 7, 0.1);
  color: #ffc107;
}

.out-of-stock {
  background: rgba(220, 53, 69, 0.1);
  color: #dc3545;
}

.rating {
  color: var(--gold);
  margin-left: 0.5rem;
}

@media (max-width: 768px) {
  .product-body {
    padding: 1.5rem;
  }
  
  .product-header {
    padding: 1.5rem;
  }
  
  .action-buttons {
    flex-direction: column;
    gap: 15px;
  }
  
  .btn-add-to-cart, .btn-back {
    width: 100%;
    text-align: center;
  }
  
  .detail-label {
    display: block;
    margin-bottom: 0.5rem;
  }
}

/* Pulse animation for Add to Cart button */
@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}

.btn-add-to-cart.pulse {
  animation: pulse 1s infinite;
}

/* Floating action button */
.wishlist-btn {
  position: absolute;
  top: 20px;
  right: 20px;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: white;
  color: var(--primary-red);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  z-index: 10;
}

.wishlist-btn:hover {
  transform: scale(1.1);
  color: var(--dark-red);
}
</style>
</head>
<body>
<%@ include file="../user/navbar.jsp" %>

<div class="container py-4">
    <div class="product-card">
        <div class="product-header">
            <button class="wishlist-btn" title="Add to wishlist">
                <i class="far fa-heart"></i>
            </button>
            <h1 class="h2 mb-0">${product.name}</h1>
            <div class="rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="far fa-star"></i>
                <span class="text-white">(24)</span>
            </div>
        </div>
        
        <div class="product-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="product-image-container">
                        <img src="${pageContext.request.contextPath}/product_image/${product.imageName}" 
                             alt="${product.name}" 
                             class="product-image" />
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="detail-item">
                        <span class="price-tag">Rs. <fmt:formatNumber value="${product.price}" type="number"/></span>
                        
                        <c:choose>
                            <c:when test="${product.quantity > 5}">
                                <span class="stock-status in-stock ms-3">
                                    <i class="fas fa-check-circle"></i> In Stock
                                </span>
                            </c:when>
                            <c:when test="${product.quantity > 0}">
                                <span class="stock-status low-stock ms-3">
                                    <i class="fas fa-exclamation-circle"></i> Only ${product.quantity} left
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="stock-status out-of-stock ms-3">
                                    <i class="fas fa-times-circle"></i> Out of Stock
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="detail-item">
                        <span class="detail-label">Category:</span>
                        <span class="detail-value">${product.category}</span>
                    </div>
                    
                    <div class="detail-item">
                        <span class="detail-label">Condition:</span>
                        <span class="detail-value">Excellent (Used)</span>
                    </div>
                    
                    <div class="detail-item">
                        <span class="detail-label">Availability:</span>
                        <span class="detail-value">
                            <span class="badge quantity-badge">${product.quantity} available</span>
                        </span>
                    </div>
                    
                    <div class="detail-item">
                        <span class="detail-label">Description:</span>
                        <p class="detail-value mt-2">${product.description}</p>
                    </div>
                    
                    <div class="detail-item">
                        <span class="detail-label">Seller:</span>
                        <div class="detail-value seller-info">
                            <div class="seller-avatar">
                                ${fn:substring(product.user.username, 0, 1)}
                            </div>
                            <div>
                                <div class="fw-bold">${product.user.username}</div>
                                <div class="small text-muted">Member since </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="action-buttons">
                        <c:if test="${product.quantity > 0}">
                            <button class="btn btn-add-to-cart btn-lg pulse">
                                <i class="fas fa-cart-plus me-2"></i> Add to Cart
                            </button>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/user/product/allproducts/${product.user.id}" 
                           class="btn btn-back btn-lg">
                            <i class="fas fa-arrow-left me-2"></i> Back to Products
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Add to cart functionality
document.querySelector('.btn-add-to-cart').addEventListener('click', function() {
    const btn = this;
    
    // Disable button during processing
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Adding...';
    
    // Simulate API call
    setTimeout(function() {
        // Success state
        btn.classList.remove('pulse');
        btn.innerHTML = '<i class="fas fa-check me-2"></i> Added to Cart!';
        
        // Revert after 2 seconds
        setTimeout(function() {
            btn.innerHTML = '<i class="fas fa-cart-plus me-2"></i> Add to Cart';
            btn.disabled = false;
            btn.classList.add('pulse');
        }, 2000);
    }, 1000);
});

// Wishlist button toggle
document.querySelector('.wishlist-btn').addEventListener('click', function() {
    const btn = this;
    const icon = btn.querySelector('i');
    
    if(icon.classList.contains('far')) {
        icon.classList.remove('far');
        icon.classList.add('fas');
        btn.style.color = '#dc3545'; // Red color when active
    } else {
        icon.classList.remove('fas');
        icon.classList.add('far');
        btn.style.color = ''; // Reset to default
    }
});
</script>
</body>
</html>