package com.lecture.lecturemanagement.lecture;

import com.lecture.lecturemanagement.calendar.CalendarTable;
import com.lecture.lecturemanagement.calendar.CalendarTableRepository;
import com.lecture.lecturemanagement.calendar.TimeTable;
import com.lecture.lecturemanagement.calendar.TimeTableRepository;
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

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/lecture")
public class LectureController {

    @Autowired
    TimeTableRepository timeTableRepository;

    @Autowired
    LectureRepository lectureRepository;

    @Autowired
    CalendarTableRepository calendarTableRepository;

    @Autowired
    SemisterRepository semisterRepository;

    //사용자 정보 가져오기 위한 변수
    private Object object;
    private String uid;

    private LocalDateTime[] resultStartDateTime;
    private LocalDateTime[] resultEndDateTime;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView getLecture() {

        //table select
        List<Lecture> lectureList = lectureRepository.findAll();

        ModelAndView mv = new ModelAndView();
        mv.setViewName("lecture/lecturetable");
        mv.addObject("lectureList", lectureList);

        return mv;
    }

    @ResponseBody
    @RequestMapping(value = "/timetable", method = RequestMethod.POST)
    public String addLectureToTimeTable(TimeTable timeTable,
                                        @RequestParam("date_picker") String date_picker,
                                        @RequestParam("start_time") String start_time,
                                        @RequestParam("end_time") String end_time) {

        object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (object.getClass().getName().equals("com.lecture.lecturemanagement.login.security.SecurityMember")) {
            uid = ((SecurityMember) object).getUsername();
        }

        List<TimeTable> tableList = timeTableRepository.findAllByUid(uid);

        //////////비어있으면 시간을 직접 입력해서 DB 저장!!
        if (timeTable.getLecture_time().equals("")) {

            long id = 0;
            String subject = timeTable.getSubject();
            String professor = timeTable.getProfessor();
            String location = timeTable.getLocation();

            String str_start = date_picker + " " + start_time + ":00";
            String str_end = date_picker + " " + end_time + ":00";

            //modal 시작일 변환
            LocalDateTime modal_start = LocalDateTime.parse(str_start, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            LocalDateTime modal_end = LocalDateTime.parse(str_end, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

            System.out.println("modal_start : " + modal_start);
            System.out.println("modal_end : " + modal_end);

            boolean state = true;

            //list 둘러보며 validation 검사
            for (int i = 0; i < tableList.size(); i++) {

                TimeTable table = tableList.get(i);

                LocalDateTime table_start = table.getStart_date();
                LocalDateTime table_end = table.getEnd_date();

                System.out.println("table_start : " + table_start);
                System.out.println("table_end : " + table_end);

                LocalDateTime now = LocalDateTime.now();

                System.out.println("입력값 요일 : " + modal_start.getDayOfWeek());
                System.out.println("저장값 요일 : " + table_start.getDayOfWeek());

                //요일이 같다면 더 깊숙히 검사
                if (modal_start.getDayOfWeek() == table_start.getDayOfWeek()) {
                    System.out.println("요일이 같습니다 !");

                    //
                    LocalDateTime table_end_hm =
                            now.plusHours(table_end.getHour()).plusMinutes(table_end.getMinute());
                    LocalDateTime modal_start_hm =
                            now.plusHours(modal_start.getHour()).plusMinutes(modal_start.getMinute());
                    System.out.println("table_end_hm : " + table_end_hm);
                    System.out.println("modal_start_hm : " + modal_start_hm);

                    //
                    LocalDateTime table_start_hm
                            = now.plusHours(table_start.getHour()).plusMinutes(table_start.getMinute());
                    LocalDateTime modal_end_hm
                            = now.plusHours(modal_end.getHour()).plusMinutes(modal_end.getMinute());

                    System.out.println("table_start_hm : " + table_start_hm);
                    System.out.println("modal_end_hm : " + modal_end_hm);

                    // modal의 end 와 db의 start 비교 db end가 더 크고
                    //modal의 start 와 db의 end 비교 modal start가 더 작으면 충돌
                    if (modal_start_hm.isBefore(table_end_hm) && modal_end_hm.isAfter(table_start_hm)) {
                        state = false;
                        break;
                    }
                }

                System.out.println("state : " + state);
            }

            System.out.println("최종 : " + state);

            //state == true -> 충돌이 안일어남!!
            if (state) {
                //Uid 설정
                timeTable.setUid(uid);
                //start,end -> String to LocalDateTime 형 변환 해줌
                timeTable.setUpdateTimeTable(id, subject, professor, location, str_start, str_end);

                timeTableRepository.save(timeTable);
            }
            //state == false
            else {
                return "collision";
            }
        }

        /////////////////lecture_time 이 존재하면 -> 자동으로 시간에 맞춰서 DB 삽입
        else {
            //문자열 패턴
            //^ :문자열의 시작 $ :문자열의 종료 * : 없을 수도 여러 개 일수도
            // \\D : 숫자가 아닌 모든 문자 | \\d : 숫자
            String[] week = {"월", "화", "수", "목", "금"};
            System.out.println("기본 문자열 " + timeTable.getLecture_time());

            //날짜 뽑아내기
            String result_day = "";
            Pattern dayPattern = Pattern.compile("(.?)[ㄱ-ㅎ가-힣]+");
            Matcher dayMatcher = dayPattern.matcher(timeTable.getLecture_time());
            while (dayMatcher.find()) {
                if (dayMatcher.group(0) != "") {
                    result_day += dayMatcher.group();
                }
            }
            System.out.println(result_day);

            //숫자(시간) 뽑아내기
            String result_time = "";
            Pattern timePattern = Pattern.compile("(\\d+)(.?)");
            Matcher timeMatcher = timePattern.matcher(timeTable.getLecture_time());
            while (timeMatcher.find()) {
                if (timeMatcher.group(0) != "") {
                    result_time += timeMatcher.group();
                }
            }
            System.out.println(result_time);

            // , / 숫자 로 분류 -> 월목 or 월 형태를 분류하기 위함
            String[] split_day1 = result_day.split("(,)|(/)|(\\d)");
            // 월21,수22 형태
            String[] split_day2 = result_day.split("(,)");
            // 월2,3/수2,3 형태
            String[] split_day3 = result_day.split("(/)");
            // 월8,9,10금8,9,10 형태
            String[] split_day4 = result_day.split("(\\d)");


            String[] split_day1_1 = {};

            if (split_day1.length == 1) {
                System.out.println("월목 or 월 형태");
                //월 -> 월 or 월목-> 월 목 분해
                split_day1_1 = split_day1[0].split("");
            } else if (split_day2.length != 1) {
                System.out.println("월22,화23 형태");
                //월22,화23 형태 -> 이미 앞에서 나눠서 그대로
                split_day1_1 = split_day2;
            } else if (split_day3.length != 1) {
                System.out.println("월2,3/수2,3 형태");
                split_day1_1 = split_day3;
            } else if (split_day4.length != 1) {
                System.out.println("월8,9,10금8,9,10 이런형태");
                split_day1_1 = split_day4;
            }

            //최종 전역변수 사이즈 정의
            resultStartDateTime = new LocalDateTime[split_day1_1.length];
            resultEndDateTime = new LocalDateTime[split_day1_1.length];

            for (int i = 0; i < split_day1_1.length; i++) {

                //date 설정
                Date mon = getMonday(new Date());

                //오늘 날짜 기준으로 월요일!
                LocalDateTime monday = convertToLocalDateTimeViaInstant(mon);

                System.out.println("split 요일 " + split_day1_1[i]);

                //며칠을 더해야하는지 알려줌
                int dayCount = 0;
                for (int j = 0; j < week.length; j++) {
                    if (week[j].equals(split_day1_1[i])) {
                        dayCount = j;
                        break;
                    }
                }

                System.out.println("dayCount : " + dayCount);
                //그에 맞는 일수를 더해줌
                monday = monday.plusDays(dayCount);
                //---------------- 날짜 설정은 끝 시간 설정

                // 강의 시작시간 종료시간 str형태로 가지는 클래스 선언
                LectureTime lectureTime = new LectureTime();

                //월,월목 형태 시간 부분 split_time은 동일 for문 1번
                if (split_day1.length == 1) {
                    String split_time = result_time;
                    //강의 범위를 측정
                    getTimeRangeByLectureTime(split_time, lectureTime);
                }
                //월23,화24 형태 시간부분 -> for문 2번이상 돔  -> 2,4
                else if (split_day2.length != 1) {
                    String[] split_comma = result_time.split(",");
                    getTimeRangeByLectureTime(split_comma[i], lectureTime);
                }
                //월2,3/수2,3 형태 시간부분 -> for문 2번이상 돔 -> 2,3/3,4
                else if (split_day3.length != 1) {
                    String[] split_slash = result_time.split("/");
                    getTimeRangeByLectureTime(split_slash[i], lectureTime);
                }
                //월8,9,10금8,9,10 형태 시간부분 -> for문 2번이상 -> 8,9,10금8,9,10
                else if (split_day4.length != 1) {
                    String[] split_string = result_time.split("[ㄱ-ㅎ가-힣]");
                    getTimeRangeByLectureTime(split_string[i], lectureTime);
                }

                String datetime = "";

                //yyyy-MM-dd -> string 설정
                //05,09 형태로 작성해야함
                if (monday.getMonthValue() < 10) {
                    datetime = "" + monday.getYear() + "-0" + monday.getMonthValue() + "-" + monday.getDayOfMonth() + " ";
                } else {
                    datetime = "" + monday.getYear() + "-" + monday.getMonthValue() + "-" + monday.getDayOfMonth() + " ";
                }

                //문자열 설정
                String parse_start = datetime + lectureTime.getStart() + ":00";
                String parse_end = datetime + lectureTime.getEnd() + ":00";

                //최종 강의 시작 날짜와 종료 날짜 구함
                LocalDateTime start_date = LocalDateTime.parse(parse_start, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                LocalDateTime end_date = LocalDateTime.parse(parse_end, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

                //최종 전역변수에 담음 -> 충돌 모두 확인후 db저장하기 위함
                resultStartDateTime[i] = start_date;
                resultEndDateTime[i] = end_date;

                System.out.println("저장 시작 시간" + start_date);
                System.out.println("저장 종료 시간" + end_date);

                boolean state = true;

                //list 둘러보며 validation 충돌 검사
                for (int k = 0; k < tableList.size(); k++) {

                    TimeTable table = tableList.get(k);

                    LocalDateTime table_start = table.getStart_date();
                    LocalDateTime table_end = table.getEnd_date();

                    System.out.println("table_start : " + table_start);
                    System.out.println("table_end : " + table_end);

                    LocalDateTime now = LocalDateTime.now();

                    System.out.println("입력값 요일 : " + start_date.getDayOfWeek());
                    System.out.println("저장값 요일 : " + table_start.getDayOfWeek());

                    //요일이 같다면 더 깊숙히 검사
                    if (start_date.getDayOfWeek() == table_start.getDayOfWeek()) {
                        System.out.println("요일이 같습니다 !");

                        //
                        LocalDateTime table_end_hm =
                                now.plusHours(table_end.getHour()).plusMinutes(table_end.getMinute());
                        LocalDateTime modal_start_hm =
                                now.plusHours(start_date.getHour()).plusMinutes(start_date.getMinute());
                        System.out.println("table_end_hm : " + table_end_hm);
                        System.out.println("modal_start_hm : " + modal_start_hm);

                        //
                        LocalDateTime table_start_hm
                                = now.plusHours(table_start.getHour()).plusMinutes(table_start.getMinute());
                        LocalDateTime modal_end_hm
                                = now.plusHours(end_date.getHour()).plusMinutes(end_date.getMinute());

                        System.out.println("table_start_hm : " + table_start_hm);
                        System.out.println("modal_end_hm : " + modal_end_hm);

                        // modal의 end 와 db의 start 비교 db end가 더 크고
                        //modal의 start 와 db의 end 비교 modal start가 더 작으면 충돌
                        if (modal_start_hm.isBefore(table_end_hm) && modal_end_hm.isAfter(table_start_hm)) {
                            state = false;
                            break;
                        }
                    }

                    System.out.println("state : " + state);
                }

                System.out.println("최종 : " + state);

                //state == true
                if (state) {
                    //
                }
                //state == false
                else {
                    return "collision";
                }

            }//for

            //세팅후 저장
            for (int i = 0; i < resultStartDateTime.length; i++) {
                //Uid 설정
                timeTable.setUid(uid);
                long id = 0;
                String subject = timeTable.getSubject();
                String professor = timeTable.getProfessor();
                String location = timeTable.getLocation();
                String str_start = resultStartDateTime[i].format(formatter);
                String str_end = resultEndDateTime[i].format(formatter);

                //start,end -> String to LocalDateTime 형 변환 해줌
                timeTable.setUpdateTimeTable(id, subject, professor, location, str_start, str_end);

                System.out.println("resultStartDateTime : " + resultStartDateTime[i]);
                System.out.println("resultEndDateTime : " + resultEndDateTime[i]);

                timeTableRepository.save(timeTable);

                //calendar에 해당 과목 요일을 모든 날짜에 추가
                setCalendarAllRegister(i,id,subject,professor,location);

            }

        }//else lecture_time이 존재하는 경우

        return "success";
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

    //result_time 으로 매칭해서 str 강의 시간을 설정 해주는 함수
    public void getTimeRangeByLectureTime(String lecture_time, LectureTime lectureTime) {

        //1~12교시 시작 시간
        String[] match1StartTime = {"09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00"
                , "16:00", "17:00", "18:00", "18:50", "19:40"};
        //1~12교시 종료 시간
        String[] match1EndTime = {"09:50", "10:50", "11:50", "12:50", "13:50", "14:50", "15:50"
                , "16:50", "17:50", "18:45", "19:35", "20:25"};

        //21~28 교시 시작 시간
        String[] match2StartTime = {"09:00", "10:30", "12:00", "13:30", "15:00", "16:30", "18:00"
                , "19:15"};
        //21~28 교시 종료 시간
        String[] match2EndTime = {"10:15", "11:45", "13:15", "14:45", "16:15", "17:45", "19:10"
                , "20:25"};

        String[] split = lecture_time.split(",");

        //오류 없으면 1개든 여러개든
        if (split.length != 0) {
            //시작 시작 index
            int startNum = Integer.parseInt(split[0]);
            //종료 시간 index
            int endNum = Integer.parseInt(split[split.length - 1]);

            if (startNum >= 1 && startNum <= 12) {
                lectureTime.start = "" + match1StartTime[startNum - 1];
                lectureTime.end = "" + match1EndTime[endNum - 1];
            } else if (startNum >= 21 && startNum <= 28) {
                lectureTime.start = "" + match2StartTime[startNum - 21];
                lectureTime.end = "" + match2EndTime[endNum - 21];
            } else {
                System.out.println("시간 분류 작업 도중 오류");
            }
        }

        System.out.println("시작 시간" + lectureTime.start);
        System.out.println("종료 시간" + lectureTime.end);
    }

    //lecture 등록시 모든 캘린더에 해당하는 요일들 모두 추가
    public void setCalendarAllRegister(int index,long id,String subject,String professor,String location) {
        //calendar의 일정 등록
        CalendarTable calendarTable = new CalendarTable();
        calendarTable.setUid(uid);
        //추가한 날짜만큼 반복

        LocalDateTime now = LocalDateTime.now();

        List<Semister> semisterList = semisterRepository.findAll();
        //요일을 가져옴
        DayOfWeek dayOfWeek = resultStartDateTime[index].getDayOfWeek();
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
                            .plusHours(resultStartDateTime[index].getHour())
                            .plusMinutes(resultStartDateTime[index].getMinute())
                            .format(formatter);
                    String str_semister_end = semister_start
                            .plusHours(resultEndDateTime[index].getHour())
                            .plusMinutes(resultStartDateTime[index].getMinute())
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

class LectureTime {
    String start = "";
    String end = "";

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }
}
