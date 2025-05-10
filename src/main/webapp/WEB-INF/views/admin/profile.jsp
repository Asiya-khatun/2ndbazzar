<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<title> Admin Profile</title>
<style>
/* Container Styling */
.container {
    max-width: 350px;
    margin: 50px auto;
    padding: 10px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Card Styling */
.card {
    border: none;
}

/* Card Body Styling */
.card-body {
    padding: 20px;
}

/* Header Styling */
.text-center h1 {
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

/* Input Styling */
.form-control-user {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 15px;
}

/* Button Styling */
.btn-user {
    width: 50%;
    padding: 10px;
    background-color:green;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

/* Alert Styling */
.alert {
    padding: 10px;
    background-color: blue;
    border: 1px solid #c3e6cb;
    border-radius: 5px;
    color: #155724;
    margin-bottom: 20px;
}

</style>
<body>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    
    <div class="container">
        <div class="card">
            <div class="card-body">
                <div class="text-center">
                   <b> <h1 class="h4 text-gray-900 mb-4" align="center">Update Account </b></h1>
                </div>
                <form class="user" action="${cp}/admin/profile" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    
                    <div class="form-group">
                        <input type="text" class="form-control form-control-user" value="${user.name }" name="name">
                    </div>
                   
                    <div class="form-group">
                        <input type="text" class="form-control form-control-user" value="${user.phone }" name="phone">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control form-control-user" value="${user.address }" name="address">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control form-control-user" value="${user.username }" name="username">
                    </div>
                    <div class="form-group">
                        <input type="date" class="form-control form-control-user" name="dob" value="${user.dob }">
                    </div>
                    <div class="form-group">
                        <input type="email" class="form-control form-control-user" value="${user.email }" name="email">
                    </div>
                    
                    <div class="form-group">
                        <input type="password" class="form-control form-control-user" value="${user.password }" name="password">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control form-control-user" value="${user.password }">
                    </div>
                    
                    <div class="form-group">
                        <input type="submit" name="submit" class="btn btn-primary btn-user btn-block" value="Update">
                       
                    
                    </div>
                </form>
                <br>
                <div class="form-group">
                </div><br>

           
            </div>
        </div>
    </div>

</body>
