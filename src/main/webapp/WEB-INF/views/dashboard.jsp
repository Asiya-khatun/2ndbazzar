
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Second Hand Bazar</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${cp}/asset/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${cp}/asset/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${cp}/asset/css/nouislider.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/slick.css">
<link rel="stylesheet" type="text/css"
	href="${cp}/asset/css/slick-theme.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/style.css">

<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap"
	rel="stylesheet">
</head>
<style>
/* Importing Google Fonts */
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@600&family=Roboto:wght@500&family=Open+Sans:wght@400;600&display=swap')
	;
</style>

<body>
	<div class="col-md-3">
		<div class="header-logo">
			<a href="#" class="logo"> <img src="${cp }/asset/img/logo1.png" alt="" />
			</a>
		</div>
	</div>
	<header>
		<div id="top-header">
			<div class="container">
				<ul class="header-links pull-right" ">
					<li><a href="${cp}/login" class="nav-link" style="font-size: 2rem;">Login</a></li>
				</ul>

			</div>
		</div>
</body>
			
	
		<div class="section">
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-xs-6">
						<div class="shop">
							<div class="shop-img">
								<img src="${cp }/asset/img/shop01.png" alt="" />
							</div>
							<div class="shop-body">
								<h3>Laptop<br />Collection</h3>
								<a href="${cp }/login" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>					<div class="col-md-4 col-xs-6">
						<div class="shop">
							<div class="shop-img">
								<img src="${cp }/asset/img/shop03.png" alt="" />
							</div>
							<div class="shop-body">
								<h3>Accessories<br />Collection</h3>
								<a href="${cp }/login" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>					<div class="col-md-4 col-xs-6">
						<div class="shop">
							<div class="shop-img">
								<img src="${cp }/asset/img/shop02.png" alt="" />
							</div>
							<div class="shop-body">
								<h3>Cameras<br />Collection</h3>
								<a href="${cp }/login" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
<%@ include file ="./user/footer.jsp" %>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/slick.min.js"></script>
<script src="js/nouislider.min.js"></script>
<script src="js/jquery.zoom.min.js"></script>
<script src="js/main.js"></script>
</html>

