<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>User Account Management</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${cp}/asset/css/Profile.css">


</head>
<body>
  <%@ include file="navbar.jsp" %>

  <div class="container">
<h1><i class="fas fa-user-cog"></i> User Account Management</h1>

    <div class="tabs">
      <div class="tab active" data-target="account">
        <i class="fas fa-user-edit tab-icon"></i>
        <span>Update Account</span>
      </div>
      <div class="tab" data-target="password">
        <i class="fas fa-key tab-icon"></i>
        <span>Update Password</span>
      </div>
    </div>

    <form id="account" class="active" action="${cp}/user/edit" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <div class="form-grid">
        <input type="text" name="id" value="${user.id}" readonly class="full-width" />
        <input type="text" name="name" value="${user.name}" placeholder="Full Name" />
        <input type="text" name="phone" value="${user.phone}" placeholder="Phone Number" />
        <input type="text" name="address" value="${user.address}" placeholder="Address" />
        <input type="text" name="username" value="${user.username}" placeholder="Username" />
        <input type="date" name="dob" value="${user.dob}" />
        <input type="email" name="email" value="${user.email}" placeholder="Email" />

        
      </div>
      <button type="submit">Update Account</button>
    </form>

    <form id="password" action="${cp}/updatePassword/${user.id}" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <div class="form-grid">
        <input type="password" name="password" placeholder="Current Password" />
        <input type="password" name="NewPassword" placeholder="Enter New Password" />
        <input type="password" name="ConfirmPassword" placeholder="Confirm New Password" />
      </div>
      <button type="submit">Update Password</button>
    </form>
  </div>

  <script>
    const tabs = document.querySelectorAll('.tab');
    const forms = document.querySelectorAll('form');

    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        tabs.forEach(t => t.classList.remove('active'));
        forms.forEach(f => f.classList.remove('active'));
        tab.classList.add('active');
        document.getElementById(tab.dataset.target).classList.add('active');
      });
    });
  </script>
  
</body>
</html>