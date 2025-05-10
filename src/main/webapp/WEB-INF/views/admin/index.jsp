<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Admin Panel</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="${cp }/assests/vendors/feather/feather.css">
  <link rel="stylesheet" href="${cp }/assests/vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="${cp }/assests/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${cp }/assests/vendors/typicons/typicons.css">
  <link rel="stylesheet" href="${cp }/assests/vendors/simple-line-icons/css/simple-line-icons.css">
  <link rel="stylesheet" href="${cp }/assests/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="${cp }/assests/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="${cp }/assests/js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="${cp }/assests/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="${cp }/assests/images/favicon.png" />
</head>
<body>
  <div class="container-scroller"> 
    <!-- partial:partials/_navbar.html -->
    		<%@ include file="../admin/navbar.jsp"%>
    
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_settings-panel.html -->
         		<%@ include file="../admin/sidebar.jsp"%>
     
    
      <!-- partial -->
      <!-- partial:partials/_sidebar.html -->
      
      <!-- partial -->
      
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- plugins:js -->
  <script src="${cp }/assests/vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="${cp }/assests/vendors/chart.js/Chart.min.js"></script>
  <script src="${cp }/assests/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
  <script src="${cp }/assests/vendors/progressbar.js/progressbar.min.js"></script>

  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="${cp }/assests/js/off-canvas.js"></script>
  <script src="${cp }/assests/js/hoverable-collapse.js"></script>
  <script src="${cp }/assests/js/template.js"></script>
  <script src="${cp }/assests/js/settings.js"></script>
  <script src="${cp }/assests/js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="${cp }/assests/js/dashboard.js"></script>
  <script src="${cp }/assests/js/Chart.roundedBarCharts.js"></script>
  <!-- End custom js for this page-->
</body>

</html>

