<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>User Management</title>

    <!-- Custom fonts for this template-->
    <link rel="stylesheet" href="${cp}/assests/vendors/feather/feather.css">
    <link rel="stylesheet" href="${cp}/assests/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="${cp}/assests/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="${cp}/assests/vendors/typicons/typicons.css">
    <link rel="stylesheet" href="${cp}/assests/vendors/simple-line-icons/css/simple-line-icons.css">
    <link rel="stylesheet" href="${cp}/assests/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="${cp}/assests/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="${cp}/assests/js/select.dataTables.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="${cp}/assests/css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="${cp}/assests/images/favicon.png" />
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- side bar  -->
        <%@ include file="../admin/navbar.jsp" %>

        <!-- partial -->
        <div class="container-fluid page-body-wrapper">
            <!-- partial:partials/_settings-panel.html -->
            <%@ include file="../admin/sidebar.jsp" %>
            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <!-- top bar end -->

                    <div class="container-fluid">
                        <div></div>

                        <div class="row">

                            <div class="row" id="category_data">
                                <div class="col">
                                    <div class="card">
                                        <div class="card-heading">
                                            User Lists
                                            <div class="card-body">
                                                <table class="table table-responsive table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>User Id</th>
                                                            <th>Name</th>
                                                            <th>Address</th>
                                                            <th>Phone</th>
                                                            <th>Email</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:choose>
                                                            <c:when test="${empty user_list}">
                                                                <tr>
                                                                    <td colspan="6">No user found</td>
                                                                </tr>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach items="${user_list}" var="user">
                                                                    <tr>
                                                                        <td>${user.id}</td>
                                                                        <td>${user.name}</td>
                                                                        <td>${user.address}</td>
                                                                        <td>${user.phone}</td>
                                                                        <td>${user.email}</td>
                                                                        <td>
                                                                            
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Footer -->

                </div>
                <!-- End of Content Wrapper -->

            </div>
            <!-- End of Page Wrapper -->

            <!-- Scroll to Top Button-->
            <a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i></a>

            <!-- Logout Modal-->
            <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Confirm Delete Category</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <label for="recipient-name" class="col-form-label">Are you sure to delete this category?</label>
                                <div class="form-group">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-danger">Confirm delete</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Bootstrap core JavaScript-->
            <script src="${cp}/assests/vendor/jquery/jquery.min.js"></script>
            <script src="${cp}/assests/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

            <!-- Core plugins JavaScript-->
            <script src="${cp}/assests/vendor/jquery-easing/jquery.easing.min.js"></script>

            <!-- Custom scripts for all pages-->
            <script src="${cp}/assests/vendors/js/vendor.bundle.base.js"></script>
            <!-- endinject -->
            <!-- Plugin js for this page -->
            <script src="${cp}/assests/vendors/chart.js/Chart.min.js"></script>
            <script src="${cp}/assests/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
            <script src="${cp}/assests/vendors/progressbar.js/progressbar.min.js"></script>

            <!-- End plugin js for this page -->
            <!-- inject:js -->
            <script src="${cp}/assests/js/off-canvas.js"></script>
            <script src="${cp}/assests/js/hoverable-collapse.js"></script>
            <script src="${cp}/assests/js/template.js"></script>
            <script src="${cp}/assests/js/settings.js"></script>
            <script src="${cp}/assests/js/todolist.js"></script>
            <!-- endinject -->
            <!-- Custom js for this page-->
            <script src="${cp}/assests/js/dashboard.js"></script>
            <script src="${cp}/assests/js/Chart.roundedBarCharts.js"></script>

            <script type="text/javascript">
                $('#deleteModal').on('show.bs.modal', function(event) {
                    var button = $(event.relatedTarget);
                    var id = button.data('whatever');

                    var modal = $(this);
                    modal.find('.modal-title').text('Delete category with id ' + id);
                    modal.find('form').attr('action', `${cp}/admin/category/delete/` + id);
                });
            </script>
</body>

</html>
