package com.lecture.lecturemanagement.calendar;

import com.lecture.lecturemanagement.login.security.SecurityMember;
import com.lecture.lecturemanagement.semister.Semister;
import com.lecture.lecturemanagement.semister.SemisterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/calendar")
public class TimetableController {

    @Autowired
    TimeTableRepository timeTableRepository;

    @Autowired
    SemisterRepository semisterRepository;

    @Autowired
    CalendarTableRepository calendarTableRepository;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    //사용자 정보 가져오기 위한 변수
    private Object object;
    private String uid;

    @RequestMapping(value = "/timetable", method = RequestMethod.GET)
    public ModelAndView showTimeTable() {

        object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (object.getClass().getName().equals("com.lecture.lecturemanagement.login.security.SecurityMember")) {
            uid = ((SecurityMember) object).getUsername();
        }

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

        System.out.println("\n오늘 날짜 기준 월" + monday);
        System.out.println("오늘 날짜 기준 금" + friday);

        ArrayList<String> lecture_color = new ArrayList();

        for (int i = 0; i < tableList.size(); i++) {
            TimeTable timeTable = tableList.get(i);

            LocalDateTime start_date = timeTable.getStart_date();
            LocalDateTime end_date = timeTable.getEnd_date();

            System.out.println("저장된 start_date" + start_date);

            int count = 0;
            boolean equal = false;

            //* 현재 저장된 날짜가 보여주는 월화수목금 이전일때 *
            if (start_date.isBefore(monday)) {
                //이전
                if (start_date.getMonth() == monday.getMonth()) {
                    if (start_date.getDayOfMonth() == monday.getDayOfMonth()) {
                        System.out.println("같은날 ^^");
                        System.out.println("start_date " + start_date);
                        System.out.println("monday " + monday);

                        equal = true;
                    }
                }
                if (!equal) {
                    //저장된 날짜와 상관없이 요일확인후 현재일 기준 월~금 날짜로 조정
                    if (start_date.getDayOfWeek() == DayOfWeek.MONDAY) count = 0;
                    else if (start_date.getDayOfWeek() == DayOfWeek.TUESDAY) count = 1;
                    else if (start_date.getDayOfWeek() == DayOfWeek.WEDNESDAY) count = 2;
                    else if (start_date.getDayOfWeek() == DayOfWeek.THURSDAY) count = 3;
                    else if (start_date.getDayOfWeek() == DayOfWeek.FRIDAY) count = 4;

                    //년,월,일 맞춰준것
                    LocalDate localDate = LocalDate.of(monday.getYear(), monday.getMonthValue(), monday.getDayOfMonth() + count);
                    //시간,분,초 더해준것
                    LocalDateTime start_DateTime = localDate.atTime(start_date.getHour(), start_date.getMinute(), start_date.getSecond());
                    LocalDateTime end_DateTime = localDate.atTime(end_date.getHour(), end_date.getMinute(), end_date.getSecond());

                    //localdatetime to string 포맷으로 변경
                    str_start_date = start_DateTime.format(formatter);
                    str_end_date = end_DateTime.format(formatter);
                } else {
                    str_start_date = timeTable.getStart_date().format(formatter);
                    str_end_date = timeTable.getEnd_date().format(formatter);
                }
            }
            //* 현재 저장된 날짜가 보여주는 월화수목금 이후일때 *
            else if (start_date.isAfter(friday)) {
                if (start_date.getMonth() == friday.getMonth()) {
                    if (start_date.getDayOfMonth() == friday.getDayOfMonth()) {
                        System.out.println("같은날 ^^");
                        System.out.println("start_date " + start_date);
                        System.out.println("friday " + friday);

                        equal = true;
                    }
                }
                //저장된 날짜와 오늘 기준으로 이번주 금요일의 날짜와 같지 않을 때
                if (!equal) {
                    //저장된 날짜와 상관없이 요일확인후 현재일 기준 월~금 날짜로 조정
                    if (start_date.getDayOfWeek() == DayOfWeek.MONDAY) count = 4;
                    else if (start_date.getDayOfWeek() == DayOfWeek.TUESDAY) count = 3;
                    else if (start_date.getDayOfWeek() == DayOfWeek.WEDNESDAY) count = 2;
                    else if (start_date.getDayOfWeek() == DayOfWeek.THURSDAY) count = 1;
                    else if (start_date.getDayOfWeek() == DayOfWeek.FRIDAY) count = 0;

                    //년,월,일 맞춰준것
                    LocalDate localDate = LocalDate.of(friday.getYear(), friday.getMonthValue(), friday.getDayOfMonth() - count);

                    //시간,분,초 더해준것
                    LocalDateTime start_DateTime = localDate.atTime(start_date.getHour(), start_date.getMinute(), start_date.getSecond());
                    LocalDateTime end_DateTime = localDate.atTime(end_date.getHour(), end_date.getMinute(), end_date.getSecond());

                    //localdatetime to string 포맷으로 변경
                    str_start_date = start_DateTime.format(formatter);
                    str_end_date = end_DateTime.format(formatter);

                } else {
                    //localdatetime to string 포맷으로 변경
                    str_start_date = timeTable.getStart_date().format(formatter);
                    str_end_date = timeTable.getEnd_date().format(formatter);
                }
            }
            // *저장된 날짜가 딱 이번주 월~금 사이에 포함되는 날짜들*
            else {
                //localdatetime to string 포맷으로 변경
                str_start_date = timeTable.getStart_date().format(formatter);
                str_end_date = timeTable.getEnd_date().format(formatter);
            }

            //날짜 값 대입
            timeTable.setStr_start_date(str_start_date);
            timeTable.setStr_end_date(str_end_date);

            //색상 대입
            //같은 과목 이름이면 색상 동일하게

            int size = lecture_color.size();
            boolean findColor = false;

            //for문 돌면서 확인 같은 이름이 있나
            for (int j = 0; j < size; j++) {
                //현재 timeTable 이름과 lecture_color의 요소와 이름이 같은게 있으면!
                //lecture_color에 subject이름을 담고 해당 인덱스로 color 설정
                if (timeTable.getSubject().equals(lecture_color.get(j))) {
                    System.out.println("찾은 과목 : " + timeTable.getSubject());
                    System.out.println("색상 index : " + j);
                    int colorIndex = j;
                    colorIndex = colorIndex % 7;
                    timeTable.setColor(colorIndex + 1);
                    findColor = true;
                }
            }

            //같은 이름을 못찾았으면!
            if (!findColor) {
                lecture_color.add(timeTable.getSubject());
                timeTable.setColor(color);
                color++;
                if (color == 8) color = 1;
            }

            System.out.println(lecture_color.toString());

//            //lecture_time 설정
//            timeTable.setLecture_time();
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
    @RequestMapping(value = "/timetable", method = RequestMethod.POST)
    public String addTimeTable(@RequestParam("subject") String subject,
                               @RequestParam("professor") String professor,
                               @RequestParam("location") String location,
                               @RequestParam("start_date") String start_date,
                               @RequestParam("end_date") String end_date) {

        System.out.println("TimeTable ADD !");

        object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (object.getClass().getName().equals("com.lecture.lecturemanagement.login.security.SecurityMember")) {
            uid = ((SecurityMember) object).getUsername();
        }

        //값 대입후 세팅
        TimeTable timeTable = new TimeTable();
        //아이디
        timeTable.setUid(uid);
        //기본 정보들 초기화
        timeTable.setUpdateTimeTable(0, subject, professor, location, start_date, end_date);

        //저장
        timeTableRepository.save(timeTable);

        ///////////calendar에도 해당되는 요일들 모두 추가
        LocalDateTime localDateTime_start = LocalDateTime.parse(start_date,formatter);
        LocalDateTime localDateTime_end = LocalDateTime.parse(end_date,formatter);

        setCalendarAllRegister(0,subject,professor,location,localDateTime_start,localDateTime_end);

        return "TimeTable Add OK";
    }

    //시간표 수정
    @ResponseBody
    @RequestMapping(value = "/timetable", method = RequestMethod.PUT)
    public String updateTimeTable(@RequestParam("id") Long id,
                                  @RequestParam("subject") String subject,
                                  @RequestParam("professor") String professor,
                                  @RequestParam("location") String location,
                                  @RequestParam("start_date") String start_date,
                                  @RequestParam("end_date") String end_date) {

        System.out.println("TimeTable Update !");

        object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (object.getClass().getName().equals("com.springboot.web.login.security.SecurityMember")) {
            uid = ((SecurityMember) object).getUsername();
        }

        //값 대입후 세팅
        TimeTable timeTable = new TimeTable();
        //아이디
        timeTable.setUid(uid);
        //기본 정보들 초기화
        timeTable.setUpdateTimeTable(id, subject, professor, location, start_date, end_date);

        //수정
        timeTableRepository.save(timeTable);

////        ///////////calendar에도 해당되는 요일들 모두 수정
//        LocalDateTime localDateTime_start = LocalDateTime.parse(start_date,formatter);
//        LocalDateTime localDateTime_end = LocalDateTime.parse(end_date,formatter);
//
//        List<CalendarTable> calendarTableList = calendarTableRepository.findAllByUid(uid);
//
//        System.out.println(calendarTableList.size());
//
//        LocalDateTime now = LocalDateTime.now();
//
//        //요일을 가져옴
//        DayOfWeek dayOfWeek = localDateTime_start.getDayOfWeek();
//
//        for(int i=0;i<calendarTableList.size();i++){
//            CalendarTable calendarTable = calendarTableList.get(i);
//            calendarTable.setUid(uid);
//            System.out.println(calendarTable.getId());
//            System.out.println(calendarTable.getTitle());
//            if(calendarTable.getTitle().equals(subject)){
//                System.out.println("제목과 과목이름이 같습니다.");
//
//
//                calendarTableRepository.save(calendarTable);
//            }
//        }



        return "TimeTable Update OK";
    }

    //시간표 삭제
    @ResponseBody
    @RequestMapping(value = "/timetable", method = RequestMethod.DELETE)
    public String deleteTimeTable(@RequestParam("id") Long id,
                                  @RequestParam("subject") String subject,
                                  Principal principal) {

        System.out.println("TimeTable DELETE !");

        //수정
        timeTableRepository.deleteTimeTableById(id);

        uid = principal.getName();
        //삭제
        calendarTableRepository.deleteCalendarTableByUidAndSubject(uid,subject);

        return "TimeTable Delete OK";
    }

    //현재 날짜 기준으로 월요일 구하기
    public Date getMonday(Date now) {
        int day = now.getDay() % 7;
        if (day != 1) {
            now.setHours(-24 * (day - 1));
        }
        return now;
    }

    //Date to LocalDateTime convertor
    public LocalDateTime convertToLocalDateTimeViaInstant(Date dateToConvert) {
        return dateToConvert.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDateTime();
    }

    //lecture 등록시 모든 캘린더에 해당하는 요일들 모두 추가
    public void setCalendarAllRegister(long id,String subject,String professor,String location,LocalDateTime start_date,LocalDateTime end_date) {
        //calendar의 일정 등록
        CalendarTable calendarTable = new CalendarTable();
        calendarTable.setUid(uid);
        //추가한 날짜만큼 반복

        LocalDateTime now = LocalDateTime.now();

        List<Semister> semisterList = semisterRepository.findAll();
        //요일을 가져옴
        DayOfWeek dayOfWeek = start_date.getDayOfWeek();
        System.out.println("dayOfWeek : " + dayOfWeek);
        for (int k = 0; k < semisterList.size(); k++) {
            Semister semister = semisterList.get(k);
            System.out.println("semister 데이터 가져옴");
            if (now.isBefore(semister.getEnd_date()) && now.isAfter(semister.getStart_date())) {
                System.out.println("조건 성립하는 semister 가져온다");
                LocalDateTime semister_start = semister.getStart_date();
                LocalDateTime semister_end = semister.getEnd_date();

                System.out.println("semister_start : " + semister_start);
                System.out.println("semister_end : " + semister_end);

                while (semister_start.isBefore(semister_end)) {

                    //다음주 요일 -> 같으면 같은 날짜 반환
                    System.out.println("semister_end.isBefore(semiseter_start)");

                    semister_start = semister_start.with(TemporalAdjusters.nextOrSame(dayOfWeek));

                    String str_semister_start = semister_start
                            .plusHours(start_date.getHour())
                            .plusMinutes(start_date.getMinute())
                            .format(formatter);
                    String str_semister_end = semister_start
                            .plusHours(start_date.getHour())
                            .plusMinutes(start_date.getMinute())
                            .format(formatter);

                    //calendar에 날짜 저장
                    calendarTable.setUpdateTimeTable(
                            id, subject, professor, location, str_semister_start, str_semister_end
                    );

                    System.out.println("저장!");
                    calendarTableRepository.save(calendarTable);

                    //7일 추가
                    semister_start = semister_start.plusDays(7);
                }
                break;
            }
        }
    }
}
