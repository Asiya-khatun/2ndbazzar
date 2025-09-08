<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Products | Product Manager</title>
<link href="${cp}/assests/css/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${cp}/asset/css/Myproducts.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
	<%@ include file="../user/navbar.jsp"%>

	<div class="container-fluid py-4">
		<div class="row">
			<div class="col-12">
				<div class="dashboard-header">
					<div>
						<h1 class="dashboard-title">📦 My Products</h1>
						<p class="dashboard-subtitle">Manage your product inventory</p>
					</div>

					<div class="d-flex gap-3 justify-content-right my-4 marketplace-actions">
						<a href="${cp}/user/product/allproducts/${user.id}" class="btn btn-outline-darkred">
							<i class="fas fa-store me-2"></i> View Marketplace
						</a> 
						<a href="${cp}/user/product/add" class="btn btn-darkred">
							<i class="fas fa-plus me-2"></i> Add Product
						</a>
					</div>
				</div>

				<c:if test="${not empty success}">
					<div class="alert alert-success alert-dismissible fade show">
						<div>
							<i class="fas fa-check-circle me-2"></i> ${success}
						</div>
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>

				<c:if test="${not empty deleteSuccess}">
					<div class="alert alert-success alert-dismissible fade show">
						<div>
							<i class="fas fa-check-circle me-2"></i> ${deleteSuccess}
						</div>
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>

				<c:if test="${not empty errordelete}">
					<div class="alert alert-danger alert-dismissible fade show">
						<div>
							<i class="fas fa-exclamation-circle me-2"></i> ${errordelete}
						</div>
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>

				<div class="card">
					<div class="card-header">
						<h5 class="card-title mb-0">
							<i class="fas fa-boxes me-2"></i> Product Inventory
						</h5>
						<div class="d-flex align-items-center">
							<span class="badge bg-light text-dark me-2"> 
								<i class="fas fa-box me-1"></i> ${products.size()} Items
							</span>
						</div>
					</div>

					<div class="card-body">
						<c:choose>
    <c:when test="${noProduct}">
        <div class="empty-state">
            <div class="empty-state-icon">
                <i class="fas fa-box-open"></i>
            </div>
            <h3 class="empty-state-title">No Products Found</h3>
            <p class="empty-state-text">
                You haven't added any products yet. Start building your inventory by adding your first product.
            </p>
            <a href="${cp}/user/product/add" class="btn btn-primary btn-lg">
                <i class="fas fa-plus me-2"></i> Add Product
            </a>
        </div>
    </c:when>

    <c:otherwise>
        <div class="table-container">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Added On</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td data-label="Product">
                                <div class="d-flex align-items-center">
                                    <div class="product-img-container me-3">
                                        <img src="${cp}/product_image/${product.imageName}" alt="${product.name}" class="product-img">
                                    </div>
                                    <div>
                                        <h6 class="mb-0">${product.name}</h6>
                                        <small class="text-muted">${product.description}</small>
                                    </div>
                                </div>
                            </td>
                            <td data-label="Category"><span class="badge badge-primary">${product.category}</span></td>
                            <td data-label="Price"><strong class="cash"> RS:${product.price}</strong></td>
                            <td data-label="Stock">
                                <c:choose>
                                  
                                    <c:when test="${product.quantity > 0}">
                                        <span class="text-success"><i class="fas fa-check-circle me-1"></i>${product.quantity}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger"><i class="fas fa-times-circle me-1"></i> Out of stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td data-label="Status"><span class="status-badge"><span class="status-dot active"></span> <span>Active</span></span></td>
                            <td data-label="Added On">${product.addedDate}</td>
                            <td data-label="Actions">
                                <div class="d-flex gap-2 align-items-center">
                                    <a href="${cp}/user/product/edit/${product.id}" class="btn btn-sm btn-info" data-toggle="tooltip" title="Edit Product">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="${cp}/user/product/delete/${product.id}" method="post" class="m-0 p-0">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you absolutely sure you want to delete this product? This action cannot be undone.')" data-toggle="tooltip" title="Delete Product">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>

					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Floating Action Button -->
	<a href="${cp}/user/product/add" class="floating-btn btn btn-primary d-lg-none">
		<i class="fas fa-plus"></i>
	</a>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/ekko-lightbox@5.3.0/dist/ekko-lightbox.min.js"></script>

	<script>
    $(document).ready(function() {
        $('[data-toggle="tooltip"]').tooltip();

        $(document).on('click', '.product-img-container', function(event) {
            event.preventDefault();
            $(this).ekkoLightbox({
                alwaysShowClose: true,
                showArrows: true
            });
        });

        function setupResponsiveTable() {
            if ($(window).width() < 1000) {
                $('table').each(function() {
                    $(this).find('td').each(function() {
                        var cell = $(this);
                        var header = cell.closest('table').find('th').eq(cell.index());
                        cell.attr('data-label', header.text());
                    });
                });
            }
        }
        setupResponsiveTable();
        $(window).resize(function() {
            setupResponsiveTable();
        });
    });
    </script>

	<%@ include file="../user/footer.jsp"%>

</body>
</html>
