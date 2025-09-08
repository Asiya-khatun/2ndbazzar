<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/nouislider.min.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/slick.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/slick-theme.css">
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/style.css">

<body>
    <footer id="footer">
        <div class="section">
            <div class="container">
                <div class="column">

                    <div class="col-md-4 col-xs-12">
                        <div class="footer">
                            <h3 class="footer-title">
                                <i class="fas fa-user-circle"></i> Personal Info
                            </h3>
                            <ul class="footer-links">
                                <li><a href="#"><i class="fa fa-map-marker"></i> ${user.address}</a></li>
                                <li><a href="#"><i class="fa fa-phone"></i> ${user.phone}</a></li>
                                <li><a href="#"><i class="fa fa-envelope-o"></i> ${user.email}</a></li>
                            </ul>
                        </div>
                    </div>

                    <!-- Activity -->
                    <div class="col-md-4 col-xs-12">
                        <div class="footer">
                            <h3 class="footer-title">
                                <i class="fas fa-tasks"></i> Activity
                            </h3>
                            <ul class="footer-links">
                                <li>
                                    <a href="${cp}/user/product/add">
                                        <i class="fas fa-plus-circle"></i>Add Product
                                    </a>
                                </li>
                                <li>
                                    <a href="${cp}/user/product/view/${user.id}">
                                        <i class="fas fa-plus-circle"></i> My Products
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Service -->
                    <div class="col-md-4 col-xs-12">
                        <div class="footer">
                            <h3 class="footer-title">
                                <i class="fas fa-concierge-bell"></i> Service
                            </h3>
                            <ul class="footer-links">
                                <li>
                                    <a href="${cp}/user/edit">
                                        <i class="fas fa-user-cog"></i> My Account
                                    </a>
                                </li>
                                <li>
                                    <a href="${cp}/user/cart/show/${user.id}">
                                        <i class="fas fa-shopping-cart"></i> View Cart
                                    </a>
                                </li>
                                <li>
                                    <a href="${cp}/myorders">
                                        <i class="fas fa-box"></i> My Orders
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </footer>
</body>
</html>
