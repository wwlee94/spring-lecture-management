<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<style>
    .datepicker {
        z-index: 9999 !important
    }
</style>


<!-- Modal: modalCart -->
<div class="modal fade" id="lectureModal" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable" role="document">
        <div class="modal-content" style="background-color: #FFFFF7">
            <!--Header-->
            <!--color mdb
                info-color-dark #0099CC
                info-color #33b5e5
                default-color #2BBBAD
                unique color #3F729B
            -->
            <div class="modal-header" style="background-color: #0099CC; color:#FFF;">
                <h4 class="modal-title" id="myModalLabel">강의 추가</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:#FFF;">
                    <span aria-hidden="true" style="color:#FFF;">&times;</span>
                </button>
            </div>
            <form action="/lecture/timetable" method="post" onsubmit="return checkForm();">
                <!--Body-->
                <div class="modal-body">
                    <div class="form-group">
                        <label for="modal_lecture" class="col-form-label font-weight-bold">수업 과목</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button class="btn btn-danger" type="button">
                                    <span class="fas fa-book"></span>
                                </button>
                            </div>
                            <input type="text" class="form-control" id="modal_lecture" name="subject"
                                   placeholder="강좌 이름을 입력하세요." style="text-align: center">
                        </div>
                    </div>
                    <hr>
                    <div class="form-group">
                        <label for="modal_professor" class="col-form-label font-weight-bold">교수 이름</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button class="btn btn-warning" type="button">
                                    <span class="fas fa-user-tie"></span>
                                </button>
                            </div>
                            <input type="text" class="form-control" id="modal_professor" name="professor"
                                   placeholder="교수 이름을 입력하세요." style="text-align: center">
                        </div>
                    </div>
                    <hr>
                    <div class="form-group">
                        <label for="modal_location" class="col-form-label font-weight-bold">강의 장소</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button class="btn btn-success" type="button">
                                    <span class="fas fa-map-marked-alt"></span>
                                </button>
                            </div>
                            <input type="text" class="form-control" id="modal_location" name="location"
                                   placeholder="강의 장소를 입력하세요." style="text-align: center">
                        </div>
                    </div>
                    <hr>
                    <!-- 강의시간 값 존재시 -->
                    <div class="form-group" id="show_lecture_time">
                        <label for="modal_lecture_time" class="col-form-label font-weight-bold">강의 시간</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button class="btn btn-primary" type="button">
                                    <span class="fas fa-clock"></span>
                                </button>
                            </div>
                            <input type="text" class="form-control" id="modal_lecture_time" name="lecture_time"
                                   style="text-align: center" readonly>
                        </div>
                    </div>

                    <!-- 강의 시간 값 없을 때 -->
                    <div id="show_clockpicker">
                        <p class="font-weight-bold"> 강의 날짜 &nbsp; &nbsp;</p>

                        <!-- datapicker -->

                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button class="btn btn-primary" type="button">
                                    <span class="fas fa-calendar"></span>
                                </button>
                            </div>
                            <input type='text' class="datepicker-here form-control"
                                   placeholder="클릭해서 원하는 요일을 선택하세요."
                                   id="modal_start_date" name="date_picker"
                                   style="text-align:center;"/>
                        </div>


                        <p class="font-weight-bold" style="margin-top: 5px;"> 강의 시간 &nbsp; &nbsp; 9:00 ~ 18:00</p>
                        <!-- clockpicker -->
                        <div class="form-group row" style="margin-left: 30px;">
                            <div class="col-xs-2" style="text-align:center;">
                                <label for="modal_end_time">시작 시간</label>
                                <div class="input-group clockpicker">
                                    <input type="text" class="form-control" id="modal_start_time" name="start_time"
                                           value="12:00" style="text-align:center; display:block;  width: 150px;">
                                    <div class="input-group-addon">
                                        <button class="btn btn-dark" type="button">
                                            <span class="fas fa-clock"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <div class="col-xs-2" style="text-align:center;">
                                <label for="modal_end_time">종료 시간</label>
                                <div class="input-group clockpicker">
                                    <input type="text" class="form-control" id="modal_end_time" name="end_time"
                                           value="12:30" style="text-align:center; display:block;  width: 150px;">
                                    <div class="input-group-addon">
                                        <button class="btn btn-dark" type="button">
                                            <span class="fas fa-clock"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 나머지 데이터도 전달 -->
                    <input type="hidden" id="modal_lecture_code" name="lecture_code" value="">
                    <input type="hidden" id="modal_division" name="division" value="">
                    <input type="hidden" id="modal_grade" name="grade" value="">
                </div> <!-- body -->
                <!--Footer-->
                <div class="modal-footer">
                    <input type="submit" class="btn btn-info" value="추가">
                    <button type="button" class="btn btn-outline-info" data-dismiss="modal">취소</button>
                </div>

            </form>
        </div>
    </div>
</div>
<!-- Modal: modalCart -->

<script>
    // clockpicker validate 체크
    function checkForm() {
        var modal_start_val = $('#modal_start_time').val();
        var modal_end_val = $('#modal_end_time').val();

        var now = new Date();
        //기준값 설정
        var validate_start = new Date(now.getFullYear(),now.getMonth(),now.getDate(),9,0,0);
        var validate_end = new Date(now.getFullYear(),now.getMonth(),now.getDate(),18,0,0);

        //문자열 분해 xx:yy 형태
        var start_parts =modal_start_val.split(':');
        var end_parts =modal_end_val.split(':');

        var modal_start_time = new Date(now.getFullYear(),now.getMonth(),now.getDate(),start_parts[0],start_parts[1],0);
        var modal_end_time = new Date(now.getFullYear(),now.getMonth(),now.getDate(),end_parts[0],end_parts[1],0);

        console.log("validate_start : "+validate_start);
        console.log("validate_end : "+validate_end);

        console.log("modal_start_time : "+modal_start_time);
        console.log("modal_end_time : "+modal_end_time);

        notify_state = false;
        message = "";

        //validation 검사
        if(modal_start_time.getTime()<validate_start.getTime()
            || modal_start_time.getTime() > validate_end.getTime()){
            notify_state = true;
            message = "강의 시작 시간을 다시 입력해주세요 :) <br> (9:00 ~ 18:00)";
        }
        else if(modal_end_time.getTime()<validate_start.getTime()
            || modal_end_time.getTime() > validate_end.getTime()){
            notify_state = true;
            message = "강의 종료 시간을 다시 입력해주세요 :) <br> (9:00 ~ 18:00)";
        }

        //validate를 만족하지 못한다면 알림 보내줌
        if(notify_state){
            //알림
            $.notify({
                icon: 'fa fa-paw',
                title: '<strong> Try Again !</strong><br>',
                message: message
            },{
                type: 'warning',
                offset: 50,
                z_index : 99999,
                animate: {
                    enter: 'animated bounceIn',
                    exit: 'animated bounceOut'
                },
                newest_on_top: true
            });

            return false;
        }

        return true;

    }
</script>