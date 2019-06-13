<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>리포트 관리</title>

    <!-- Custom fonts for this template-->
    <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top" onload="init();">

<!-- Navbar jsp  -->
<jsp:include page="../common/navbar.jsp"/>
<jsp:include page="modal.jsp"/>
<div id="wrapper">

    <!-- sidebar jsp -->
    <jsp:include page="../common/sidebar.jsp"/>
    <div id="content-wrapper">

        <div class="container-fluid">
            <!-- Breadcrumbs-->
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="#">Reports</a>
                </li>
                <li class="breadcrumb-item active">My Report List</li>
            </ol>


            <!-- Icon Cards-->
            <div class="row">

                <div class="col-xl-3 col-sm-6 mb-3">
                    <div class="card text-white bg-secondary o-hidden h-100">
                        <div class="card-body">
                            <div class="card-body-icon">
                                <i class="fas fa-fw fa-plus"></i>
                            </div>
                            <div class="mr-5">Create Room !</div>
                        </div>
                        <a class="card-footer text-white clearfix small z-1" data-toggle="modal" href="#addRoom">
                            <span class="float-left">Add new room</span>
                            <span class="float-right">
                                <i class="fas fa-plus"></i>
                            </span>
                        </a>
                    </div>
                </div>

                <c:forEach var="report" items="${myReportList}">
                    <div class="col-xl-3 col-sm-6 mb-3">
                        <div class="card text-white bg-primary o-hidden h-100">
                            <div class="card-body">
                                <div class="card-body-icon">
                                    <i class="fas fa-fw fa-comments"></i>
                                </div>
                                <div class="mr-5">제목 : ${report.name}</div>
                                <div class="mr-5">방장 : ${report.manager}</div>
                            </div>
                            <a class="card-footer text-white clearfix small z-1" href="/report/room/${report.id}">
                                <span class="float-left">View Details</span>
                                <span class="float-right">
                                <i class="fas fa-angle-right"></i>
                            </span>
                            </a>
                        </div>
                    </div>
                </c:forEach>


            </div>

        </div>

        <div class="container-fluid">
            <!-- Breadcrumbs-->
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="#">Reports</a>
                </li>
                <li class="breadcrumb-item active">Other Report List</li>
            </ol>

            <!-- Icon Cards-->
            <div class="row">

                <c:forEach var="report" items="${otherReportList}">
                    <c:if test="${report.password eq ''}">
                        <div class="col-xl-3 col-sm-6 mb-3">
                            <div class="card text-white bg-success o-hidden h-100">
                                <div class="card-body">
                                    <div class="card-body-icon">
                                        <i class="fas fa-fw fa-lock-open"></i>
                                    </div>
                                    <div class="mr-5">제목 : ${report.name}</div>
                                    <div class="mr-5">방장 : ${report.manager}</div>
                                </div>
                                <a class="card-footer text-white clearfix small z-1" href="#">
                                    <span class="float-left">Attend this Room</span>
                                    <span class="float-right">
                                <i class="fas fa-lock-open"></i>
                            </span>
                                </a>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${report.password ne ''}">
                        <div class="col-xl-3 col-sm-6 mb-3">
                            <div class="card text-white bg-danger o-hidden h-100">
                                <div class="card-body">
                                    <div class="card-body-icon">
                                        <i class="fas fa-fw fa-lock"></i>
                                    </div>
                                    <div class="mr-5">제목 : ${report.name}</div>
                                    <div class="mr-5">방장 : ${report.manager}</div>
                                </div>
                                <a onclick="passwordModal('${report.name}','${report.id}')" class="card-footer text-white clearfix small z-1" data-toggle="modal">
                                    <span class="float-left">Attend this Room</span>
                                    <span class="float-right">
                                <i class="fas fa-lock"></i>
                            </span>
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>


            </div>

        </div>

        <%--footer jsp--%>
        <jsp:include page="../common/footer.jsp"/>

    </div>
    <!-- /.content-wrapper -->

</div>
<!-- /#wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<script type="text/javascript">
    function passwordModal(title,roomId){
        //show 호출시 넘겨준 값을 이용하여 ajax 등을 통해 modal 을 띄울때 동적으로 바뀌어야 하는 값을 얻어온다.

        //얻어온 값을 이용하여, modal 에서 동적으로 바뀌어야 하는 값을 바꾸어 준다..
        $("#title").html(title);
        $("#roomId").val(roomId);

        //modal을 띄워준다.
        $("#inRoom").modal('show');
    }
</script>

<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<%--modal--%>
<script src="/js/modal.js" type="text/javascript" charset="utf-8"></script>

<!-- Core plugin JavaScript-->
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Page level plugin JavaScript-->
<script src="/vendor/chart.js/Chart.min.js"></script>
<script src="/vendor/datatables/jquery.dataTables.js"></script>
<script src="/vendor/datatables/dataTables.bootstrap4.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin.min.js"></script>

<!-- dhtmlxscheduler js -->
<script src="/js/dhtmlxscheduler.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/dhtmlxscheduler_tooltip.js" type="text/javascript" charset="utf-8"></script>
</body>

</html>
