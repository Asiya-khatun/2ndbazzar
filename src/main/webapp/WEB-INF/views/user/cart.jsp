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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="${cp}/css/cart.css">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Lora:wght@700&family=Poppins:wght@400;600&display=swap"
	rel="stylesheet">

<!-- Custom Styles -->
<style>
body {
	font-family: 'Poppins', sans-serif;
	background-color: #f8f9fa;
	padding: 20px;
}

.cart-header h2 {
	font-family: 'Lora', serif;
	color: #fff;
	background-color: #800080; /* Purple */
	font-size: 2.5rem;
	text-align: center;
	padding: 20px;
	border-radius: 10px;
	text-transform: uppercase;
}

.cart-item {
	background-color: #fff;
	border-radius: 10px;
	padding: 15px;
	margin-bottom: 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: space-between;
	align-items: center;
	max-width: 800px;
	margin: 0 auto;
}

.cart-item img {
	width: 120px;
	height: auto;
	border-radius: 10px;
}

.cart-item-details {
	flex-grow: 1;
	padding-left: 20px;
}

.cart-item-details h5 {
	font-family: 'Lora', serif;
	color: #FF6F61; /* Soft Coral */
	font-size: 1.5rem;
}

.cart-item-details p {
	font-size: 1rem;
	color: #34495e;
	margin: 5px 0;
}

.button-container {
	display: flex;
	gap: 10px;
}

.btn-update, .remove-btn {
	background-color: #FF6F61;
	color: white;
	border: none;
	padding: 8px 15px;
	border-radius: 5px;
	cursor: pointer;
	text-transform: uppercase;
	font-size: 0.75rem;
	width: 90px;
}

.btn-update:hover, .remove-btn:hover {
	background-color: #ff4d3f;
}

.cart-total {
	background-color: #fff;
	border-radius: 10px;
	padding: 15px;
	margin-top: 30px;
	text-align: center;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.cart-total h4 {
	font-family: 'Lora', serif;
	color: #2c3e50;
	font-size: 2rem;
}

.form-container {
	margin-top: 30px;
	background-color: #fff;
	border-radius: 10px;
	padding: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.form-header {
	font-family: 'Lora', serif;
	font-size: 1.8rem;
	color: #FF6F61;
	text-align: center;
	margin-bottom: 20px;
}

.d-flex a {
	margin: 0 10px;
}

.d-flex img {
	width: 100px;
	height: auto;
	border-radius: 10px;
}

.show-ordered-btn, .delete-all-btn {
	background-color: #800080;
	color: white;
	padding: 10px 5px;
	font-size: 1.50vh;
	border-radius: 10px;
	text-align: center;
	text-decoration: none;
	width: 200px;
	text-transform: uppercase;
}

.show-ordered-btn:hover, .delete-all-btn:hover {
	background-color: #6a006a;
}

.button-wrapper {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
}

.alert {
	text-align: center;
	margin-bottom: 15px;
}
</style>
</head>
<body>
	<%@ include file="../userhome.jsp"%>

	<c:if test="${not empty param.error}">
		<div class="alert alert-danger">Cart not found!</div>
	</c:if>

	<div class="container">
		<div class="cart-header">
			<h2>My Cart List</h2>
		</div>
		<c:if test="${not empty deleteSuccess}">
			<div class="alert alert-success">
				${deleteSuccess}
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>

			</div>
		</c:if>

		<c:if test="${not empty deleteOneSuccess}">
			<div class="alert alert-success">
				${deleteOneSuccess}
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>

			</div>
		</c:if>

		<c:if test="${not empty errordelete}">
			<div class="alert alert-success">
				${errordelete}
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>

			</div>
		</c:if>
		<c:if test="${not empty NullProduct}">
			<div class="alert alert-danger">${NullProduct}</div>
		</c:if>

		<c:if test="${not empty noCartFound}">
			<div class="alert alert-danger">${noCartFound}</div>
		</c:if>

		<c:set var="totalPrice" value="0" />
		<c:forEach items="${cartItems}" var="item" varStatus="status">
			<div class="cart-item">
				<img src="${cp}/product_image/${item.product.imageName}"
					alt="Product Image">
				<div class="cart-item-details">
					<h5>${item.product.name}</h5>
					<p>Category: ${item.product.category.name}</p>
					<p>Price: Rs ${item.product.price}</p>
					<p>Total Quantity: ${item.product.quantity}</p>
					<p>Ordered Quantity: ${item.quantity}</p>
					<c:if test="${not empty QuantityExceed}">
						<div class="alert alert-warning">${QuantityExceed}</div>
					</c:if>
				</div>
				<div class="button-container">
					<form action="${cp}/user/cart/update/${item.id}" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <input type="number" name="quantity"
							value="${item.quantity}" /> <br>
						<br>
						<button type="submit" class="btn-update">Update</button>
					</form>
					<form action="${cp}/user/cart/delete/${item.id}" method="post">
						<input type="hidden" name="cartId" value="${item.id}">
						<button type="submit" class="remove-btn"
							onclick="return confirm('Are you sure you want to remove this item?')">Delete</button>
					</form>
				</div>
			</div>
			<c:set var="itemTotal" value="${item.product.price * item.quantity}" />
			<c:set var="totalPrice" value="${totalPrice + itemTotal}" />
		</c:forEach>

		<div class="cart-total">
			<h4>Total: Rs ${totalPrice}</h4>
		</div>

		<div class="button-wrapper">
			<a href="${cp}/myorders/${user.id}" class="show-ordered-btn">Show
				My Ordered Products</a>

			<form
				action="${pageContext.request.contextPath}/user/cart/deleteAll/${user.id}"
				method="post">
				<button type="submit" class="delete-all-btn"
					onclick="return confirm('Are you sure you want to remove all items?')">Delete
					All Carts</button>
			</form>
		</div>

		<div class="form-container">
			<div class="form-header">Payment Options</div>
			<div class="d-flex justify-content-around">
				<a href="${cp}/user/payment/success/cod"> <img
					src="/images/cod_logo.png" alt="Cash on Delivery">
				</a> <a href="${cp}/user/payment/esewa/${user.id}"> <img
					src="/images/esewa_logo.png" alt="eSewa Payment">
				</a> <a href="${cp}/user/khalti/${user.id}"> <img
					src="/images/khalti_logo.png" alt="Khalti Payment">
				</a>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
