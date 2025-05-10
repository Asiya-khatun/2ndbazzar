<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Product Management</title>

<!-- Custom fonts for this template-->
<link href="${cp}/assets/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="${cp}/assests/css/product.css" rel="stylesheet">
</head>

<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<div class="container-fluid">
					<div class="row">


						<div class="col-lg-9">
							<c:choose>
								<c:when test="${edit ne true}">
									<div class="card">
										<div class="card-header">Add New Product</div>
										<div class="card-body">
											<form class="form" action="${cp}/user/product/add"
												method="post" enctype="multipart/form-data">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}">

												<!-- Row 1: Product Name and Product Quantity -->
												<div class="row mb-3">
													<div class="col-md-6">
														<label for="product_name">Product Name:</label> <input
															type="text" id="product_name" class="form-control"
															name="name" />

													</div>
													<div class="col-md-6">
														<label for="product_quantity">Product Quantity:</label> <input
															type="number" id="product_qty" class="form-control"
															name="quantity" />

													</div>
												</div>

												<!-- Row 2: Product Price and Product Category -->
												<div class="row mb-3">
													<div class="col-md-6">
														<label for="product_price">Price:</label> <input
															type="number" id="product_price" class="form-control"
															name="price" />

													</div>
													<div class="col-md-6">
														<label for="product_category">Product Category:</label> <select
															class="form-control" name="category"
															id="product_category">
															<c:forEach items="${cat_list}" var="cat">
																<option value="${cat.id}"
																	${cat.id == product.category.id ? 'selected' : ''}>${cat.name}</option>
															</c:forEach>
														</select>
													</div>
												</div>

												<!-- Row 3: Product Description -->
												<div class="row mb-3">
													<div class="col-md-12">
														<label for="product_description">Product
															Description:</label>
														<textarea name="description" id="product_description"
															class="form-control" rows="5"></textarea>

													</div>
												</div>

												<!-- Row 4: Product Image -->
												<div class="row mb-3">
													<div class="col-md-12">
														<label for="product_image">Product Image:</label> <input
															type="file" id="product_image" class="form-control"
															name="imageFile" />
													</div>
												</div>

												<!-- Form Actions -->
												<div class="form-group mb-3">
													<input type="submit" class="btn btn-primary"
														value="Add Product" /> <input type="reset"
														class="btn btn-warning" value="Reset Form" />
												</div>
											</form>
										</div>
									</div>
								</c:when>

								<c:otherwise>
									<!-- Update Product Form -->
									<div class="card">
										<div class="card-header">Update Product Information</div>
										<div class="card-body">
											<form class="form" action="${cp}/user/product/update/${product_id}"
												method="post" enctype="multipart/form-data">

												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}">


												<div class="row mb-3">
													<div class="col-md-6">
														<label for="product_name">Product Id:</label> <input
															type="number" id="product_id" class="form-control"
															 value="${edit_product.id}" readonly />
													</div>
													<!-- Row 1: Product Name and Product Quantity -->
													<div class="row mb-3">
														<div class="col-md-6">
															<label for="product_name">Product Name:</label> <input
																type="text" id="product_name" class="form-control"
																name="name" value="${edit_product.name}" />
														</div>
														<div class="col-md-6">
															<label for="product_quantity">Product Quantity:</label> <input
																type="number" id="product_qty" class="form-control"
																name="quantity" value="${edit_product.quantity}" />
														</div>
													</div>

													<!-- Row 2: Product Price and Product Category -->
													<div class="row mb-3">
														<div class="col-md-6">
															<label for="product_price">Price:</label> <input
																type="number" id="product_price" class="form-control"
																name="price" value="${edit_product.price}" />
														</div>
														<div class="col-md-6">
															<label for="product_category">Product Category:</label> <select
																class="form-control" name="category"
																id="product_category">
																<c:forEach items="${cat_list}" var="cat">
																	<option value="${cat.id}"
																		${cat.id == edit_product.category.id ? 'selected' : ''}>${cat.name}</option>
																</c:forEach>
															</select>
														</div>
													</div>

													<!-- Row 3: Product Description -->
													<div class="row mb-3">
														<div class="col-md-12">
															<label for="product_description">Product
																Description:</label>
															<textarea name="description" id="product_description"
																class="form-control" rows="5">${edit_product.description}</textarea>
														</div>
													</div>

													<!-- Row 4: Product Image -->
													<div class="row mb-3">
														<div class="col-md-12">
															<input type="hidden" name="pevImage"
																value="${product.imageName}"> <label
																for="product_image">Product Image:</label> <input
																type="file" id="product_image" class="form-control"
																name="imageFile" />
														</div>
													</div>

													<!-- Form Actions -->
													<div class="form-group mb-3">
														<input type="submit" class="btn btn-primary"
															value="Update Product" /> <input type="reset"
															class="btn btn-warning" value="Reset Form" />
													</div>
											</form>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Scripts -->


	<!-- Logout Modal-->


	<script src="${cp}/assests/vendor/jquery/jquery.min.js"></script>
	<script src="${cp}/assests/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugins JavaScript-->
	<script src="${cp}/assests/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${cp}/assests/js/sb-admin-2.min.js"></script>
	<!-- Bootstrap core JavaScript-->





</body>

</html>