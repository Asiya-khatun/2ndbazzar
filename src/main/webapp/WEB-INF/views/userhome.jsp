<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <title>Second Hand Bazar</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${cp}/asset/css/vendor.css">
    <link rel="stylesheet" type="text/css" href="${cp}/asset/style.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">
</head>

<header class="bg-light py-3 shadow-sm">
    <div class="container-lg d-flex justify-content-between align-items-center">
            <h1 href="${cp}/user/home" class="text-logo">2ndBazar </h1>
            
        <nav class="d-flex gap-3 align-items-center" aria-label="Main Navigation">
            <a href="${cp}/user/home" class="nav-link">Home</a>
            <a href="${cp}/user/product/view/${user.id}" class="nav-link"> Products</a>
            <a href="${cp}/user/cart/show/${user.id}" class="nav-link">Cart</a>
            <a href="${cp}/otherOrders/${user.id}" class="nav-link">Orders</a>
            

            <!-- Profile Dropdown -->
            <div class="dropdown">
                <a class="nav-link dropdown-toggle d-flex align-items-center" id="UserDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <!-- Default User Logo -->
                    <img 
                        src="${cp}/asset/images/default-user.png" 
                        alt="User" 
                        class="img-xs rounded-circle me-2" 
                        style="width: 40px; height: 40px;">
                   
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="UserDropdown">
                    <li class="dropdown-header text-center">
                        <img 
                            src="${cp}/asset/images/default-user.png" 
                            alt="User" 
                            class="rounded-circle mb-2" 
                            style="width: 50px; height: 50px;">
                        <p class="mb-0">${user.email}</p>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <a class="dropdown-item" href="${cp}/user/edit">
                            <i class="mdi mdi-account-outline text-primary me-2"></i> My Profile
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="${cp}/logout">
                            <i class="mdi mdi-power text-primary me-2"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</header>
