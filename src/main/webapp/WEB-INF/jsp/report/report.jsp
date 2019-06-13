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

            <%--상단 탭 --%>
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link" href="/report/room/${roomNo}">방 소개</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/report/report/${roomNo}">과제</a>
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
                    <h2>과제 게시판</h2>
                    <div class="table-responsive table-striped">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th style="width: 50%">제목</th>
                                <th>작성자</th>
                                <th>작성 일</th>
                                <th>조회 수</th>
                                <th>댓글 수</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="board" items="${boards}">
                            <tr>
                                <td>${board.bno}</td>
                                <td><a href="/report/report/${roomNo}/${board.bno}">${board.title}</a></td>
                                <td>${board.userName}</td>
                                <td>${board.date}</td>
                                <td>${board.viesNum}</td>
                                <td>#</td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <button onclick="addBoardFromRoom('${roomNo}')" id="addBoard" type="button" class="btn btn-info" data-toggle="modal">새 글 쓰기</button>
                    </div>
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
    function addBoardFromRoom(roomNo){
        //show 호출시 넘겨준 값을 이용하여 ajax 등을 통해 modal 을 띄울때 동적으로 바뀌어야 하는 값을 얻어온다.

        //얻어온 값을 이용하여, modal 에서 동적으로 바뀌어야 하는 값을 바꾸어 준다..
        // $("#title").html(title);
        $("#roomNoFromReport").val(roomNo);

        //modal을 띄워준다.
        $("#addBoardModal").modal('show');
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

</body>

</html>
