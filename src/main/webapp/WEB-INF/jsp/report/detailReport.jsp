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
4
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
                <h2>글 상세 보기</h2>
                <div class="table table-responsive">
                    <table class="table">
                        <tr>
                            <th class="success">작성자</th>
                            <td>${board.userName}</td>
                            <th class="success">작성일</th>
                            <td>${board.createdDate}</td>
                        </tr>
                        <tr>
                            <th class="success">조회수</th>
                            <td>${board.viesNum}</td>
                            <th class="success">수정일</th>
                            <td>${board.modifiedDate}</td>
                        </tr>
                        <tr>
                            <th class="success">제목</th>
                            <td colspan="3">${board.title}</td>
                        </tr>

                        <tr>
                            <th class="success">글 내용</th>
                            <td colspan="3">${board.contents}</td>
                        </tr>
                    </table>
                    <button type="button" class="btn btn-info" onclick="location.href='/report/report/${roomNo}'">목록으로
                    </button>
                    <c:if test="${isMyBoard eq true}">
                        <input type="hidden" id="roomNoFromDetailReport" value="${roomNo}"/>
                        <button type="button" class="btn btn-success"
                                onclick="modifiedBoard('${board.bno}','${board.title}','${board.contents}')">수정하기
                        </button>
                        <button type="button" class="btn btn-danger" onclick="deleteBoard('${board.bno}')">삭제하기</button>
                    </c:if>

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
        function deleteBoard(bno) {

            $("#deleteBno").val(bno);

            //modal을 띄워준다.
            $("#deleteBoardModal").modal('show');
        }

        function modifiedBoard(bno, title, contents) {
            $("#modifiedBno").val(bno);
            $("#modifiedBoardTitle").val(title);
            $("#modifedBoardContents").val(contents);

            //modal을 띄워준다.
            $("#modifiedBoardModal").modal('show');
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
