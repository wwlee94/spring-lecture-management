package com.lecture.lecturemanagement.lecture;

import com.lecture.lecturemanagement.calendar.TimeTable;
import com.lecture.lecturemanagement.calendar.TimeTableRepository;
import com.lecture.lecturemanagement.login.security.SecurityMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/lecture")
public class LectureController {

    @Autowired
    TimeTableRepository timeTableRepository;

    @Autowired
    LectureRepository lectureRepository;

    //사용자 정보 가져오기 위한 변수
    private Object object;
    private String uid;

    @RequestMapping(value = "" , method = RequestMethod.GET)
    public ModelAndView getLecture(){

        //table select
        List<Lecture> lectureList = lectureRepository.findAll();

        ModelAndView mv = new ModelAndView();
        mv.setViewName("lecture/lecturetable");
        mv.addObject("lectureList",lectureList);

        return mv;
    }

    @RequestMapping(value = "/timetable" , method = RequestMethod.POST)
    public String addLectureToTimeTable(TimeTable timeTable,
                                        @RequestParam("date_picker") String date_picker,
                                        @RequestParam("start_time") String start_time,
                                        @RequestParam("end_time") String end_time){

        object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (object.getClass().getName().equals("com.lecture.lecturemanagement.login.security.SecurityMember")) {
            uid = ((SecurityMember) object).getUsername();
        }
        else uid = "woowon";

        //비어있으면 시간을 직접 입력했다는 뜻
        if(timeTable.getLecture_time().equals("")){

            long id = 0;
            String subject = timeTable.getSubject();
            String professor = timeTable.getProfessor();
            String location = timeTable.getLocation();

            String str_start = date_picker+" "+start_time+":00";
            String str_end = date_picker+" "+end_time+":00";

            //Uid 설정
            timeTable.setUid(uid);
            //start,end -> String to LocalDateTime 형 변환 해줌
            timeTable.setUpdateTimeTable(id,subject,professor,location,str_start,str_end);

            timeTableRepository.save(timeTable);
        }
        else{

        }

        return "redirect:/";
    }

}
