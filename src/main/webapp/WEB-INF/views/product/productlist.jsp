<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta charset="UTF-8">
<title>My Products</title>
</head>

<link href="${cp }/assests/css/sb-admin-2.min.css" rel="stylesheet">

<style>
.btn-danger.btn-sm {
    background-color: #dc3545; /* Red color */
    border: 2px solid #bd2130; /* Darker red border */
    color: white;
    font-weight: bold;
    padding: 8px 15px;
    border-radius: 5px;
    text-transform: uppercase; /* Optional, makes text uppercase */
    transition: all 0.3s ease; /* Smooth transition for hover effect */
}

.btn-danger.btn-sm:hover {
    background-color: #bd2130; /* Darken the button on hover */
    border-color: #9e1c2b; /* Darker border on hover */
    cursor: pointer;
}

</style>
<body>

<%@ include file="../userhome.jsp" %>

    

	<div class="row" id="product_data" >
		<div class="col">
			<div class="card">
	
			        <h1 align="center"> My Products</h2>
			
		
									
									<c:if test="${noProduct }">
			<div class="alert alert-success">${noProduct }</div>
									</c:if>
			
				<div class="card-heading">
					<div class="card-body">
						<table class="table table-responsive table-striped">
							<thead>
							
								<tr>
								
									<th>Product Id</th>
									<th>Product Name</th>
									<th>Product Description</th>
									<th>Parent Category</th>
									<th>Product Price</th>
									<th>Product Image</th>
									<th>Product Quantity</th>
									<th>Added Date</th>
									<th>Edit</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
    <c:forEach items="${products}" var="product" >
        <tr>
            <td>${product.id}</td>
            <td>${product.name}</td>
            <td>${product.description}</td>
            <td>${product.category.name}</td>
            <td>${product.price}</td>
            
            <td>
         
                <a href="${cp}/product_image/${product.imageName}">
                    <img src="${cp}/product_image/${product.imageName}" alt="${product.imageName}" height="30px">
                </a>
            </td>
            <td>${product.quantity}</td>
            <td>${product.addedDate}</td>
            <td>
<a href="${cp}/user/product/edit/${product.id}" class="btn btn-info btn-sm">Edit</a>
            </td>
            <td>
               <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${product.id}">
    Delete
</button>


            </td>
        </tr>
    </c:forEach>
</tbody>
</table>
<c:if test="${not empty success}">
    <div class="alert alert-success">
        ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        
    </div>
</c:if>


<c:if test="${not empty deleteSuccess}">
    <div class="alert alert-success">
        ${deleteSuccess}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        
    </div>
</c:if>

<c:if test="${not empty errordelete}">
    <div class="alert alert-success">
        ${errordelete}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        
    </div>
</c:if>
						
					</div>

				</div>
			</div>
			
			<br> <br>
			 




		</div>
	</div>


	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Confirm Delete
						User</h5>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="deleteForm" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
						<p>Are you sure you want to delete this User?</p>
						<div class="form-group d-flex justify-content-end">
							<button type="button" class="btn btn-secondary mr-2"
								data-bs-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-danger">Confirm
								Delete</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>



	<script type="text/javascript">
		$('#deleteModal').on(
				'show.bs.modal',
				function(event) {
					var button = $(event.relatedTarget); // Button that triggered the modal
					var id = button.data('id'); // Extract product id from data-id attribute

					var modal = $(this);
					modal.find('.modal-title').text(
							'Delete product with id ' + id); // You can customize this text
					modal.find('form').attr('action',
							'${cp}/user/product/delete/' + id); // Set the form action to the delete URL
				});
	</script>


    <button type="button" class="btn btn-danger btn-sm" onclick="window.location.href='${cp}/user/product/allproducts/${user.id}'">
    View All Products
</button>

</body>
</html>











