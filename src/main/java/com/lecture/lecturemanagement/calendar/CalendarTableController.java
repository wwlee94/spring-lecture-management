package com.lecture.lecturemanagement.calendar;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/calendar")
public class CalendarTableController {

    @RequestMapping(value = "/calendartable",method = RequestMethod.GET)
    public String getCalendar(){

        return "/calendar/calendartable";
    }
}
