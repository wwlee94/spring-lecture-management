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

    <title>학기 시간표</title>

    <!-- Custom fonts for this template-->
    <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin.css" rel="stylesheet">

    <!-- dhtmlxscheduler css -->
    <link rel="stylesheet" href="/css/dhtmlxscheduler_material.css" type="text/css" charset="utf-8">

    <style>

        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
        }

        .dhx_cal_event div.dhx_footer,
        .dhx_cal_event.past_event div.dhx_footer,
        .dhx_cal_event.event_english div.dhx_footer,
        .dhx_cal_event.event_math div.dhx_footer,
        .dhx_cal_event.event_science div.dhx_footer {
            background-color: transparent !important;
        }

        .dhx_cal_event .dhx_body {
            -webkit-transition: opacity 0.1s;
            transition: opacity 0.1s;
            opacity: 0.7;
        }

        .dhx_cal_event .dhx_title {
            line-height: 12px;
        }

        .dhx_cal_event_line:hover,
        .dhx_cal_event:hover .dhx_body,
        .dhx_cal_event.selected .dhx_body,
        .dhx_cal_event.dhx_cal_select_menu .dhx_body {
            opacity: 1;
        }

        .dhx_cal_event.event_math div,
        .dhx_cal_event_line.event_math {
            background-color: #FF5722 !important;
            border-color: #732d16 !important;
        }

        .dhx_cal_event.dhx_cal_editor.event_math {
            background-color: #FF5722 !important;
        }

        .dhx_cal_event_clear.event_math {
            color: #FF5722 !important;
        }

        .dhx_cal_event.event_science div,
        .dhx_cal_event_line.event_science {
            background-color: #0FC4A7 !important;
            border-color: #698490 !important;
        }

        .dhx_cal_event.dhx_cal_editor.event_science {
            background-color: #0FC4A7 !important;
        }

        .dhx_cal_event_clear.event_science {
            color: #0FC4A7 !important;
        }

        .dhx_cal_event.event_english div,
        .dhx_cal_event_line.event_english {
            background-color: #684f8c !important;
            border-color: #9575CD !important;
        }

        .dhx_cal_event.dhx_cal_editor.event_english {
            background-color: #684f8c !important;
        }

        .dhx_cal_event_clear.event_english {
            color: #B82594 !important;
        }
    </style>
    <!-- dhtmlxscheduler script -->
    <script type="text/javascript" charset="utf-8">
        function init() {
            scheduler.config.xml_date = "%Y-%m-%d %H:%i";           //json으로 등록할때 xml 형식
            scheduler.config.time_step = 30;                        //30분 단위
            // scheduler.config.multi_day = true;                      //일정 중복으로 등록 가능
            scheduler.locale.labels.section_subject = "Subject";
            scheduler.config.first_hour = 9;                        //타임 테이블 시작 시간
            scheduler.config.last_hour = 19;                        //타임 테이블 마지막 시간
            scheduler.config.limit_time_select = true;
            scheduler.config.details_on_dblclick = true;
            scheduler.config.details_on_create = true;

            scheduler.config.show_loading = true;                   //loading spinner 보여주기

            //클릭 했을 때 이벤트 / 이벤트 -> 일정 추가하는 네모난 박스
            scheduler.templates.event_class = function (start, end, event) {
                var css = "";

                if (event.subject) // if event has subject property then special class should be assigned
                    css += "event_" + event.subject;

                if (event.id == scheduler.getState().select_id) {
                    css += " selected";
                }
                return css; // default return

                /*
                    Note that it is possible to create more complex checks
                    events with the same properties could have different CSS classes depending on the current view:

                    var mode = scheduler.getState().mode;
                    if(mode == "day"){
                        // custom logic here
                    }
                    else {
                        // custom logic here
                    }
                */
            };
            //event_class
            //lightbox에서 선택하려면 이거
            // var subject = [
            //     {key: '', label: 'Appointment'},
            //     {key: 'english', label: 'English'},
            //     {key: 'math', label: 'Math'},
            //     {key: 'science', label: 'Science'}
            // ];

            scheduler.config.lightbox.sections = [
                {name: "subject", height: 43, map_to: "subject", type: "textarea", focus: true},
                {name: "professor", height: 43, map_to: "professor", type: "textarea"},
                {name: "location", height: 43, map_to: "location", type: "textarea"},
                {name: "time", height: 72, type: "time", map_to: "auto"}
            ];

            //locale 설정 -> 직접
            scheduler.locale = {
                date:{
                    month_full:["1월", "2월", "3월", "4월", "5월", "6월",
                        "7월", "8월", "9월", "10월", "11월", "12월"],
                    month_short:["1월", "2월", "3월", "4월", "5월", "6월",
                        "7월", "8월", "9월", "10월", "11월", "12월"],
                    day_full:["일요일", "월요일", "화요일", "수요일", "목요일",
                        "금요일", "토요일"],
                    day_short:["일", "월", "화", "수", "목", "금", "토"]
                },
                labels:{
                    dhx_cal_today_button:"오늘",
                    day_tab:"일",
                    week_tab:"주간 스케줄",
                    month_tab:"달",
                    new_event:"새로운 일정",
                    icon_save:"저장",
                    icon_cancel:"취소",
                    icon_details:"세부사항",
                    icon_edit:"편집",
                    icon_delete:"삭제",
                    confirm_closing:"",// Your changes will be lost, are your sure?
                    confirm_deleting:"수업 정보를 삭제하시겠습니까?",

                    section_subject:"수업 과목",
                    section_professor:"교수 이름",
                    section_location:'수업 장소',
                    section_time:"수업 시간",

                    full_day:"Full day",

                    /* touch tooltip*/
                    drag_to_create:"드래그 해서 만드세요 !",
                    drag_to_move:"드래그 해서 옮기세요 !",

                    /* dhtmlx message default buttons */
                    message_ok:"확인",
                    message_cancel:"취소",

                    /* wai aria labels for non-text controls */
                    next:"다음",
                    prev:"이전",
                    year:"년",
                    month:"월",
                    day:"일",
                    hour:"시간",
                    minute:"분"
                }
            };

            //week header 설정
            scheduler.templates.event_header = function(start,end,ev){
                return scheduler.templates.event_date(start)+" ~ "+
                    scheduler.templates.event_date(end);
            };

            //툴팁 설정
            var format = scheduler.date.date_to_str("%H : %i");
            scheduler.templates.tooltip_text = function(start,end,event) {
                return "<b>과목 : </b>"+event.subject +
                    "<br/><b>교수 : </b>"+event.professor +
                    "<br/><b>장소 : </b>"+event.location +
                    "<br/><b>수업 시간 : </b>"+format(start) + " ~ "+ format(end);
            };

            //event text + location + professor
            scheduler.attachEvent("onTemplatesReady", function(){
                scheduler.templates.event_text=function(start,end,event){
                    return '<b>과목 : </b>' + event.subject +
                           '<br/><b>교수 : </b>' + event.professor+
                           '<br/><b>장소 : </b>' + event.location;
                }
            });


            //토요일 , 일요일 숨기기
            scheduler.ignore_week = function(date){
                if (date.getDay() == 6 || date.getDay() == 0) //토요일 , 일요일 숨김
                    return true;
            };

            //스케쥴 초기화
            scheduler.init('scheduler_here', new Date(), "week");

            <%--var jsonarray = [];--%>
            <%--//db 정보 받아 json형태로 파싱--%>
            <%--<c:forEach var="table" items="${tablelist}">--%>
                <%--var json = {};--%>
                <%--json.subject = ${table.subject};--%>
                <%--json.professor = ${table.professor};--%>
                <%--json.location = ${table.location};--%>
                <%--json.start_date = ${table.start_date};--%>
                <%--json.end_date = ${table.end_date};--%>

                <%--jsonarray.push(json);--%>

                <%--console.log(jsonarray);--%>
            <%--</c:forEach>--%>

            <%--scheduler.parse(jsonarray,"json");--%>

            //json 으로 데이터 넣기
            scheduler.parse([
                {
                    subject: 'english',
                    professor:'신우창',
                    location: '북악관 608호',
                    start_date: "2019-05-29 09:00",
                    end_date: "2019-05-29 12:00"
                },
                {
                    subject: 'math',
                    professor:'신우창',
                    location: '북악관 608호',
                    start_date: "2019-05-28 10:00",
                    end_date: "2019-05-28 16:00"
                },
                {
                    subject: 'science',
                    professor:'신우창',
                    location: '북악관 608호',
                    start_date: "2019-05-27 10:00",
                    end_date: "2019-05-27 14:00"
                },
                {
                    subject: 'english',
                    professor:'신우창',
                    location: '북악관 608호',
                    start_date: "2019-06-010 16:00",
                    end_date: "2019-06-01 17:00"
                }
            ], "json");

        }
    </script>
</head>

<body id="page-top" onload="init();">

<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="/index.jsp">Start Bootstrap</a>

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
        <li class="nav-item active">
            <a class="nav-link" href="/security/login">
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
                <a class="dropdown-item" href="/calendar/timetable">TimeTable</a>
                <a class="dropdown-item" href="/forgot-password.html">Forgot Password</a>
                <div class="dropdown-divider"></div>
                <h6 class="dropdown-header">Other Pages:</h6>
                <a class="dropdown-item" href="/404.html">404 Page</a>
                <a class="dropdown-item" href="/blank.html">Blank Page</a>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/charts.html">
                <i class="fas fa-fw fa-chart-area"></i>
                <span>Charts</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/tables.html">
                <i class="fas fa-fw fa-table"></i>
                <span>Tables</span></a>
        </li>
    </ul>

    <div id="content-wrapper">

            <!-- scheduler -->
            <div id="scheduler_here" class="dhx_cal_container" style='width:100%; height:100%;'>
                <div class="dhx_cal_navline">
                    <!-- 다음주 이전 주 버튼 -->
                    <%--<div class="dhx_cal_prev_button">&nbsp;</div>--%>
                    <%--<div class="dhx_cal_next_button">&nbsp;</div>--%>
                    <div class="dhx_cal_today_button"></div>
                    <div class="dhx_cal_date"></div>
                    <!-- delete day,month-->
                    <%--<div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div>--%>
                    <%--<div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div>--%>

                    <div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div>
                </div>
                <div class="dhx_cal_header">
                </div>
                <div class="dhx_cal_data">
                </div>
            </div>

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
                <a class="btn btn-primary" href="security/login.jsp">Logout</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

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
