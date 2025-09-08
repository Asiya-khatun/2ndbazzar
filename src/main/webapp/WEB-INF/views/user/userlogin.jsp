
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="User Login Page">
    <meta name="author" content="">
    <title>User Login</title>

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
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin: 0;
        }
        
        .login-container {
            max-width: 700px;
            width: 100%;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(230, 57, 70, 0.15);
        }
        
        .login-image {
            background: linear-gradient(rgba(230, 57, 70, 0.7), rgba(193, 18, 31, 0.7)), 
                        url('https://source.unsplash.com/random/600x800/?login,security');
            background-size: cover;
            background-position: center;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            padding: 1.5rem;
        }
        
        .login-image h2 {
            font-weight: 600;
            margin-bottom: 0.8rem;
            font-size: 1.3rem;
        }
        
        .login-image p {
            opacity: 0.9;
            font-size: 0.85rem;
        }
        
        .login-form {
            padding: 2rem;
            background: var(--white);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .login-header h1 {
            color: var(--dark-red);
            font-weight: 700;
            font-size: 1.6rem;
            margin-bottom: 0.5rem;
        }
        
        .login-header p {
            color: #6c757d;
            font-size: 0.85rem;
        }
        
        .form-group {
            margin-bottom: 1.1rem;
            position: relative;
        }
        
        .form-control {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border: 1px solid var(--light-red);
            border-radius: 6px;
            font-size: 0.9rem;
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
            font-size: 0.9rem;
        }
        
        .btn-login {
            background: linear-gradient(to right, var(--primary-red), var(--dark-red));
            border: none;
            color: white;
            padding: 10px;
            font-size: 0.95rem;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            box-shadow: 0 4px 12px rgba(230, 57, 70, 0.3);
            margin-top: 0.5rem;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(230, 57, 70, 0.4);
            background: linear-gradient(to right, var(--dark-red), var(--primary-red));
        }
        
        .btn-google {
            background: #ffffff;
            border: 1px solid #ddd;
            color: #757575;
            padding: 10px;
            font-size: 0.95rem;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-top: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-google:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            background: #f8f8f8;
        }
        
        .btn-google i {
            margin-right: 8px;
            color: #db4437;
            font-size: 1.1rem;
        }
        
        .divider {
            display: flex;
            align-items: center;
            margin: 1.2rem 0;
            color: #6c757d;
            font-size: 0.75rem;
        }
        
        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #dee2e6;
        }
        
        .divider::before {
            margin-right: 0.8rem;
        }
        
        .divider::after {
            margin-left: 0.8rem;
        }
        
        .register-link {
            text-align: center;
            margin-top: 1.1rem;
            font-size: 0.85rem;
        }
        
        .register-link a {
            color: var(--primary-red);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .register-link a:hover {
            color: var(--dark-red);
            text-decoration: underline;
        }
        
        .alert-message {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            width: 90%;
            max-width: 500px;
            padding: 12px;
            border-radius: 6px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .login-image {
                display: none;
            }
            
            .login-form {
                padding: 1.8rem;
            }
            
            .login-container {
                max-width: 400px;
            }
        }
        
        @media (max-width: 576px) {
            .login-form {
                padding: 1.5rem;
            }
            
            .login-header h1 {
                font-size: 1.4rem;
            }
        }
    </style>
</head>

<body>
    <!-- Error/Success Messages -->
    <c:if test="${param.error == 'true'}">
        <div class="alert-message alert-error">
            <strong>Login failed!</strong> Invalid username or password.
        </div>
    </c:if>
    <c:if test="${param.logout == 'true'}">
        <div class="alert-message alert-success">
            <strong>Logged out successfully!</strong>
        </div>
    </c:if>

    <div class="login-container">
        <div class="card o-hidden border-0">
            <div class="card-body p-0">
                <div class="row">
                    <div class="col-lg-6 d-none d-lg-block">
                        <div class="login-image">
                            <div>
                                <h2>Welcome Back!</h2>
                                <p>Sign in to access your personalized dashboard</p>
                                <i class="fas fa-sign-in-alt fa-2x" style="margin-top: 1rem;"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="login-form">
                            <div class="login-header">
                                <h1>User Login</h1>
                                <p>Please enter your credentials</p>
                            </div>
                            <form class="user" action="${cp}/login" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <div class="form-group">
                                    <i class="fas fa-user input-icon"></i>
                                    <input type="text" class="form-control" placeholder="Username" name="username" required>
                                </div>
                                <div class="form-group">
                                    <i class="fas fa-lock input-icon"></i>
                                    <input type="password" class="form-control" placeholder="Password" name="password" required>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn-login">
                                        <i class="fas fa-sign-in-alt"></i> Login
                                    </button>
                                </div>
                                
                                <div class="divider">OR</div>
                                
                                <a href="/oauth2/authorization/google" class="btn-google">
                                    <i class="fab fa-google"></i> Continue with Google
                                </a>
                            </form>
                            <div class="register-link">
                                <a href="/register">Don't have an account? Register Now!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Auto-hide alert messages after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert-message');
            alerts.forEach(function(alert) {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 5000);
    </script>
</body>
</html>