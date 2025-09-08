<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>User Products</title>
    <style>
        :root {
            --primary-red: #d32f2f;
            --dark-red: #b71c1c;
            --light-red: #ff5252;
            --card-bg: #fff;
            --text: #333;
            --text-light: #f5f5f5;
            --gold-accent: #FFD700;
        }
        
        body {
            background-color: #f9f9f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .dashboard-container {
            max-width: 1400px;
            margin: 2rem auto;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            border-bottom: 2px solid var(--primary-red);
        }
        
        .page-title {
            font-size: 2rem;
            color: var(--dark-red);
            font-weight: 700;
            position: relative;
        }
        
        .page-title:after {
            content: '';
            position: absolute;
            bottom: -17px;
            left: 0;
            width: 60px;
            height: 3px;
            background: var(--gold-accent);
        }
        
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }
        
        .dashboard-card {
            background: var(--card-bg);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(183, 28, 28, 0.1);
            transition: all 0.3s ease;
            border: 1px solid rgba(183, 28, 28, 0.1);
        }
        
        .dashboard-card:hover {
            box-shadow: 0 10px 25px rgba(183, 28, 28, 0.2);
            transform: translateY(-5px);
            border-color: rgba(183, 28, 28, 0.2);
        }
        
        .card-header {
            position: relative;
            height: 200px;
            overflow: hidden;
        }
        
        .card-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .dashboard-card:hover .card-img {
            transform: scale(1.05);
        }
        
        .card-body {
            padding: 20px;
        }
        
        .card-title {
            font-size: 1.3rem;
            color: var(--dark-red);
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .card-text {
            color: var(--text);
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background: linear-gradient(to right, rgba(183, 28, 28, 0.05), rgba(255, 215, 0, 0.05));
            border-top: 1px solid rgba(183, 28, 28, 0.1);
        }
        
        .category-badge {
            background: var(--primary-red);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            box-shadow: 0 2px 5px rgba(183, 28, 28, 0.2);
        }
        
        .owner-info {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: var(--dark-red);
        }
        
        .owner-info i {
            color: var(--gold-accent);
        }
        
        .no-products {
            text-align: center;
            grid-column: 1 / -1;
            padding: 50px;
            color: var(--dark-red);
            font-size: 1.2rem;
        }
        
        @media (max-width: 768px) {
            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
            
            .page-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%@include file="navbar.jsp" %>
    <div class="dashboard-container">
        <div class="page-header">
            <h1 class="page-title">User Products</h1>
        </div>
        
        <div class="products-grid">
            <c:choose>
                <c:when test="${not empty product}">
                    <c:forEach items="${product}" var="product">
                        <div class="dashboard-card">
                            <div class="card-header">
                                <img src="${cp}/product_image/${product.imageName}" alt="${product.name}" class="card-img"/>
                            </div>
                            <div class="card-body">
                                <h3 class="card-title">${product.name}</h3>
                                <p class="card-text">${product.description}</p>
                            </div>
                            <div class="card-footer">
                                <span class="category-badge">${product.category}</span>
                                <span class="owner-info">
                                    <i class="mdi mdi-account"></i>
                                    ${product.user.username}
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-products">
                        <p>No products found</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>