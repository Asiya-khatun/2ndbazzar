<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>User Management</title>

    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        body {
            background: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .user-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px 30px;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            cursor: pointer;
        }

        .user-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 16px 48px rgba(0, 0, 0, 0.15);
        }

        .user-avatar {
            width: 70px;
            height: 70px;
            background: #d32f2f;
            color: white;
            font-weight: 700;
            font-size: 2rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            user-select: none;
            margin-right: 25px;
            flex-shrink: 0;
        }

        .user-info {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .user-name {
            font-weight: 700;
            font-size: 1.3rem;
            color: #b71c1c;
            margin-bottom: 5px;
        }

        .user-address {
            font-size: 0.9rem;
            color: #555;
            margin-bottom: 12px;
        }

        .user-contact {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .badge-phone {
            background-color: #ef5350;
            color: white;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
        }

        .badge-email {
            background-color: #ab47bc;
            color: white;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
        }

        /* Container */
        .container-custom {
            max-width: 900px;
            margin: 0 auto;
        }

        /* Header */
        h1.page-title {
            text-align: center;
            color: #b71c1c;
            font-weight: 900;
            margin-bottom: 40px;
            font-size: 2.8rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-family: 'Segoe UI Black', Tahoma, Geneva, Verdana, sans-serif;
        }
    </style>
</head>

<body>
<%@ include file="navbar.jsp" %>
    <div class="container-custom">

<h1 class="page-title">
  <i class="fa-solid fa-users"></i> User Management
</h1>

        <c:choose>
            <c:when test="${empty user_list}">
                <div class="alert alert-warning text-center" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> No users found.
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${user_list}" var="user">
                    <div class="user-card d-flex align-items-center">
                   
   <!-- Avatar with initials -->
                        <div class="user-avatar">
                            <c:out value="${fn:substring(user.name, 0, 2)}" />
                        </div>
                        
                        <div class="user-info">
<div class="user-name"><i class="fas fa-user"></i> ${user.username}</div>
                            <div class="user-address"><i class="fas fa-map-marker-alt"></i>
                            ${user.address}</div>
                            <div class="user-contact">
                                <span class="badge-phone"><i class="fas fa-phone"></i> ${user.phone}</span>
                                <span class="badge-email"><i class="fas fa-envelope"></i> ${user.email}</span>
								<span class="badge-dob"><i class="fas fa-birthday-cake"></i> ${user.dob}</span>
                                
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </div>

    <!-- Bootstrap 5 JS Bundle (with Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
