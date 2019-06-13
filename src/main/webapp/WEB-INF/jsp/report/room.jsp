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

<body id="page-top">

<!-- Navbar jsp  -->
<jsp:include page="../common/navbar.jsp"/>
<jsp:include page="modal.jsp"/>

<div id="wrapper">

    <!-- sidebar jsp -->
    <jsp:include page="../common/sidebar.jsp"/>

    <div id="content-wrapper">

        <div class="container-fluid">

            <%--상단 탭 --%>
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link active" href="/report/room/${roomNo}">방 소개</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/report/report/${roomNo}">과제</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/report/trello/${roomNo}">업무 배분</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/report/chat/${roomNo}">채팅</a>
                </li>
            </ul>

            <br>
            <div class="container">
                <h2>방 소개</h2>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">방 제목</h3>
                    </div>
                    <div class="panel-body">
                        ${report.name}
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">방 설명</h3>
                    </div>
                    <div class="panel-body">
                        ${report.info}
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">방장</h3>
                    </div>
                    <div class="panel-body">
                        ${report.manager}
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">팀원</h3>
                    </div>
                    <c:forEach var="member" items="${members}">
                        <div class="panel-body">
                                ${member.uemail} ${member.uid}
                        </div>
                    </c:forEach>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">추가할 팀원</h3>
                    </div>
                    <div class="panel-body">
                        Panel content
                    </div>
                </div>

                <a class="btn btn-danger" data-toggle="modal" href="#outRoom">방 나가기</a>

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

<script>
    $('#sidebar-5').addClass("active");
</script>
</body>

</html>
