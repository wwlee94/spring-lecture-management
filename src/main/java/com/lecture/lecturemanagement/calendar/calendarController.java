package com.lecture.lecturemanagement.calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/calendar")
public class calendarController {

    @Autowired
    TimeTableRepository timeTableRepository;

    @RequestMapping(value = "/timetable" , method = RequestMethod.GET)
    public ModelAndView showTimeTable(){

        //ModelAndView -> 데이터와 뷰를 동시에 설정이 가능
        ModelAndView mv = new ModelAndView();
        mv.setViewName("calendar/timetable");

        return mv;
    }

//    @RequestMapping(value = "/timetable" , method = RequestMethod.GET)
//    public ModelAndView showTimeTable(){
//
//        List<TimeTable> tableList = timeTableRepository.findAll();
//
//        for(int i=0;i<tableList.size();i++){
//            System.out.println(tableList.get(i).getProfessor());
//        }
//
//        //ModelAndView -> 데이터와 뷰를 동시에 설정이 가능
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("calendar/timetable");
//        mv.addObject("tablelist", tableList);
//
//        return mv;
//    }

}
