<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Product Management</title>

    <!-- Fonts and Icons -->
    <link href="${cp}/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Nunito&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${cp}/asset/css/AddProduct.css">

</head>

<%@ include file="../user/navbar.jsp" %>

<body id="page-top">
    <div id="wrapper">
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <div class="container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <c:choose>
                                <c:when test="${edit ne true}">
                                    <div class="card">
                                        <div class="card-header">Add New Product</div>
                                        <div class="card-body">
                                            <form class="form" action="${cp}/user/product/add" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <label for="product_name">Product Name:</label>
                                                        <input type="text" id="product_name" class="form-control" name="name" />
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'name'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="product_quantity">Quantity:</label>
                                                        <input type="number" id="product_qty" class="form-control" name="quantity" />
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'quantity'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <label for="product_price">Price:</label>
                                                        <input type="number" id="product_price" class="form-control" name="price" />
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'price'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
													<div class="col-md-6">
														<label for="product_category">Category:</label> <select
															class="form-control" name="category"
															id="product_category">
															<c:forEach items="${cat_list}" var="cat">
																<option value="${cat}">${cat}</option>
															</c:forEach>
														</select>

														<c:if test="${not empty valid_errors}">
															<ul class="text-danger" style="margin-top: 5px;">
																<c:forEach var="error" items="${valid_errors}">
																	<c:if test="${error.field == 'category'}">
																		<li>${error.defaultMessage}</li>
																	</c:if>
																</c:forEach>
															</ul>
														</c:if>
													</div>

												</div>

                                                <div class="row mb-3">
                                                    <div class="col-md-12">
                                                        <label for="product_description">Description:</label>
                                                        <textarea name="description" id="product_description" class="form-control" rows="4"></textarea>
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'description'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-md-12">
                                                        <label for="product_image">Image:</label>
                                                        <input type="file" id="product_image" class="form-control" name="imageFile" />
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'imageFile'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <div class="form-group mb-3">
                                                    <input type="submit" class="btn btn-danger" value="Add Product" />
                                                    <input type="reset" class="btn btn-warning" value="Reset Form" />
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div class="card">
                                        <div class="card-header">Update Product Information</div>
                                        <div class="card-body">
                                            <form class="form" action="${cp}/user/product/update/${product_id}" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <label for="product_id">Product Id:</label>
                                                        <input type="number" id="product_id" class="form-control" value="${edit_product.id}" readonly />
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <label for="product_name">Product Name:</label>
                                                        <input type="text" id="product_name" class="form-control" name="name" value="${edit_product.name}" />
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'name'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="product_quantity">Quantity:</label>
                                                        <input type="number" id="product_qty" class="form-control" name="quantity" value="${edit_product.quantity}" />
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'quantity'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <label for="product_price">Price:</label>
                                                        <input type="number" id="product_price" class="form-control" name="price" value="${edit_product.price}" />
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'price'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                   <div class="col-md-6">
    <label for="product_category">Category:</label>
    <select class="form-control" name="category" id="product_category">
        <c:forEach items="${cat_list}" var="cat">
            <option value="${cat}" <c:if test="${cat == edit_product.category}">selected</c:if>>
                ${cat}
            </option>
        </c:forEach>
    </select>

    <c:if test="${not empty valid_errors}">
        <ul class="text-danger mt-2">
            <c:forEach var="error" items="${valid_errors}">
                <c:if test="${error.field == 'category'}">
                    <li>${error.defaultMessage}</li>
                </c:if>
            </c:forEach>
        </ul>
    </c:if>
</div>


                                                    
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-md-12">
                                                        <label for="product_description">Description:</label>
                                                        <textarea name="description" id="product_description" class="form-control" rows="4">${edit_product.description}</textarea>
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'description'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-md-12">
                                                        <input type="hidden" name="prevImage" value="${edit_product.imageName}" />
                                                        <label for="product_image">Image:</label>
                                                        <input type="file" id="product_image" class="form-control" name="imageFile" />
                                                        <c:if test="${not empty valid_errors}">
                                                            <ul class="text-danger" style="margin-top:5px;">
                                                                <c:forEach var="error" items="${valid_errors}">
                                                                    <c:if test="${error.field == 'imageFile'}">
                                                                        <li>${error.defaultMessage}</li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <div class="form-group mb-3">
                                                    <input type="submit" class="btn btn-danger" value="Update Product" />
                                                    <input type="reset" class="btn btn-warning" value="Reset Form" />
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
    <script src="${cp}/assets/vendor/jquery/jquery.min.js"></script>
    <script src="${cp}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${cp}/assets/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="${cp}/assets/js/sb-admin-2.min.js"></script>
</body>

</html>
