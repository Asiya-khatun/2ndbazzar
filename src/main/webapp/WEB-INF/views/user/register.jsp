<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="User Registration Page">
    <meta name="author" content="">
    <title>User Register: Second Hand Bazar</title>

    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-red: #e63946;
            --dark-red: #c1121f;
            --light-red: #ffcad4;
            --white: #f8f9fa;
            --dark: #212529;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #fff5f5 0%, #ffecec 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .register-container {
            max-width: 800px;
            width: 100%;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(230, 57, 70, 0.15);
            background: var(--white);
        }
        
        .register-form {
            padding: 2.5rem;
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 1.8rem;
        }
        
        .register-header h1 {
            color: var(--dark-red);
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }
        
        .form-group {
            margin-bottom: 1.3rem;
            position: relative;
        }
        
        .form-control {
            width: 80%;
            padding: 10px 15px 10px 40px;
            border: 1px solid var(--light-red);
            border-radius: 6px;
            font-size: 0.95rem;
            background-color: #fff;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-red);
            box-shadow: 0 0 0 3px rgba(230, 57, 70, 0.2);
        }
        
        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-red);
            font-size: 1rem;
        }
        
        .btn-register {
            background: linear-gradient(to right, var(--primary-red), var(--dark-red));
            border: none;
            color: white;
            padding: 12px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            width: 85%;
            box-shadow: 0 4px 12px rgba(230, 57, 70, 0.3);
            margin-top: 0.5rem;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(230, 57, 70, 0.4);
            background: linear-gradient(to right, var(--dark-red), var(--primary-red));
        }
        
        .login-link {
            text-align: center;
            margin-top: 1.3rem;
            font-size: 0.9rem;
        }
        
        .login-link a {
            color: var(--primary-red);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .login-link a:hover {
            color: var(--dark-red);
            text-decoration: underline;
        }
        
        .alert {
            padding: 12px 15px;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .text-danger {
            color: var(--dark-red);
            font-size: 0.8rem;
            margin-top: 5px;
            padding-left: 20px;
        }
        
        .text-danger li {
            margin-bottom: 3px;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .register-container {
                max-width: 600px;
            }
        }
        
        @media (max-width: 576px) {
            .register-form {
                padding: 1.8rem;
            }
            
            .register-header h1 {
                font-size: 1.6rem;
            }
            
            .form-control {
                padding: 10px 15px 10px 35px;
            }
        }
    </style>
</head>

<body>
    <div class="register-container">
        <div class="register-form">
            <div class="register-header">
                <h1>Create an Account</h1>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <form action="${cp}/register" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <!-- Name Field -->
                <div class="form-group">
                    <i class="fas fa-user input-icon"></i>
<input type="text" class="form-control" placeholder="Full Name" name="name" value="${user.name}" required>
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
                    <i class="fas fa-phone input-icon"></i>
<input type="text" class="form-control" placeholder="Phone Number" name="phone" value="${user.phone}" required>
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
                    <i class="fas fa-map-marker-alt input-icon"></i>
<input type="text" class="form-control" placeholder="Address" name="address" value="${user.address}" required>
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
                    <i class="fas fa-at input-icon"></i>
<input type="text" class="form-control" placeholder="Username" name="username" value="${user.username}" required>
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
					<i class="fas fa-calendar-alt input-icon"></i>
					<input type="date" class="form-control" name="dob" value="${user.dob}" required>

					<c:if test="${not empty valid_errors}">
						<ul class="text-danger">
							<c:forEach var="error" items="${valid_errors}">
								<c:if test="${error.field=='dob'}">
									<li>${error.defaultMessage}</li>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
				</div>

				<!-- Email Field -->
                <div class="form-group">
                    <i class="fas fa-envelope input-icon"></i>
<input type="email" class="form-control" placeholder="Email Address" name="email" value="${user.email}" required>
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
								<!-- Password Field -->
				<div class="form-group">
					<i class="fas fa-lock input-icon"></i> <input type="password"
						class="form-control" placeholder="Password" name="password"
						required>
					<c:if test="${not empty valid_errors}">
						<ul class="text-danger">
							<c:forEach var="error" items="${valid_errors}">
								<c:if test="${error.field=='password'}">
									<li>${error.defaultMessage}</li>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
				</div>


				<div class="form-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" class="form-control" placeholder="Confirm Password" name="confirmPassword" required>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-register">
                    <i class="fas fa-user-plus"></i> Register Account
                </button>
            </form>

            <div class="login-link">
                <a href="${cp}/login">Already have an account? Login!</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>