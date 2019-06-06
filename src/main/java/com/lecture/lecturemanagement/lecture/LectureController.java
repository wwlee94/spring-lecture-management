package com.lecture.lecturemanagement.lecture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/lecture")
public class LectureController {
    @Autowired
    LectureRepository lectureRepository;

    @RequestMapping(value = "" , method = RequestMethod.GET)
    public ModelAndView getLecture(){

        //table select
        List<Lecture> lectureList = lectureRepository.findAll();

        ModelAndView mv = new ModelAndView();
        mv.setViewName("lecture/lecturetable");
        mv.addObject("lectureList",lectureList);

        return mv;
    }

}
