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

    <title>강의목록</title>

    <!-- Custom fonts for this template-->
    <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin.css" rel="stylesheet">

    <!-- Material Design Bootstrap -->
    <%--<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.8.2/css/mdb.min.css" rel="stylesheet">--%>

    <!-- Loader -->
    <link href="/css/loader.css" rel="stylesheet">
    <!-- animate -->
    <link href="/css/animate.css" rel="stylesheet">

    <!-- clockpicker -->
    <link href="/css/datepicker/bootstrap-clockpicker.min.css" rel="stylesheet">
    <!-- datepicker -->
    <link href="/css/datepicker/datepicker.min.css" rel="stylesheet">

</head>

<body id="page-top">

<!-- 강의 추가 Modal -->
<jsp:include page="../modal/lecturemodal.jsp"/>

<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="/">Start Bootstrap</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Search for..." aria-label="Search"
                   aria-describedby="basic-addon2">
            <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>

    <!-- Navbar -->
    <ul class="navbar-nav ml-auto ml-md-0">
        <li class="nav-item dropdown no-arrow mx-1">
            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <span class="badge badge-danger">9+</span>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="alertsDropdown">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Something else here</a>
            </div>
        </li>
        <li class="nav-item dropdown no-arrow mx-1">
            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <span class="badge badge-danger">7</span>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="messagesDropdown">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Something else here</a>
            </div>
        </li>
        <li class="nav-item dropdown no-arrow">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-user-circle fa-fw"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#">Settings</a>
                <a class="dropdown-item" href="#">Activity Log</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
            </div>
        </li>
    </ul>

</nav>

<div id="wrapper">

    <!-- Sidebar -->
    <ul class="sidebar navbar-nav">
        <li class="nav-item">
            <a class="nav-link" href="/">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-fw fa-folder"></i>
                <span>Pages</span>
            </a>
            <div class="dropdown-menu" aria-labelledby="pagesDropdown">
                <h6 class="dropdown-header">Login Screens:</h6>
                <a class="dropdown-item" href="/security/login">Login</a>
                <a class="dropdown-item" href="/security/signUp">Register</a>
                <a class="dropdown-item" href="/forgot-password.html">Forgot Password</a>
                <div class="dropdown-divider"></div>
                <h6 class="dropdown-header">Other Pages:</h6>
                <a class="dropdown-item" href="/404.html">404 Page</a>
                <a class="dropdown-item" href="/blank.html">Blank Page</a>
            </div>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="/lecture">
                <i class="fas fa-fw fa-table"></i>
                <span>Lectures</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/calendar/timetable">
                <i class="fas fa-fw fa-clock"></i>
                <span>TimeTable</span></a>
        </li>
    </ul>

    <div id="content-wrapper">

        <!-- loader -->
        <div class="container-fluid">
            <div class="loader"></div>
        </div>

        <!-- Search lecture -->
        <div class="container-fluid search" style="display: none;">

            <!-- Breadcrumbs-->
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="/">Dashboard</a>
                </li>
                <li class="breadcrumb-item active">강의 검색</li>
            </ol>

            <!-- DataTables Example -->
            <div class="card mb-3">
                <div class="card-header">
                    <i class="fas fa-table"></i>
                    &nbsp; 강의 테이블 &nbsp;&nbsp; * 각 항목을 클릭하면 시간표에 추가 할 수 있습니다 :)
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover" id="dataTable" width="100%" cellspacing="0">
                            <thead class="thead-dark">
                            <tr>
                                <th>과목코드</th>
                                <th>과목명</th>
                                <th>교수</th>
                                <th>강의시간</th>
                                <th>강의실</th>
                                <th>구분</th>
                                <th>학점</th>
                            </tr>
                            </thead>
                            <%--<tfoot>--%>
                            <%--<tr>--%>
                            <%--<th>교과목명</th>--%>
                            <%--<th>학수번호</th>--%>
                            <%--<th>학과 / 부</th>--%>
                            <%--<th>교수</th>--%>
                            <%--<th>수업시간</th>--%>
                            <%--</tr>--%>
                            <%--</tfoot>--%>
                            <tbody>
                            <c:forEach var="list" items="${lectureList}">
                                <tr>
                                    <td>${list.lecture_code}</td>
                                    <td>${list.lecture}</td>
                                    <td>${list.professor}</td>
                                    <td>${list.lecture_time}</td>
                                    <td>${list.location}</td>
                                    <td>${list.division}</td>
                                    <td>${list.grade}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer small text-muted">&nbsp; 전공 검색은 학과코드로 검색 ! &nbsp; ex) CS - 컴퓨터과학과 / MT - 뮤지컬학과
                </div>
            </div>

            <p class="small text-center text-muted my-5">
                <em>찾고 싶은 과목을 검색하세요 :)</em>
            </p>

        </div>
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <footer class="sticky-footer">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>Copyright © Your Website 2019</span>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.content-wrapper -->

</div>
<!-- /#wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary" href="/">Logout</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap-notify.js"></script>

<!-- Core plugin JavaScript-->
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Page level plugin JavaScript-->
<script src="/vendor/chart.js/Chart.min.js"></script>
<script src="/vendor/datatables/jquery.dataTables.js"></script>
<script src="/vendor/datatables/dataTables.bootstrap4.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin.min.js"></script>

<!-- Demo scripts for this page-->
<script src="/js/demo/datatables-demo.js"></script>

<!-- moment.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment.min.js"></script>

<!-- timepicker -->
<script src="/js/datepicker/bootstrap-clockpicker.min.js"></script>
<!-- datepicker -->
<script src="/js/datepicker/datepicker.min.js"></script>


<!-- 강좌 테이블 관련 script -->
<script type="text/javascript" charset="utf-8">

    //로딩 완료 시
    $(document).ready(function () {
        setTimeout(function () {
            // 1초 후 작동
            $('.loader').hide('fast');
            $('.search').fadeIn('fast');
        }, 1500);
    });

    //timetableModal의 타임 피커
    $('.clockpicker').clockpicker({
        placement: 'top',
        align: 'left',
        autoclose: true,
        'default': '12:00',
    });

    //datepicker 한글 설정
    $.fn.datepicker.language['ko'] = {
        days: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
        daysShort: ['일', '월', '화', '수', '목', '금', '토'],
        daysMin: ['일', '월', '화', '수', '목', '금', '토'],
        months: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
        monthsShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        today: 'Today', // Today -> 오늘
        clear: 'Clear', // Clear -> 지우기
        dateFormat: 'yyyy-mm-dd',
        timeFormat: 'hh:ii aa',
        firstDay: 0
    };

    var disabledDays = [0, 6];

    $('.datepicker-here').datepicker({
        language: 'ko',
        minDate: new Date(), // Now can select only dates, which goes after today
        position : 'top right',
        autoClose : true,
        navTitles : {
            days: '<b>yyyy 년, MM</b>'
        },

        onRenderCell: function (date, cellType) {
            if (cellType == 'day') {
                var day = date.getDay(),
                    isDisabled = disabledDays.indexOf(day) != -1;

                return {
                    disabled: isDisabled
                }
            }
        }
    });
    $('.datepicker-here').data('datepicker');

    // 테이블의 tbody 아래의 tr 클릭시 -> Row 값 가져오기
    $('#dataTable tbody > tr').click(function () {

        // 현재 클릭된 Row(<tr>)
        var tr = $(this);
        var td = tr.children();

        // td.eq(index)를 통해 값을 가져올 수도 있다.
        var lecture_code = td.eq(0).text();
        var lecture = td.eq(1).text();
        var professor = td.eq(2).text();
        var lecture_time = td.eq(3).text();
        var location = td.eq(4).text();
        var division = td.eq(5).text();
        var grade = td.eq(6).text();

        //값 비워주기 - 강의시간 있던 tr눌렀다가 없는 tr눌러서 제출누르면 값 같이 전송됨
        $('#modal_lecture_time').val("");

        //비어있으면 lectureModal로 시간 설정 내가 직접
        if(lecture_time===""){

            //view 설정
            $('#show_lecture_time').hide();
            $('#show_clockpicker').show();
        }
        //값이 있으면 lecture_time 값대로 설정
        else{
            //값 설정
            $('#modal_lecture_time').val(lecture_time);

            //view 설정
            $('#show_clockpicker').hide();
            $('#show_lecture_time').show();
        }

        $('#lectureModal').modal();
        //Modal input 설정!
        $('#modal_lecture').val(lecture);
        $('#modal_professor').val(professor);
        $('#modal_location').val(location);

        //hidden input 설정
        $('#modal_lecture_code').val(lecture_code);
        $('#modal_division').val(division);
        $('#modal_grade').val(grade);

    }); //DataTable

    function setLectureTime(){


    }
</script>

</body>

</html>