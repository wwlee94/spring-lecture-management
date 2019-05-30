package com.lecture.lecturemanagement.calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Time;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/calendar")
public class calendarController {

    @Autowired
    TimeTableRepository timeTableRepository;

    @RequestMapping(value = "/timetable" , method = RequestMethod.GET)
    public ModelAndView showTimeTable(){

        List<TimeTable> tableList = timeTableRepository.findAll();

        int color = 1;

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        for(int i=0;i<tableList.size();i++){
            TimeTable timeTable = tableList.get(i);


            //localdatetime to string 포맷으로 변경
            String str_start_date = timeTable.getStart_date().format(formatter);
            String str_end_date = timeTable.getEnd_date().format(formatter);

            if(i==0){
                System.out.println(timeTable.getStart_date()+"end: "+timeTable.getEnd_date());
                System.out.println(str_start_date+"end: "+str_end_date);
            }

            //값 대입
            timeTable.setStr_start_date(str_start_date);
            timeTable.setStr_end_date(str_end_date);

            //색상 대입
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

}
