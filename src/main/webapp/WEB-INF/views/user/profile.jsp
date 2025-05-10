<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Account Management</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(to right, #4facfe, #00f2fe);
        }

        .container {
            max-width: 1100px;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        h1 {
            font-size: 1.8rem;
            font-weight: 600;
            color: #333;
        }

        .form-control-user {
            width: 200px;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 1rem;
            margin-bottom: 15px;
            transition: 0.3s;
        }

        .form-control-user:focus {
            border-color: #4facfe;
            box-shadow: 0 0 8px rgba(79, 172, 254, 0.5);
        }

        .btn-user {
            width: 48%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-primary {
            background-color: #4facfe;
            color: white;
        }

        .btn-primary:hover {
            background-color: #3a8fd8;
        }

        .btn-danger {
            background-color: #ff4d4d;
            color: white;
        }

        .btn-danger:hover {
            background-color: #e63c3c;
        }

        .row {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .column {
            flex: 1;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
        }

        @media (max-width: 768px) {
            .row {
                flex-direction: column;
            }
            .btn-user {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="column">
                <h1>Update Account</h1>
                <form action="${cp}/user/edit" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="text" class="form-control-user" value="${user.id}" name="id" readonly>
                    <input type="text" class="form-control-user" value="${user.name}" name="name">
                    <input type="text" class="form-control-user" value="${user.phone}" name="phone">
                    <input type="text" class="form-control-user" value="${user.address}" name="address">
                    <input type="text" class="form-control-user" value="${user.username}" name="username">
                    <input type="date" class="form-control-user" name="dob" value="${user.dob}">
                    <input type="email" class="form-control-user" value="${user.email}" name="email">
                    <div style="display: flex; justify-content: space-between;">
                        <input type="submit" class="btn-user btn-primary" value="Update">
                        <form action="${cp}/user/delete/${user.id}" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="submit" class="btn-user btn-danger" value="Delete">
                        </form>
                    </div>
                </form>
            </div>

            <div class="column">
                <h1>Update Password</h1>
                <form action="${cp}/updatePassword/${user.id}" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="password" class="form-control-user" value="${user.password}" name="password">
                    <input type="password" class="form-control-user" name="NewPassword" placeholder="Enter new Password">
                    <input type="password" name="ConfirmPassword" class="form-control-user" placeholder="Confirm New Password">
                    <input type="submit" class="btn-user btn-primary" value="Update">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
