<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shopping Cart</title>
  <link rel="stylesheet" type="text/css" href="${cp}/asset/css/.css">
    <link rel="stylesheet" type="text/css" href="${cp}/asset/css/cart.css">
  <link rel="stylesheet" type="text/css"href="${cp}/asset/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"href="${cp}/asset/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"href="${cp}/asset/css/nouislider.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/slick.css">
<link rel="stylesheet" type="text/css"href="${cp}/asset/css/slick-theme.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="navbar.jsp" %>
  <div class="cart-container">
    <div class="cart-header">
<h1 class="cart-title">🛒 Cart Options</h1>

    </div>

    <!-- Alert messages -->
    <c:if test="${not empty param.error}">
      <div class="alert alert-danger">Cart not found!</div>
    </c:if>

    <c:if test="${not empty deleteSuccess}">
      <div class="alert alert-success alert-dismissible fade show">${deleteSuccess}</div>
    </c:if>

    <c:if test="${not empty deleteOneSuccess}">
      <div class="alert alert-success alert-dismissible fade show">${deleteOneSuccess}</div>
    </c:if>

    <c:if test="${not empty errordelete}">
      <div class="alert alert-danger alert-dismissible fade show">${errordelete}</div>
    </c:if>

    <c:if test="${not empty NullProduct}">
      <div class="alert alert-danger">${NullProduct}</div>
    </c:if>

    <!-- Empty Cart -->
    <c:if test="${empty cartItems || cartItems.size() == 0}">
      <div class="empty-state">
        <div class="empty-icon">🛒</div>
        <h3>Your cart is empty</h3>
        <p>Start shopping to add items to your cart</p>
        <a href="${cp}/user/product/allproducts/${user.id}" class="btn btn-primary mt-3">Browse Products</a>
      </div>
    </c:if>

    <!-- No cart found -->
    <c:if test="${not empty noCartFound}">
      <div class="empty-state">
        <div class="empty-icon">❓</div>
        <h3>${noCartFound}</h3>
        <a href="${cp}/user/product/allproducts/${user.id}" class="btn btn-primary mt-3">Browse Products</a>
      </div>
    </c:if>

    <!-- Cart Items -->
    <c:if test="${not empty cartItems && cartItems.size() > 0}">
      <div class="cart-items">
        <c:set var="totalPrice" value="0" />
        <c:forEach items="${cartItems}" var="item">
          <div class="cart-item">
            <img src="${cp}/product_image/${item.product.imageName}" alt="${item.product.name}" class="item-image">
            <div class="item-details">
              <h3 class="item-name">${item.product.name}</h3>
              <span class="item-category">${item.product.category}</span>
              <span class="item-price">Rs ${item.product.price}</span>
              <span class="item-stock">${item.product.quantity} available</span>
              <c:if test="${not empty QuantityExceed}">
                <div class="alert alert-warning mt-2 p-2">${QuantityExceed}</div>
              </c:if>
            </div>
            <div class="item-actions">
              <form action="${cp}/user/cart/update/${item.id}" method="post" class="quantity-control">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <button type="button" class="quantity-btn minus"
                 onclick="this.parentNode.querySelector('input[type=number]').stepDown()">−</button>
                <input type="number" name="quantity" value="${item.quantity}" min="1" 
                max="${item.product.quantity}" class="quantity-input">
                <button type="button" class="quantity-btn plus" 
                onclick="this.parentNode.querySelector('input[type=number]').stepUp()">+</button>
                <button type="submit" class="btn-danger">Update Cart</button>
              </form>
              <form action="${cp}/user/cart/delete/${item.id}" method="post">
                <input type="hidden" name="cartId" value="${item.id}">
                <button type="submit" class="remove-btn" onclick="return confirm('Remove this item?')">Remove</button>
              </form>
            </div>
          </div>
          <c:set var="itemTotal" value="${item.product.price * item.quantity}" />
          <c:set var="totalPrice" value="${totalPrice + itemTotal}" />
        </c:forEach>
      </div>

      <!-- Order Summary -->
      <div class="summary-card">
        <h3 class="summary-title">Order Summary</h3>
        <div class="summary-row">
          <span>Subtotal</span>
          <span>Rs ${totalPrice}</span>
        </div>
        <div class="summary-row">
          <span>Shipping</span> 
          <span>Rs:100</span>
        </div>
        <div class="summary-total">
          <span>Total</span>
          <span>Rs ${totalPrice+100}</span>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="action-buttons">
        <a href="${cp}/products" class="action-btn btn-outline">← Continue Shopping</a>
        <form action="${cp}/user/cart/deleteAll/${user.id}" method="post" style="flex: 1;">
          <button type="submit" class="action-btn btn-outline" onclick="return confirm('Clear your entire cart?')">Clear Cart</button>
        </form>
        <a href="${cp}/myorders" class="action-btn btn-outline">View Orders →</a>
      </div>

      <!-- Payment Options -->
      <div class="payment-options">
        <h3 class="payment-title">Payment Method</h3>
        <div class="payment-methods">
          <a href="${cp}/user/payment/success/cod" class="payment-method">
            <img src="/images/cod_logo.png" alt="Cash on Delivery" class="payment-logo">
            <span class="payment-name">Cash on Delivery</span>
          </a>
          <a href="${cp}/user/payment/esewa/${user.id}" class="payment-method">
            <img src="/images/esewa_logo.png" alt="eSewa" class="payment-logo">
            <span class="payment-name">eSewa</span>
          </a>
          <a href="${cp}/user/khalti/${user.id}" class="payment-method">
            <img src="/images/khalti_logo.png" alt="Khalti" class="payment-logo">
            <span class="payment-name">Khalti</span>
          </a>
        </div>
      </div>
    </c:if>
  </div>
<%@ include file="../user/footer.jsp" %>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
