package com.lecture.lecturemanagement.calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/calendar")
public class CalendarTableController {

    @Autowired
    private CalendarTableRepository calendarTableRepository;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    //사용자 이메일
    String uid;

    @RequestMapping(value = "/calendartable", method = RequestMethod.GET)
    public ModelAndView getCalendar(Principal principal) {

        int color = 1;

        //사용자 이메일
        uid = principal.getName();
        List<CalendarTable> calendarList = calendarTableRepository.findAllByUid(uid);

        for (int i = 0; i < calendarList.size(); i++) {
            CalendarTable calendarTable = calendarList.get(i);

            LocalDateTime start_date = calendarTable.getStart_date();
            LocalDateTime end_date = calendarTable.getEnd_date();

            //localdatetime to string 포맷으로 변경
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            String str_start_date = "";
            String str_end_date = "";

            //localdatetime to string 포맷으로 변경
            str_start_date = start_date.format(formatter);
            str_end_date = end_date.format(formatter);

            //날짜 값 대입
            calendarTable.setStr_start_date(str_start_date);
            calendarTable.setStr_end_date(str_end_date);

            calendarTable.setColor(color);
            color++;
            if (color == 8) color = 1;
        }


        //ModelAndView -> 데이터와 뷰를 동시에 설정이 가능
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/calendar/calendartable");
        mv.addObject("calendarList", calendarList);

        return mv;
    }

    //일정 추가
    //ResponseBody 안쓰면 요청은 잘 처리되는데 크롬에서 404에러 뜸
    @ResponseBody
    @RequestMapping(value = "/calendartable", method = RequestMethod.POST)
    public String addCalendarTable(CalendarTable calendarTable,
                                   Principal principal) {

        System.out.println("CalendarTable ADD !");

        uid = principal.getName();

        //String to LocalDateTime 변환
        LocalDateTime start = LocalDateTime.parse(calendarTable.getStr_start_date(), formatter);
        LocalDateTime end = LocalDateTime.parse(calendarTable.getStr_end_date(), formatter);

        //이메일 설정
        calendarTable.setUid(uid);
        //기간 설정
        calendarTable.setStart_date(start);
        calendarTable.setEnd_date(end);

        //저장
        calendarTableRepository.save(calendarTable);

        return "CalendarTable Add OK";
    }

    //시간표 수정
    @ResponseBody
    @RequestMapping(value = "/calendartable", method = RequestMethod.PUT)
    public String updateCalendarTable(CalendarTable calendarTable,
                                      Principal principal) {

        System.out.println("CalendarTable Update !");

        //이메일
        uid = principal.getName();

        //String to LocalDateTime 변환
        LocalDateTime start = LocalDateTime.parse(calendarTable.getStr_start_date(), formatter);
        LocalDateTime end = LocalDateTime.parse(calendarTable.getStr_end_date(), formatter);

        //이메일 설정
        calendarTable.setUid(uid);
        //기간 설정
        calendarTable.setStart_date(start);
        calendarTable.setEnd_date(end);

//        long parent_id = -1;
//
//        //분리
//        if (calendarTable.getStr_id().indexOf("#") != -1) {
//            String[] split = calendarTable.getStr_id().split("#");
//            parent_id = (long)Integer.parseInt(split[0]);
//        }
//
//        //recurring 업데이트 +삭제시 특정 이벤트
//        if(!calendarTable.getRec_type().equals("") && !calendarTable.getRec_type().equals("none") ){
//            calendarTableRepository
//                    .deleteCalendarTableByEvent_pid(parent_id);
//            System.out.println("parent_id : 삭제완료");
//        }

        //수정
        calendarTableRepository.save(calendarTable);

        return "CalendarTable Update OK";
    }

    //시간표 삭제
    @ResponseBody
    @RequestMapping(value = "/calendartable", method = RequestMethod.DELETE)
    public String deleteCalendarTable(@RequestParam("id") long id) {

        System.out.println("CalendarTable DELETE !");

//        if(calendarTable.getEvent_pid() != 0){
//            //이메일
//            uid = principal.getName();
//
//            //String to LocalDateTime 변환
//            LocalDateTime start = LocalDateTime.parse(calendarTable.getStr_start_date(),formatter);
//            LocalDateTime end = LocalDateTime.parse(calendarTable.getStr_end_date(),formatter);
//
//            //이메일 설정
//            calendarTable.setUid(uid);
//            //기간 설정
//            calendarTable.setStart_date(start);
//            calendarTable.setEnd_date(end);
//            //update
//            calendarTable.setRec_type("none");
//
//            calendarTableRepository.save(calendarTable);
//        }
//
//        //recurring 업데이트+삭제시 특정 이벤트
//        if(!calendarTable.getRec_type().equals("") && !calendarTable.getRec_type().equals("none") ){
//            calendarTableRepository
//                    .deleteCalendarTableByEvent_pid(
//                            calendarTable.getEvent_pid(),
//                            calendarTable.getId()
//                    );
//        }

        //삭제
        calendarTableRepository.deleteCalendarTableById(id);

        return "CalendarTable Delete OK";
    }
}
