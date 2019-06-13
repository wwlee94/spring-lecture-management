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

    <title>수업 일정</title>

    <!-- Custom fonts for this template-->
    <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin.css" rel="stylesheet">

    <!-- dhtmlxscheduler css -->
    <link rel="stylesheet" href="/css/dhtmlxscheduler_material.css" type="text/css" charset="utf-8">

    <!--loader -->
    <link href="/css/loader.css" rel="stylesheet">
    <!-- animate -->
    <link href="/css/animate.css" rel="stylesheet">

    <style>

        .dhx_cal_event div {
            background-color: #5780ab !important;
        }

        .dhx_cal_event div.dhx_footer,
        .dhx_cal_event.past_event div.dhx_footer {
            background-color: transparent !important;
        }

        /*.dhx_cal_event .dhx_body {*/
        /*-webkit-transition: opacity 0.1s;*/
        /*transition: opacity 0.1s;*/
        /*opacity: 0.9;*/
        /*}*/

        .dhx_cal_event .dhx_title {
            line-height: 12px;
        }

        .dhx_cal_event_line:hover,
        .dhx_cal_event:hover .dhx_body,
        .dhx_cal_event.selected .dhx_body,
        .dhx_cal_event.dhx_cal_select_menu .dhx_body {
            opacity: 1;
        }

        .dhx_cal_event.event_1 div,
        .dhx_cal_event_line.event_1{
            background-color: #ff7473 !important;
            border-color: White !important;
        }

        .dhx_cal_event.event_2 div,
        .dhx_cal_event_line.event_2{
            background-color: #A593E0 !important;
            border-color: White !important;
        }

        .dhx_cal_event.event_3 div,
        .dhx_cal_event_line.event_3{
            background-color: #ffc952 !important;
            border-color: White !important;
        }

        .dhx_cal_event.event_4 div,
        .dhx_cal_event_line.event_4{
            background-color: #8CD790 !important;
            border-color: White !important;
        }

        /*.dhx_cal_event.event_5 div {*/
        /*background-color: #47b8e0 !important;*/
        /*border-color: White !important;*/
        /*}*/

        .dhx_cal_event.event_5 div,
        .dhx_cal_event_line.event_5{
            background-color: #5780ab !important;
            border-color: White !important;
        }

        .dhx_cal_event.event_6 div,
        .dhx_cal_event_line.event_6{
            background-color: #58C9B9 !important;
            border-color: White !important;
        }

        .dhx_cal_event.event_7 div,
        .dhx_cal_event_line.event_7{
            background-color: #F17F42 !important;
            border-color: White !important;
        }

        /* month text color 설정 */
        .dhx_cal_event_clear{
            color: #5780ab;
            background-color: White;
        }

        /*.dhx_cal_event_clear.event_1{*/
            /*color: #ff7473;*/
        /*}*/
        /*.dhx_cal_event_clear.event_2{*/
            /*color: #A593E0;*/
        /*}*/
        /*.dhx_cal_event_clear.event_3{*/
            /*color: #ffc952;*/
        /*}*/
        /*.dhx_cal_event_clear.event_4{*/
            /*color: #8CD790;*/
        /*}*/
        /*.dhx_cal_event_clear.event_5{*/
            /*color: #5780ab;*/
        /*}*/
        /*.dhx_cal_event_clear.event_6{*/
            /*color: #58C9B9;*/
        /*}*/
        /*.dhx_cal_event_clear.event_7{*/
            /*color: #F17F42;*/
        /*}*/

        /* lightbox 버튼 디자인 설정 */
        .dhx_cal_ltitle{
            background-color : #5780ab;
            border-bottom: #5780ab;
            height : 45px;
            padding-top: 5px;
        }
        .dhx_save_btn_set{
            background-color: #5780ab;
            border-color: #5780ab;
        }
        .dhx_save_btn_set:hover {
            border-color: #466287;
            transition: all .1s ease-in-out
        }
        .dhx_save_btn_set:hover div {
            background-color: #466287;
            border-color: #466287;
            transition: all .1s ease-in-out
        }

        .dhx_cancel_btn_set{
            color: #5780ab;
        }

    </style>

    <!-- dhtmlxscheduler script -->
    <script type="text/javascript" charset="utf-8">

        function init() {

            scheduler.config.xml_date = "%Y-%m-%d %H:%i";           //json으로 등록할때 xml 형식
            scheduler.config.time_step = 30;                        //lightbox 띄울때 30분 차이로
            scheduler.config.limit_time_select = true;              //set in the lightbox -> 'last_hour' and 'first_hour' options limit
            scheduler.config.mark_now = true;                       //현재시각 빨간색 라인으로 표시
            scheduler.config.multi_day = true;                      //서브헤더랑 content 사이에 뜨는 하루짜리 이벤트
            scheduler.config.full_day = true;                       //클릭하면 4일 00:00 ~ 5일 00:00 으로 바로 설정
            //?
            scheduler.config.details_on_dblclick = true;
            scheduler.config.details_on_create = true;

            // //month config ?? 되는거?
            scheduler.config.max_month_events = 3;                  //월별 이벤트 3개로 제한 이상되면 view more 보여줌

            // // recurring config
            // scheduler.config.repeat_date = "%m/%d/%Y";
            // scheduler.config.include_end_by = true;
            // scheduler.config.repeat_precise = true;


            //event coloring
            scheduler.templates.event_class = function (start, end, event) {

                var css = "";

                if (event.title) // if event has subject property then special class should be assigned
                    css += "event_" + event.color;

                if (event.id == scheduler.getState().select_id) {
                    css += " selected";
                }
                return css; // default return
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
                {name: "title", height: 43, map_to: "title", type: "textarea", focus: true},
                {name: "explanation", height: 43, map_to: "explanation", type: "textarea"},
                {name: "location", height: 43, map_to: "location", type: "textarea"},
                {name: "time", height: 72, type: "time", map_to: "auto", time_format: ["%H:%i" , "%Y", "%m", "%d"]}
            ];

            //locale 설정 -> 직접 #한글화#
            scheduler.locale = {
                date: {
                    month_full:["January", "February", "March", "April", "May", "June",
                        "July", "August", "September", "October", "November", "December"],
                    month_short: ["1월", "2월", "3월", "4월", "5월", "6월",
                        "7월", "8월", "9월", "10월", "11월", "12월"],
                    day_full: ["일요일", "월요일", "화요일", "수요일", "목요일",
                        "금요일", "토요일"],
                    day_short: ["일", "월", "화", "수", "목", "금", "토"]
                },
                labels: {
                    dhx_cal_today_button: "오늘",
                    day_tab: "일간",
                    week_tab: "주간",
                    month_tab: "월간",
                    new_event: "새로운 일정",
                    icon_save: "저장",
                    icon_cancel: "취소",
                    icon_details: "세부사항",
                    icon_edit: "편집",
                    icon_delete: "삭제",
                    confirm_closing: "",// Your changes will be lost, are your sure?
                    confirm_deleting: "일정을 삭제하시겠습니까?",

                    section_title: "제목",
                    section_explanation: "설명",
                    section_location: '장소',
                    section_time: "시간",

                    full_day: "종일",

                    /* touch tooltip*/
                    drag_to_create: "드래그 해서 만드세요 !",
                    drag_to_move: "드래그 해서 옮기세요 !",

                    /* dhtmlx message default buttons */
                    message_ok: "확인",
                    message_cancel: "취소",

                    /* wai aria labels for non-text controls */
                    next: "다음",
                    prev: "이전",
                    year: "년",
                    month: "월",
                    day: "일",
                    hour: "시간",
                    minute: "분"
                }
            };

            //navline day 제목 header 설정
            scheduler.templates.day_date = function(date){
                var day_string = date.getFullYear()+"년 "+(date.getMonth()+1)+"월 "+date.getDate()+"일";
                return day_string;
            };

            //navline day 부제목 설정
            scheduler.templates.day_scale_date = function(date){
                var day_substring = date.getFullYear()+"년 "+(date.getMonth()+1)+"월 "+date.getDate()+"일";
                return day_substring;
            };

            //navline week 제목 header 설정
            scheduler.templates.week_date = function(start, end){

                start_format = start.getFullYear()+"년 "+(start.getMonth()+1)+"월 "+start.getDate()+"일";

                var new_end = scheduler.date.add(end,-1,"day");
                end_format = new_end.getFullYear()+"년 "+(new_end.getMonth()+1)+"월 "+(new_end.getDate())+"일";

                return start_format+" &ndash; "+end_format;
            };

            var week = ['일', '월', '화', '수', '목', '금', '토'];
            //navline week 부제목  요일,월,일 설정
            scheduler.templates.week_scale_date = function(date){
                return week[date.getDay()]+" , "+(date.getMonth()+1)+" / "+date.getDate();
            };

            //event week header 설정
            scheduler.templates.event_header = function (start, end, ev) {
                return scheduler.templates.event_date(start) + " ~ " +
                    scheduler.templates.event_date(end);
            };

            //navline month 제목 header 설정
            scheduler.templates.month_date = function(date){
                var month_string = date.getFullYear()+"년 "+(date.getMonth()+1)+"월 ";
                return month_string;
            };

            //event month text
            scheduler.templates.event_bar_text = function(start,end,event){
                if(event.title==="" || event.title ===null || event.title === "undefined" || event.title === undefined){
                    return "새로운 일정";
                }
                return event.title;
            };

            // // view more locale
            // scheduler.templates.month_events_link = function(date, count){
            //     return "<a>View more("+count+" events)</a>";
            // };

            //event week 내용 설정 text + location + professor
            scheduler.attachEvent("onTemplatesReady", function () {
                scheduler.templates.event_text = function (start, end, event) {
                    var result = "";
                    if (event.title != "") {
                        result = result + "<b>제목 : </b>" + event.title + "<br/>";
                    }
                    if (event.explanation != "") {
                        result = result + "<b>설명 : </b>" + event.explanation + "<br/>";
                    }
                    if (event.location != "") {
                        result = result + "<b>장소 : </b>" + event.location + "<br/>";
                    }

                    return result;
                }
            });

            //이벤트 추가시
            scheduler.attachEvent("onEventAdded", function (id, event) {

                console.log("onEventAdded");
                console.log(id);

                url = '/calendar/calendartable';
                type = "POST";

                start_date = moment(event.start_date).format("YYYY-MM-DD HH:mm:ss"); //"2013-03-10 23:22:00"
                end_date = moment(event.end_date).format("YYYY-MM-DD HH:mm:ss"); //"2013-03-10 23:22:00"

                //비어있으면 0 , 존재하면 가져와서 사용
                if(event.event_pid==="" || event.event_pid===null){
                    pid = parseInt("0");
                }
                else{
                    pid = parseInt(event.event_pid);
                }

                //비어있으면 0 , 존재하면 가져와서 사용
                if(event.event_length==="" || event.event_length===null){
                    leng = parseInt("0");
                }
                else{
                    // length = parseInt((event.end_date - event.start_date)/1000);
                    leng = parseInt(event.event_length);
                }

                data = {
                    "id": id,
                    "title": event.title,
                    "explanation": event.explanation,
                    "location": event.location,
                    "str_start_date": start_date,
                    "str_end_date": end_date
                };

                $.ajax({
                    url: url,
                    type: type,
                    data: data,
                    //complete 되면 reload
                    complete: function (data) {
                        //console.log(data.toString());
                        //로딩 안해도 되는데 색상때문에?
                        location.reload();
                    }
                });
            });

            //이벤트 수정시
            scheduler.attachEvent("onEventChanged", function (id, event) {
                console.log("onEventChanged");

                console.log(id);

                url = '/calendar/calendartable';
                type = "PUT";

                start_date = moment(event.start_date).format("YYYY-MM-DD HH:mm:ss"); //"2013-03-10 23:22:00"
                end_date = moment(event.end_date).format("YYYY-MM-DD HH:mm:ss"); //"2013-03-10 23:22:00"

                //비어있으면 0 , 존재하면 가져와서 사용
                if(event.event_pid==="" || event.event_pid===null){
                    pid = parseInt("0");
                }
                else{
                    pid = parseInt(event.event_pid);
                }

                //비어있으면 0 , 존재하면 가져와서 사용
                if(event.event_length==="" || event.event_length===null){
                    leng = parseInt("0");
                }
                else{
                    // length = parseInt((event.end_date - event.start_date)/1000);
                    leng = parseInt(event.event_length);
                }

                data = {
                    "id": id,
                    "title": event.title,
                    "explanation": event.explanation,
                    "location": event.location,
                    "str_start_date": start_date,
                    "str_end_date": end_date
                };

                $.ajax({
                    url: url,
                    type: type,
                    data: data,
                    //complete 되면 reload
                    complete: function (data) {
                        //console.log(data.toString());
                        //location.reload();
                    }
                });

            });

            //Delete 버튼 클릭시
            scheduler.attachEvent("onEventDeleted", function (id, event) {
                console.log("onEventDeleted");
                console.log(id);

                //Delete 취소시에도 동작해서
                if (id < 150000000000) {

                    url = '/calendar/calendartable';
                    type = "DELETE";

                    data = {
                        "id": id
                    };

                    $.ajax({
                        url: url,
                        type: type,
                        data: data,
                        //complete 되면 reload
                        complete: function (data) {
                            //js로 event 삭제
                            //scheduler.deleteEvent(id);

                        }
                    });
                }//if
            });

            //충돌 설정
            /*
            scheduler.attachEvent("onEventCollision", function (ev, evs){

                //알림
                $.notify({
                    icon: 'fa fa-paw',
                    title: '<strong> Try Again !</strong><br>',
                    message: "이벤트 충돌이에요 :)"
                },{
                    type: 'warning',
                    offset: 50,
                    animate: {
                        enter: 'animated bounceIn',
                        exit: 'animated bounceOut'
                    },
                    newest_on_top: true
                });

                return true;
            });
            */

            //툴팁 설정
            dhtmlXTooltip.config.timeout_to_display = 0;
            dhtmlXTooltip.config.timeout_to_hide = 0;

            var format = scheduler.date.date_to_str("%H : %i");
            scheduler.templates.tooltip_text = function (start, end, event) {
                var result = "";
                if (event.title != "") {
                    result = result + "<b>제목 : </b>" + event.title + "<br/>";
                }
                if (event.explanation != "") {
                    result = result + "<b>설명 : </b>" + event.explanation + "<br/>";
                }
                if (event.location != "") {
                    result = result + "<b>장소 : </b>" + event.location + "<br/>";
                }

                if(format(start)==="00 : 00" && format(end)==="00 : 00"){
                    var betweenDay = (end.getTime() - start.getTime())/1000/60/60/24;

                    return result + "<b>기간 : </b>" + betweenDay + "일";
                }
                return result + "<b>기간 : </b>" + format(start) + " ~ " + format(end);
            };

            //스케쥴 초기화
            scheduler.init('scheduler_here', new Date(),"month");

            //db 정보 받아 json형태로 파싱
            var jsonarray = [];

            <c:forEach var="calendar" items="${calendarList}">
            var json = {};
            json.id = "${calendar.id}";
            json.title = "${calendar.title}";
            json.explanation = "${calendar.explanation}";
            json.location = "${calendar.location}";
            json.start_date = "${calendar.str_start_date}";
            json.end_date = "${calendar.str_end_date}";
            json.color = "${calendar.color}";

            jsonarray.push(json);
            </c:forEach>

            scheduler.parse(jsonarray, "json");

            //json 으로 데이터 넣기 12일 9시 ~ 19일까지
            // scheduler.parse([
            //     {
            //         title: 'english',
            //         explanation:'신우창',
            //         location: '북악관 608호',
            //         start_date: "2019-06-12 00:00:00",
            //         end_date: "2019-06-13 00:00:00",
            //     }
            // ], "json");

        }//init()

    </script>

</head>

<body id="page-top" onload="init();">

<!-- Navbar jsp  -->
<jsp:include page="../common/navbar.jsp"/>


<div id="wrapper">

    <!-- sidebar jsp -->
    <jsp:include page="../common/sidebar.jsp"/>

    <div id="content-wrapper">


        <!-- loader -->
        <div class="container-fluid">
            <div class="loader"></div>
        </div>

        <!-- scheduler -->
        <div id="scheduler_here" class="dhx_cal_container" style='width:100%; height:100%; display: none'>
            <div class="dhx_cal_navline">
                <!-- 다음주 이전 주 버튼 -->
                <div class="dhx_cal_prev_button">&nbsp;</div>
                <div class="dhx_cal_next_button">&nbsp;</div>
                <div class="dhx_cal_today_button"></div>
                <div class="dhx_cal_date"></div>
                <!-- delete day,month-->
                <div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div>
                <div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div>
                <div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div>
            </div>
            <div class="dhx_cal_header">
            </div>
            <div class="dhx_cal_data">
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

<!-- dhtmlxscheduler js -->
<script src="/js/dhtmlx/dhtmlxscheduler.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/dhtmlx/dhtmlxscheduler_tooltip.js" type="text/javascript" charset="utf-8"></script>
<%--<script src="/js/dhtmlx/dhtmlxscheduler_collision.js" type="text/javascript" charset="utf-8"></script>--%>
<script src="/js/dhtmlx/dhtmlxscheduler_limit.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/dhtmlx/dhtmlxscheduler_recurring.js" type="text/javascript" charset="utf-8"></script>

<script>

    $('#sidebar-4').addClass("active");

    <!-- 로딩 완료되면 -->
    $(document).ready(function(){
        setTimeout(function(){
            // 1초 후 작동
            $('.loader').hide('fast');
            $('#scheduler_here').fadeIn('fast');
            scheduler.updateView();
        }, 1500);
    });
</script>
</body>

</html>
