<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" type="text/css" href="${cp}/asset/css/cart.css">
  <link rel="stylesheet" type="text/css"href="${cp}/asset/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"href="${cp}/asset/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"href="${cp}/asset/css/nouislider.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/slick.css">
<link rel="stylesheet" type="text/css"href="${cp}/asset/css/slick-theme.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body>
<header>
	<div id="header">
		<div class="container">
			<div class="row align-items-center">
				
				<!-- Logo -->
				<div class="col-md-3">
					<div class="header-logo">
						<a href="${cp}/admin/home" class="logo">
							<img src="${cp}/asset/img/logo1.png" alt="Logo" />
						</a>
					</div>
				</div>

				<!-- Product / Cart / Orders -->
				<div class="col-md-6 offset-md-3">
					<div class="header-ctn d-flex justify-content-start align-items-center gap-3">
						<div>
							<a href="${cp}/admin/user/show">
								<i class="fa fa-shopping-bag mr-1"></i> User
							</a>
						</div>
						<div>
							<a href="${cp}/admin/allProducts">
								<i class="fa fa-shopping-bag mr-1"></i> Product
							</a>
						</div>
								
							<div>
							<a href="${cp}/admin/editProfile">
								<i class="fa fa-user-circle"></i> Profile   
							</a>
						</div>
							<div>
								<a href="${cp}/logout"> <i class="fa fa-sign-out"></i>
									Logout
								</a>
							</div>
						</div>
				</div>

			</div>
		</div>
	</div>
</header>
</body>
</html>