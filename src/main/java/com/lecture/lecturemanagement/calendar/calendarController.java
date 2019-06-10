package com.lecture.lecturemanagement.calendar;

import com.lecture.lecturemanagement.login.security.SecurityMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/calendar")
public class calendarController {

    @Autowired
    TimeTableRepository timeTableRepository;

    //사용자 정보 가져오기 위한 변수
    private Object object;
    private String uid;

    @RequestMapping(value = "/timetable" , method = RequestMethod.GET)
    public ModelAndView showTimeTable(){

        object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (object.getClass().getName().equals("com.lecture.lecturemanagement.login.security.SecurityMember")) {
            uid = ((SecurityMember) object).getUsername();
        }
        else uid = "woowon";

        List<TimeTable> tableList = timeTableRepository.findAllByUid(uid);

        int color = 1;

        //localdatetime to string 포맷으로 변경
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        String str_start_date = "";
        String str_end_date = "";

        //오늘 날짜를 기준으로 월요일 가져옴
        Date mon = getMonday(new Date());

        //Date to LocalDateTime 형 변환
        LocalDateTime monday = convertToLocalDateTimeViaInstant(mon);
        LocalDateTime friday = monday.plusDays(4);

        System.out.println("\n오늘 날짜 기준 월"+monday);
        System.out.println("오늘 날짜 기준 금"+friday);

        for(int i=0;i<tableList.size();i++){
            TimeTable timeTable = tableList.get(i);

            LocalDateTime start_date = timeTable.getStart_date();
            LocalDateTime end_date = timeTable.getEnd_date();

            System.out.println("저장된 start_date"+start_date);

            int count = 0;
            boolean equal = false;

            //* 현재 저장된 날짜가 보여주는 월화수목금 이전일때 *
            if(start_date.isBefore(monday)){
                //이전
                if(start_date.getMonth() == monday.getMonth()){
                    if(start_date.getDayOfMonth() == monday.getDayOfMonth()){
                        System.out.println("같은날 ^^");
                        System.out.println("start_date " + start_date);
                        System.out.println("monday "+ monday);

                        equal = true;
                    }
                }
                if(!equal) {
                    //저장된 날짜와 상관없이 요일확인후 현재일 기준 월~금 날짜로 조정
                    if(start_date.getDayOfWeek()== DayOfWeek.MONDAY) count = 0;
                    else if(start_date.getDayOfWeek()== DayOfWeek.TUESDAY) count = 1;
                    else if(start_date.getDayOfWeek()== DayOfWeek.WEDNESDAY) count = 2;
                    else if(start_date.getDayOfWeek()== DayOfWeek.THURSDAY) count = 3;
                    else if(start_date.getDayOfWeek()== DayOfWeek.FRIDAY) count = 4;

                    //년,월,일 맞춰준것
                    LocalDate localDate = LocalDate.of(monday.getYear(),monday.getMonthValue(),monday.getDayOfMonth()+count);
                    //시간,분,초 더해준것
                    LocalDateTime start_DateTime = localDate.atTime(start_date.getHour(),start_date.getMinute(),start_date.getSecond());
                    LocalDateTime end_DateTime = localDate.atTime(end_date.getHour(),end_date.getMinute(),end_date.getSecond());

                    //localdatetime to string 포맷으로 변경
                    str_start_date = start_DateTime.format(formatter);
                    str_end_date = end_DateTime.format(formatter);
                }
                else{
                    str_start_date = timeTable.getStart_date().format(formatter);
                    str_end_date = timeTable.getEnd_date().format(formatter);
                }
            }
            //* 현재 저장된 날짜가 보여주는 월화수목금 이후일때 *
            else if(start_date.isAfter(friday)){
                if(start_date.getMonth() == friday.getMonth()){
                    if(start_date.getDayOfMonth() == friday.getDayOfMonth()){
                        System.out.println("같은날 ^^");
                        System.out.println("start_date " + start_date);
                        System.out.println("friday "+ friday);

                        equal = true;
                    }
                }
                //저장된 날짜와 오늘 기준으로 이번주 금요일의 날짜와 같지 않을 때
                if(!equal){
                    //저장된 날짜와 상관없이 요일확인후 현재일 기준 월~금 날짜로 조정
                    if(start_date.getDayOfWeek()== DayOfWeek.MONDAY) count = 4;
                    else if(start_date.getDayOfWeek()== DayOfWeek.TUESDAY) count = 3;
                    else if(start_date.getDayOfWeek()== DayOfWeek.WEDNESDAY) count = 2;
                    else if(start_date.getDayOfWeek()== DayOfWeek.THURSDAY) count = 1;
                    else if(start_date.getDayOfWeek()== DayOfWeek.FRIDAY) count = 0;

                    //년,월,일 맞춰준것
                    LocalDate localDate = LocalDate.of(friday.getYear(),friday.getMonthValue(),friday.getDayOfMonth()-count);

                    //시간,분,초 더해준것
                    LocalDateTime start_DateTime = localDate.atTime(start_date.getHour(),start_date.getMinute(),start_date.getSecond());
                    LocalDateTime end_DateTime = localDate.atTime(end_date.getHour(),end_date.getMinute(),end_date.getSecond());

                    //localdatetime to string 포맷으로 변경
                    str_start_date = start_DateTime.format(formatter);
                    str_end_date = end_DateTime.format(formatter);

                }else{
                    //localdatetime to string 포맷으로 변경
                    str_start_date = timeTable.getStart_date().format(formatter);
                    str_end_date = timeTable.getEnd_date().format(formatter);
                }
            }
            // *저장된 날짜가 딱 이번주 월~금 사이에 포함되는 날짜들*
            else{
                //localdatetime to string 포맷으로 변경
                str_start_date = timeTable.getStart_date().format(formatter);
                str_end_date = timeTable.getEnd_date().format(formatter);
            }

            //날짜 값 대입
            timeTable.setStr_start_date(str_start_date);
            timeTable.setStr_end_date(str_end_date);

            //색상 대입
            //TODO: 같은 과목이름이면 색상 동일하도록
            timeTable.setColor(color);
            color++;
            if(color==8) color = 1;
        }

        //ModelAndView -> 데이터와 뷰를 동시에 설정이 가능
        ModelAndView mv = new ModelAndView();
        mv.setViewName("calendar/timetable");
        mv.addObject("tablelist", tableList);

        return mv;
    }

    //시간표 추가
    //ResponseBody 안쓰면 요청은 잘 처리되는데 크롬에서 404에러 뜸
    @ResponseBody
    @RequestMapping(value = "/timetable" , method = RequestMethod.POST)
    public String addTimeTable(@RequestParam("subject") String subject,
                               @RequestParam("professor") String professor,
                               @RequestParam("location") String location,
                               @RequestParam("start_date") String start_date,
                               @RequestParam("end_date") String end_date){

        System.out.println("TimeTable ADD !");

        object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (object.getClass().getName().equals("com.lecture.lecturemanagement.login.security.SecurityMember")) {
            uid = ((SecurityMember) object).getUsername();
        }
        else uid = "woowon";

        //값 대입후 세팅
        TimeTable timeTable = new TimeTable();
        //아이디
        timeTable.setUid(uid);
        //기본 정보들 초기화
        timeTable.setUpdateTimeTable(0,subject,professor,location,start_date,end_date);

        //저장
        timeTableRepository.save(timeTable);

        return "TimeTable Add OK";
    }

    //시간표 수정
    @ResponseBody
    @RequestMapping(value = "/timetable" , method = RequestMethod.PUT)
    public String updateTimeTable(@RequestParam("id") Long id,
                                  @RequestParam("subject") String subject,
                                  @RequestParam("professor") String professor,
                                  @RequestParam("location") String location,
                                  @RequestParam("start_date") String start_date,
                                  @RequestParam("end_date") String end_date){

        System.out.println("TimeTable Update !");

        object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (object.getClass().getName().equals("com.springboot.web.login.security.SecurityMember")) {
            uid = ((SecurityMember) object).getUsername();
        }
        else{
            uid = "woowon";
        }

        //값 대입후 세팅
        TimeTable timeTable = new TimeTable();
        //아이디
        timeTable.setUid(uid);
        //기본 정보들 초기화
        timeTable.setUpdateTimeTable(id,subject,professor,location,start_date,end_date);

        //수정
        timeTableRepository.save(timeTable);

        return "TimeTable Update OK";
    }

    //시간표 삭제
    @ResponseBody
    @RequestMapping(value = "/timetable" , method = RequestMethod.DELETE)
    public String deleteTimeTable(@RequestParam("id") Long id){

        System.out.println("TimeTable DELETE !");

        //수정
        timeTableRepository.deleteTimeTableById(id);

        return "TimeTable Delete OK";
    }

    //현재 날짜 기준으로 월요일 구하기
    public Date getMonday(Date now){
        int day = now.getDay() % 7;
        if (day != 1){
            now.setHours(-24*(day-1));
        }
        return now;
    }

    //Date to LocalDateTime convertor
    public LocalDateTime convertToLocalDateTimeViaInstant(Date dateToConvert) {
        return dateToConvert.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDateTime();
    }
}
