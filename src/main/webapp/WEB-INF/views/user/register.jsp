<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>User Register: Second Hand Bazar</title>

    <!-- Custom fonts for this template-->
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">
    <link rel="stylesheet" href="${cp}/css/register.css">
</head>

<body>
    <div class="container-sm">
        <div class="card">
            <div class="card-body">
                <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Create an Account</h1>
                </div>

                <c:if test="${not empty success}">
                    <div class="alert alert-success fw-bold" role="alert">
                        ${success}
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger fw-bold" role="alert">
                        ${error}
                    </div>
                </c:if>

                <form class="user" action="${cp}/register" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <!-- Name Field -->
                    <div class="form-group">
                        <input type="text" class="form-control form-control-user" placeholder="Enter Name" name="name" required>
                        <c:if test="${not empty valid_errors}">
                            <ul class="text-danger">
                                <c:forEach var="error" items="${valid_errors}">
                                    <c:if test="${error.field=='name'}">
                                        <li>${error.defaultMessage}</li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </div>

                    <!-- Phone Field -->
                    <div class="form-group">
                        <input type="text" class="form-control form-control-user" placeholder="Enter Phone" name="phone" required>
                        <c:if test="${not empty valid_errors}">
                            <ul class="text-danger">
                                <c:forEach var="error" items="${valid_errors}">
                                    <c:if test="${error.field=='phone'}">
                                        <li>${error.defaultMessage}</li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </div>

                    <!-- Address Field -->
                    <div class="form-group">
                        <input type="text" class="form-control form-control-user" placeholder="Enter Address" name="address" required>
                        <c:if test="${not empty valid_errors}">
                            <ul class="text-danger">
                                <c:forEach var="error" items="${valid_errors}">
                                    <c:if test="${error.field=='address'}">
                                        <li>${error.defaultMessage}</li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </div>

                    <!-- Username Field -->
                    <div class="form-group">
                        <input type="text" class="form-control form-control-user" placeholder="Enter Username" name="username" required>
                        <c:if test="${not empty valid_errors}">
                            <ul class="text-danger">
                                <c:forEach var="error" items="${valid_errors}">
                                    <c:if test="${error.field=='username'}">
                                        <li>${error.defaultMessage}</li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </div>

                    <!-- Date of Birth Field -->
                    <div class="form-group">
                        <input type="date" class="form-control form-control-user" name="dob" required>
                    </div>

                    <!-- Email Field -->
                    <div class="form-group">
                        <input type="email" class="form-control form-control-user" placeholder="Enter Email Address" name="email" required>
                        <c:if test="${not empty valid_errors}">
                            <ul class="text-danger">
                                <c:forEach var="error" items="${valid_errors}">
                                    <c:if test="${error.field=='email'}">
                                        <li>${error.defaultMessage}</li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </div>

                    <!-- Password Fields -->
                    <div class="form-group">
                        <input type="password" class="form-control form-control-user" placeholder="Enter Password" name="password" required>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control form-control-user" placeholder="Repeat Password" name="confirmPassword" required>
                    </div>

                    <!-- Submit Button -->
                    <div class="form-group">
                        <input type="submit" class="btn btn-user btn-block btn-primary" value="Register">
                    </div>
                </form>

                <div class="text-center">
                    <a class="small" href="${cp }/login">Already have an account? Login!</a>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
